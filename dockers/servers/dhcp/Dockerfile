# GANDHI RELOAD
# @edt ASIX M14-PROJECTE Curs 2018-2019
# Èric Escribà
# Server DHCP
# -------------------------------------
FROM fedora:27
RUN dnf -y install dhcp procps iproute nmap 
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh /opt/docker/install.sh
WORKDIR /opt/docker
CMD [ "/opt/docker/startup.sh" ]
