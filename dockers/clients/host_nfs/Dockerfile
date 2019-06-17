# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
# Dockerfile HOST NFS
# -------------------------------------
FROM fedora:27
LABEL author="ERIC ESCRIBA"
LABEL description="host NFS"
RUN dnf -y install procps passwd openldap-clients nss-pam-ldapd authconfig pam_mount nfs-utils iputils pam_krb5 krb5-workstation dhclient iproute nmap bind-utils
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/install.sh /opt/docker/startup.sh
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]
