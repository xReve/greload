#! /bin/bash
# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
## instal·lacio servidor Kerberos
# -------------------------------------

# Arxius configuració
cp /opt/docker/krb5.conf /etc/krb5.conf
cp /opt/docker/kdc.conf /var/kerberos/krb5kdc/kdc.conf
cp /opt/docker/kadm5.acl /var/kerberos/krb5kdc/kadm5.acl

# Creacio DB
kdb5_util create -s -P masterkey

# Creacio Usuaris
kadmin.local -q "addprinc -pw pere pere"
kadmin.local -q "addprinc -pw anna anna"
kadmin.local -q "addprinc -pw pau pau"
kadmin.local -q "addprinc -pw marta marta"
kadmin.local -q "addprinc -pw operador operador"


