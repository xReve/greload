# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

## SERVIDOR LDAP

* En aquest apartat del projecte tenim el servidor LDAP. Aquest servidor és l'encarregat d'enmagatzemar els comptes d'usuari de la organització.

* Per poder desenvolupar aquest servidor s'han instal·lat els paquets **openldap-clients** i **openldap-servers**

* La base de dades està definida amb una **organization** que inclou tota entrada:

```
dn: dc=edt,dc=org
dc: edt
description: Escola del treball de Barcelona
objectClass: dcObject
objectClass: organization
o: edt.org
```  

* Aquesta base de dades està formada per **usuaris**,**hosts**,**aules** i grups. 

```
dn: ou=usuaris,dc=edt,dc=org
ou: usuaris
description: Container per usuaris del sistema linux
objectClass: organizationalunit

dn: ou=hosts,dc=edt,dc=org
ou: hosts
description: Container per a hosts linux
objectClass: organizationalunit

dn: ou=aules,dc=edt,dc=org
ou: aules
description: Container per aules de la organitzacio
objectClass: organizationalunit

dn: ou=grups,dc=edt,dc=org
ou: groups
ou: grups
description: Container per a grups
objectClass: organizationalunit
```

* Tant els usuaris com els hosts estàn definits com a **PosixAccount**, en el cas dels grups estàn definits com a **PosixGrup** i  pel que respecta a les aules no estàn especificades.

* Els usuaris estàn definits amb el **uid** com a **RDN**.

```
dn: uid=pere,ou=usuaris,dc=edt,dc=org
objectClass: posixAccount
objectClass: inetOrgPerson
cn: Pere Pou
sn: Pou
homePhone: 555-222-2221
mail: pere@edt.org
description: Watch out for this guy
ou: test
uid: pere
uidNumber: 1002
gidNumber: 200
loginShell: /bin/bash
homeDirectory: /home/grups/test/pere
userPassword:: e1NTSEF9Z2htdFJMMTFZdFhvVWhJUDd6NmY3bmI4UkNOYWRGZSs=

dn: uid=j04,ou=hosts,dc=edt,dc=org
objectClass: posixAccount
objectClass: device
objectClass: ipHost
cn: j04
uid: j04
uidNumber: 5014
gidNumber: 9000
homeDirectory: /dev/null
loginShell: /bin/false
gecos: Computer
description: Ordinador j04
ipHostNumber: 0.0.0.0

dn: cn=test,ou=grups,dc=edt,dc=org
cn: test
gidNumber: 200
description: Grup d'usuaris de proves
memberUid: pere
memberUid: anna
memberUid: marta
memberUid: pau
objectClass: posixGroup

```

* Tenim definits uns usuaris base a LDAP que actuen com a usuaris de **proves** de cara a l'**execució** de scripts. Aquests usuaris son en **pere**,**anna*,**marta** i **pau**.
Aquests usuaris pertany al PosixGrup **test**.

* Aquests usuaris tenen definit un password el qual s'ha creat mitjançant la ordre **slappasswd**:


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
```

* Els usuaris que s'insertaràn posteriorment en fer una càrrega a la base de dades no tindran un password definit al servidor, ja que aquest estarà emmagatzemat al servidor **kerberos**.


* És important destacar que cada usuari existent a la base de dades ha de pertanyer en un grup si no seria una base de dades inconsistent i errònia.


* A més a més, també hi ha un usuari predefinit amb la funció d'administrar la base de dades i fer modificacions sobre aquesta. Aquest usuari es diu **operador** i té com a password el mateix nom que usuari.
Aquest usuari pertany al grup **admin**.

```
dn: uid=operador,ou=usuaris,dc=edt,dc=org
objectClass: posixAccount
objectClass: inetOrgPerson
cn: Administrador Sistema
sn: Operador
homePhone: 555-222-2225
mail: operador@edt.org
description: Administrador
ou: admin
uid: operador
uidNumber: 111
gidNumber: 111
loginShell: /bin/bash
homeDirectory: /home/grups/admin/operador
userPassword:: e1NTSEF9WkFPek5wU2FwbmIyZ0Q0aG1IaXQ0WFFoNjRabHBqYS8=

```

* Per poder donar-l'hi els permisos d'administrador en aquest usuari de cara a la modificació en la base de dades, s'ha tingut que definir una política d'**ACL** la qual ho indiqui:

```
access to * by dn.exact="uid=operador,ou=usuaris,dc=edt,dc=org" manage by self write by * read
``` 


* Pel que respecta als **grups predefinits**, trobem 9 grups:

```
dn: cn=admin,ou=grups,dc=edt,dc=org

dn: cn=hosts,ou=grups,dc=edt,dc=org

dn: cn=profes,ou=grups,dc=edt,dc=org

dn: cn=test,ou=grups,dc=edt,dc=org

dn: cn=wiaw1,ou=grups,dc=edt,dc=org

dn: cn=wiaw2,ou=grups,dc=edt,dc=org

dn: cn=hisx1,ou=grups,dc=edt,dc=org

dn: cn=hisx2,ou=grups,dc=edt,dc=org

dn: cn=wiam1,ou=grups,dc=edt,dc=org

```

* Aquest servidor està configurat per ser executat en mode **detach**:

```
/sbin/slapd -d0  

```

* En cas de voler ser **executat** sense cap altre component, és pot fer de la següent manera:


```
docker run --rm --name ldap.edt.org -h ldap.edt.org --network network_name -d eescriba/ldapserver:greload 
```









