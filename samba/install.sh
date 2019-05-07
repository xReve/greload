#! /bin/bash
# @edt ASIX M06 2018-2019
# instal.lacio
#  - crear usuaris locals
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


# users nomes de samba 
useradd patipla
useradd lila
useradd roc
useradd pla

echo -e "patipla\npatipla" | smbpasswd -a patipla
echo -e "lila\nlila" | smbpasswd -a lila
echo -e "roc\nroc" | smbpasswd -a roc
echo -e "pla\npla" | smbpasswd -a pla


# users ldap 

echo -e "pere\npere" | smbpasswd -a pere
echo -e "pau\npau" | smbpasswd -a pau
echo -e "anna\nanna" | smbpasswd -a anna
echo -e "marta\nmarta" | smbpasswd -a marta
echo -e "admin\nadmin" | smbpasswd -a admin







