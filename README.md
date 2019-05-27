# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà


### OBJECTIU

* L’objectiu d’aquest projecte és generar un model similar a **gandhi** de l’Escola del Treball però amb cada un dels components separats en containers Docker. 

* **Gandhi** és el nom otorgat a l'estructura informàtica de l'escola la qual incorpora un servidor **LDAP**,servidor **KERBEROS**,servidor **NFS**,servidor **DNS** entre d'altres. 

* Implementació dels serveis bàscis **d'autenticació** d'un usuari unix, és a dir, en aquest cas com que simulem la plataforma de l'escola hem d'aconseguir que atravès d'un compte d'usuari unix pugem autenticar-nos contra el servidor **LDAP** i obtenint la confirmació del password atravès del servidor de **KERBEROS**.  
Una vegada és produeixi aquesta autenticació, aquest usuari requerirà d'un lloc de treball el qual serà importat d'una zona externa a aquests servidors, la qual estarà destinada a emmagatzemar els **homes** dels usuaris i el seu contingut. Per tant, una vegada acceptat l'usuari amb el seu password corresponent, se li montara una unitat al seu directori de treball (home) mitjançant un servidor **NFS** o bé **SAMBA**, depenet de la configuració del client.  


### ESTRUCTURA

* El projecte és divideix en dos grans blocs: l'estructura de **contenidors Docker** (amb cadascun dels servidors i clients) i l'apartat de **scripting**.

#### CONTENIDORS
---

* Pel que respecta a l'estructura de contenidors, ho tenim explicat en el directori `dockers`, on en cada apartat d'explica tot l'implementat en detall i els punts a considerar


#### SCRIPTING
----
* En aquesta secció 



### REPRESENTACIÓ GRÀFICA

![alt xarlio](https://github.com/xReve/greload/blob/master/aux/docker_cloud.png)

![alt wigga](https://github.com/xReve/greload/aux/host.png)




* **EXPLICACIÓ CORRESPONENT EN CADA DIRECTORI** ->

* SEGUIMENT DEL PROJECTE EN EL FITXER **seguiment.md**

docker-compose up -d


**EXECUCIÓ DOCKERS**

docker run --rm --name shost.edt.org -h shost.edt.org --network gandhi-net --privileged -it eescriba/sambahost:greload


docker run --rm --name nfshost.edt.org -h nfshost.edt.org --network gandhi-net --privileged -it eescriba/nfshost:greload






