#! /bin/bash
# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
# Instal·lacio SERVIDOR SAMBA
# -------------------------------------

mkdir /var/lib/samba/homes
chmod 777 /var/lib/samba/homes
cp /opt/docker/* /var/lib/samba/homes/.
cp /opt/docker/smb.conf /etc/samba/smb.conf


cp /opt/docker/nslcd.conf /etc/nslcd.conf
cp /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp /opt/docker/nsswitch.conf /etc/nsswitch.conf


# engegar el dimoni perque funcioni el getent
/usr/sbin/nslcd && echo "nslcd Ok"
/usr/sbin/nscd && echo "nscd Ok"

# SSH
/usr/bin/ssh-keygen -A

# Passwd root

echo "jupiter" | passwd --stdin root

# users ldap 

echo -e "pere\npere" | smbpasswd -a pere
echo -e "pau\npau" | smbpasswd -a pau
echo -e "anna\nanna" | smbpasswd -a anna
echo -e "marta\nmarta" | smbpasswd -a marta
echo -e "operador\noperador" | smbpasswd -a operador







