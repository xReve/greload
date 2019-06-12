# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

## SERVIDOR SAMBA

* En aquesta part del projecte està desenvolupat el servidor **SAMBA**.


Servidor que permet el montatge d els homes dels usuaris LDAP a travès del volum que se li monta al engegarse del docker **homes**.

**COMPROVACIÓ MOUNT VOLUM**

* El docker **homes** exporta el volum **/home** que es monta automaticament al engegar el servidor **samba** utilitzant la opció 
**--volumes-from homes.edt.org** , li indiques que vols montar tots els volums que té un docker en concret. 

```
[root@samba docker]# mount -t ext4
/dev/sda1 on /home type ext4 (rw,relatime,errors=remount-ro)
```

```
[root@samba docker]# ll /home/grups/
total 32
drwxr-xr-x 3 root root 4096 May  9 16:17 admin
drwxr-xr-x 6 root root 4096 May  9 16:17 especial
drwxr-xr-x 2 root root 4096 May  9 16:17 hisx1
drwxr-xr-x 2 root root 4096 May  9 16:17 hisx2
drwxr-xr-x 2 root root 4096 May  9 16:17 wiam1
drwxr-xr-x 2 root root 4096 May  9 16:17 wiam2
drwxr-xr-x 2 root root 4096 May  9 16:17 wiaw1
drwxr-xr-x 2 root root 4096 May  9 16:17 wiaw2
```


* En cas de voler ser **executat** sense cap altre component, és pot fer de la següent manera:

```
docker run --rm --name samba.edt.org -h samba.edt.org --network network_name --privileged --volumes-from homes.edt.org -d eescriba/samba:greload

```

