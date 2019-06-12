# Version: 0.0.1
# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
# Dockerfile NFS SERVER
# -------------------------------------
FROM fedora:27
LABEL author="ERIC ESCRIBA"
LABEL description="NFS SERVER"
RUN dnf -y install procps passwd openldap-clients nss-pam-ldapd  pam_mount nfs-utils
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/install.sh /opt/docker/startup.sh
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]
