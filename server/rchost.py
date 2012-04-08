from concurrence import Tasklet
from rcserial import RCSerialStream

class Packet(object):
    "Packet to be sent over radio channel"
    def __init__(self, *data):
        self.buf = data[:]

class Host(object):
    "Interface to the hardware"
    def __init__(self, devname):
        "Constructor. devname - serial port devname"
        self.stream = RCSerialStream(devname)
        self.dispatcher = None

    def crc(self, crc, data):
        "Accepts previous CRC byte and data byte. Returns new CRC"
        for i in xrange(0, 8):
            if (crc ^ (data >> i)) & 1:
                crc ^= 0x9d
            crc >>= 1
        return crc

    def send(self, pkt):
        "Immediately pushes packet to the serial port"
        buf = chr(0x5a)
        crc = 0
        for data in [len(pkt.buf)] + list(pkt.buf):
            if type(data) == str and len(data) == 1:
                data = ord(data)
            crc = self.crc(crc, data)
            buf += chr(data)
        buf += chr(crc)
        print "Sending: %s" % (", ".join(["0x%02x" % ord(a) for a in buf]))
        with self.stream.get_writer() as writer:
            writer.write_bytes(buf)
            writer.flush()

    def loop(self):
        "Infinitely reads serial input and parses packets"
        with self.stream.get_reader() as reader:
            while True:
                # waiting for preamble
                while True:
                    data = ord(reader.read_bytes(1))
                    if data == 0x5a:
                        break
                # reading packet length
                crc = 0
                pktlen = ord(reader.read_bytes(1))
                crc = self.crc(crc, pktlen)
                # reading packet data
                if pktlen > 0:
                    data = []
                    for d in reader.read_bytes(pktlen):
                        d = ord(d)
                        data.append(d)
                        crc = self.crc(crc, d)
                    # reading CRC
                    crc = self.crc(crc, ord(reader.read_bytes(1)))
                    # checking CRC
                    if crc == 0:
                        print "Packet received successfully: %s" % (", ".join(["0x%02x" % d for d in data]))

class RequestNotImplemented(Exception):
    "This exception is raised by a protocol when it encounters unsupported request"
    pass

#class Protocol(object):
#    "Protocol is an implementation of remote device protocol. This is abstract class"
#    pass

class ResponseWaiter(object):
    "When request completed dispatcher calls all ResponseWaiters attached to it"
    def response(self, pkt):
        pass

class Request(object):
    """Request is the single request to the remote device. Requests can be queued and sent.
    Request contains list of parties interested in this request result"""
    def __init__(self, pkt):
        self.data = pkt
        self.tp = None
        self.constant = False
        self.waiters = []

    def add_waiter(self, waiter):
        self.waiters.append(waiter)

class Dispatcher(object):
    "Dispatcher implements requests machinery"
    def __init__(self):
        self.hosts = []

    def add_host(self, host):
        host.dispatcher = self
        self.hosts.append(host)
        Tasklet.new(host.loop)()

class RemoteDevice(object):
    "Interface to remote device"
    def __init__(self, dispatcher, addr):
        self.dispatcher = dispatcher
        self.addr = addr

    def protocol_version(self):
        pkt = Packet('R', 1, self.addr, 'V')
        req = Request(pkt)
        req.add_waiter(waiter)
