# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

### INJECCIÓ DE GRUPS
---

### ESTRUCTURA

Per poder duur a terme la creació d'un grup, és necessari seguir una sèrie de passos:

**1. CREACIÓ GRUP AL SERVIDOR LDAP**

* En primer lloc crearem l'entrada del grup a **LDAP**. Aquest grup que és crearà, si té usuaris que pertanyen com a secundaris, és a dir, que són usuaris que tenen aquest grup com a grup secundari, també s'els introduira en la creació del grup. S'afegiran **memberUID** en el **posixGroup**.


**2. CREACIÓ DIRECTORI GRUP**

* I finalment farà falta crear el directori del grup, on dins seu es crearàn els directoris dels usuaris que pertanyin en aquest grup. Aquests directoris de treball és crearàn al docker **homes** com hem comentat anteriorment. 


### DESENVOLUPAMENT

#### SECCIÓ LDAP
---

* En primer lloc, ens arriba un fitxer amb linies de grups, el qual hem de processar per poder obtenir un fitxer final amb els grups que volem afegir a **LDAP** en format **LDIF**.

* L'encarregat de fer aquest procès és l'script en **python** `insercio_grups.py`.

* Aquest script contempla els següents casos:
	
	- La línia del fixer que ens arriba estigui en format correcte. En cas contrari genera un error i el guarda.
	
	- El grup ja està en el servidor LDAP. És genera un error i es guarda.
	
	- La connexió amb LDAP no és correcta. En aquest cas el programa finalitza i ens retorna un missatge explicatiu

* Reb un únic argument `insert_groups.txt` i retorna 3 fitxers:

`grups_alta.ldif``-> Fitxer amb format ldif on s'emmagatzemen els grups vàlids per poder ser injectats al servidor.

**EXEMPLE**

```
dn: cn=docker,ou=grups,dc=edt,dc=org 
cn: docker
gidNumber: 998
description: Grup de docker
objectclass: posixGroup
memberUid: pere
memberUid: pau
memberUid: eric

dn: cn=pere,ou=grups,dc=edt,dc=org 
cn: pere
gidNumber: 1000
description: Grup de pere
objectclass: posixGroup
memberUid: pere
```

`grups_acceptats.txt` -> Fitxer amb format de text pla on per cada línia hi ha un nom de grup vàlid que l'script `insercio_grups.py` ha processat i ha determinat vàlid.  
Aquest fitxer serà utilitzat posteriorment en la creació dels directoris dels grups.

`error_log/grups_error.log` -> Fitxer que emmagatzema tots els errors que s'han produit durant la transformació dels grups a format **LDIF**. Dins d'ell trobarem l'explicació de perquè ha fallat la transformació per determinat grup.

**EXEMPLE**

```
[root@491b2c85ce76 insertGrup]# cat error_log/grups_error.log 
Linia de grup incorrecta: LINIA 12
El grup wiam1 ja existeix a LDAP
```

* Al finalitzar l'execució retorna quants grups s'han processat correctament i quants han fallat. 


* Per afegir els grups al servidor haurem d'utilitzar la ordre **ldapadd** i entrar com a usuari **operador** per fer els canvis.

```
ldapadd -x -w operador -h ldap.edt.org -D "uid=operador,ou=usuaris,dc=edt,dc=org" -f grups_alta.ldif
```


#### SECCIÓ HOMES
---

* Per completar la injecció nomès ens falta crear el directori del grup.

* Per aquesta part existeix l'script en **bash** anomenat `create_homes.sh`.

* `create_homes.sh` té la funció de crear els directoris de treball dels grups al lloc adequat i ens informa per cada grup processat si ha anat bé o ha fallat.



### SCRIPT GLOBAL

* Per fer tota aquesta feina molt més fàcil i eficaç, he creat un script que incorpora cada pas i on et va informant en cada moment del que està succeint i que passarà.

* Aquest script de bash és diu `UPDATEDB-insertGrup.sh` i segueix l'estructura en ordre que hem comentat.

* Per poder veureu amb més detall aquí deixo una captura de l'execució de l'script amb un fitxer d'usuaris el qual tots els usuaris en aquest cas són vàlids.


**EXECUCIÓ UPDATEDB-insertGrup.sh**

```
[root@491b2c85ce76 insertGrup]# bash UPDATEDB-insertGrup.sh 
Total processats:
Acceptats: 11 (Consultar grups_alta.ldif)
Denegats: 2 (Consultar grups_error.log)
Vols continuar?
Yes/No
Yes

ATENCIO
Ara s'afegiran els grups a la DB de LDAP
adding new entry "cn=docker,ou=grups,dc=edt,dc=org "

adding new entry "cn=pere,ou=grups,dc=edt,dc=org "

adding new entry "cn=kvm,ou=grups,dc=edt,dc=org "

adding new entry "cn=render,ou=grups,dc=edt,dc=org "

adding new entry "cn=geoclue,ou=grups,dc=edt,dc=org "

adding new entry "cn=tss,ou=grups,dc=edt,dc=org "

adding new entry "cn=wireshark,ou=grups,dc=edt,dc=org "

adding new entry "cn=Debian-snmp,ou=grups,dc=edt,dc=org "

adding new entry "cn=systemd-coredump,ou=grups,dc=edt,dc=org "

adding new entry "cn=bumaie,ou=grups,dc=edt,dc=org "

adding new entry "cn=eric,ou=grups,dc=edt,dc=org "


Ara es crearan els directoris dels nous grups
docker creat correctament
pere creat correctament
kvm creat correctament
render creat correctament
geoclue creat correctament
tss creat correctament
wireshark creat correctament
Debian-snmp creat correctament
systemd-coredump creat correctament
bumaie creat correctament
eric creat correctament
TOTAL:
Succeed: 11
Fail: 0

SCRIPT D'INJECCIO DE GRUPS FINALITZAT

```


### ALTRES PUNTS

* El directori `error_log` és el lloc on és creen i guarden els fitxers d'errors generat durant l'injecció de grups.

* El fitxer `neteja.sh` és un script que esborra tots els fitxers generats durant l'execució de l'script **GLOBAL**.



