# Version: 0.0.1
# @edt M06 2018-2019
# ldapserver base edt.org
# -------------------------------------
FROM fedora:27
LABEL author="ERIC ESCRIBA"
LABEL description="ldapserver edt.org uid dataDB"
RUN dnf -y install procps openldap-clients openldap-servers
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/install.sh /opt/docker/startup.sh
WORKDIR /opt/docker
EXPOSE 389
CMD ["/opt/docker/startup.sh"]


