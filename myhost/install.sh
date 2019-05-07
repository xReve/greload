#! /bin/bash

groupadd locals
groupadd kusers
useradd -g users -G locals local01
useradd -g users -G locals local02
useradd -g users -G locals local03
useradd -g users -G kusers ker01
useradd -g users -G kusers ker02
useradd -g users -G kusers ker03
echo "local01" | passwd --stdin local01
echo "local02" | passwd --stdin local02
echo "local03" | passwd --stdin local03

cp /opt/docker/krb5.conf /etc/krb5.conf


bash /opt/docker/auth.sh
cp /opt/docker/nslcd.conf /etc/nslcd.conf
cp /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp /opt/docker/nsswitch.conf /etc/nsswitch.conf
cp /opt/docker/system-auth /etc/pam.d/system-auth
cp /opt/docker/pam_mount.conf.xml /etc/security/pam_mount.conf.xml
echo "172.18.0.5 samba.edt.org " >> /etc/hosts
echo "172.18.0.4 homes.edt.org " >> /etc/hosts





