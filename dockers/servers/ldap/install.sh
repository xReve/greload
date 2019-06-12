#! /bin/bash
# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
## instal·lacio servidor LDAP
# -------------------------------------
cp  /opt/docker/ldap.conf /etc/openldap/ldap.conf

rm -rf /etc/openldap/slapd.d/*
rm -rf /var/lib/ldap/*
cp /opt/docker/DB_CONFIG /var/lib/ldap
slaptest -F /etc/openldap/slapd.d -f /opt/docker/slapd.conf
slapadd -F /etc/openldap/slapd.d -l /opt/docker/edt.ldif
chown -R ldap.ldap /etc/openldap/slapd.d
chown -R ldap.ldap /var/lib/ldap

