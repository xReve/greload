[root@i22 ~]# ping ldap.edt.org
PING gandhi.edt.org (192.168.2.44) 56(84) bytes of data.
64 bytes from 192.168.2.44 (192.168.2.44): icmp_seq=1 ttl=64 time=0.124 ms
64 bytes from 192.168.2.44 (192.168.2.44): icmp_seq=2 ttl=64 time=0.175 ms
^C
--- gandhi.edt.org ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1001ms
rtt min/avg/max/mdev = 0.124/0.149/0.175/0.028 ms
[root@i22 ~]# ping gandhi
PING gandhi.edt.org (192.168.2.44) 56(84) bytes of data.
64 bytes from 192.168.2.44 (192.168.2.44): icmp_seq=1 ttl=64 time=0.125 ms
64 bytes from 192.168.2.44 (192.168.2.44): icmp_seq=2 ttl=64 time=0.188 ms
^C
--- gandhi.edt.org ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1057ms
rtt min/avg/max/mdev = 0.125/0.156/0.188/0.033 ms
[root@i22 ~]# ping kserver
PING gandhi.edt.org (192.168.2.44) 56(84) bytes of data.
64 bytes from 192.168.2.44 (192.168.2.44): icmp_seq=1 ttl=64 time=0.131 ms
64 bytes from 192.168.2.44 (192.168.2.44): icmp_seq=2 ttl=64 time=0.195 ms
^C
--- gandhi.edt.org ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1014ms
rtt min/avg/max/mdev = 0.131/0.163/0.195/0.032 ms
[root@i22 ~]# ping samba
PING gandhi.edt.org (192.168.2.44) 56(84) bytes of data.
64 bytes from 192.168.2.44 (192.168.2.44): icmp_seq=1 ttl=64 time=0.152 ms
64 bytes from 192.168.2.44 (192.168.2.44): icmp_seq=2 ttl=64 time=0.190 ms
64 bytes from 192.168.2.44 (192.168.2.44): icmp_seq=3 ttl=64 time=0.194 ms
^C
--- gandhi.edt.org ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2033ms
rtt min/avg/max/mdev = 0.152/0.178/0.194/0.024 ms
[root@i22 ~]# ping nfs
PING gandhi.edt.org (192.168.2.44) 56(84) bytes of data.
64 bytes from 192.168.2.44 (192.168.2.44): icmp_seq=1 ttl=64 time=0.122 ms
64 bytes from 192.168.2.44 (192.168.2.44): icmp_seq=2 ttl=64 time=0.166 ms
^C
--- gandhi.edt.org ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1024ms
rtt min/avg/max/mdev = 0.122/0.144/0.166/0.022 ms



setenforce 0

sed -i -e s,'SELINUX=enforcing','SELINUX=permissive', /etc/selinux/config

systemctl restart nfs-secure.service


