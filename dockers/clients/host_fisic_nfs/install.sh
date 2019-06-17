#! /bin/bash
# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
# Install HOST FISIC
# -------------------------------------

dnf -y install procps passwd openldap-clients nss-pam-ldapd authconfig pam_mount nfs-utils iputils pam_krb5 krb5-workstation dhclient iproute nmap bind-utils

# COPY FILES

cp nslcd.conf /etc/nslcd.conf
cp /opt/docker/nsswitch.conf /etc/nsswitch.conf
cp /opt/docker/ldap.conf /etc/openldap/ldap.conf

cp /opt/docker/krb5.conf /etc/krb5.conf

cp /opt/docker/pam_mount.conf.xml /etc/security/pam_mount.conf.xml
cp /opt/docker/system-auth /etc/pam.d/system-auth

cp resolv.conf /etc/resolv.conf
cp sssd.conf /etc/sssd/sssd.conf

bash auth.sh
/usr/sbin/nslcd && echo "nslcd Ok"
/usr/sbin/nscd && echo "nscd Ok"

