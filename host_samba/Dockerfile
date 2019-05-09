# Version: 0.0.1
# @edt M06 2018-2019
# hostpam
# -------------------------------------
FROM fedora:27
<<<<<<< HEAD
LABEL author="eescriba"
LABEL description="HOST PAM 2018-2019"
RUN dnf -y install krb5-workstation passwd cifs-utils authconfig pam_krb5 openssh-clients nss-pam-ldapd procps pam_mount iputils 
=======
LABEL author="@edt ASIX M06-ASO"
LABEL description="host PAM 2018-2019"
RUN dnf -y install procps passwd openldap-clients nss-pam-ldapd pam_mount cifs-utils pam_krb5  krb5-workstation
>>>>>>> 5cddf6f7a48785f9c2d695d3cec683805bc0da7a
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/install.sh /opt/docker/startup.sh
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]
