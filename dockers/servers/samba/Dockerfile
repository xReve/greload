# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
# Dockerfile SERVER SAMBA
# -------------------------------------
FROM fedora:27
LABEL author="@edt ASIX M06-ASO"
LABEL description="host PAM-SAMBA 2018-2019"
RUN dnf -y install procps passwd openldap-clients nss-pam-ldapd pam_mount cifs-utils samba samba-client openssh-server
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/install.sh /opt/docker/startup.sh
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]
