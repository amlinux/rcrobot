#include <htc.h>
#include "usart.h"
#include "../radio.h"

__CONFIG(FCMEN_OFF & IESO_OFF & CLKOUTEN_OFF & BOREN_ON & CP_OFF & MCLRE_ON &
        PWRTE_OFF & WDTE_OFF & FOSC_INTOSC);
__CONFIG(WRT_OFF & VCAPEN_OFF & STVREN_ON & BORV_25 & LPBOR_OFF & LVP_OFF);

unsigned char radio_len = 0;
unsigned char radio_data[64];

void interrupt isr()
{
    while (RCIF) {
        usart_recv();
    }
}

void usart_pkt_received(unsigned char cmd, unsigned char len)
{
    switch (cmd) {
        case 'E':
            usart_pkt_send('E', 1);
            break;
        case 'R':
            len--;
            if (len <= 64) {
                unsigned char c;
                radio_len = len;
                for (c = 0; c < len; c++)
                    radio_data[c] = usart_pkt_get();
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

int main(void) {
    di();
    OSCCON = 0x78;
    led_init();
    usart_init();
    radio_init();
    ei();

    usart_pkt_send('R', 1);
    while (1) {
        if (radio_len != 0) {
            unsigned char c;
            LATB |= 0x01;
            radio_tx_start();
            radio_tx_data(radio_len);
            for (c = 0; c < radio_len; c++)
                radio_tx_data(radio_data[c]);
            radio_tx_finish();
            LATB &= ~0x01;
            radio_len = 0;
        }
        radio_rx();
        usart_check();
    }
}

