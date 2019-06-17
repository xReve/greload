# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

### DOCKERS

* En aquesta secció tenim cadascún dels **elements** del projecte separats en directoris, els quals contenen els fitxers necessaris per crear imatges de docker que posteriorment seràn els contenidors en els quals s'executaran els serveis indicats.

* Està dividit en **tres** seccions: servidors, clients i zona de treball/homes 

* En els **servidors** tenim: **LDAP**, **KERBEROS**, **SAMBA**, **NFS**, **DNS**, **DHCP**,**SSH**,**HTTP**

* En els **clients** tenim: client **NFS** i client **SAMBA**

* I finalment ens queda la zona dels **homes** del usuaris, que al mateix temps és el lloc en el qual **l'administrador** treballara quan s'hagin de fer canvis en les bases de dades dels servidors. 

* Les imatges pertinents de cada contenidor Docker es troben emmagatzemades a [IMATGES_DOCKERS](https://hub.docker.com/u/eescriba/)


### DESPLEGAMENT

* El llançament dels servidors en la xarxa interna de docker es durà a terme a traves d'un fitxer anomenat `docker_compose.yml`.

* Abans d'iniciar l'execució hem de tenir en compte una sèrie de punts perquè aquesta es faci correctament:

	- 
	
	- 

	-
	
	- 


