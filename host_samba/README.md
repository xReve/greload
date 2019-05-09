# SAMBA HOST
## @edt ASIX M14-PROJECTE Curs 2018-2019


* Docker en el qual els usuaris locals i LDAP podran fer connexions i els seus homes seran montats del servidor Samba

* Usuari obtingut de **LDAP**, password de **KERBEROS** i el home a travès del servidor **samba**


* **EXECUCIÓ**

```
docker run --rm --name shost.edt.org -h shost.edt.org --network gandhi-net --privileged -it eescriba/sambahost:greload

```

* MOUNT TYPE **CIFS** 
 
cat `pam_mount.conf.xml` 

```
<volume user="*" fstype="cifs" server="samba" path="%(USER)" mountpoint="~/%(USER)" />

```


* **EXEMPLE**

```
[local02@shost ~]$ su - pere
Password: 
Creating directory '/home/grups/especial/pere'.

[pere@shost ~]$ df -h
Filesystem            Size  Used Avail Use% Mounted on
overlay               216G   20G  185G  10% /
tmpfs                  64M     0   64M   0% /dev
tmpfs                 1.9G     0  1.9G   0% /sys/fs/cgroup
/dev/sda1             216G   20G  185G  10% /etc/hosts
shm                    64M     0   64M   0% /dev/shm
//samba.edt.org/pere  216G   31G  185G  15% /home/grups/especial/pere/pere

[pere@shost ~]$ pwd
/home/grups/especial/pere

[pere@shost ~]$ ll
total 0
drwxr-xr-x 2 pere especial 0 May  9 16:17 pere

[pere@shost ~]$ ll pere/
total 1024
-rwxr-xr-x 1 pere especial 33 May  9 16:17 welcome.md

```
