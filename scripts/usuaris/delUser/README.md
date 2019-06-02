# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

### ESBORRAT D'USUARIS
---

### ESTRUCTURA

Per poder duur a terme l'esborrat d'un compte d'usuari, és necessari seguir una sèrie de passos:


**1. ESBORRAT HOME**

* En aquest cas alhora d'esborrar el compte d'usuari primer agafarem el seu home i l'esborrarem. També és podria contemplar l'opció de guardar el contingut d'aquests homes en cas especial però no ho implementarem en aquesta secció. 

* És necessari esborrar el **home** en primer lloc ja que d'altra forma no podriem saber quin és ja que no tindrim on consultau. 


**2. ESBORRAT USUARI LDAP**

* Seguidament esborrarem l'usuari de **LDAP** conjunatment la seva entrada en el seu grup corresponent. Per tant s'haurà de crear l'estructura per fer ambdues tasques.


**3. ESBORRAT PRINCIPAL KERBEROS**

* En terçer lloc ens toca esborrar el principal de kerberos ja que no ens interessa deixar usuaris no actius penjats per les bases de dades. 


**4. ESBORRAT COMPTE SAMBA**

* I per finalitzar nomès ens caldria esborrat el compte d'usuari de samba ja que tampoc és necessari i pràctic tenir-l'ho guardat i no fer-ne ús.


### DESENVOLUPAMENT

#### SECCIÓ HOMES
---

* Per poder esborrat els **homes** dels usuaris tenim un script en **bash** anomenat `delete_home.sh`.

* Aquest script està enfocat a l'esborrat de homes, però per fer-ho contacta amb el servidor **LDAP** per poder determinar el home de l'usuari que reb.

* Una vegada s'intenta l'esborrat aquest script ens retorna si ha anat be o ha fallat, en la finalització de l'execució ens retorna el total de homes esobrrats i els fallits.

* Aquest script reb un fitxer amb usuaris **vàlids** per ser esborrats. Aquests usuaris que han estat determinat vàlids han estat processats per l'script `delete_entries.py` i els ha guardat en un fitxer de format **txt** anomenat `usuaris_acceptats.txt`.

* El fitxer `usuaris_acceptats.txt` contè un nom usuari (login) per línia.

#### SECCIÓ LDAP
---

* Els usuaris a tractar ens arriben en un fitxer anomenat `delete_users.txt`, aquest fitxer contè per cada línia un usuari que no sabem si és valid o no ja que no l'hem tractat.

* Per processar aquests usuaris tenim l'script que hem anomenat anteriorment `delete_entries.py`.

* Aquest script té la principal finalitat de processar usuaris i crear l'estructura amb format **LDIF** per poder esborrar aquests usuaris de **LDAP**.

* A més a més aquest script contempla els possibles cassos d'error:

	- Una mala **connexió** amb el servidor LDAP: en aquest cas el programa finalitza amb un missatge d'error i no es continua processant els usuaris.
	
	- Usuari existent a LDAP: si l'usuari no existeix a LDAP es generarà un missatge d'error i s'ignorarà aquest usuari.

* Al finalitzar l'script ens retorna la quantitat d'usuaris que s'han processat correctament i la quantitat de fallits.

* Aquest script reb el fitxer `usuaris_acceptats.txt` i retorna **4 fitxers**:

`usuaris_delete.ldif` -> Fitxer amb format **LDIF** amb l'entrada de cada usuari vàlid per ser esborrat de LDAP

**EXEMPLE**

cat **usuaris_delete.ldif**

```
uid=pere,ou=usuaris,dc=edt,dc=org

uid=anna,ou=usuaris,dc=edt,dc=org

uid=marta,ou=usuaris,dc=edt,dc=org

```

`usuaris_group_del.ldif` -> Fitxer amb format **LDIF** que contè l'estructura d'esborrar l'usuari del grup al qual pertany.

**EXEMPLE**

cat **usuaris_group_del.ldif** 

```
dn: cn=test,ou=grups,dc=edt,dc=org
changetype: modify
delete: memberUid
memberUid: pere

dn: cn=test,ou=grups,dc=edt,dc=org
changetype: modify
delete: memberUid
memberUid: anna

dn: cn=test,ou=grups,dc=edt,dc=org
changetype: modify
delete: memberUid
memberUid: marta

```

`usuaris_acceptats.txt` -> Fitxer amb un usuari vàlid processat en cada línia. Aquests usuaris podran ser esborrats sense causar cap problema.

`usuarisDel_error.log` -> Fitxer on es guarden els errors produits durant l'execució de l'script. 

**EXEMPLE**

cat **usuarisDel_error.log**

```
L'usuari po no existeix a LDAP
```

* Per aplicar l'esborrat de l'usuari de LDAP nomès ens cal atacar la base de dades amb l'usuari **operador** que és l'encarregat de fer operacions contra el servidor.

**EXECUCIÓ**

```
# Esborrar usuaris de LDAP

ldapdelete -x -w operador -h ldap.edt.org -D "uid=operador,ou=usuaris,dc=edt,dc=org" -f usuaris_delete.ldif 


# Esborrar usuaris del grup

ldapmodify -x -w operador -h ldap.edt.org -D "uid=operador,ou=usuaris,dc=edt,dc=org" -f usuaris_group_del.ldif
```

#### SECCIÓ KERBEROS
---

* Per tractar amb els principals de kerberos tenim l'script en **bash** `delete_kerberos.sh`.

* Aquest script processa el fitxer `usuaris_acceptats.txt` i per cada usuari s'encarrega de contactar amb el servidor kerberos i executa l'esborrat del principal.

* Per cada intent d'esborrat l'script ens retorna un missatge amb el resultat de l'operació: okey o error.

* En finalitzar l'script ens retorna un missatge amb la quanitat d'usuaris processats i el total de esborrats i fallits.

* Aquest script no retorna cap fitxer.

**EXECUCIÓ**

```
echo "yes" | kadmin -p operador -w operador -q "delete_principal $user"
```

#### SECCIÓ SAMBA
---

* Per finalitzar amb l'esborrat ens queda encarregar-nos dels comptes SAMBA. Per tractar això tenim l'script en **python** `delete_samba.py`.

* Aquest script té la principal funció de crear un fitxer on cada línia serà l'estructura necessària per poder esborrar un usuari de samba.

* Reb un únic argument, `usuaris_acceptats` i retorna un script en **bash** per ser executat en el servidor `usuaris_samba.sh`.

* L'estructura d'esborrar seria la següent:

```
#! /bin/bash

smbpasswd -x pere
smbpasswd -x anna
smbpasswd -x marta
``` 

* Aquest script s'executarà dins del servidor **SAMBA**, igual que en l'injecció d'usuaris, establint una connexió **SSH** contra el servidor per copiar el fitxer i una altra per executar-l'ho.

**EXECUCIÓ**

```
scp usuaris_samba.sh root@samba.edt.org:/tmp

ssh root@samba.edt.org "bash /tmp/usuaris_samba.sh"

```

* Com esta comentat en la secció d'injecció, la connexió s'ha d'establir com a usuari **root** degut als permisos del servidor **SAMBA**.


### SCRIPT GLOBAL

* Per fer tota aquesta feina molt més fàcil i eficaç, he creat un script que incorpora cada pas i on et va informant en cada moment del que està succeint i que passarà.

* Aquest script de bash és diu `UPDATEDB-delUsers.sh` i segueix l'estructura en ordre que hem comentat.

* Per poder veureu amb més detall aqui deixo una captura de l'execució de l'script amb un fitxer d'usuaris el qual tots els usuaris en aquest cas són vàlids.

**EXECUCIÓ UPDATEDB-delUsers.sh**

```
Total processats:
Acceptats: 3 (Consultar usuaris_delete.ldif)
Denegats: 1 (Consultar usuarisDel_error.log)
Vols continuar?
Yes/No
Yes

ARA S'ESBORRARAN ELS HOMES DELS USUARIS
/home/grups/test/pere esborrat correctament
/home/grups/test/anna esborrat correctament
/home/grups/test/marta esborrat correctament
TOTAL
Esborrats: 3
Failed: 0

ARA S'ESBORRARAN ELS USUARIS A LA DB de LDAP

ARA S'ESBORRARAN ELS USUARIS DELS SEUS GRUPS CORRESPONENTS
modifying entry "cn=test,ou=grups,dc=edt,dc=org"

modifying entry "cn=test,ou=grups,dc=edt,dc=org"

modifying entry "cn=test,ou=grups,dc=edt,dc=org"


ATENCIO
Ara es borraran els principals de kerberos
pere ha estat esborrat correctament
anna ha estat esborrat correctament
marta ha estat esborrat correctament
TOTAL
Esborrats: 3
Failed: 0
The authenticity of host 'samba.edt.org (172.30.0.7)' can't be established.
ECDSA key fingerprint is SHA256:59OAkdpBSJhiMny7tJ1xEjV2dnbTCBp1UxOwdILXTiU.
ECDSA key fingerprint is MD5:15:10:87:40:67:1c:a1:b9:fd:64:81:e7:92:09:63:0c.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'samba.edt.org,172.30.0.7' (ECDSA) to the list of known hosts.
root@samba.edt.org's password: 
usuaris_samba.sh                                                                                                                                                                 100%   68   379.9KB/s   00:00    
root@samba.edt.org's password: 
Deleted user pere.
Deleted user anna.
Deleted user marta.

SCRIPT D'ESBORRAT D'USUARIS FINALITZAT
```

### ALTRES PUNTS

* EL directori `error_log` és el lloc on és creen i guarden els fitxers d'errors generat durant l'esborrat d'usuaris.

* L'script `neteja.sh` esborra tots els fitxers generats durant l'esborrat d'usuaris. 

