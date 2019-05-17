# NFS
## @edt ASIX M06-ASO Curs 2018-2019

Servidor NFS

 * **nfsserver:18base** Servidor nfs. Com a host està configurat amb PAM+LDAP. S'hi creen usuaris locals i té accés via LDAP als usuaris de xarxa.
Crea els homes dels usuaris (respectant el home indicat al LDAP de cada usuari), li posa xixa al home i li assigna l'usuari i grup apropiat. Exporta els
homes via el servei nfs-utils (que engega).



#### Execució

En global s'engega el servidor ldap, el servidor nfs i el host amb pam configurat per crear i muntar els homes dels usuaris via nfs.

```
docker run --rm --name ldap -h ldap --net ldapnet -d edtasixm06/ldapserver:18group
docker run --rm --name host -h host --net ldapnet --privileged -it edtasixm06/hostpam:18homenfs
docker run --rm --name nfsserver -h nfserver --net ldapnet --privileged -it edtasixm06/nfsserver:18base
```

#### Configuracions

Install.sh:
```
mkdir /var//tmp/home
mkdir /var//tmp/home/pere
mkdir /var//tmp/home/anna
mkdir /var//tmp/home/marta
mkdir /var//tmp/home/jordi
mkdir /var//tmp/home/admin

cp README.md /var//tmp/home/pere
cp README.md /var//tmp/home/anna
cp README.md /var//tmp/home/marta
cp README.md /var//tmp/home/jordi
cp README.md /var//tmp/home/admin

chown -R pere.users /var/tmp/home/pere
chown -R anna.alumnes /var/tmp/home/anna
chown -R marta.alumnes /var/tmp/home/marta
chown -R jordi.users /var/tmp/home/jordi
chown -R admin.wheel /var/tmp/home/admin

bash /opt/docker/auth.sh
cp -ra  /opt/docker/nslcd.conf /etc/nslcd.conf
cp -ra /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp -ra /opt/docker/nsswitch.conf /etc/nsswitch.conf
cp -ra /opt/docker/system-auth-edt /etc/pam.d/system-auth-edt
cp -ra /opt/docker/pam_mount.conf.xml /etc/security/pam_mount.conf.xml
ln -ra -sf /etc/pam.d/system-auth-edt /etc/pam.d/system-auth

cp /opt/docker/exports /etc/exports
mkdir /run/rpcbind 
touch /run/rpcbind/rpcbind.lock
```

startup.sh:
```
/opt/docker/install.sh && echo "Install Ok"
/usr/sbin/nslcd && echo "nslcd Ok"
/usr/sbin/nscd && echo "nscd Ok"

/usr/sbin/rpcbind && echo "rpcbind Ok"
/usr/sbin/rpc.statd && echo "rpc.stad Ok"
/usr/sbin/rpc.nfsd && echo "rpc.nfsd Ok"
/usr/sbin/rpc.mountd && echo "rpc.mountd Ok"
/usr/sbin/exportfs -av
/bin/bash
```


