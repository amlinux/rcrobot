from concurrence import Tasklet, Channel, TimeoutError
from rcserial import RCSerialStream

def crc(crc, data):
    "Accepts previous CRC byte and data byte. Returns new CRC"
    for i in xrange(0, 8):
        if (crc ^ (data >> i)) & 1:
            crc ^= 0x9d
        crc >>= 1
    return crc

class BaudRateCalibrationError(Exception):
    pass

class Host(object):
    "Interface to the hardware"
    def __init__(self, dispatcher, devname):
        "Constructor. devname - serial port devname"
        self.dispatcher = dispatcher
        self.stream = RCSerialStream(devname)

    def send_raw(self, buf):
        "Send raw data without any checksuming and headers"
        print "Sending: %s" % (", ".join(["0x%02x" % a for a in buf]))
        buf = ''.join([chr(a) for a in buf])
        with self.stream.get_writer() as writer:
            writer.write_bytes(buf)
            writer.flush()

    def flush(self):
        self.stream.flush()

    def send(self, pkt):
        "Immediately pushes packet to the serial port"
        buf = [0x5a]
        _crc = 0
        for data in [len(pkt)] + list(pkt):
            if type(data) == str and len(data) == 1:
                data = ord(data)
            _crc = crc(_crc, data)
            buf.append(data)
        buf.append(_crc)
        self.send_raw(buf)

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
                _crc = 0
                pktlen = ord(reader.read_bytes(1))
                _crc = crc(_crc, pktlen)
                # reading packet data
                if pktlen > 0:
                    data = []
                    for d in reader.read_bytes(pktlen):
                        d = ord(d)
                        data.append(d)
                        _crc = crc(_crc, d)
                    # reading CRC
                    _crc = crc(_crc, ord(reader.read_bytes(1)))
                    # checking CRC
                    if _crc == 0:
                        print "Packet received successfully: %s" % (", ".join(["0x%02x" % d for d in data]))
                        self.dispatcher.receive(data)

    def available(self):
        "Check whether host is available"
        req = HostEchoRequest()
        try:
            return self.dispatcher.request(req, timeout=3)
        except TimeoutError:
            return False

    def calibrate_baudrate(self):
        "Perform baud rate calibration"
        req = BaudRateCalibrationRequest()
        try:
            return self.dispatcher.request(req, timeout=3)
        except TimeoutError:
            raise BaudRateCalibrationError()

class RequestNotImplemented(Exception):
    "This exception is raised by a protocol when it encounters unsupported request"
    pass

class DestinationUnreachable(Exception):
    "Packet routing error"
    pass

#class Protocol(object):
#    "Protocol is an implementation of remote device protocol. This is an abstract class"
#    pass

#class ResponseWaiter(object):
#    "When request completed dispatcher calls all ResponseWaiters attached to it"
#    def response(self, pkt):
#        pass

class Request(object):
    """
    Request is the single request to the remote device. Requests can be queued and sent.
    Request can check any packet to detect whether it is a valid response.
    """
    def primary_key(self):
        """
        Primary key is a unique identifier of the request. Several requests with same primary key
        may be joined by the system and requested once.
        """
        return None

    def data(self):
        "Returns request data to be sent"
        return []

    def valid_response(self, data):
        "Checks whether this data is a valid response for the request"
        return False

    def send(self, host):
        "Send request to the host. Some requests may need to some specific sending protocol"
        host.send(self.data())

class Dispatcher(object):
    "Dispatcher implements requests machinery"
    def __init__(self):
        self.hosts = []
        self.sent_requests = []
        self.pending_requests = []
        self.req_channel = Channel()

    def add_host(self, host):
        "Add a host to the dispatcher. Host is a Host instance"
        self.hosts.append(host)

    def request(self, request, timeout=-1):
        """
        Performs request. Response data is returned to the caller.
        TimeoutError raised when no valid response received.
        """
        resp_channel = Channel()
        if self.req_channel.has_receiver():
            self.req_channel.send((request, resp_channel))
        else:
            self.pending_requests.append((request, resp_channel))
        return resp_channel.receive(timeout)

    def loop(self):
        "Infinitely reads input queue, performs requests and returns responses"
        host_tasks = []
        for host in self.hosts:
            task = Tasklet.new(host.loop)
            host_tasks.append(task)
            task()
        try:
            while True:
                while self.pending_requests:
                    request, resp_channel = self.pending_requests.pop(0)
                    self._send_request(request, resp_channel)
                request, resp_channel = self.req_channel.receive()
                self._send_request(request, resp_channel)
        finally:
            for task in host_tasks:
                task.kill()

    def route(self, request):
        """
        This method decides what host to send the request to.
        Return None if nowhere to send
        """
        if self.hosts:
            return self.hosts[0]

    def _send_request(self, request, resp_channel):
        host = self.route(request)
        if host is None:
            resp_channel.send_exception(DestinationUnreachable())
        else:
            self.sent_requests.append((request, resp_channel))
            request.send(host)

    def receive(self, data):
        "Notify dispatcher that packet is received"
        i = 0
        reqlen = len(self.sent_requests)
        while i < reqlen:
            req, resp_channel = self.sent_requests[i]
            resp = req.valid_response(data)
            if resp is not None:
                self.sent_requests.pop(i)
                resp_channel.send(resp)
                reqlen -= 1
            else:
                i += 1

class HostEchoRequest(Request):
    "Request to check host availability"
    def data(self):
        return ['E']

    def valid_response(self, data):
        if data == [ord('E')]:
            return True

class BaudRateCalibrationRequest(Request):
    "Calibrate frequency generator on the host to match server baud rate"
    def data(self):
        return [0xf0]

    def valid_response(self, data):
        if len(data) == 4 and data[0] == 0xf0:
            if data[1] == 0:
                return data[2:]
            else:
                raise BaudRateCalibrationError()

    def send(self, host):
        Request.send(self, host)
        host.flush()
        Tasklet.sleep(0.001)
        host.send_raw([0x55])
