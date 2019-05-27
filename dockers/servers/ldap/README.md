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

```
[root@ldap docker]# #pere
[root@ldap docker]# slappasswd 
New password: 
Re-enter new password: 
{SSHA}8Ze071A01HHddKpOnc34Eshh0uMi+R/L
[root@ldap docker]# #marta
[root@ldap docker]# slappasswd 
New password: 
Re-enter new password: 
{SSHA}JpMKA0RV6Ktv7Dd56Nkg1ILelv84x7+9
[root@ldap docker]# #pau
[root@ldap docker]# slappasswd 
New password: 
Re-enter new password: 
{SSHA}qiwn1xK8E4FmiATEJt5rS8VIexEkOCFV
[root@ldap docker]# #anna
[root@ldap docker]# slappasswd 
New password: 
Re-enter new password: 
{SSHA}zMLvkz9WC9lbXtE1YJ8CYQliSKfujcDg
[root@ldap docker]# #operador
[root@ldap docker]# slappasswd 
New password: 
Re-enter new password: 
{SSHA}ZAOzNpSapnb2gD4hmHit4XQh64Zlpja/
[root@ldap docker]# 
```

# Afegir 
ldapadd -x -w secret -D "cn=Manager,dc=edt,dc=org" -f new.ldif

# Modificar grups
ldapmodify -x -w secret -D "cn=Manager,dc=edt,dc=org" -f modify.ldif

# Borrar entrades

ldapdelete -w secret -D 'cn=Manager,dc=edt,dc=org' -f delete.ldif




#### Execució

```
docker run --rm --name ldap.edt.org -h ldap.edt.org --network gandhi-net -d eescriba/ldapserver:greload 

```
