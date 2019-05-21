# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà


* L’objectiu d’aquest projecte és generar un model similar a gandhi de l’Escola del Treball però amb cada un dels components separats en containers Docker. 
* És de especial importància Kerberos, LDAP , NFS i SAMBA. 
* Un un segon grau els serveis DNS i DHCP. Un tercer nivell de serveis serien serveis generals tipus SSH, HTTP, TFTP, FTP, etc.

* **EXPLICACIÓ CORRESPONENT EN CADA DIRECTORI** ->

* SEGUIMENT DEL PROJECTE EN EL FITXER **seguiment.md**

Les imatges es troben disponibles a [eescriba](https://hub.docker.com/u/eescriba/)


docker-compose up -d



**EXECUCIÓ DOCKERS**

docker run --rm --name ldap.edt.org -h ldap.edt.org --network gandhi-net -d eescriba/ldapserver:greload

docker run --rm --name kserver.edt.org -h kserver.edt.org --network gandhi-net -d eescriba/kerberos:greload


docker run --rm --name homes.edt.org -h homes.edt.org --network gandhi-net --privileged -d eescriba/userhomes:greload


docker run --rm --name samba.edt.org -h samba.edt.org --network gandhi-net --privileged --volumes-from homes.edt.org -d eescriba/sambaserver:greload

docker run --rm --name shost.edt.org -h shost.edt.org --network gandhi-net --privileged -it eescriba/sambahost:greload


docker run --rm --name nfshost.edt.org -h nfshost.edt.org --network gandhi-net --privileged -it eescriba/nfshost:greload


docker run --rm --name nfsserver.edt.org -h nfsserver.edt.org --network gandhi-net --privileged --volumes-from homes.edt.org -d eescriba/nfsserver:greload 

