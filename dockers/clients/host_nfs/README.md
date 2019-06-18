# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

### NFS HOST


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




```
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




