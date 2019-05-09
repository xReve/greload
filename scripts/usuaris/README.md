# SCRIPTS USUARIS
## INJECCIÓ, MODIFICACIÓ I ESBORRAT D'USUARIS 

**alta-users.py** -> Script que processa fitxers del tipus `/etc/passwd` amb usuaris, i crea la seva entrada per a ldap amb format **ldif**,
sempre i quant la linia del usuari sigui del **format correcte** i el seu **grup existeixi a LDAP**.

cat `UPDATEDB-usuari-usuaris.sh` -> Script injecció dades al **LDAP**

```
#! /bin/bash

# Creació fitxers ldif
python alta_users.py insert_users.txt

# Inserció usuaris

ldapadd -x -w secret -h ldap -D "cn=Manager,dc=edt,dc=org" -f usuaris_alta.ldif

# Afegir usuaris al grup

ldapadd -x -w secret -h ldap -D "cn=Manager,dc=edt,dc=org" -f usuaris_append_grup.ldif
```
