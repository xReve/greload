#! /bin/bash
# @edt ASIX M06 2018-2019
# instal.lacio slapd edt.org
# -------------------------------------

cp /opt/docker/named.conf /etc/named.conf

cp /opt/docker/edt.org.zone.db /var/named/edt.org.zone.db
cp /opt/docker/edt.org.rev.zone.db /var/named/edt.org.rev.zone.db
