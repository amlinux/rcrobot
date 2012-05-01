from rchost import Request, DeviceUnreachable

class RadioDeviceRequest(Request):
    "Request to remote radio device"
    def __init__(self, addr, data):
        Request.__init__(self)
        self._addr = addr
        self._data = data
        self._pkt_id = None

    def data(self):
        return ['R', self._pkt_id, 1, self._addr] + self._data

    def valid_response(self, data):
        """
        RadioDeviceRequests checks packet header and if it is a radio packet from target device
        performs additional checks with valid_device_response()
        """
        if len(data) >= 4 and data[0] == ord('R') and data[1] == self._addr and data[2] == 1:
            # Extract payload
            data = data[3:]
            return self.valid_device_response(data)
        if len(data) == 2 and data[0] == ord('Y') and data[1] == self._pkt_id:
            return True
        if len(data) == 3 and data[0] == ord('N') and data[1] == self._pkt_id:
            raise DeviceUnreachable(data[2])

    def send(self, host):
        self._pkt_id = host.next_pkt_id()
        return Request.send(self, host)
    
    def valid_device_response(self, data):
        """
        This method received packet data (without radio header) and shouild response either with
        some data that is considered successful response or with None otherwise.
        """
        return None

class VersionRequest(RadioDeviceRequest):
    def __init__(self, addr):
        RadioDeviceRequest.__init__(self, addr, ['V'])
        self.primary_key = "VersionRequest-%d" % addr

    def valid_device_response(self, data):
        if len(data) == 2 and data[0] == ord('V'):
            return data[1]

class ADCRequest(RadioDeviceRequest):
    def __init__(self, addr):
        RadioDeviceRequest.__init__(self, addr, ['D'])
        self.primary_key = "ADCRequest-%d" % addr

    def valid_device_response(self, data):
        if len(data) == 11 and data[0] == ord('D'):
            adc = []
            for i in xrange(0, 5):
                adc.append(data[i * 2 + 1] * 256 + data[i * 2 + 2])
            return adc

class RadioDevice(object):
    "Interface to the remote device"
    def __init__(self, dispatcher, addr):
        self.dispatcher = dispatcher
        self.addr = addr

    @property
    def protocol_version(self):
        try:
            return self._protocol_version
        except AttributeError:
            req = VersionRequest(self.addr)
            self._protocol_version = self.dispatcher.request(req)
            return self._protocol_version

    def adc_data(self):
        req = ADCRequest(self.addr)
        return self.dispatcher.request(req)
