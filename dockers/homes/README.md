# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

### HOMES / ZONA DE TREBALL

* En aquesta part del projecte està desenevolupat la secció dels **homes**

* És la**Zona d'emmagatzematge** dels homes dels usuaris d'**LDAP** i al mateix temps la zona de treball on l'administrador farà ús dels **scripts d'usuaris i grups**.

* Aquests scripts són la còpia de l'apartat **scripts** de la primera pàgina del projecte.

* Aquest docker està configurat per tal de tenir connectivitat amb el servidor **ldap** i el servidor **kerberos** ja que alhora d'executar els scripts és necessari la connexió.

* Per executar el següent docker es faria així:

```
docker run --rm --name homes.edt.org -h homes.edt.org --privileged --network network_name -d eescriba/userhomes:greload
```

* No és un docker interactiu ja que s'executa juntament amb tots els servidors.

* Per poder entrar-hi executarem la següent ordre.

```
docker exec -it homes.edt.org /bin/bash
```

* S'ha creat un **volum** que conté tots aquests homes, ja que han de ser montats en els servidors **nfs** i **samba**


cat `Dockerfile`

```
FROM fedora:27
RUN dnf -y install procps passwd openldap-clients nss-pam-ldapd iputils nmap
LABEL author="eescriba"
LABEL description="User Homes"
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh /opt/docker/install.sh
WORKDIR /opt/docker
VOLUME /home
CMD [ "/opt/docker/startup.sh" ]
```


cat `install.sh`

```

mkdir /home/grups
mkdir /home/grups/hisx1
mkdir /home/grups/hisx2
mkdir /home/grups/wiam1
mkdir /home/grups/wiam2
mkdir /home/grups/wiaw1
mkdir /home/grups/wiaw2
mkdir /home/grups/profes
mkdir /home/grups/test
mkdir /home/grups/admin
mkdir /home/grups/test/pere
mkdir /home/grups/test/pau
mkdir /home/grups/test/anna
mkdir /home/grups/test/marta
mkdir /home/grups/admin/operador

cp welcome.md /home/grups/test/pere
cp welcome.md /home/grups/test/pau
cp welcome.md /home/grups/test/anna
cp welcome.md /home/grups/test/marta
cp welcome.md /home/grups/admin/operador

chown -R pere.test /home/grups/test/pere
chown -R pau.test /home/grups/test/pau
chown -R anna.test /home/grups/test/anna
chown -R marta.test /home/grups/test/marta
chown -R operador.admin /home/grups/admin/operador
```


### ALTRES PUNTS

* S'ha tingut que fer una petita modificació al docker ja que alhora de contactar amb el servidor **kerberos** la connexió tardava massa. Aquesta afectació provè del servidor **dns** que d'alguna forma retrassava la connexió amb els servidors i feia anar molt lent l'execució dels scripts.

* Per tal de millorar la rapidesa de la connexió, s'ha canviat el **dns** i s'han mapejat els noms dels servidors al `/etc/hosts`.

* No és pràctic però és la solució per poder executar els scripts d'una forma ràpida.

