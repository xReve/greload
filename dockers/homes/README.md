# DOCKER HOMES

## @edt ASIX M14-PROJECTE Curs 2018-2019

* **Zona d'emmagatzematge** dels homes dels usuaris d'**LDAP**.

* S'ha creat un **volum** que conté tots aquests homes, ja que han de ser exportats en un altre docker.

* Aquest docker té connexió amb el LDAP per poder reconeixer els usuaris i **afegir permisos** als seus homes.

* Docker interactiu (temporalment) i possible lloc d'execució de scripts d'injecció i elminiació usuaris


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
mkdir /home/grups/especial
mkdir /home/grups/admin
mkdir /home/grups/especial/pere
mkdir /home/grups/especial/pau
mkdir /home/grups/especial/anna
mkdir /home/grups/especial/marta
mkdir /home/grups/admin/admin

chown -R pere.especial /home/grups/especial/pere
chown -R pau.especial /home/grups/especial/pau
chown -R anna.especial /home/grups/especial/anna
chown -R marta.especial /home/grups/especial/marta
chown -R admin.admin /home/grups/especial/admin
```


**EXECUCIÓ**

```
docker run --rm --name homes.edt.org -h homes.edt.org --network gandhi-net --privileged -it eescriba/userhomes:greload

```

