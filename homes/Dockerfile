FROM fedora:27
RUN dnf -y install procps passwd openldap-clients nss-pam-ldapd iputils nmap krb5-workstation krb5-server
LABEL author="eescriba"
LABEL description="User Homes"
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh /opt/docker/install.sh
WORKDIR /opt/docker
VOLUME /home
CMD [ "/opt/docker/startup.sh" ]
