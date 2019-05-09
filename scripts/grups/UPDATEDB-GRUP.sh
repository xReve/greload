#! /bin/bash

# Creació grups
python insercio_grups.py groups.txt

# Injecció grups

ldapadd -x -w secret -h ldap -D "cn=Manager,dc=edt,dc=org" -f grups_alta.ldif
