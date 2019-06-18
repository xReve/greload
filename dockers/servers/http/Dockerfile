# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
## HTTP SERVER Dockerfile
# -------------------------------------
FROM fedora:27
LABEL author="ERIC ESCRIBA"
LABEL description="SERVER HTTPD"
RUN dnf -y install httpd
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/install.sh /opt/docker/startup.sh
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]
