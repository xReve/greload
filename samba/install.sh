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


# se han de crear els homes perque aixi es pot montar 


mkdir /home/edt
mkdir /home/edt/pere
mkdir /home/edt/pau
mkdir /home/edt/anna
mkdir /home/edt/marta
mkdir /home/edt/admin

cp welcome.md /home/edt/pere
cp welcome.md /home/edt/pau
cp welcome.md /home/edt/anna
cp welcome.md /home/edt/marta
cp welcome.md /home/edt/admin

chown -R pere.especial /home/edt/pere
chown -R pau.especial /home/edt/pau
chown -R anna.especial /home/edt/anna
chown -R marta.especial /home/edt/marta
chown -R admin.admin /home/edt/admin


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
echo -e "jordi\njordi" | smbpasswd -a jordi
echo -e "admin\nadmin" | smbpasswd -a admin







