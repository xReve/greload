# PAM
## @edt ASIX M06-ASO Curs 2018-2019

Repositori d'exemples de containers docker que utilitzen PAM

 * **hostpam:18homenfsd** host pam amb authenticació ldap. Munta els homes de l'usuari via nfs.
Atenció, per poder realitzar el mount cal que el container es generi amb l'opció **--privileged**.

Implementa un buble *curtre* per deixar el container en detach.

Fer que els homes dels usuaris es muntin per nfs. Primer caldrà en un servidor nfs crear els directoris homes dels usuaris, i assignar-los els permisos apropiats, propietari i grup (recursivament). Podem fer que el servidor nfs sigui primerament el nostre host amb l’adreça de docker, i posteriorment fabricar un container servidor nfs.

Un host  pam client pot carregar de cop tots els homes del servidor nfs i muntar-los com a homes locals (tot /var/tmp/home es munta a /tmp/home que és on hi ha els homes locals). Per fer-ho així simplement cal configurar fstab per muntar el homes global.

Si volem que els homes de xarxa dels usuaris es muntin individualment, per exemple posant un directori home-xarxa dins del home local, cal instal·lar pam_mount i configurar pam_mount.conf.xml. 
És especialment important configurar correctament els permisos amb què es munta el directori de xarxa, el propietari i grup ha de ser el de l’usuari.

Atenció: considerem que tenim un servidor nfs actiu i en marxa per exemple al nostre propi host (no en un docker). S’han creat els directoris i fet el chown -R. L’exportació funciona, l’hem provada localment i va.

Atenció: en el container client CAL assegurar-se que el nom de host nfsserver apunta correctament a la ip de docker del nostre host, per exemple la 172.20.0.1. Afegiu aquesta entrada al /etc/hosts.

Atenció: senmbla que el client no engega cap dels serveis relacionats amb nfs-utils. S’hi menja tot pam_mount.


#### Execució

```
docker run --rm --name host -h host --net ldapnet --privileged -d edtasixm06/hostpam:18homenfsd
```

#### Configuracions

system-auth:
```
session     optional      pam_mkhomedir.so
session     [success=1 default=ignore] pam_succeed_if.so service in crond quiet use_uid
session     [success=1  default=ignore] pam_succeed_if.so uid <= 5000
   session     optional      pam_mount.so
session     sufficient    pam_unix.so

```

pam_mount.conf.xml (només a pere se li genera el  ramdisk):
```
<volume user="pere" fstype="tmpfs" mountpoint="~/test" options="size=10M,uid=%(USER),mode=0755" />
<volume user="*" fstype="nfs" server="nfsserver" path="/var/tmp/home/%(USER)"  mountpoint="~/%(USER)" uid="%(USER)" gid="%(GROUP)" />
```


#### Utilització

```
[local01@host ~]$ su - local02
pam_mount password:
[local02@host ~]$ pwd
/home/local02
[local02@host ~]$ ll
total 0

[local01@host ~]$ su - pere
pam_mount password:
[pere@host ~]$ pwd
/tmp/home/pere
[pere@host ~]$ ll
total 4
drwx------. 3 pere users 4096 Nov 24 14:44 pere
drwxr-xr-x. 2 pere users   40 Nov 24 16:26 test
```

