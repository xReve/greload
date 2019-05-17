# SERVIDOR KERBEROS

## @edt ASIX M14-PROJECTE Curs 2018-2019


* Servidor kerberos. Aquest servidor crea els principals corresponents als clàssics usuaris que tenim també a ldap.
* És un servidor que actua amb mode **detach**


Les característiques principals són:
 * s'ha d'anomenar kserver.edt.org
 * usuaris amb nomenclatura ldap: pere, pau, anna, marta.
 * usuaris administradors kerberos: admin, pere/admin.
 * tot el procés és autometitzat i el servidor s'executa detach.

* Pertany al **reialme edt.org**

* cat `krb5.conf`

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


* **EXECUCIÓ:**

```
docker run --rm --name kserver.edt.org -h kserver.edt.org --network gandhi-net -d eescriba/k18:greload
```
