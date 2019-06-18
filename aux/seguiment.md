## SEGUIMENT PROJECTE GANDHI RELOAD
### Eric Escriba

* **SETMANA 1**

En la primera setmana m'he informat i fet in plà de treball.
He tractat de fer esquemes i aclaracions del futur desenvolupament del projecte, aclarir els concepetes per poder inciar-ho i no 
tenir que rectificar per malentesos.
Creació de repositoris i llocs de treball.


* **SETMANA 2** 

He iniciat el projecte.
M'he centrat principalment en la creació de la **Base de Dades de LDAP** perquè inclogui usuaris,grups,hosts i aules. Cadascú amb els 
atributs pròpis.
Paral·lelament a la Base de Dades també m'he centrat en el desenvolupament de **scripts** per la injecció d'usuaris i grups, modificiacions i esborrat d'usuaris (tant la seva entrada com la que tenen en el grup al qual pertanyen).
En resum, els scripts transformen dades del format de fitxers del `/etc/passwd` o `/etc/group` a format **LDIF** per poder ser injectats a **LDAP**.

Els scripts no estàn finalitzats perquè falta tenir en compte més dades com ara **informació personal** i els **homes dels usuaris** (scripts d'afegir els homes al seu docker).


* **SETMANA 3**

He desplegat una estructura de dockers més gran.
He incorporat el servidor **kerberos**, servidor **samba**, **host samba** (el qual traballara amb el servidor samba) i l'**estructura del homes** en un docker apart.

He conseguit connectar tots aquests perquè funcionin correctament de la manera següent:

Des del **shost** (host samba) et connectes com a un usuari **ldap** el qual té emmagatzemat la seva password al servidor **kerberos** 
i consegueix autenticar-se.
Paral·lelament, aquest a aquest host se li monta un **recurs samba** (el seu home) que es troba situat
al docker homes **homes** .
Aquest docker té creat un volum el qual incorpora tots els homes dels usuaris de tal forma que ens permetrà exportar-los en un altre docker,en aquest cas el de samba. 
El servidor samba, al ser iniciat, monta aquest volum del **homes** a dins seu perquè els pugi agafar i d'aquesta manera montar el home al usuari en iniciar la sessió.

He treballat una mica més en els scripts creant el **formulari** per d'informació adicional per a l'usuari.

He començat a preparar tant el **servidor com el client nfs**. No estàn en funcionament encara.


* **SETMANA 4**
 
El servidor **nfs** està en funcionament juntament amb el seu client, el qual pot inciar sessió i el servidor li monta el seu home via nfs.

M'estic documentant sobre la implementació del servidor **dns i dhcp** en els dockers respectius i també estic avançant ens els scripts.

Finalment he creat la estructura desitjada del projecte. Els dockers aïllats en una xarxa docker i els clients en una altra xarxa sense saber dels servidors. Ell simplement ataca contra el host on estan situats els servidors.
He creat el docker-compose amb els servidors.

Amb el client **Samba** tot funciona correcte, ataco al host i la connexió es correcta. Inicio sessio amb un usuari ldap i hem **monta el homevia cifs**.

Pel que fa al client **nfs** aquest pot inciar sessió amb un usuari ldap (autenticat amb kerberos) pero el home no se li monta per culpa d'una mala connexió amb el servidor. Es queixa que no pot accedir als **ports del servidor** pero no obstant aquests **estàn en funcionament** i accessibles des del host i el client nfs.


* **SETMANA 5**

Setmana que m'he centrat basicament en pulir i acabar de definir els scripts del projecte.
Els **scripts** ja els dono per acabats, considero que ara mateix estàn força bé, i ara toca centrar-se amb el **dns i dhcp**
Pel que fa al client **nfs** encara no he trobat la sol·lució al problema.
A tot aixo hem queda pendent acabar aquests dockers i documentar tot el fet.




