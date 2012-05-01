#include <htc.h>
#include "radio.h"
#include "adc.h"

__CONFIG(FCMEN_OFF & IESO_OFF & CLKOUTEN_OFF & BOREN_ON & CP_OFF & MCLRE_ON &
        PWRTE_OFF & WDTE_OFF & FOSC_INTOSC);
__CONFIG(WRT_OFF & VCAPEN_OFF & STVREN_ON & BORV_25 & LPBOR_OFF & LVP_OFF);

#define AUTO_DISABLE_MOTORS 10
#define VERSION 1

unsigned char motors_disable_timer = 0;

/* Radio send buffer */
unsigned char radio_len = 0;
unsigned char radio_data[64];

/* Current ADC values */
unsigned char adc_data[10];

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
    if (radio_len == 0) {
        radio_data[0] = MYADDR;
        radio_data[1] = radio_rx_data[0];
    }
    switch (radio_rx_data[2]) {
        case 'V':
            /* protocol version */
            if (radio_len == 0) {
                radio_len = 4;
                radio_data[2] = 'V';
                radio_data[3] = VERSION;
            }
            break;
        case 'E':
            /* echo request */
            if (radio_len == 0) {
                radio_len = 3;
                radio_data[2] = 'E';
            }
            break;
        case 'M':
            /* set motors */
            LATA = (LATA & ~0x1f) | (radio_rx_data[3] & 0x1f);
            motors_disable_timer = AUTO_DISABLE_MOTORS;
            /* after setting motors mode report status
             * automatically */
        case 'S':
            /* report status */
            if (radio_len == 0) {
                radio_len = 4;
                radio_data[2] = 'S';
                radio_data[3] = LATA & 0x1f;
            }
            break;
        case 'A':
            /* acknowledge buffer */
            radio_len = 0;
            break;
        case 'D':
            /* report ADC status */
            if (radio_len == 0) {
                radio_len = 13;
                radio_data[2] = 'D';
                for (unsigned char c = 0; c < 10; c++)
                    radio_data[c + 3] = adc_data[c];
            }
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
    adc_init();
    ei();

    while (1) {
        /* Listen for incoming radio packet */
        if (radio_rx()) {
            /* If a radio packet is pending
             * send it immediately
             */
            if (radio_len != 0) {
                /* Send a packet */
                unsigned char c;
                LATB |= 0x01;
                radio_tx_start();
                radio_tx_data(radio_len);
                for (c = 0; c < radio_len; c++)
                    radio_tx_data(radio_data[c]);
                radio_tx_finish();
                LATB &= ~0x01;
            }
        }

        /* Read ADC values sequentally */
        {
            static char adc_ptr = 0;
            const char adc_addr[5] = {5, 15, 11, 9, 30};
            /* Reading value */
            adc_measure(adc_addr[adc_ptr]);
            adc_data[adc_ptr << 1] = ADRESH;
            adc_data[(adc_ptr << 1) | 1] = ADRESL;
            /* Incrementing address */
            adc_ptr++;
            if (adc_ptr >= 5)
                adc_ptr = 0;
        }
    }
}