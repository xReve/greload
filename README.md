# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà


### OBJECTIU

* L’objectiu d’aquest projecte és generar un model similar a **gandhi** de l’Escola del Treball però amb cada un dels components separats en containers Docker. 

* **Gandhi** és el nom otorgat a l'estructura informàtica de l'escola la qual incorpora un servidor **LDAP**,servidor **KERBEROS**,servidor **NFS**,servidor **DNS** entre d'altres. 

* Implementació dels serveis bàscis **d'autenticació** d'un usuari unix, és a dir, en aquest cas com que simulem la plataforma de l'escola hem d'aconseguir que atravès d'un compte d'usuari unix pugem autenticar-nos contra el servidor **LDAP** i obtenint la confirmació del password atravès del servidor de **KERBEROS**.  
Una vegada és produeixi aquesta autenticació, aquest usuari requerirà d'un lloc de treball el qual serà importat d'una zona externa a aquests servidors, la qual estarà destinada a emmagatzemar els **homes** dels usuaris i el seu contingut. Per tant, una vegada acceptat l'usuari amb el seu password corresponent, se li montara una unitat al seu directori de treball (home) mitjançant un servidor **NFS** o bé **SAMBA**, depenet de la configuració del client.  

* A més a més, el **host client** en iniciar-se ha de rebre una configuració de xarxa provenent del servidor **DHCP**, el qual té configurat un rang d'IP les quals assignara als hosts que demanin una identitat. Aquest servidor també va lligat amb el servidor **DNS** el qual farà que el host client pugi resoldre les IPs segons la seva configuració.

* Per finalitzar, també trobem la implementació de 3 servidors secundaris: **SSH**, **HTTP** i **FTP**. Cadascun d'aquests es trobarà també en un contenidor i l'usuari podra atacar contra els seus ports corresponents, ja sigui per fer una connexió ssh,ftp o bé una consulta web.  
Aquests servidors seràn **kerberitzats**, és a dir, han de tenir connexió amb LDAP i KERBEROS per poder autenticar els usuaris que es vulgin connectar. 

### ESTRUCTURA

* El projecte és divideix en dos grans blocs: l'estructura de **contenidors Docker** (amb cadascun dels servidors i clients) i l'apartat de **scripting**.

#### CONTENIDORS
---

* Pel que respecta a l'estructura de contenidors, ho tenim explicat en el directori `dockers`, on en cada apartat d'explica tot l'implementat en detall i els punts a considerar


#### SCRIPTING
----
* En aquesta secció del projecte es desenvolupa l'automatizació de tasques d'administració de la infraestructura.

* S'ha implementat scripts **d'alta, baixa d'usuaris i grups LDAP**. Això no nomès en esborrar l'usuari i el grup de LDAP si no que comportaconnectar amb el servidor kerberos per tractar el principal corresponent per a l'usuari tractat (ja sigui d'alta o baixa).  
A més també s'ha de tenir en compte que aquest usuari o grup té un directori de treball on hi haura tota la seva informació emmagatzemada del dia a dia.  
També cal afegir els usuaris samba, ja que és una part indispensable per poder obtenir els homes.

* Aquesta part s'explica més explicitament i amb més detalls dins de la secció de scripts en el directori `scripts`.


### REPRESENTACIÓ GRÀFICA

* A continuació us presento un breu esquema visual de l'estructura que s'implementa en aquest projecte amb tots els seus components i com interactuen entre ells.


![alt cloud](https://github.com/xReve/greload/blob/master/aux/docker_cloud.png)
![alt host](https://github.com/xReve/greload/blob/master/aux/host.png)



* En la part superior de l'esquema trobem situats cadascun dels servidors que hem comentat anteriorment que són essencials per al projecte.  
Aquests estàn localitzats en una xarxa interna de **docker**, cal destacar que no nomès es podrien trobar en una xarxa docker, podrien estar en una màquina virtual, una màquina de amazon o qualsevol altre lloc virtualitzat, però en aquest cas s'ha fet en una xarxa docker.


* Les fletxes **blaves** representen quins servidors estàn connectats pel servidor **LDAP**, és a dir, que tenen connectivitat entre ells i són capaços de fer consultes contra ell.

* Les fletxes **vermelles** representen la relació que tenen els servidors **NFS** i **SAMBA** envers el contenidor **HOMES**. Aquesta connexió que existeix entre ells, permet que quan un usuari s'autentiqui contra LDAP i KERBEROS, una vegada confirmada aquesta autenticació, obtingui un directori de treball. Aquests servidors obtenen aquests directoris del contenidor **HOMES** i el monten al host on s'està connectant el client. 

* Les flexes **negres** ens indiquen a qui ataquen aquests servidors. Totes apunten al mateix lloc, el **host**. 

* El **host** és la màquina en la qual s'ha implementat aquesta estructura i la que els clients atacaran per poder obtenir les seves credencials.   
És a dir, els clients, dels dels seus propis hosts (pc), enviaran les peticions necessaries contra el **host** en el qual està desenvolupada la estructura anterior, i ells mai sabran ni tindran coneixement d'aquesta, ja que per ells els servidors responen en nom del host.

* Tenint en compte això, podriem guardar aquesta estructura i desplegar-l'ha en qualsevol host d'arreu del món i alli tindriem un sistema d'administració d'usuaris sempre i quan configuressim els hosts clients perquè ataquessin contra el host el qual ho té montat. 

 
### ALTRES PUNTS

* **EXPLICACIÓ DEL CONTINGUT EN CADA DIRECTORI**

* **SEGUIMENT DEL PROJECTE EN EL FITXER** `seguiment.md`

* Les imatges pertinents de cada contenidor Docker es troben emmagatzemades a [dockerhub](https://hub.docker.com/u/eescriba/)

* Directori `aux` on és guarda contingut adicional al projecte

aesborrar -> 
**EXECUCIÓ DOCKERS**

docker run --rm --name shost.edt.org -h shost.edt.org --network gandhi-net --privileged -it eescriba/sambahost:greload


docker run --rm --name nfshost.edt.org -h nfshost.edt.org --network gandhi-net --privileged -it eescriba/nfshost:greload






