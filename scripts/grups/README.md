# SCRIPTS GRUPS
## INJECCIÓ GRUPS

**insercio-grups.py** -> Script que reb grups amb el format `/etc/group` i els transforma amb format **ldif**.



cat `UPDATEDB-grups.sh`  -> Script injecció dades a **LDAP**

```
#! /bin/bash

# Creació grups
python insercio_grups.py groups.txt

# Injecció grups

ldapadd -x -w secret -h ldap -D "cn=Manager,dc=edt,dc=org" -f grups_alta.ldif
```

