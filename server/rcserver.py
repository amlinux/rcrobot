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
        def f():
            print "Protocol version: %s" % dev.protocol_version
        #tasklets = []
        for i in xrange(0, 10):
            f()
            #task = Tasklet.new(f)
            #task()
            #tasklets.append(task)
        #Tasklet.join_all(tasklets)

        #host.send(Packet('E'))
        #host.send(Packet('R', 1, 2, 'E'))
        #host.send(Packet('R', 1, 2, 'V'))
        #while True:
            #host.send(Packet('R', 1, 2, 'M', 1+2+16))
            #host.send(Packet('R', 1, 2, 'M', 0))
            #host.send(Packet('R', 1, 2, 'M', 1+4+8))
            #host.send(Packet('R', 1, 2, 'M', 0))
            #Tasklet.yield_()
        os._exit(0)
    except Exception as e:
        logging.exception(e)
        os._exit(1)

dispatch(main)

