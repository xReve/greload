# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
# Dockerfile Homes
#--------------------------
FROM fedora:27
RUN dnf -y install procps passwd openldap-clients nss-pam-ldapd iputils nmap krb5-workstation python vim openssh-clients 
LABEL author="eescriba"
LABEL description="User Homes"
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh /opt/docker/install.sh
WORKDIR /opt/docker
VOLUME /home
CMD [ "/opt/docker/startup.sh" ]
