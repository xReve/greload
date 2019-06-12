#! /bin/bash
# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
# install.sh
####################################

cp /opt/docker/nslcd.conf /etc/nslcd.conf
cp /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp /opt/docker/nsswitch.conf /etc/nsswitch.conf
cp /opt/docker/sshd_config /etc/ssh/sshd_config

cp /opt/docker/krb5.conf /etc/krb5.conf
/usr/bin/ssh-keygen -A

