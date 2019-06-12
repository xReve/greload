# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

## SERVIDOR KERBEROS

* En aquesta part del projecte està desenvolupat el servidor **KERBEROS**.

**Autenticaction Provider AP**

Kerberos proporciona el servei de proveïdor d'autenticació. No emmagatzema informació dels comptes d'usuari com el uid, git, shell, etc. 
Simplement emmagatzema i gestiona els passwords dels usuaris, en entrades anomenades principals en la seva base de dades.

* Coneixem els següents AP:

	* /etc/passwd que conté els password (AP) i també la informació dels comptes d'usuari (IP).
	* ldap el servei de directori ldap conté informació dels comptes d'usuari (IP) i també els seus passwords (AP).
	* kerberos que únicament actua de AP i no de IP.

**Information Provider IP**

Els serveis que emmagatzemen la informació dels comptes d'usuari s'anomenen Information providers. 
Aquests serveis proporcionen el uid, gid, shell, gecos, etc. Els clàssics són /etc/passwd i ldap.

* Per desenvolupar aquest servidor s'han instal·lat els paquets **krb5-server, krb5-workstation, krb5-libs**.

* Aquest servidor pertany al reialme **EDT.ORG**


cat `krb5.conf`

```
# To opt out of the system crypto-policies configuration of krb5, remove the
# symlink at /etc/krb5.conf.d/crypto-policies which will not be recreated.
includedir /etc/krb5.conf.d/

[logging]
 default = FILE:/var/log/krb5libs.log
 kdc = FILE:/var/log/krb5kdc.log
 admin_server = FILE:/var/log/kadmind.log

[libdefaults]
 dns_lookup_realm = false
 ticket_lifetime = 24h
 renew_lifetime = 7d
 forwardable = true
 rdns = false
 default_realm = EDT.ORG
# default_ccache_name = KEYRING:persistent:%{uid}

[realms]
EDT.ORG = {
  kdc = kserver.edt.org
  admin_server = kserver.edt.org
 }

[domain_realm]
.edt.org = EDT.ORG
edt.org = EDT.ORG
```

* Aquest servidor té definit als principals que en l'LDAP pertanyen al grup de test i a l'usuari **operador**.

```
kadmin.local -q "addprinc -pw pere pere"
kadmin.local -q "addprinc -pw anna anna"
kadmin.local -q "addprinc -pw pau pau"
kadmin.local -q "addprinc -pw marta marta"
kadmin.local -q "addprinc -pw operador operador"
```

* De cara a l'administració de principals definim aquests usuaris com a administradors i pel que respsecta a la resta d'usuaris nomès
els hi donem els permisos de lectura.


```
pere@EDT.ORG *
anna@EDT.ORG *
pau@EDT.ORG *
marta@EDT.ORG *
operador@EDT.ORG *
*@EDT.ORG l
```

* Aquest servidor està dissenyat per ser executat em mode **detach**.

```
/usr/sbin/krb5kdc
/usr/sbin/kadmind -nofork 
```


* En cas de voler ser **executat** sense cap altre component, és pot fer de la següent manera:


```
docker run --rm --name kserver.edt.org -h kserver.edt.org --network network_name -d eescriba/kerberos:greload
```
