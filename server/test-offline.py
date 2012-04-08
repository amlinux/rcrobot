#!/usr/bin/python2.6
# -*- coding: utf-8 -*-

import unittest
from concurrence import dispatch, Tasklet, TimeoutError, Channel
from rchost import Dispatcher, crc, Request
from radio import RadioDevice

class EmulatedHost(object):
    def __init__(self, dispatcher):
        self.dispatcher = dispatcher

    def loop(self):
        ch = Channel()
        while True:
            ch.receive()

    def send(self, pkt):
        if pkt == [1, 2, 3]:
            self.dispatcher.receive([4, 5, 6])
        elif pkt == ['R', 1, 2, 'V']:
            self.dispatcher.receive([ord('R'), 2, 1, ord('V'), 88])

class TestCRC(unittest.TestCase):
    def testCRC(self):
        _crc = 0
        _crc = crc(_crc, 0x01)
        _crc = crc(_crc, 0xf0)
        self.assertEqual(_crc, 0x40)
        _crc = crc(_crc, 0x40)
        self.assertEqual(_crc, 0)

class EmulatedTest(unittest.TestCase):
    def setUp(self):
        self.dispatcher = Dispatcher()
        self.host = EmulatedHost(self.dispatcher)
        self.dispatcher.add_host(self.host)
        self.dispatcher_task = Tasklet.new(self.dispatcher.loop)
        self.dispatcher_task()

    def tearDown(self):
        self.dispatcher_task.kill()

class TestDispatcher(EmulatedTest):
    class TestRequest(Request):
        def data(self):
            return [1, 2, 3]

        def valid_response(self, data):
            if data == [4, 5, 6]:
                return "it worked"

    def testTimeout(self):
        disp = Dispatcher()
        req = TestDispatcher.TestRequest()
        self.assertRaises(TimeoutError, disp.request, req, 1)

    def testRequest(self):
        req = TestDispatcher.TestRequest()
        self.assertEqual(self.dispatcher.request(req), "it worked")

class TestRemoteDevice(EmulatedTest):
    def testVersion(self):
        dev = RadioDevice(self.dispatcher, 2)
        self.assertEqual(dev.protocol_version, 88)

if __name__ == "__main__":
    dispatch(unittest.main)
