# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

### ESBORRAT DE GRUPS
---

### ESTRUCTURA

Per poder duur a terme l'esborrat d'un grup, és necessari seguir una sèrie de passos:

**1. ESBORRAT ENTRADA GRUP A LDAP**

* Per obtenir un esborrat exitòs, hem d'eliminar l'entrada del grup de LDAP, però sempre tenint en compte que aquest grup no contingui usuaris, ja que en aquest cas no podrem esobrrar el grup.

**2. ESBORRAT DIRECTORI GRUP**

* I sense oblidar-nos del seu directori de treball, també haurà de ser esborrat per no tenir dades sense ús guardades.


### DESENVOLUPAMENT

#### SECCIÓ LDAP
---

* Els grups ens arriben en un fitxer anomenat `delete_groups.txt` on cada línia del fitxer és un nom de grup.

* Per processar aquests grups tenim l'script en **python** anomenat `baixa_grups.py`.

* Aquest script té la principal funció de processar els grups i retornar un fitxer format **LDIF** amb els grups vàlids per poder injectar a LDAP.

* A més a més, l'script contempla el següent:

	- Una mala **connexió** amb el servidor LDAP: en aquest cas el programa finalitza amb un missatge d'error i no es continua processant els grups restants.
	
	- Grup existent a LDAP: en cas de que existeixi serà un grup vàlid, però en cas contrari generarà un error, saltarà el grup i continuarà processant els següents.

	- El grup conté usuaris: si el grup conté usuaris no s'acceptarà l'esborrat del grup ja que primer s'hauran d'esborrar els usuaris que hi pertanyen. Generarà un error i continuarà.

* Al finalitzar l'script ens retorna la quantitat de grups que s'han processat correctament i la quantitat de fallits.

* Aquest script reb el fitxer `usuaris_acceptats.txt` i retorna **3 fitxers**:


`grup_delete.ldif` -> Fitxer amb format **LDIF** amb l'entrada de cada grup vàlid per ser esborrat de LDAP

**EXEMPLE**

cat **grup_delete.ldif**

```
cn=kvm,ou=grups,dc=edt,dc=org

cn=render,ou=grups,dc=edt,dc=org

cn=geoclue,ou=grups,dc=edt,dc=org

cn=tss,ou=grups,dc=edt,dc=org

cn=wiam1,ou=grups,dc=edt,dc=org

cn=wireshark,ou=grups,dc=edt,dc=org

cn=Debian-snmp,ou=grups,dc=edt,dc=org

cn=systemd-coredump,ou=grups,dc=edt,dc=org
```

`grups_acceptats.txt` -> Fitxer amb un grup vàlid processat en cada línia. Aquests grups podran ser esborrats sense causar cap problema.  
Aquest fitxer serà utilitzat posteriorment en l'esborrat dels directoris dels grups.


`error_log/grupDel_error.log` -> Fitxer on es guarden els errors generats durant l'execució de l'script.

**EXEMPLE**

cat **usuarisDel_error.log**

```
El grup beef-xss no existeix a LDAP
El grup docker conte usuaris. Siusplau, esborri els usuaris del grup per poder esborra'l 
El grup pere conte usuaris. Siusplau, esborri els usuaris del grup per poder esborra'l 
El grup asdfasdf no existeix a LDAP
El grup hola no existeix a LDAP
``` 

* Per aplicar l'esborrat de grups de LDAP nomès ens cal atacar la base de dades amb l'usuari **operador** que és l'encarregat de fer operacions contra el servidor. Utilitzarem la ordre **ldapdelete**:

```
ldapdelete -x -w operador -h ldap.edt.org -D "uid=operador,ou=usuaris,dc=edt,dc=org" -f grup_delete.ldif
```


#### SECCIÓ HOMES
---

* Per poder esborrat els **homes** dels usuaris tenim un script en **bash** anomenat `delete_home.sh`.

* Aquest script té la finalitat d'esborrat els directoris dels grups a esborrar. 

* Una vegada s'intenta l'esborrat aquest script ens retorna si ha anat be o ha fallat, en la finalització de l'execució ens retorna el total de homes esobrrats i els fallits.

* Aquest script reb un fitxer amb grups **vàlids** per ser esborrats. Aquests grups que han estat determinats vàlids, han estat processats per l'script `baixa_grup.py` i els ha guardat en un fitxer de format **txt** anomenat `grups_acceptats.txt`.


* El fitxer `grups_acceptats.txt` contè un nom de grup (gname) per línia. 


### SCRIPT GLOBAL

* Per fer tota aquesta feina molt més fàcil i eficaç, he creat un script que incorpora cada pas i on et va informant en cada moment del que està succeint i que passarà.

* Aquest script de bash és diu `UPDATEDB-delGrup.sh` i segueix l'estructura en ordre que hem comentat.

* Per poder veureu amb més detall aqui deixo una captura de l'execució de l'script amb un fitxer d'usuaris el qual tots els usuaris en aquest cas són vàlids.

**EXECUCIÓ UPDATEDB-delUsers.sh**

```
[root@491b2c85ce76 delGrup]# bash UPDATEDB-delGrup.sh 
Total processats:
Acceptats: 8 (Consultar grup_delete.ldif)
Denegats: 5 (Consultar grupDel_error.log)
Vols continuar?
Yes/No
Yes

ATENCIO
Ara s'esborraran el grups seleccionats anteriorment

Ara s'esborraran els directoris dels grups esborrats
kvm esborrat correctament
render esborrat correctament
geoclue esborrat correctament
tss esborrat correctament
wiam1 esborrat correctament
wireshark esborrat correctament
Debian-snmp esborrat correctament
systemd-coredump esborrat correctament
TOTAL:
Succeed: 8
Fail: 0

SCRIPT D'ESBORRAT DE GRUPS FINALITZAT
```

### ALTRES PUNTS

* EL directori `error_log` és el lloc on és creen i guarden els fitxers d'errors generat durant l'esborrat de grups.

* L'script `neteja.sh` esborra tots els fitxers generats durant l'esborrat de grups. 



