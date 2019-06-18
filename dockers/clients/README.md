# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

### CLIENTS

* En aquesta secció tenim definits els clients del projecte.

* Hi ha un total de **dos** clients: **nfs** i **samba**

* Aquests clients és validaran contra els seus respectius **hosts** i en aquesta part es troben les configuracions per aquests hosts,
per tal de que els clients pugin treballar en les condicions òptimes i adients a la situació.

* Aqui trobem 4 configuracions diferents de host: 2 per host de **docker** i 2 per un host **físic**.

* Pel que respecta als hosts **docker**, aquests estàn configurats de forma automatitzada perquè quan es crei el contenidor ja estigui operatiu i en funcionament.

* En l'altra banda, en els hosts **físics**, per tal de tenir la configuració adient s'hauràn d'aplicar els canvis necessaris tal i com ho indica en cada apartat de configuració.

* Recalcar que aquests **hosts** estàn configurats de tal manera perquè enviin peticions al host **192.168.2.44** que és el host on està desplegada tota la estructura de servidors els quals
estàn exportant els seus ports en la màquina i aquesta respon en el seu lloc.

* Per tant, si es vol reutilitzar aquestes configuracions és important canviar contra qui actuen. 

