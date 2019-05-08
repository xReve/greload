#! /bin/bash

cp /opt/docker/krb5.conf /etc/krb5.conf
cp /opt/docker/kdc.conf /var/kerberos/krb5kdc/kdc.conf
cp /opt/docker/kadm5.acl /var/kerberos/krb5kdc/kadm5.acl

kdb5_util create -s -P masterkey
kadmin.local -q "addprinc -pw pere pere"
kadmin.local -q "addprinc -pw pere pere/admin"
kadmin.local -q "addprinc -pw anna anna"
kadmin.local -q "addprinc -pw pau pau"
kadmin.local -q "addprinc -pw marta marta"
kadmin.local -q "addprinc -pw admin admin"

# Usuaris kerberos
kadmin.local -q "addprinc -pw ker01 ker01"
kadmin.local -q "addprinc -pw ker02 ker02"
kadmin.local -q "addprinc -pw ker03 ker03"

