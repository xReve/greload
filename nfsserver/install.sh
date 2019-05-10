#! /bin/bash
# @edt ASIX M06 2018-2019
# instal.lacio
#  - crear usuaris locals
# -------------------------------------
cp -ra  /opt/docker/nslcd.conf /etc/nslcd.conf
cp -ra /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp -ra /opt/docker/nsswitch.conf /etc/nsswitch.conf

cp /opt/docker/exports /etc/exports
mkdir /run/rpcbind 
touch /run/rpcbind/rpcbind.lock

