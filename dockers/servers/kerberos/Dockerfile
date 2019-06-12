# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
# Kerberos Server Dockerfile
##########################################
FROM fedora:27
RUN dnf -y install krb5-server krb5-workstation krb5-libs
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh /opt/docker/install.sh
WORKDIR /opt/docker
CMD [ "/opt/docker/startup.sh" ]

