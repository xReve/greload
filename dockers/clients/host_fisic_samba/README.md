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



[root@i21 host_fisic_samba]# su - anna
Password: 
Creating directory '/home/grups/test/anna'.
[anna@i21 ~]$ df -h
Filesystem      Size  Used Avail Use% Mounted on
devtmpfs        7.8G     0  7.8G   0% /dev
tmpfs           7.8G   41M  7.8G   1% /dev/shm
tmpfs           7.8G  2.0M  7.8G   1% /run
tmpfs           7.8G     0  7.8G   0% /sys/fs/cgroup
/dev/sda5        98G   15G   79G  16% /
tmpfs           7.8G  156K  7.8G   1% /tmp
tmpfs           1.6G   16K  1.6G   1% /run/user/42
tmpfs           1.6G  5.8M  1.6G   1% /run/user/0
//samba/anna     98G   34G   65G  35% /home/grups/test/anna/anna
[anna@i21 ~]$ logout
[root@i21 host_fisic_samba]# su - iamuser60
Password: 
Creating directory '/home/grups/wiam2/iamuser60'.
[iamuser60@i21 ~]$ df -h
Filesystem         Size  Used Avail Use% Mounted on
devtmpfs           7.8G     0  7.8G   0% /dev
tmpfs              7.8G   41M  7.8G   1% /dev/shm
tmpfs              7.8G  2.0M  7.8G   1% /run
tmpfs              7.8G     0  7.8G   0% /sys/fs/cgroup
/dev/sda5           98G   15G   79G  16% /
tmpfs              7.8G  156K  7.8G   1% /tmp
tmpfs              1.6G   16K  1.6G   1% /run/user/42
tmpfs              1.6G  5.8M  1.6G   1% /run/user/0
//samba/iamuser60   98G   34G   65G  35% /home/grups/wiam2/iamuser60/iamuser60



