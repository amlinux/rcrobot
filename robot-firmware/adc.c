#include <htc.h>
#include "adc.h"

void adc_init()
{
    ADCON0 = 0x00;
    ADCON1 = 0xe0;
}

void adc_measure(char channel)
{
    ADCON0 = ((channel & 0x1f) << 2) | 0x01;
    __delay_us(5);
    ADCON0 |= 0x02;
    while (ADCON0 & 0x02)
        1;
    ADCON0 = 0;
}