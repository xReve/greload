# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
# Dockerfile HOST SAMBA
# -------------------------------------
FROM fedora:27
LABEL author="eescriba"
LABEL description="HOST SAMBA"
RUN dnf -y install krb5-workstation passwd cifs-utils authconfig pam_krb5 openssh-clients nss-pam-ldapd procps pam_mount iputils iproute dhclient bind-utils 
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh /opt/docker/install.sh
WORKDIR /opt/docker
CMD [ "/opt/docker/startup.sh" ]
