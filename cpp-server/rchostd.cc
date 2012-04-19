#include <iostream>
#include <cerrno>
#include <cstring>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <vector>
#include <unistd.h>
#include <iomanip>
#include <termios.h>
#include <cstdlib>

using namespace std;

class Exception {
public:
    Exception(const string &str): m_str(str) {}
    const string &get_str() const { return m_str; }
private:
    string m_str;
};

ostream &operator<<(ostream &str, const Exception &e)
{
    str << e.get_str();
    return str;
}

class SysException: public Exception {
public:
    SysException(const string &str): Exception(str + ": " + strerror(errno)) {}
};

class SerialPort {
public:
    SerialPort(const char *devname)
    {
        fd = open(devname, O_RDWR | O_NOCTTY | O_NONBLOCK | O_EXCL);
        if (fd < 0)
            throw SysException("Opening serial port");
        struct termios attr;
        tcgetattr(fd, &attr);
        cfmakeraw(&attr);
        cfsetspeed(&attr, B19200);
        tcsetattr(fd, TCSANOW, &attr);
    }

    ~SerialPort()
    {
        if (fd >= 0)
            close(fd);
    }

    int read(unsigned char *buffer, int buflen)
    {
        int res = ::read(fd, buffer, buflen);
        if (res < 0) {
            if (errno == EAGAIN)
                return 0;
            throw SysException("Reading from serial port");
        }
        return res;
    }

    void write_all(const unsigned char *buffer, int size)
    {
        int ptr = 0;
        while (ptr < size) {
            int res = write(fd, buffer + ptr, size - ptr);
            if (res < 0) {
                if (res == EAGAIN) {
                    usleep(0);
                } else
                    throw SysException("Writing to the serial port");
            }
            ptr += res;
        }
    }

    void flush()
    {
        tcdrain(fd);
    }

private:
    int fd;
};

typedef vector<unsigned char> Buffer;

class Packet {
public:
    Packet(const Buffer &buf):
        m_buf(buf)
    {
    }

    Packet(unsigned char cmd)
    {
        add(cmd);
    }

    void add(unsigned char cmd)
    {
        m_buf.push_back(cmd);
    }

    ~Packet()
    {
    }

    const Buffer &get_buf() const
    {
        return m_buf;
    }
private:
    Buffer m_buf;
};

ostream &operator<<(ostream &str, const Buffer &buf)
{
    str << '[' << hex;
    for (int i = 0; i < buf.size(); i++) {
        str << setw(2) << setfill('0') << (int)buf[i];
        if (i != buf.size() - 1)
            str << ", ";
    }
    str << ']';
    return str;
}

ostream &operator<<(ostream &str, const Packet &pkt)
{
    return str << pkt.get_buf();
}

class RCHostServer {
public:
    RCHostServer(SerialPort &port):
        m_port(port), rcv_state(0),
        ping_running(false), last_time(0), pkt_sent(0), pkt_recv(0),
        last_stat(0)
    {
    }

    ~RCHostServer()
    {
    }

    void idle()
    {
        receive();
        time_t now = time(0);
        if (ping_running) {
            if (now != last_time) {
                pkt_sent++;
                last_time = now;
                {
                    Packet wpkt('E');
                    int len = rand() % 50;
                    for (int i = 0; i < len; i++)
                        wpkt.add(rand() % 256);
                    send(wpkt);
                    if (pkt_sent > 1)
                        cout << "Sent: " << dec << pkt_sent << "; received: " << pkt_recv << "; drop " << (pkt_sent - 1 - pkt_recv) * 100.0 / (pkt_sent - 1) << "%" << endl;
                    else
                        pkt_recv = 0;
                }
                {
                    Packet wpkt('R');
                    wpkt.add(1);
                    wpkt.add(2);
                    wpkt.add('E');
                    send(wpkt);
                }
            }
        }
        if (now > last_stat + 30) {
            Packet wpkt(0xf1);
            send(wpkt);
            last_stat = now;
        }
    }

    void receive()
    {
        const int BUFSIZE = 1024;
        unsigned char buffer[BUFSIZE];
        int len = m_port.read(buffer, BUFSIZE);
        if (!len)
            return;
        for (int i = 0; i < len; i++)
            received(buffer[i]);
    }

    void crc(unsigned char *crc, unsigned char data)
    {
        for (int i = 0; i < 8; i++) {
            if ((*crc ^ data) & 1) {
                *crc ^= 0x9d;
            }
            *crc >>= 1;
            data >>= 1;
        }
    }

    void received(unsigned char d)
    {
        cout << "Received: " << hex << setw(2) << setfill('0') << (int)d << endl;
        switch (rcv_state) {
            case 0:
                if (d == 0x5a)
                    rcv_state = 1;
                break;
            case 1:
                if (d == 0) {
                    rcv_state = 0;
                } else {
                    rcv_len = d;
                    rcv_state = 2;
                    rcv_crc = 0;
                    crc(&rcv_crc, d);
                    rbuf.clear();
                }
                break;
            case 2:
                crc(&rcv_crc, d);
                rbuf.push_back(d);
                if (--rcv_len == 0)
                    rcv_state = 3;
                break;
            case 3:
                if (rcv_crc == d) {
                    // packet received
                    Packet pkt(rbuf);
                    unsigned char cmd = pkt.get_buf()[0];
                    if (cmd == 0xf0 && !ping_running) {
                        ping_running = true;
                        pkt_sent = 0;
                        pkt_recv = 0;
                    } else if (ping_running && cmd == 'E')
                        pkt_recv++;
                    else
                        cout << "Received packet: " << pkt << endl;
/*                    static int n = 0;
                    const Buffer &buf = pkt.get_buf();
                    if (buf[0] == 'R') {
                        n = 0;
                    } else if (buf[0] == 'E') {
                        n = buf[1];
                    }
                    // send response packet
                    Packet wpkt(n);
                    int len = rand() % 15;
                    for (int i = 0; i < len; i++)
                        wpkt.add(rand() % 256);
                    send(wpkt);*/
                }
                rcv_state = 0;
                break;
            default:
                rcv_state = 0;
        }
    }

    void send(const Packet &pkt)
    {
//        cout << "Sending packet: " << pkt << endl;

        const Buffer &buf = pkt.get_buf();
        int size = buf.size() + 3;
        unsigned char buffer[size];

        // preparing packet data
        buffer[0] = 0x5a;
        buffer[1] = buf.size();
        unsigned char snd_crc = 0;
        crc(&snd_crc, buffer[1]);
        for (int i = 0; i < buf.size(); i++) {
            unsigned char data = buf[i];
            buffer[2 + i] = data;
            crc(&snd_crc, data);
        }
        buffer[size - 1] = snd_crc;

        cout << "Sending bytes:";
        for (int i = 0; i < size; i++)
            cout << ' ' << hex << setw(2) << setfill('0') << (int)buffer[i];
        cout << endl;

        // sending packet
        m_port.write_all(buffer, size);
    }

    void calibrate()
    {
        Packet wpkt(0xf0);
        send(wpkt);
        m_port.flush();
        usleep(1000);
        unsigned char sync = 0x55;
        m_port.write_all(&sync, 1);
        m_port.flush();
        usleep(1000);
    }

private:
    // serial port
    SerialPort &m_port;

    // receive buffer
    Buffer rbuf;

    // receive state
    int rcv_state;
    unsigned char rcv_len;
    unsigned char rcv_crc;

    // ping
    bool ping_running;
    time_t last_time;
    int pkt_sent;
    int pkt_recv;

    // sync
    time_t last_stat;
};

int main()
{
    try {
        SerialPort port("/dev/ttyS0");
        RCHostServer srv(port);
        srv.calibrate();
        while (1) {
            srv.idle();
            usleep(0);
        }
    } catch (Exception e) {
        cout << e << endl;
    }
}
