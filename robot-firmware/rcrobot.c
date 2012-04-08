#include <htc.h>
#include "radio.h"

__CONFIG(FCMEN_OFF & IESO_OFF & CLKOUTEN_OFF & BOREN_ON & CP_OFF & MCLRE_ON &
        PWRTE_OFF & WDTE_OFF & FOSC_INTOSC);
__CONFIG(WRT_OFF & VCAPEN_OFF & STVREN_ON & BORV_25 & LPBOR_OFF & LVP_OFF);

#define AUTO_DISABLE_MOTORS 10

unsigned char motors_disable_timer = 0;

void interrupt isr()
{
    if (TMR1IF) {
        TMR1IF = 0;
        TMR1H += 0x80;
        if (motors_disable_timer != 0) {
            if (--motors_disable_timer == 0) {
                /* disable motors by timeout */
                LATA &= ~0x1f;
            }
        }
    }
}

void sound_init()
{
    T2CON = 0x04;
    TRISC &= ~0x04;
    ANSELC &= ~0x04;
    TRISA &= ~0x80;
    ANSELA &= ~0x80;
    PR2 = 63;
    CCP1CON = 0x0c;
    CCPR1L = 32;
}

void motors_init()
{
    TRISA &= ~0x1f;
    ANSELA &= ~0x1f;
    /* LFINTOSC (32768 Hz) divided by 1:1 */
    T1CON = 0xcf;
    T1GCON = 0;
    TMR1IE = 1;
    PEIE = 1;
}

void led_init()
{
    TRISB &= ~0x03;
    ANSELB &= ~0x03;
    LATB &= ~0x03;
}

void radio_rx_packet()
{
    switch (radio_rx_data[2]) {
        case 'V':
            /* protocol version */
            LATB |= 0x01;
            radio_tx_start();
            radio_tx_data(4);
            radio_tx_data(MYADDR);
            radio_tx_data(radio_rx_data[0]);
            radio_tx_data('V');
            radio_tx_data(1);
            radio_tx_finish();
            LATB &= ~0x01;
            break;
        case 'E':
            /* echo request */
            LATB |= 0x01;
            radio_tx_start();
            radio_tx_data(3);
            radio_tx_data(MYADDR);
            radio_tx_data(radio_rx_data[0]);
            radio_tx_data('E');
            radio_tx_finish();
            LATB &= ~0x01;
            break;
        case 'M':
            /* set motors */
            LATA = (LATA & ~0x1f) | (radio_rx_data[3] & 0x1f);
            motors_disable_timer = AUTO_DISABLE_MOTORS;
            /* after setting motors mode report status
             * automatically */
        case 'S':
            /* report status */
            LATB |= 0x01;
            radio_tx_start();
            radio_tx_data(4);
            radio_tx_data(MYADDR);
            radio_tx_data(radio_rx_data[0]);
            radio_tx_data('S');
            radio_tx_data(LATA & 0x1f);
            radio_tx_finish();
            LATB &= ~0x01;
            break;
    }
}

int main(void) {
    di();
    OSCCON = 0x78;
    led_init();
    //sound_init();
    radio_init();
    motors_init();
    ei();

    while (1) {
        radio_rx();
    }
}