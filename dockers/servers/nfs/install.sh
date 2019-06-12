#! /bin/bash
# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
# Install
# -------------------------------------
cp -ra  /opt/docker/nslcd.conf /etc/nslcd.conf
cp -ra /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp -ra /opt/docker/nsswitch.conf /etc/nsswitch.conf

cp /opt/docker/exports /etc/exports
mkdir /run/rpcbind 
touch /run/rpcbind/rpcbind.lock

