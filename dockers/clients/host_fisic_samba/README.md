# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

### HOST FÍSIC SAMBA


* En aquest apartat està desenvolupada la configuració per obtenir un host client per a un montatge de **homes** dels usuaris a travès d'un servidor **samba**. 

* Aquest host és un **ordenador físic** on es configuraran els fitxers pertinents per tal de actuar com un client.

* Aquest host té usuaris locals i de LDAP els quals podran fer connexions i obtindran els homes del servidor SAMBA.

* Aquest host està configurat de tal manera que ataqui contra el host **192.168.2.44** en el qual es troben els servidors en una xarxa interna.

* Per tenir aquest host configurat per actuar com a client, el configurarem de la següent manera:

### CONFIGURACIÓ

**INSTAL·LACIÓ DE PAQUETS** -> És necessari instal·lar uns paquets base per obtenir les eines adients per configurar el host.

```
krb5-workstation passwd cifs-utils authconfig pam_krb5 openssh-clients nss-pam-ldapd procps pam_mount iputils iproute dhclient bind-utils
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
```

* Finalment nomès queda canviar la configuració del **dns**.

```
cp resolv.conf /etc/resolv.conf
```

* Una vegada configurat tot això ja podriem anar a comprovar si podem iniciar sessió i obtenir el **home**.

### COMPROVACIÓ

```
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
```

* El client ataca contra el host **192.168.2.44** preguntat per tots els servidors. Tots els servidors són un **CNAME** de **gandhi**.

### ALTRES PUNTS

* Existeix l'script anomenat `install.sh` que incorpora cada part descrita anteriorment.

* No obstant dins de l'script es recomana fer algunes parts manualment per assegurar-se de que han funcionat.


