# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

### HOST FÍSIC NFS

* En aquest apartat està desenvolupada la configuració per obtenir un host client per a un montatge de **homes** dels usuaris a travès d'un servidor **nfs**. 

* Aquest host és un **ordenador físic** on es configuraran els fitxers pertinents per tal de actuar com un client.

* Aquest host té usuaris locals i de LDAP els quals podran fer connexions i obtindran els homes del servidor NFS.

* Aquest host està configurat de tal manera que ataqui contra el host **192.168.2.44** en el qual es troben els servidors en una xarxa interna.

* Per tenir aquest host configurat per actuar com a client, el configurarem de la següent manera:

### CONFIGURACIÓ

**INSTAL·LACIÓ DE PAQUETS** -> És necessari instal·lar uns paquets base per obtenir les eines adients per configurar el host.

```
procps passwd openldap-clients nss-pam-ldapd authconfig pam_mount nfs-utils iputils pam_krb5 krb5-workstation dhclient iproute nmap bind-utils sssd
```

* No tots els paquests són essencials, però recomano la instal·lació de tots ells ja que són interessants i útils.

* Vigilar amb la seguretat del sistema que no ens bloqueji algún paràmetre de configuració. 

```
setenforce 0

sed -i -e s,'SELINUX=enforcing','SELINUX=permissive', /etc/selinux/config
```

* Fitxers de configuració **ldap i kerberos**

```
cp nslcd.conf /etc/nslcd.conf
cp nsswitch.conf /etc/nsswitch.conf
cp ldap.conf /etc/openldap/ldap.conf

cp krb5.conf /etc/krb5.conf
cp sssd.conf /etc/sssd/sssd.conf
```

* Configuració amb la commanda `authconfig` de ldap i kerberos:

```
authconfig  --enableshadow --enablelocauthorize --enableldap \
            --ldapserver='ldap' --ldapbase='dc=edt,dc=org' \
            --enablekrb5 --krb5kdc='kserver.edt.org' \
            --krb5adminserver='kserver.edt.org' --krb5realm='EDT.ORG' \
--updateall

```

* Fitxers de l'inici de sessió i montatge del **home**.

```
cp pam_mount.conf.xml /etc/security/pam_mount.conf.xml
cp system-auth /etc/pam.d/system-auth
``` 

* Activació dels serveis.

```
/usr/sbin/nslcd && echo "nslcd Ok"
/usr/sbin/nscd && echo "nscd Ok"
systemctl restart nfs-secure.service
```

* Finalment nomès queda canviar la configuració del **dns**.

```
cp resolv.conf /etc/resolv.conf
```

* Una vegada configurat tot això ja podriem anar a comprovar si podem iniciar sessió i obtenir el **home**.

### COMPROVACIÓ

```
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
```

* El client ataca contra el host **192.168.2.44** preguntat per tots els servidors. Tots els servidors són un **CNAME** de **gandhi**.

```
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

```

### ALTRES PUNTS

* Existeix l'script anomenat `install.sh` que incorpora cada part descrita anteriorment.

* No obstant dins de l'script es recomana fer algunes parts manualment per assegurar-se de que han funcionat.



