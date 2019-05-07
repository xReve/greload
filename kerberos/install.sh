#! /bin/bash

cp /opt/docker/krb5.conf /etc/krb5.conf
cp /opt/docker/kdc.conf /var/kerberos/krb5kdc/kdc.conf
cp /opt/docker/kadm5.acl /var/kerberos/krb5kdc/kadm5.acl

kdb5_util create -s -P masterkey
kadmin.local -q "addprinc -pw kpere pere"
kadmin.local -q "addprinc -pw kpere pere/admin"
kadmin.local -q "addprinc -pw kanna anna"
kadmin.local -q "addprinc -pw kpau pau"
kadmin.local -q "addprinc -pw kmarta marta"
kadmin.local -q "addprinc -pw kadmin admin"

# Usuaris kerberos
kadmin.local -q "addprinc -pw kker01 ker01"
kadmin.local -q "addprinc -pw kker02 ker02"
kadmin.local -q "addprinc -pw kker03 ker03"

