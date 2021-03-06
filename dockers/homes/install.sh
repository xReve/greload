#! /bin/bash
# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
# INSTALL DOCKER HOMES
# -----------------------------------------------------------

mkdir /opt/docker/usuaris/insertUser/error_log
mkdir /opt/docker/usuaris/delUser/error_log
mkdir /opt/docker/grups/insertGrup/error_log
mkdir /opt/docker/grups/delGrup/error_log


cp /opt/docker/nslcd.conf /etc/nslcd.conf
cp /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp /opt/docker/nsswitch.conf /etc/nsswitch.conf

/usr/sbin/nslcd && echo "nslcd Ok"
/usr/sbin/nscd && echo "nscd Ok"

cp /opt/docker/krb5.conf /etc/krb5.conf
cp /opt/resolv.conf /etc/resolv.conf
#--------------------------------

mkdir /home/grups
mkdir /home/grups/hisx1
mkdir /home/grups/hisx2
mkdir /home/grups/wiam1
mkdir /home/grups/wiam2
mkdir /home/grups/wiaw1
mkdir /home/grups/wiaw2
mkdir /home/grups/profes
mkdir /home/grups/test
mkdir /home/grups/admin
mkdir /home/grups/test/pere
mkdir /home/grups/test/pau
mkdir /home/grups/test/anna
mkdir /home/grups/test/marta
mkdir /home/grups/admin/operador

cp welcome.md /home/grups/test/pere
cp welcome.md /home/grups/test/pau
cp welcome.md /home/grups/test/anna
cp welcome.md /home/grups/test/marta
cp welcome.md /home/grups/admin/operador

chown -R pere.test /home/grups/test/pere
chown -R pau.test /home/grups/test/pau
chown -R anna.test /home/grups/test/anna
chown -R marta.test /home/grups/test/marta
chown -R operador.admin /home/grups/admin/operador



echo "172.30.0.4 ldap.edt.org" >> /etc/hosts
echo "172.30.0.5 kserver.edt.org" >> /etc/hosts
echo "172.30.0.7 samba.edt.org" >> /etc/hosts


