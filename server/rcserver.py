#!/usr/bin/python2.6

# Project path
import sys
import re
path = re.sub(r'\/[^\/]+$', '', sys.argv[0])
sys.path.append(path)

from concurrence import dispatch, Tasklet
from concurrence.http import WSGIServer
import logging
from rchost import Dispatcher, Host
from radiodevice import RadioDevice
import os
os.environ["DJANGO_SETTINGS_MODULE"] = "rcweb.settings"
import django.core.handlers.wsgi

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

        # Running HTTP server
        application = django.core.handlers.wsgi.WSGIHandler()
        def app_wrapper(*args, **kwargs):
            try:
                return application(*args, **kwargs)
            except Exception as e:
                print e
        server = WSGIServer(application)
        server.serve(('localhost', 8080))

        while True:
            print "ADC data: %s, supply voltage: %.2f" % (dev.adc_data(), dev.supply_voltage())
            Tasklet.sleep(1)

        os._exit(0)
    except Exception as e:
        logging.exception(e)
        os._exit(1)

dispatch(main)

