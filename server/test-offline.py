#!/usr/bin/python2.6
# -*- coding: utf-8 -*-

import unittest
from concurrence import dispatch, Tasklet, TimeoutError, Channel
from rchost import Dispatcher, crc, Request, DeviceUnreachable
from radiodevice import RadioDevice, RadioDeviceRequest

class EmulatedHost(object):
    def __init__(self, dispatcher):
        self.dispatcher = dispatcher
        self._ch = Channel()

    def loop(self):
        while True:
            pkt = self._ch.receive()
            Tasklet.yield_()
            if pkt == [1, 2, 3]:
                # Test request
                self.dispatcher.receive([4, 5, 6])
            elif pkt == ['R', 5, 1, 2, 'V']:
                # Version request
                self.dispatcher.receive([ord('R'), 2, 1, ord('V'), 88])
            elif pkt == [1, 2, 5]:
                # Device unreachable (timeout)
                self.dispatcher.receive([ord('N'), 5, 1])
            elif pkt == [1, 2, 6]:
                # Device unreachable (incorrect response)
                self.dispatcher.receive([ord('N'), 5, 2])
            elif pkt == [1, 2, 7]:
                # Valid radio response
                self.dispatcher.receive([ord('R'), 3, 1, 4, 5, 6])

    def send(self, pkt):
        self._ch.send(pkt)

    def next_pkt_id(self):
        return 5

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

    class TestFailingRequest(RadioDeviceRequest):
        def __init__(self):
            RadioDeviceRequest.__init__(self, 3, [1])
            self.attempt = 0

        def data(self):
            self.attempt += 1
            if self.attempt == 1:
                # System will respond with DeviceUnreachable
                return [1, 2, 5]
            elif self.attempt == 2:
                # System will respond with DeviceUnreachable(2) and it will
                # result in automatic request resending even for onetime queries
                return [1, 2, 6]
            else:
                # Valid radio request
                return [1, 2, 7]

        def valid_device_response(self, data):
            if data == [4, 5, 6]:
                return "it worked"

    def testTimeout(self):
        disp = Dispatcher()
        req = TestDispatcher.TestRequest()
        self.assertRaises(TimeoutError, disp.request, req, 1)

    def testRequest(self):
        req = TestDispatcher.TestRequest()
        self.assertEqual(self.dispatcher.request(req), "it worked")

    def testRetries(self):
        req = TestDispatcher.TestFailingRequest()
        self.assertEqual(self.dispatcher.request(req), "it worked")

    def testExceptions(self):
        req = TestDispatcher.TestFailingRequest()
        self.assertRaises(DeviceUnreachable, self.dispatcher.request, req, 0)
        self.assertEqual(self.dispatcher.request(req, 0), "it worked")

class TestRemoteDevice(EmulatedTest):
    def testVersion(self):
        dev = RadioDevice(self.dispatcher, 2)
        self.assertEqual(dev.protocol_version, 88)

if __name__ == "__main__":
    dispatch(unittest.main)
