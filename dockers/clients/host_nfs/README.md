# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

### NFS HOST

* En aquest apartat està desenvolupada la configuració per obtenir un host client per a un montatge de **homes** dels usuaris a travès d'un servidor **nfs**.

* Aquest host està desenvolupat a travès de la plataforma **docker**.

* Aquest docker contindra usuaris locals i LDAP els quals podran fer connexions i obtindran els homes del servidor NFS.

* Per poder obtenir aquest **client** nomès cal que executem la següent ordre:

```
docker run --rm --name nfshost.edt.org -h nfshost.edt.org --network gandhi-net --privileged -it eescriba/nfshost:greload
```
* És important destacar l'opció **--privileged** perquè el docker pugi permetre el montatge dels homes.

* Aquest client és un docker **interactiu** el qual pot pertanyer a qualsevol xarxa interna de docker. 

* El client no tindra coneixement de la xarxa on es troben els servidors, aquest demanarà les credencials i autenticació contra el **host** on està desplegat la estructura de servidors.  
És a dir, el host atacarà al mateix host per consultar el servidor **LDAP,KERBEROS I NFS**  i mai sabrà on es troben situats ja que no tindra accès a la red interna on es troben. 

* Tenint en compte això, ja es pot parlar sobre la configuració d'aquest i els fitxers involucrats en aquesta.

### CONFIGURACIÓ

* Aquest host requereix de un software determinat per poder funcionar correctament. Dins dels paquets a instal·lar, destacar els:

**nfs-utils** -> Paquet responsable per poder fer el montatge dels homes via **nfs**.

**nss-pam-ldapd** -> Paquet responsable de la **connexió** amb LDAP.

**pam_mount** -> Paquet que permet fer els **mount** dels homes.

**krb5-workstation** -> Paquet que inclou les ordres per interactuar amb **kerberos**.


* Una vegada tenint en compte els paquets, és interessant saber quins fitxers necessitarem per fer l'autenticació i el montatge correctament. 

`krb5.conf` ->  El fitxer krb5.conf conté informació de configuració de Kerberos, incloses les ubicacions de KDCs i servidors d’administració per als dominis d’interès de Kerberos, per defecte per al domini actual i per a aplicacions Kerberos i mapatges de noms d’ordinador a regnes Kerberos.

`ldap.conf` -> Fitxer de configuració / entorn LDAP

`nslcd.conf` -> Fitxer de configuració per al dimoni del servidor de noms LDAP

`nsswitch.conf``->  És utilitzat per la Biblioteca C de GNU i altres aplicacions a determinar les fonts per obtenir informació sobre el nom del servei en un ventall de categories i en quin ordre. Cada categoria de la informació s'identifica mitjançant un nom de base de dades.

`pam_mount.conf.xml` -> És el fitxer encarregat de montar recursos alhora d'iniciar sessió. Ens servirà per anar a buscar els homes i poder-los montar via **nfs**.

```
<volume user="*" fstype="nfs" server="nfs.edt.org" path="/home/grups/%(GROUP)/%(USER)" mountpoint="~/%(USER)" uid="%(USER)" gid="%(GROUP)" />
```

`system-auth` -> És el fitxer encarregat de gestionar l'inici de sessió i quins punts ha de tenir en compte: **validació ldap i autenticació kerberos, creació dels homes i montatge.**

```
#%PAM-1.0
# This file is auto-generated.
# User changes will be destroyed the next time authconfig is run.
auth        required      pam_env.so
auth        sufficient    pam_unix.so nullok
auth        optional      pam_mount.so
auth        sufficient    pam_krb5.so use_first_pass
auth        required      pam_deny.so

account     sufficient    pam_unix.so broken_shadow
account     sufficient    pam_localuser.so
account     sufficient    pam_succeed_if.so uid < 1000 quiet
account     [default=bad success=ok user_unknown=ignore] pam_krb5.so
account     required      pam_permit.so

password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=
password    sufficient    pam_unix.so sha512 shadow nullok try_first_pass use_authtok
password    sufficient    pam_krb5.so use_authtok
password    required      pam_deny.so

session     optional      pam_keyinit.so revoke
session     required      pam_limits.so
-session     optional      pam_systemd.so
session     optional      pam_mkhomedir.so
session     [success=2  default=ignore] pam_succeed_if.so uid > 5000
session     optional      pam_mount.so
session sufficient pam_krb5.so
session sufficient pam_unix.so
```

* Important activar els següents serveis per obtenir les dades del servidor LDAP:

```
/usr/sbin/nslcd && echo "nslcd Ok"
/usr/sbin/nscd && echo "nscd Ok"
```

* A més a més es necessari activar els serveis de nfs en client perquè el montatge sigui possible:

```
/usr/sbin/rpcbind && echo "rpcbind Ok"
/usr/sbin/rpc.statd && echo "rpc.stad Ok"
/usr/sbin/rpc.nfsd && echo "rpc.nfsd Ok"
```


### COMPROVACIÓ

```
root@xarlio:~/greload/dockers/clients/host_nfs# docker run --rm --name nfshost.edt.org -h nfshost.edt.org --privileged -it eescriba/nfshost:greload
Changing password for user local01.
passwd: all authentication tokens updated successfully.
Changing password for user local02.
passwd: all authentication tokens updated successfully.
Changing password for user local03.
passwd: all authentication tokens updated successfully.
Install Ok
nslcd Ok
nscd: 49 monitoring file `/etc/passwd` (1)
nscd: 49 monitoring directory `/etc` (2)
nscd: 49 monitoring file `/etc/group` (3)
nscd: 49 monitoring directory `/etc` (2)
nscd: 49 monitoring file `/etc/hosts` (4)
nscd: 49 monitoring directory `/etc` (2)
nscd: 49 monitoring file `/etc/resolv.conf` (5)
nscd: 49 monitoring directory `/etc` (2)
nscd: 49 monitoring file `/etc/services` (6)
nscd: 49 monitoring directory `/etc` (2)
nscd: 49 disabled inotify-based monitoring for file `/etc/netgroup': No such file or directory
nscd: 49 stat failed for file `/etc/netgroup'; will try again later: No such file or directory
nscd Ok
rpcbind Ok
rpc.stad Ok
rpc.nfsd Ok

[root@nfshost docker]# su - iamuser60
Creating directory '/home/grups/wiam2/iamuser60'.
reenter password for pam_mount:

[iamuser60@nfshost ~]$ df -h
Filesystem                               Size  Used Avail Use% Mounted on
overlay                                   98G   13G   81G  14% /
tmpfs                                    7.8G     0  7.8G   0% /dev
tmpfs                                    7.8G     0  7.8G   0% /sys/fs/cgroup
/dev/sda5                                 98G   13G   81G  14% /etc/hosts
shm                                       64M     0   64M   0% /dev/shm
nfs.edt.org:/home/grups/wiam2/iamuser60   98G   29G   65G  32% /home/grups/wiam2/iamuser60/iamuser60

[iamuser60@nfshost ~]$ ll
total 4
drwxr-xr-x. 2 iamuser60 wiam2 4096 Jun 18 08:25 iamuser60

[iamuser60@nfshost ~]$ ll iamuser60/
total 4
-rw-r--r--. 1 iamuser60 wiam2 33 Jun 18 08:25 welcome.md

[iamuser60@nfshost ~]$ pwd
/home/grups/wiam2/iamuser60
```

### PUNTS A DESTACAR

* Aquest client està configurat perquè ataqui contra el host **192.168.2.44**, lloc on es troba desplegada l'estructura de servidors. 

* En la instal·lació està configurat el següent:

```
echo "192.168.2.44 ldap.edt.org kserver.edt.org nfs.edt.org" >> /etc/hosts
```

* Això es deu a que docker no es capaç de poder resoldre a travès d'un **dns exterior** al del propi docker i per tant s'han de mapejar els noms dels servidors en comptes de que ho faci el nostre servidor dns.

* Quan s'intenta resoldre l'adreça que estem preguntant amb el nostre **dns** la petició passa a travès de la porta d'enllaç de docker i es queda estancat sense poder sortir a l'exterior.

* Per indicar quin dns volem que resolgui en el docker, es faria de la següent manera:

```
docker run --rm --name nfshost.edt.org -h nfshost.edt.org --privileged --dns 192.168.2.44 -it eescriba/nfshost:greload
```

**--dns** -> Canvia el `/etc/resolv.conf` i ho configura amb el servidor que li hagis passat a la opció

**COMPROVACIÓ**

```
[root@shost docker]# nslookup ldap.edt.org        
;; reply from unexpected source: 172.17.0.1#53, expected 192.168.2.44#53
;; reply from unexpected source: 172.17.0.1#53, expected 192.168.2.44#53
;; reply from unexpected source: 172.17.0.1#53, expected 192.168.2.44#53
;; connection timed out; no servers could be reached

```


* Sembla que docker no deixa buscar fora de la xarxa en que es troba el client, responent per la **.1** de la xarxa. 

* Aquest client no reb una ip del servidor **dhcp** ja que aquest servidor dhcp nomès es capaç de donar ip als hosts que es troben ubicats dins de la seva xarxa. Aquest és un punt a mirar i tornar a probar.

