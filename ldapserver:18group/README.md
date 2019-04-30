# SERVIDOR LDAP 


## @edt ASIX M14-PROJECTE Curs 2018-2019

Servidor ldap amb edt.org, amb usuaris i grups, RDN=uid

S'han afegit els grups que són posixGroup i identifiquen als membres del group amb l'atribut memberUid.

#### Exemple de dades .ldif

Entitat **grups** per acollir els grups:
```
dn: ou=grups,dc=edt,dc=org
ou: groups
description: Container per a grups
objectclass: organizationalunit
```

Entitat grup **especial**: (Usuaris per defecte)

```
dn: cn=especial,ou=grups,dc=edt,dc=org
cn: especial
gidNumber: 200
description: Grup d'usuaris especials
memberUid: pere
memberUid: anna
memberUid: marta
memberUid: pau
objectClass: posixGroup
```

Entitat grup **1asix**: (Encara no hi ha usuaris al grup)

```
dn: cn=1asix,ou=grups,dc=edt,dc=org
cn: 1asix
gidNumber: 203
description: Grup de 1asix
objectClass: posixGroup

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
docker run --rm --name ldap -h ldap --network gandhi-net -d eescriba/ldapserver:greload 

```
