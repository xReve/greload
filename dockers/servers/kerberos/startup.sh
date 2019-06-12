#! /bin/bash
# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
## startup Kerberos
# -------------------------------------

/opt/docker/install.sh && echo "Ok install"
/usr/sbin/krb5kdc
/usr/sbin/kadmind -nofork 
