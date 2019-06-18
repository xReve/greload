#! /bin/bash
# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
# Install servidor DNS
# -------------------------------------

cp /opt/docker/named.conf /etc/named.conf

cp /opt/docker/edt.org.zone.db /var/named/edt.org.zone.db
cp /opt/docker/edt.org.rev.zone.db /var/named/edt.org.rev.zone.db
