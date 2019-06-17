#! /bin/bash
# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
# -----------------

authconfig  --enableshadow --enablelocauthorize --enableldap \
            --ldapserver='ldap.edt.org' --ldapbase='dc=edt,dc=org' \
            --enablekrb5 --krb5kdc='kserver.edt.org' \
            --krb5adminserver='kserver.edt.org' --krb5realm='EDT.ORG' \
--updateall
