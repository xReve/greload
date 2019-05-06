FROM fedora:27
LABEL author="eescriba"
LABEL description="HOST PAM 2018-2019"
RUN dnf -y install krb5-workstation passwd authconfig pam_krb5 openssh-clients nss-pam-ldapd procps 
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh /opt/docker/install.sh
WORKDIR /opt/docker
CMD [ "/opt/docker/startup.sh" ]

