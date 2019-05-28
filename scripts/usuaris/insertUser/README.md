# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

### INJECCIÓ D'USUARIS
---

### ESTRUCTURA

* Per poder duur a terme la creació d'un compte d'usuari, és necessari seguir una sèrie de passos:

1. CREACIÓ COMPTE USUARI A LDAP

* En primer lloc crearem el compte usuari al servidor LDAP. Això també implica tenir inclòs aquest usuari dins d'un grup ja que un usuari per força està obligat a pertanyer en un grup, per tant un segon pas és afegir aquest usuari al seu grup pertinent.

2. CREACIÓ PRINCIPAL KERBEROS

* Seguidament aquest usuari requereix d'una entrada al servidor kerberos com a principal. Un principal és un nom únic d'usuari o servei que permet autenticar-se mitjançant un servidor kerberos. Aquest pas és necessari perquè l'usuari es pugi atenticar agafat el login de LDAP i el password de KERBEROS.

3. CREACIÓ COMPTE SAMBA

* Aquest punt és clau perquè els usuaris pugin montar els seus homes a travès del servidor **SAMBA**. Aquests usuaris de LDAP també han de tenir un compte samba registrat perquè siguin usuaris valids i el servidor els hi permeti accedir als seus homes.

4. CREACIÓ HOME

* Finalment ens queda crear els llocs de treball dels usuaris que aquests es guardaràn dels del docker **HOMES**, que també és la zona de treball on s'executaràn els scripts d'injecció i esborrat d'usuaris. 


#### DESENVOLUPAMENT




 
