#!/usr/bin/python2.6

from concurrence import dispatch, Tasklet
import logging
import os
from rchost import Dispatcher, Host
from radiodevice import RadioDevice

def main():
    try:
        dispatcher = Dispatcher()
        host = Host(dispatcher, "/dev/ttyS0")
        dispatcher.add_host(host)
        Tasklet.new(dispatcher.loop)()

        print "Calibration: %s" % host.calibrate_baudrate()
        print "Available: %s" % host.available()

        dev = RadioDevice(dispatcher, 2)
        print "Protocol version: %s" % dev.protocol_version

        while True:
            print "ADC data: %s, supply voltage: %.2f" % (dev.adc_data(), dev.supply_voltage())
            Tasklet.sleep(1)

        os._exit(0)
    except Exception as e:
        logging.exception(e)
        os._exit(1)

dispatch(main)

