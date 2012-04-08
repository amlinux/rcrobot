#ifndef RADIO_H
#define RADIO_H

extern unsigned char radio_rx_len;
extern unsigned char radio_rx_data[64];

/* initialize ports */
void radio_init();

/* disable radio */
void radio_off();

/* start sending packet */
void radio_tx_start();

/* send packet byte (delay after returning from previous call to
 * radio_send_preamble or radio_send_data must be less than 1/2 of data bit
 * length) */
void radio_tx_data(unsigned char data);

/* send final CRC and disable radio module */
void radio_tx_finish();

/* receive data. First of all calls radio_rx_reset. Then waits for preamble.
 * If no preamble return immediately. If preamble is running then listen
 * for data. for every byte received call radio_rx_data. If data packet
 * interrupted by another preamble calls radio_rx_reset again and reruns.
 * If receiving timed out calls radio_rx_timeout and returns. */
void radio_rx();

/* this callback is called when packet is received successfully
 * packet length is stored in radio_rx_len, data - radio_rx_data */
void radio_rx_packet();

#endif