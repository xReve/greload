[root@i22 host_fisic_nfs]# su - anna
Password: 
[anna@i22 ~]$ df -h
Filesystem                 Size  Used Avail Use% Mounted on
devtmpfs                   7.8G     0  7.8G   0% /dev
tmpfs                      7.8G     0  7.8G   0% /dev/shm
tmpfs                      7.8G  2.0M  7.8G   1% /run
tmpfs                      7.8G     0  7.8G   0% /sys/fs/cgroup
/dev/sda5                   98G   12G   82G  13% /
tmpfs                      7.8G   92K  7.8G   1% /tmp
tmpfs                      1.6G   16K  1.6G   1% /run/user/42
tmpfs                      1.6G   36K  1.6G   1% /run/user/0
nfs:/home/grups/test/anna   98G   29G   65G  32% /home/grups/test/anna/anna
[anna@i22 ~]$  su - iamuser60
Password: 
Creating directory '/home/grups/wiam2/iamuser60'.
[iamuser60@i22 ~]$ df -h
Filesystem                       Size  Used Avail Use% Mounted on
devtmpfs                         7.8G     0  7.8G   0% /dev
tmpfs                            7.8G     0  7.8G   0% /dev/shm
tmpfs                            7.8G  2.0M  7.8G   1% /run
tmpfs                            7.8G     0  7.8G   0% /sys/fs/cgroup
/dev/sda5                         98G   12G   82G  13% /
tmpfs                            7.8G   92K  7.8G   1% /tmp
tmpfs                            1.6G   16K  1.6G   1% /run/user/42
tmpfs                            1.6G   36K  1.6G   1% /run/user/0
nfs:/home/grups/test/anna         98G   29G   65G  32% /home/grups/test/anna/anna
nfs:/home/grups/wiam2/iamuser60   98G   29G   65G  32% /home/grups/wiam2/iamuser60/iamuser60

