# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

## SECCIÓ SERVIDORS

* En aquesta part del projecte estàn desenvolupats cadascun dels servidors demanats amb les seves explicacions corresponents en els seus directoris.

* Cada servidor es troba desenvolupat en un docker i tots es troben en una xarxa de docker. Això es desplega amb el `docker-compose.yml` com hem comentat abans.

* Dins de cada directori hi ha els fitxers necessaris per crear una imatge i executar-l'ha perquè treballi en mode **detach**. 

* Els servidors segueixen la estructura realitzada durant el curs: 

	* contenen un fitxer `install.sh` que inclou cada pas necessari perquè el servidor funcioni com nosaltres vulgem.
	
	* contenen un fitxer `startup.sh` que és el **CMD** del contenidor. Aquest fitxer executa `install.sh` i fa que el docker es quedi en **detach**.

* Aquests servidors es creen atravès d'una imatge que es genera amb un **Dockerfile** que és troba en cadascun dels directoris corresponents.


