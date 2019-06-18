# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

### DOCKERS

* En aquesta secció tenim cadascún dels **elements** del projecte separats en directoris, els quals contenen els fitxers necessaris per crear imatges de docker que posteriorment seràn els contenidors en els quals s'executaran els serveis indicats.

* Està dividit en **tres** seccions: servidors, clients i zona de treball/homes 

* En els **servidors** tenim: **LDAP**, **KERBEROS**, **SAMBA**, **NFS**, **DNS**, **DHCP**,**SSH**,**HTTP**,**FTP**.

* En els **clients** tenim: client **NFS** i client **SAMBA** desplegats en dockers, i els mateixos clients però en versió **física**. 

* I finalment ens queda la zona dels **homes** del usuaris, que al mateix temps és el lloc en el qual **l'administrador** treballara quan s'hagin de fer canvis en les bases de dades dels servidors. 

* Les imatges pertinents de cada contenidor Docker es troben emmagatzemades a [IMATGES_DOCKERS](https://hub.docker.com/u/eescriba/)


### DESPLEGAMENT

* El llançament dels servidors en la xarxa interna de docker es durà a terme a traves d'un fitxer anomenat `docker_compose.yml`.

* El docker **homes** també estarà inclòs en aquests llançament.

* Abans d'iniciar l'execució hem de tenir en compte una sèrie de punts perquè aquesta es faci correctament:

	- No han d'existir contenidors creats amb els mateixos noms que els contenidors del llançament.
	
	- Els ports que s'exporten dels contenidors ara escoltaran en el host on s'executi, per tant, aquests ports no poden estar en ús pels serveis del host.

	- Definir un ordre d'execució en els servidors per tal de que els que depenguin d'altres s'inicin a continuació i no abans.
	

**EXEMPLE EXECUCIÓ**

* Per posar-ho en funcionament utilitzarem la ordre `docker-compose up -d`

```

```

* Per parar la estructura utilitzarem la ordre `docker-compose down` tenint en compte que aquesta ordre borrarà qualsevol canvi fet en els contenidors i tornaran a estar igual que abans de la execució.

```

```



### ALTRES PUNTS

* Els servidors es troben en una xarxa interna de docker, en concret és la **172.30.0.0/16** la qual està definida al `docker-compose.yml`.

* Estem utilitzant la **versió 2** del docker-compose per la utilització d'opcions més concretes per al desplegament dels servidors. 

* En aquesta versió no és possible definir un **hostname** als contenidors ni un **network_name** a la xarxa interna.

* Per altra banda ens permet utilitzar opcions com ara **volumes_from**, per montar els volum del docker **homes** i la opció **depends_on** per definir una prioritat d'arrencada. 

* A més a més en aquesta versió es pot configurar les opcions de la xarxa així podent definir la xarxa que nosaltres vulgem i el seu **gateway**.

* Els clients no estàn inclosos en l'execució del docker-compose ja que aquests no estàn en la mateixa xarxa. 



