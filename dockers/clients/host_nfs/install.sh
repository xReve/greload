#! /bin/bash
# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
# Instal·lació host NFS
# -------------------------------------

groupadd locals
useradd -g users -G locals -u 5001 local01
useradd -g users -G locals -u 5002 local02
useradd -g users -G locals -u 5003 local03
echo "local01" | passwd --stdin local01
echo "local02" | passwd --stdin local02
echo "local03" | passwd --stdin local03

cp /opt/docker/krb5.conf /etc/krb5.conf

cp /opt/docker/nslcd.conf /etc/nslcd.conf
cp /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp /opt/docker/nsswitch.conf /etc/nsswitch.conf
cp /opt/docker/pam_mount.conf.xml /etc/security/pam_mount.conf.xml
cp /opt/docker/system-auth /etc/pam.d/system-auth
echo "192.168.2.44 ldap.edt.org kserver.edt.org nfs.edt.org" >> /etc/hosts
