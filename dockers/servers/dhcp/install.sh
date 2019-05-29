#! /bin/bash
# GANDHI RELOAD
# @edt ASIX M14-PROJECTE Curs 2018-2019
# Èric Escribà
############################################


cp /opt/docker/dhcpd.conf /etc/dhcp/dhcpd.conf

echo "DHCPDARGS='eth0'" >> /etc/sysconfig/network-scripts/ifcfg-eth0
