# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
## LDAP SERVER Dockerfile
# -------------------------------------
FROM fedora:27
LABEL author="ERIC ESCRIBA"
LABEL description="ldapserver edt.org uid dataDB"
RUN dnf -y install procps openldap-clients openldap-servers
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/install.sh /opt/docker/startup.sh
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]
