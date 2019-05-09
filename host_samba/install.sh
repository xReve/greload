#! /bin/bash
# @edt ASIX M06 2018-2019
# instal.lacio
#  - crear usuaris locals
# -------------------------------------
groupadd locals
groupadd kusers
<<<<<<< HEAD
useradd -g users -G locals -u 5001 local01
useradd -g users -G locals -u 5002 local02
useradd -g users -G locals -u 5003 local03
=======

useradd -g users -G locals local01
useradd -g users -G locals local02
>>>>>>> 5cddf6f7a48785f9c2d695d3cec683805bc0da7a
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
<<<<<<< HEAD





=======
cp /opt/docker/krb5.conf /etc/krb5.conf
>>>>>>> 5cddf6f7a48785f9c2d695d3cec683805bc0da7a
