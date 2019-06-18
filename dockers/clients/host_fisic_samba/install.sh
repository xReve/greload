#! /bin/bash
# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
# Install HOST FISIC
# -------------------------------------

RUN dnf -y install krb5-workstation passwd cifs-utils authconfig pam_krb5 openssh-clients nss-pam-ldapd procps pam_mount iputils iproute dhclient bind-utils

# COPY FILES

cp nslcd.conf /etc/nslcd.conf
cp nsswitch.conf /etc/nsswitch.conf
cp ldap.conf /etc/openldap/ldap.conf

cp krb5.conf /etc/krb5.conf

cp pam_mount.conf.xml /etc/security/pam_mount.conf.xml
cp system-auth /etc/pam.d/system-auth

cp resolv.conf /etc/resolv.conf
cp sssd.conf /etc/sssd/sssd.conf

bash auth.sh
/usr/sbin/nslcd && echo "nslcd Ok"
/usr/sbin/nscd && echo "nscd Ok"


