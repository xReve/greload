#! /bin/bash

# Creació fitxers ldif
python alta_users.py insert_users.txt

# Inserció usuaris

ldapadd -x -w secret -h ldap -D "cn=Manager,dc=edt,dc=org" -f usuaris_alta.ldif

# Afegir usuaris al grup

ldapadd -x -w secret -h ldap -D "cn=Manager,dc=edt,dc=org" -f usuaris_append_grup.ldif
