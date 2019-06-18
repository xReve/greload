# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
# Dockerfile SSH SERVER
# ---------------------------
FROM fedora:27
LABEL author="Eric Escriba"
LABEL description="Server SSH"
RUN dnf -y install krb5-workstation passwd pam_krb5 openldap-clients nss-pam-ldapd \
                   procps pam_mount openssh-clients openssh-server cifs-utils iputils iproute
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh /opt/docker/install.sh
WORKDIR /opt/docker
CMD [ "/opt/docker/startup.sh" ]

