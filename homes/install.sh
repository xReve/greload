#! /bin/bash
# 2018-2019
# HOMES
# -----------------------------------------------------------

cp /opt/docker/nslcd.conf /etc/nslcd.conf
cp /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp /opt/docker/nsswitch.conf /etc/nsswitch.conf

/usr/sbin/nslcd && echo "nslcd Ok"
/usr/sbin/nscd && echo "nscd Ok"


mkdir /home/grups
mkdir /home/grups/hisx1
mkdir /home/grups/hisx2
mkdir /home/grups/wiam1
mkdir /home/grups/wiam2
mkdir /home/grups/wiaw1
mkdir /home/grups/wiaw2
mkdir /home/grups/especial
mkdir /home/grups/admin
mkdir /home/grups/especial/pere
mkdir /home/grups/especial/pau
mkdir /home/grups/especial/anna
mkdir /home/grups/especial/marta
mkdir /home/grups/admin/admin

cp welcome.md /home/grups/especial/pere
cp welcome.md /home/grups/especial/pau
cp welcome.md /home/grups/especial/anna
cp welcome.md /home/grups/especial/marta
cp welcome.md /home/grups/especial/admin

chown -R pere.especial /home/grups/especial/pere
chown -R pau.especial /home/grups/especial/pau
chown -R anna.especial /home/grups/especial/anna
chown -R marta.especial /home/grups/especial/marta
chown -R admin.admin /home/grups/especial/admin

# -----------------------------------------------------------

cp /opt/docker/nslcd.conf /etc/nslcd.conf
cp /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp /opt/docker/nsswitch.conf /etc/nsswitch.conf




