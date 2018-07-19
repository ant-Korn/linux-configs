#!/usr/bin/env python
import pexpect
import getpass
import os

def check_ip(ip, port, ip_checker):
    os.system("curl --socks5 "+ip+":"+port+" "+ip_checker)

ip = "127.0.0.1"
port_config = "9051"
port_proxy = "9050"
ip_checker = "https://checkip.amazonaws.com/"

print("Old IP: ", end="", flush=True)
check_ip(ip, port_proxy, ip_checker)

telconn = pexpect.spawn("telnet "+ip+" "+port_config, timeout=2, encoding='utf-8')

res = telconn.expect(["Connected to "+ip+".", pexpect.TIMEOUT])
if res == 0:
    password = getpass.getpass()
    telconn.sendline("AUTHENTICATE "+password)
    res = telconn.expect(["250 OK",
                          "Connection closed by foreign host.",
                          pexpect.TIMEOUT])
    if  res == 0:
        telconn.sendline("signal NEWNYM")
        telconn.sendline("quit")
        print("New IP: ", end="", flush=True)
        check_ip(ip, port_proxy, ip_checker)
    else:
        print("Not authenticate")
elif res == 1:
    print("Not connected")
telconn.close()
