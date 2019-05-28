# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

### INJECCIÓ D'USUARIS
---

### ESTRUCTURA

Per poder duur a terme la creació d'un compte d'usuari, és necessari seguir una sèrie de passos:

1. **CREACIÓ COMPTE USUARI A LDAP**

* En primer lloc crearem el compte usuari al **servidor LDAP**. Això també implica tenir inclòs aquest usuari dins d'un grup ja que un usuari per força està obligat a pertanyer en un grup, per tant un segon pas és afegir aquest usuari al seu grup pertinent.

2. **CREACIÓ PRINCIPAL KERBEROS**

* Seguidament aquest usuari requereix d'una entrada al servidor kerberos com a principal. Un principal és un nom únic d'usuari o servei que permet autenticar-se mitjançant un **servidor kerberos**. Aquest pas és necessari perquè l'usuari es pugi atenticar agafat el login de LDAP i el password de KERBEROS.

3. **CREACIÓ COMPTE SAMBA**

* Aquest punt és clau perquè els usuaris pugin montar els seus homes a travès del servidor **SAMBA**. Aquests usuaris de LDAP també han de tenir un compte samba registrat perquè siguin usuaris valids i el servidor els hi permeti accedir als seus homes.

4. **CREACIÓ HOME**

* Finalment ens queda crear els llocs de treball dels usuaris que aquests es guardaràn dels del docker **HOMES**, que també és la zona de treball on s'executaràn els scripts d'injecció i esborrat d'usuaris. 


### DESENVOLUPAMENT

* En primer lloc es processa el fitxer d'usuaris del format `/etc/passwd` a travès de l'script `alta_users.py`.  

`alta_users.py` és un script que té la finalitat de **transformar** cada un dels usuaris que processi del format `/etc/passwd` i tranformar-los a format **LDIF**.

* A més a més, aquest script contempla els possibles casos d'error com ara:

- Una **mala connexió** amb LDAP: en aquest cas el programa finalitza i ens retorna un missatge explicatiu.

- Usuari **existent** a LDAP: en aquest cas l'usuari no es processa i és genera un error. 

- L'usuari no té un **grup** existent a LDAP: en aquest cas l'usuari no es processa i també genera un error.

- La **linia** d'usuari està mal escrita: tampoc es processa i genera un error.
 

* Aquest script reb un únic argument, un fitxer d'usuaris amb el format que hem comentat, i retorna 4 fitxers:

`usuaris_alta.ldif` -> Fitxer en format ldif on s'emmagatzema cada **usuari vàlid** que s'ha processat i està **preparat** per ser injectat a LDAP

**EXEMPLE**

```
dn: uid=iawuser01,ou=usuaris,dc=edt,dc=org
objectclass: posixAccount
objectclass: inetOrgPerson
cn: iawuser01
sn: iawuser01
ou: wiaw1
uid: iawuser01
uidNumber: 2001
gidNumber: 201
loginShell: /bin/bash
homeDirectory: /home/grups/wiaw1/iawuser01 
```

`usuaris_append_grup.ldif` -> Fitxer em format ldif on s'emmagatzema l'entrada del usuari pel seu grup, està preparat per ser injectat a LDAP.

**EXEMPLE**

```
dn: cn=profes,ou=grups,dc=edt,dc=org
changetype: modify
add: memberUid
memberUid: profe01 
```

`userhomes.txt` -> Fitxer en s'emmagatzema, per cada linia, l'usuari i el seu home amb el format de **user:home**, aquest fitxer és creat ja que desprès serà processat per d'altres scripts.

**EXEMPLE**

cat userhomes.txt

```
iawuser01:/home/grups/wiaw1/iawuser01
iawuser02:/home/grups/wiaw1/iawuser02
iawuser03:/home/grups/wiaw1/iawuser03
```

`error_log/usuaris_error.log` -> Fitxer de logs en cas de que es produeixi algun tipus d'**incidència** quan es processa un usuari. Aquest fitxer recopila totes les incidències provenent de les linies del fitxer processat i indica el motiu.
 
**EXEMPLE**

cat usuaris_error.log
```
User userx04 no te un grup existent a la BBDD. Crei el grup i despres afegeix lusuari 
Linia d'usuari incorrecta, revisi la linia 9 
L'usuari pere ja existeix a LDAP
```





 
