# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

### INJECCIÓ D'USUARIS
---

### ESTRUCTURA

Per poder duur a terme la creació d'un compte d'usuari, és necessari seguir una sèrie de passos:

**1. CREACIÓ COMPTE USUARI A LDAP**

* En primer lloc crearem el compte usuari al **servidor LDAP**. Això també implica tenir inclòs aquest usuari dins d'un grup ja que un usuari per força està obligat a pertanyer en un grup, per tant un segon pas és afegir aquest usuari al seu grup pertinent.

**2. CREACIÓ PRINCIPAL KERBEROS**

* Seguidament aquest usuari requereix d'una entrada al servidor kerberos com a principal. Un principal és un nom únic d'usuari o servei que permet autenticar-se mitjançant un **servidor kerberos**. Aquest pas és necessari perquè l'usuari es pugi atenticar agafat el login de LDAP i el password de KERBEROS.

**3. CREACIÓ COMPTE SAMBA**

* Aquest punt és clau perquè els usuaris pugin montar els seus homes a travès del servidor **SAMBA**. Aquests usuaris de LDAP també han de tenir un compte samba registrat perquè siguin usuaris valids i el servidor els hi permeti accedir als seus homes.

**4. CREACIÓ HOME**

* Finalment ens queda crear els llocs de treball dels usuaris que aquests es guardaràn dels del docker **HOMES**, que també és la zona de treball on s'executaràn els scripts d'injecció i esborrat d'usuaris. 


### DESENVOLUPAMENT

#### SECCIÓ LDAP
---

* En primer lloc es processa el fitxer d'usuaris del format `/etc/passwd` a travès de l'script `alta_users.py`.  

`alta_users.py` és un script fet en **python** que té principal finalitat de **transformar** cada un dels usuaris que processi a format **LDIF**.

* Destacar que l'script processa cada usuari i a partir del grup en el qual està assigat, es crea el seu home i login en funció d'aquest.  
És a dir, si ens arriba un usuari nou amb el login *planet* i pertany al grup *hisx1*, el login que se li assignara serà *isxplanet* i el home */home/grups/hisx1/isxplanet*.  
Per trobar a quin grup pertany, és fa una consulta al ldap i es processa la sortida obtenint el grup.

* Al finalitzar l'script ens retorna la quantitat d'usuaris que s'han processat correctament i la quantitat de fallits.


* A més a més, aquest script contempla els possibles **casos d'error** com ara:

	- Una **mala connexió** amb LDAP: en aquest cas el programa finalitza i ens retorna un missatge explicatiu.

	- Usuari **existent** a LDAP: en aquest cas l'usuari no es processa i és genera un error. 

	- L'usuari no té un **grup** existent a LDAP: en aquest cas l'usuari no es processa i també genera un error.

	- La **linia** d'usuari està mal escrita: tampoc es processa i genera un error.
 

* Aquest script reb un únic argument,`insert_users.txt`, un fitxer d'usuaris amb el format que hem comentat, i retorna **4 fitxers**:

`usuaris_alta.ldif` -> Fitxer en format ldif on s'emmagatzema cada **usuari vàlid** que s'ha processat i està **preparat** per ser injectat a LDAP

**EXEMPLE**

cat **usuaris_alta.ldif**
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

cat **usuaris_append_grup.ldif**
```
dn: cn=profes,ou=grups,dc=edt,dc=org
changetype: modify
add: memberUid
memberUid: profe01 
```

`userhomes.txt` -> Fitxer en s'emmagatzema, per cada linia, l'usuari i el seu home amb el format de **user:home**,recordar que aquests són els nous logins i homes contemplant el grup al qual pertany l'usuari.  
Aquest fitxer és creat amb la finalitat de tenir **registrats els usuaris vàlids** processats juntament amb els seus **homes** per poder processar-los posteriorment en els següents scripts. 

**EXEMPLE**

cat **userhomes.txt**

```
iawuser01:/home/grups/wiaw1/iawuser01
iawuser02:/home/grups/wiaw1/iawuser02
iawuser03:/home/grups/wiaw1/iawuser03
```

`error_log/usuaris_error.log` -> Fitxer de logs en cas de que es produeixi algun tipus d'**incidència** quan es processa un usuari. Aquest fitxer recopila totes les incidències provenent de les linies del fitxer processat i indica el motiu.
 
**EXEMPLE**

cat **usuaris_error.log**
```
User userx04 no te un grup existent a la BBDD. Crei el grup i despres afegeix lusuari 
Linia d'usuari incorrecta, revisi la linia 9 
L'usuari pere ja existeix a LDAP
```

* Per afegir aquests usuaris a LDAP utilitzarem la commanda **ldapadd** i ens autenticarem contra ldap amb l'usuari **operador**, que és l'usuari encarregat de duur a terme aquest tipus de operacions contra el servidor.

```
# afegir usuari

ldapadd -x -w operador -h ldap.edt.org -D "uid=operador,ou=usuaris,dc=edt,dc=org" -f usuaris_alta.ldif

# afegir usuari al grup

ldapadd -x -w operador -h ldap.edt.org -D "uid=operador,ou=usuaris,dc=edt,dc=org" -f usuaris_append_grup.ldif
```


#### SECCIÓ KERBEROS
---

* En segon lloc tenim l'**script en bash** `create_kerberos.sh` que té la funció de crear el principals de kerberos.

* Aquest script reb el fitxer `userhomes.txt` que ha estat creat a travès de l'execució de l'script `alta_users.py`.

* Processa cada usuari i **crea el seu principal de kerberos**. Una vegada creat comprova si la creació ha anat bé o ha fallat, consultant a la base de dades de kerberos i comprovant si el principal injectat es troba alli.  
En cas de que ha funcionat mostra per pantalla que s'ha creat i en cas d'error mostra un missatge d'error.  
Al finalitzar l'script mostra el recompte total d'usuaris processats correctament i els fallits. 

* Aquest script no retorna cap fitxer.

**EXECUCIÓ**

```
kadmin -p operador -w operador -q "addprinc -pw  $user $passwd
```

#### SECCIÓ SAMBA
---

* En terçer lloc trobem l'script en **python** `create_samba.py` que té la funció de **crear els comptes de samba** per cada usuari processat.

`create_samba.py` és un script en python que igual que l'script `crete_kerberos.sh`, reb el fitxer `userhomes.txt`.

* Aquest script és basa en la creació d'un fitxer que contindrà a cada linia l'**estructura** necessaria per poder crear un usuari de samba automatizadament. 

```
echo -e "user\npassword" | smbpasswd -a user
```

* Rep per argument el fitxer `userhomes.txt` i una vegada executat ens crea el fitxer `usuaris_samba.sh` amb el contingut mostrat anteriorment per cada usuari vàlid. 

* Cal remarcar que samba no disposa de eina en si per poder agregar nous usuaris a la seva base de dades **remotament**. Permet llistar, canviar passwords però no crear usuaris nous si no et trobes dins del servidor.  
Tenint en compte aquest factor advers, per poder crear aquests usuaris ens haurem de connectar al servidor samba mitjançant una connexió **ssh**.  
Bé, realment seràn 2 connexions: una per copiar l'arxiu dins del servidor i l'altra per executar-l'ho.

```
scp usuaris_samba.sh root@samba.edt.org:/tmp

ssh root@samba.edt.org "bash /tmp/usuaris_samba.sh"
```

* També important a destacar que quan realitzem la connexió ssh serà amb l'usuari **root** ja que el servidor samba requereix de l'usuari root per poder afegir usuaris, ja que sent qualsevol altre usuari no es possible fer la incorporació.


#### SECCIÓ HOMES
---

* Finalment nomès ens queda l'última part per completar l'injecció d'usuaris, la **creació** del directori de treball de l'usuari (home).

* Per aquesta part tenim un script en **bash** anomenat `create_homes.sh` que tambè rep per argument el fitxer `userhomes.txt`.

* Aquest script està destinat a la creació del home dels usuaris i l'assignació dels permisos corresponents. 

* En acabar l'execució retorna quants **home** shan creat correctament i quans han fallat.


### SCRIPT GLOBAL

* Per fer tota aquesta feina molt més fàcil i eficaç, he creat un script que incorpora cada pas i on et va informant en cada moment del que està succeint i que passarà.

* Aquest script de bash és diu `UPDATEDB-insertUsers.sh` i segueix l'estructura en ordre que hem comentat.

* Per poder veureu amb més detall aquí deixo una captura de l'execució de l'script amb un fitxer d'usuaris el qual tots els usuaris en aquest cas són vàlids.

**EXECUCIÓ UPDATEDB-insertUsers.sh**


```
Total processats:
Acceptats: 70 (Consultar usuaris_alta.ldif)
Denegats: 0 (Consultar usuaris_error.log)
Vols continuar?
Yes/No
Yes

ARA S'INJECTARAN ELS USUARIS A LA DB de LDAP
adding new entry "uid=iawuser01,ou=usuaris,dc=edt,dc=org"

adding new entry "uid=iawuser02,ou=usuaris,dc=edt,dc=org"

adding new entry "uid=iawuser03,ou=usuaris,dc=edt,dc=org"

adding new entry "uid=iawuser04,ou=usuaris,dc=edt,dc=org"

adding new entry "uid=iawuser05,ou=usuaris,dc=edt,dc=org"
.
.
.

ARA S'AFEGIRAN ELS USUARIS ALS SEUS GRUPS CORRESPONENTS
modifying entry "cn=wiaw1,ou=grups,dc=edt,dc=org"

modifying entry "cn=wiaw1,ou=grups,dc=edt,dc=org"

modifying entry "cn=wiaw1,ou=grups,dc=edt,dc=org"
.
.
modifying entry "cn=wiaw2,ou=grups,dc=edt,dc=org"

modifying entry "cn=wiaw2,ou=grups,dc=edt,dc=org"
.
.
modifying entry "cn=hisx1,ou=grups,dc=edt,dc=org"

modifying entry "cn=hisx1,ou=grups,dc=edt,dc=org"
.
.
modifying entry "cn=hisx2,ou=grups,dc=edt,dc=org"

modifying entry "cn=hisx2,ou=grups,dc=edt,dc=org"
.
.
modifying entry "cn=wiam1,ou=grups,dc=edt,dc=org"

modifying entry "cn=wiam1,ou=grups,dc=edt,dc=org"
.
.
modifying entry "cn=wiam2,ou=grups,dc=edt,dc=org"

modifying entry "cn=wiam2,ou=grups,dc=edt,dc=org"
.
.
modifying entry "cn=profes,ou=grups,dc=edt,dc=org"

modifying entry "cn=profes,ou=grups,dc=edt,dc=org"


ATENCIO
Ara es crearan els principals de kerberos
iawuser01 creat correctament
iawuser02 creat correctament
.
.
.
profe08 creat correctament
profe09 creat correctament
profe10 creat correctament
TOTAL:
Succeed: 70
Fail: 0

CONNEXIO AMB SAMBA
Injecció d'usuaris Samba

The authenticity of host 'samba.edt.org (172.30.0.6)' can't be established.
ECDSA key fingerprint is SHA256:mtrxUZix8dcmB0bJnAHbn0BxOU+oJn+i14QvzJ7FqvY.
ECDSA key fingerprint is MD5:75:8c:00:48:f6:38:ad:58:ac:b2:d7:cf:86:4f:a1:04.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'samba.edt.org,172.30.0.6' (ECDSA) to the list of known hosts.
root@samba.edt.org's password: 
usuaris_samba.sh                                                                                          100% 3873    16.1MB/s   00:00    
root@samba.edt.org's password: 

New SMB password:
Retype new SMB password:
Added user iawuser01.
New SMB password:
Retype new SMB password:
Added user iawuser02.
.
.
.
New SMB password:
Retype new SMB password:
Added user profe09.
New SMB password:
Retype new SMB password:
Added user profe10.

CREACIO HOMES DEL USUARIS
/home/grups/wiaw1/iawuser01 creat correctament
/home/grups/wiaw1/iawuser02 creat correctament
.
.
.
/home/grups/profes/profe08 creat correctament
/home/grups/profes/profe09 creat correctament
/home/grups/profes/profe10 creat correctament
TOTAL:
Succeed: 70
Fail: 0

SCRIPT D'INJECCIÓ D'USUARIS FINALITZAT
```

### ALTRES PUNTS

* El fitxer `welcome.md` que tenim en aquest directori és el fitxer de benvinguda que es copia dins dels homes dels usuaris en la creació d'aquest.

* El directori `error_log` és el lloc on és creen i guarden els fitxers d'errors generat durant l'injecció d'usuaris.

#### EXTRA

* Paral·lelament a l'injecció dels usuaris també existeix un script en python de formulari anomenat `formulari.py` 

**EXECUCIÓ**

```
[root@homes insertUser]# python formulari.py 

FORMULARI INFORMACIÓ BÁSICA
USERNAME: iawuser01 # Introduir el login que t'hagin donat
FULL NAME: xavi pepito palotes
EMAIL: x@edt.org
TELEPHONE: 62626262626
DESCRIPTION: Im new here!
```

* Aquesta execució genera un fitxer **LDIF** anomenat `usuari_more_data.ldif` que està preparat per ser afegit a ldap i modificar l'entrada de l'usuari.

**EXECUCIÓ**

```
ldapadd -x -w operador -h ldap.edt.org -D "uid=operador,ou=usuaris,dc=edt,dc=org" -f usuari_more_data.ldif 
modifying entry "uid=iawuser01,ou=usuaris,dc=edt,dc=org"

[root@homes insertUser]# ldapsearch -x -LLL uid=iawuser01
dn: uid=iawuser01,ou=usuaris,dc=edt,dc=org
objectClass: posixAccount
objectClass: inetOrgPerson
cn: iawuser01
sn: iawuser01
ou: wiaw1
uid: iawuser01
uidNumber: 2001
gidNumber: 201
loginShell: /bin/bash
homeDirectory: /home/grups/wiaw1/iawuser01
mail: x@edt.org
mobile: 62626262626
description: Im new here!
displayName: xavi pepito palotes
```

