#! /bin/bash
# @edt ASIX M06 2018-2019
# instal.lacio
#  - crear usuaris locals
# -------------------------------------
groupadd locals
groupadd kusers

useradd -g users -G locals local01
useradd -g users -G locals local02
echo "local01" | passwd --stdin local01
echo "local02" | passwd --stdin local02

useradd -g users -G kusers ker01
useradd -g users -G kusers ker02
useradd -g users -G kusers ker03

cp /opt/docker/nslcd.conf /etc/nslcd.conf
cp /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp /opt/docker/nsswitch.conf /etc/nsswitch.conf
cp /opt/docker/system-auth /etc/pam.d/system-auth
cp /opt/docker/pam_mount.conf.xml /etc/security/pam_mount.conf.xml
cp /opt/docker/krb5.conf /etc/krb5.conf
