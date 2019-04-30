# ldapserver:18practica


## @edt ASIX M06-ASO Curs 2018-2019

Servidor ldap amb edt.org, amb usuaris i grups, RDN=uid
Exercici per practicar tots els conceptes treballats.


S'han afegit els grups que són posixGroup i identifiquen als membres del group amb l'atribut memberUid.

#### Exemple de dades .ldif

Entitat **grups** per acollir els grups:
```
dn: ou=grups,dc=edt,dc=org
ou: groups
description: Container per a grups
objectclass: organizationalunit
```

Entitat grup 2asix:
```
dn: cn=2asix,ou=grups,dc=edt,dc=org
cn: 2asix
gidNumber: 611
description: Grup de 2asix
memberUid: user06
memberUid: user07
memberUid: user08
memberUid: user09
memberUid: user10
objectclass: posixGroup
```

# Afegir 
ldapadd -x -w secret -D "cn=Manager,dc=edt,dc=org" -f new.ldif

# Modificar grups
ldapmodify -x -w secret -D "cn=Manager,dc=edt,dc=org" -f modify.ldif

# Borrar entrades

ldapdelete -w secret -D 'cn=Manager,dc=edt,dc=org' -f delete.ldif

#
dn: cn=skeret,ou=grups,dc=edt,dc=org
cn: skeret
gidNumber: 333
description: Grup de 1wiaw
objectclass: posixGroup

#
[root@ldap docker]# cat delete.ldif 
cn=skeret,ou=grups,dc=edt,dc=org

#
[root@ldap docker]# cat modify.ldif 
dn: cn=1asix,ou=grups,dc=edt,dc=org
changetype: modify
add: memberUid
memberUid: new



#### Execució

```
$ docker run --rm --name ldap -h ldap --net ldapnet -d edtasixm06/ldapserver:18group
```
