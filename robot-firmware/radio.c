#include <htc.h>
#include "radio.h"
#include "../host-firmware/crc.h"

unsigned char radio_rx_len;
unsigned char radio_rx_data[64];
unsigned char radio_tx_crc;

void radio_init()
{
    RADIO_EN_ANSEL &= ~(1 << RADIO_EN_BIT);
    RADIO_EN_TRIS &= ~(1 << RADIO_EN_BIT);
    RADIO_EN_LAT &= ~(1 << RADIO_EN_BIT);

    RADIO_TXRX_ANSEL &= ~(1 << RADIO_TXRX_BIT);
    RADIO_TXRX_TRIS &= ~(1 << RADIO_TXRX_BIT);
    RADIO_TXRX_LAT &= ~(1 << RADIO_TXRX_BIT);

    RADIO_SND_ANSEL &= ~(1 << RADIO_SND_BIT);
    RADIO_SND_TRIS &= ~(1 << RADIO_SND_BIT);
    RADIO_SND_LAT &= ~(1 << RADIO_SND_BIT);

    RADIO_RCV_ANSEL &= ~(1 << RADIO_RCV_BIT);
    RADIO_RCV_TRIS |= (1 << RADIO_RCV_BIT);
}

void radio_off()
{
    RADIO_EN_LAT &= ~(1 << RADIO_EN_BIT);
    RADIO_TXRX_LAT &= ~(1 << RADIO_TXRX_BIT);
    RADIO_SND_LAT &= ~(1 << RADIO_SND_BIT);
}

void radio_tx_start()
{
    unsigned char cnt;
    di();
    RADIO_TXRX_LAT &= ~(1 << RADIO_TXRX_BIT);
    RADIO_SND_LAT &= ~(1 << RADIO_SND_BIT);
    RADIO_EN_LAT |= (1 << RADIO_EN_BIT);
    __delay_us(20);
    RADIO_TXRX_LAT |= (1 << RADIO_TXRX_BIT);
    __delay_us(400);
    for (cnt = 0; cnt < 50; cnt++) {
        RADIO_SND_LAT |= (1 << RADIO_SND_BIT);
        __delay_us(100);
        RADIO_SND_LAT &= ~(1 << RADIO_SND_BIT);
        __delay_us(100);
    }
    __delay_us(100);
    radio_tx_crc = 0;
}

void radio_tx_data(unsigned char data)
{
    unsigned char cnt;
    calc_crc(&radio_tx_crc, data);
    for (cnt = 0; cnt < 8; cnt++) {
        RADIO_SND_LAT |= (1 << RADIO_SND_BIT);
        if (data & 1) {
            __delay_us(300);
        } else {
            __delay_us(200);
        }
        RADIO_SND_LAT &= ~(1 << RADIO_SND_BIT);
        __delay_us(100);
        data >>= 1;
    }
}

void radio_tx_finish()
{
    radio_tx_data(radio_tx_crc);
    radio_off();
    ei();
}

unsigned char _radio_rx_bit()
{
    static unsigned char last = 0;
    unsigned char buf;
    if ((RADIO_RCV_PORT & (1 << RADIO_RCV_BIT)) != 0) {
        buf = (buf << 1) | 1;
    } else {
        buf <<= 1;
    }
    if (buf == 0xff) {
        last = 1;
    } else if (buf == 0x00) {
        last = 0;
    }
    return last;
}

void radio_rx()
{
    unsigned char crc, mode, preamble_periods, myaddr;
    /* initialize receiver */
    di();
    if ((RADIO_SND_LAT & (1 << RADIO_SND_BIT)) == 0) {
        RADIO_EN_LAT |= (1 << RADIO_EN_BIT);
        __delay_us(20);
        RADIO_TXRX_LAT |= (1 << RADIO_TXRX_BIT);
        __delay_us(200);
    }
    RADIO_TXRX_LAT &= ~(1 << RADIO_TXRX_BIT);
    __delay_us(40);
    RADIO_EN_LAT &= ~(1 << RADIO_EN_BIT);
    __delay_us(20);
    RADIO_EN_LAT |= (1 << RADIO_EN_BIT);
    __delay_us(200);
    /* initialize timer (increment every 2 uS) */
    OPTION_REG = (OPTION_REG & 0xc0) | 0x02;
    /* listen for preamble */
    /* wait for 0 */
    TMR0 = 0;
    while (_radio_rx_bit()) {
        // timeout 150 uS
        if (TMR0 >= 75)
            goto done;
    }
    /* initializing preamble counter */
    preamble_periods = 0;
    while (1) {
        /* wait for 1 */
        TMR0 = 0;
        while (!_radio_rx_bit()) {
            // timeout 150 uS
            if (TMR0 >= 75) {
                if (preamble_periods < 5) {
                    /* preamble was too short */
                    goto done;
                } else {
                    /* preamble is OK. going to the receiving mode */
                    goto preamble_ok;
                }
            }
        }
        /* wait for 0 */
        TMR0 = 0;
        while (_radio_rx_bit()) {
            // timeout 150 uS
            if (TMR0 >= 75)
                goto done;
        }
        /* preamble pulse OK */
        if (++preamble_periods >= 70) {
            /* preamble is too long */
            goto done;
        }
    }
preamble_ok:
    /* preamble is OK. initialize buffers and start receiving data */
    crc = 0;
    mode = 0x80;
    /* receive bytes */
    while (1) {
        unsigned char data = 0;
        unsigned char cnt;
        for (cnt = 0; cnt < 8; cnt++) {
            /* wait for 1 */
            TMR0 = 0;
            while (!_radio_rx_bit()) {
                // timeout 150 uS
                if (TMR0 >= 75)
                    goto done;
            }
            /* wait for 0 */
            TMR0 = 0;
            while (_radio_rx_bit()) {
                // timeout 350 uS
                if (TMR0 >= 175)
                    goto done;
            }
            /* evaluating length */
            if (TMR0 < 75) {
                /* pulse is too short even for 0 */
                goto done;
            } else if (TMR0 >= 125) {
                /* 1 */
                data = (data >> 1) | 0x80;
            } else {
                data >>= 1;
            }
        }
        if (mode == 0x80) {
            /* packet length */
            if (data < 3 || data >= 64) {
                /* packet is too long or too short */
                goto done;
            }
            radio_rx_len = data;
            mode = 0;
            calc_crc(&crc, data);
        } else if (mode > radio_rx_len) {
            goto done;
        } else if (mode < radio_rx_len) {
            #ifdef MYADDR
            if (mode == 1 && data != MYADDR) {
                /* destination address mismatch */
                goto done;
            }
            #endif
            radio_rx_data[mode] = data;
            calc_crc(&crc, data);
            mode += 1;
        } else {
            calc_crc(&crc, data);
            if (crc == 0) {
                radio_rx_packet();
            }
            goto done;
        }
    }
done:
    ei();
    radio_off();
}
