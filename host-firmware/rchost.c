#include <htc.h>
#include "usart.h"
#include "../robot-firmware/radio.h"

__CONFIG(FCMEN_OFF & IESO_OFF & CLKOUTEN_OFF & BOREN_ON & CP_OFF & MCLRE_ON &
        PWRTE_OFF & WDTE_OFF & FOSC_INTOSC);
__CONFIG(WRT_OFF & VCAPEN_OFF & STVREN_ON & BORV_LO & LPBOR_OFF & LVP_OFF);

unsigned char radio_pkt_id;
unsigned char radio_len = 0;
unsigned char radio_data[64];
unsigned char wait_for_preamble;

void interrupt isr()
{
    while (RCIF) {
        usart_recv();
    }
    if (TMR1IF) {
        /* Period is 64us */
        TMR1H = 0xff;
        TMR1IF = 0;
        if (wait_for_preamble != 0)
            wait_for_preamble--;
    }
}

void usart_pkt_received(unsigned char cmd, unsigned char len)
{
    switch (cmd) {
        case 'E':
            /* Simple echo command */
            usart_pkt_send('E', 1);
            break;
        case 'R':
            /* This command from the master host initiates
             * query to a radio device. Received packed
             * is stored into the radio_data buffer and
             * it will be sent to the device from the main loop.
             */
            if (radio_len == 0) {
                len--;
                if (len <= 64) {
                    unsigned char c;
                    radio_pkt_id = usart_pkt_get();
                    radio_len = len;
                    for (c = 0; c < len; c++)
                        radio_data[c] = usart_pkt_get();
                }
            }
            break;
    }
}

void led_init()
{
    TRISB &= 0xfc;
    ANSELB &= 0xfc;
    LATB &= ~0x03;
}

void radio_rx_packet()
{
    if (radio_rx_len < 60) {
        unsigned char c;
        usart_pkt_send('R', radio_rx_len + 1);
        for (c = 0; c < radio_rx_len; c++)
            usart_pkt_put(radio_rx_data[c]);
    }
}

void timer_init()
{
    /* Fosc/4 divided by 1:1 */
    T1CON = 0x0f;
    T1GCON = 0;
    TMR1IE = 1;
    PEIE = 1;
}

int main(void) {
    di();
    OSCCON = 0x78;
    led_init();
    usart_init();
    radio_init();
    timer_init();
    ei();

    /* Enable LED */
    LATB |= 0x01;

    /* Sent 'reset' notification to the master */
    usart_pkt_send('R', 1);

    /* Main loop */
    while (1) {

        /* If a radio packet is pending
         * send it immediately and wait for the
         * response packet
         */
        if (radio_len != 0) {
            /* Send a packet */
            unsigned char c;
            LATB |= 0x02;
            radio_tx_start();
            radio_tx_data(radio_len);
            for (c = 0; c < radio_len; c++)
                radio_tx_data(radio_data[c]);
            radio_tx_finish();
            LATB &= ~0x02;
            /* Wait for a response packet for 0.064*31 = 1.984ms */
            wait_for_preamble = 31;
            while (1) {
                if (radio_rx()) {
                    /* If we received proper packet respond with 'Y' */
                    if (radio_rx_data[0] == radio_data[1] &&
                            radio_rx_data[1] == radio_data[0]) {
                        usart_pkt_send('Y', 2);
                        usart_pkt_put(radio_pkt_id);
                        /* Sent acknowledge packet */
                        LATB |= 0x02;
                        radio_tx_start();
                        radio_tx_data(3);
                        radio_tx_data(radio_data[0]);
                        radio_tx_data(radio_data[1]);
                        radio_tx_data('A');
                        radio_tx_finish();
                        LATB &= ~0x02;
                    } else {
                        /* Received invalid packet */
                        usart_pkt_send('N', 3);
                        usart_pkt_put(radio_pkt_id);
                        usart_pkt_put(2);
                    }
                    break;
                }
                if (wait_for_preamble == 0) {
                    /* Timeout waiting for preamble */
                    usart_pkt_send('N', 3);
                    usart_pkt_put(radio_pkt_id);
                    usart_pkt_put(1);
                    break;
                }
            }
            /* Marking radio buffer as free */
            radio_len = 0;
        }
        
        usart_check();
    }
}

