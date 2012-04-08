#!/usr/bin/python2.6

from concurrence import dispatch, Tasklet
import logging
import os
from rchost import Dispatcher, Host, Packet

def main():
    try:
        dispatcher = Dispatcher()
        host = Host("/dev/ttyS0")
        dispatcher.add_host(host)

        #host.send(Packet('E'))
        #host.send(Packet('R', 1, 2, 'E'))
        #host.send(Packet('R', 1, 2, 'V'))
        while True:
            #host.send(Packet('R', 1, 2, 'M', 1+2+16))
            #host.send(Packet('R', 1, 2, 'M', 0))
            #host.send(Packet('R', 1, 2, 'M', 1+4+8))
            #host.send(Packet('R', 1, 2, 'M', 0))
            Tasklet.yield_()
        os._exit(0)
    except Exception as e:
        logging.exception(e)
        os._exit(1)

dispatch(main)

