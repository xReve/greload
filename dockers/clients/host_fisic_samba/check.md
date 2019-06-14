[root@i22 ~]# su - pau
Password: 
Creating directory '/home/grups/test/pau'.
[pau@i22 ~]$ df -h
Filesystem            Size  Used Avail Use% Mounted on
devtmpfs              7.8G     0  7.8G   0% /dev
tmpfs                 7.8G   49M  7.8G   1% /dev/shm
tmpfs                 7.8G  2.3M  7.8G   1% /run
tmpfs                 7.8G     0  7.8G   0% /sys/fs/cgroup
/dev/sda5              98G   12G   82G  13% /
tmpfs                 7.8G  240K  7.8G   1% /tmp
tmpfs                 1.6G   20K  1.6G   1% /run/user/42
tmpfs                 1.6G  5.7M  1.6G   1% /run/user/101438
tmpfs                 1.6G  5.7M  1.6G   1% /run/user/0
//samba.edt.org/pere   98G   33G   66G  34% /home/grups/test/pere/pere
//samba.edt.org/pau    98G   33G   66G  34% /home/grups/test/pau/pau
[pau@i22 ~]$ pwd
/home/grups/test/pau
[pau@i22 ~]$ ll pau/
total 1024
-rwxr-xr-x. 1 pau test 33 Jun 14 10:41 welcome.md

