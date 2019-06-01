# DNS SERVER
# -------------------------------------
FROM fedora:27
LABEL author="ERIC ESCRIBA"
LABEL description="DNS SERVER"
RUN dnf -y install procps bind nmap 
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/install.sh /opt/docker/startup.sh
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]
