#! /bin/bash
# Instal·lació client samba
#---------------------------

cp /opt/docker/sssd.conf /etc/sssd/sssd.conf
cp /opt/docker/krb5.conf /etc/krb5.conf
cp /opt/docker/nslcd.conf /etc/nslcd.conf
cp /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp /opt/docker/nsswitch.conf /etc/nsswitch.conf
cp /opt/docker/system-auth /etc/pam.d/system-auth
cp /opt/docker/pam_mount.conf.xml /etc/security/pam_mount.conf.xml

