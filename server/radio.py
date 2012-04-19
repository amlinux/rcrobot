from rchost import Request

class RadioDeviceRequest(Request):
    "Request to remote radio device"
    def __init__(self, addr, data):
        self._addr = addr
        self._data = data

    def data(self):
        return ['R', 1, self._addr] + self._data

    def valid_response(self, data):
        """
        RadioDeviceRequests checks packet header and if it is a radio packet from target device
        performs additional checks with valid_device_response()
        """
        if len(data) >= 4 and data[0] == ord('R') and data[1] == self._addr and data[2] == 1:
            data = data[3:]
            return self.valid_device_response(data)
    
    def valid_device_response(self, data):
        """
        This method received packet data (without radio header) and shouild response either with
        some data that is considered successful response or with None otherwise.
        """
        return None

class VersionRequest(RadioDeviceRequest):
    def __init__(self, addr):
        RadioDeviceRequest.__init__(self, addr, ['V'])

    def valid_device_response(self, data):
        if len(data) == 2 and data[0] == ord('V'):
            return data[1]

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

