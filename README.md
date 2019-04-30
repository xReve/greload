# GANDHI RELOAD
## Èric Escribà


L’objectiu d’aquest projecte és generar un model similar a gandhi de l’Escola del Treball però amb cada un dels components separats en containers Docker. 
És de especial importància Kerberos, LDAP , NFS i SAMBA. 
Un un segon grau els serveis DNS i DHCP. Un tercer nivell de serveis serien serveis generals tipus SSH, HTTP, TFTP, FTP, etc.

**alta-users.py** -> Script que processa fitxers del tipus `/etc/passwd` amb usuaris, i crea la seva entrada per a ldap amb format **ldif**,
sempre i quant la linia del usuari sigui del **format correcte** i el seu **grup existeixi a LDAP**.

**EXEMPLE**

Contingut inicial

```
[isx47983457@i14 greload]$ ll
total 20
-rwxr-xr-x. 1 isx47983457 hisx2 1997 Apr 30 13:18 alta_users.py
-rwxr-xr-x. 1 isx47983457 hisx2  647 Apr 30 12:53 insercio_grups.py
drwxr-xr-x. 2 isx47983457 hisx2 4096 Apr 30 13:32 ldapserver:18group
-rw-r--r--. 1 isx47983457 hisx2  789 Apr 30 13:32 README.md
-rw-r--r--. 1 isx47983457 hisx2  561 Apr 30 12:38 usuaris.txt
 
```
**Execució de prova**: el programa reb un file amb els usuaris.

```
[isx47983457@i14 greload]$ python alta_users.py usuaris.txt 
Total processats:
Acceptats: 2 (Consultar usuaris_alta.ldif)
Denegats: 9 (Consultar error.log)
```

**COMPROVACIÓ**

```
[isx47983457@i14 greload]$ cat usuaris_alta.ldif 
dn: uid=anna,ou=usuaris,dc=edt,dc=org
objectclass: posixAccount
objectclass: inetOrgPerson
cn: anna
sn: anna
ou: admin
uid: anna
uidNumber: 10
gidNumber: 10
homeDirectory: /home/anna
 
dn: uid=smmsp,ou=usuaris,dc=edt,dc=org
objectclass: posixAccount
objectclass: inetOrgPerson
cn: smmsp
sn: smmsp
ou: profes
uid: smmsp
uidNumber: 100
gidNumber: 100
homeDirectory: /var/spool/mqueue
```


```
[isx47983457@i14 greload]$ cat error.log 
User pere no te un grup existent a la BBDD. Crei el grup i despres afegeix lusuari 
 User mysql no te un grup existent a la BBDD. Crei el grup i despres afegeix lusuari 
 User dhcpd no te un grup existent a la BBDD. Crei el grup i despres afegeix lusuari 
 User squid no te un grup existent a la BBDD. Crei el grup i despres afegeix lusuari 
 User webalizer no te un grup existent a la BBDD. Crei el grup i despres afegeix lusuari 
 User marta no te un grup existent a la BBDD. Crei el grup i despres afegeix lusuari 
 Linia dusuari incorrecta, revisi la linia 8 
User mongod no te un grup existent a la BBDD. Crei el grup i despres afegeix lusuari 
 User mailnull no te un grup existent a la BBDD. Crei el grup i despres afegeix lusuari 
```




**insercio-grups.py** -> Script que processoa fitxers del tipus `/etc/group` i crea la seva entrada per a ldap amb format **ldif**.

