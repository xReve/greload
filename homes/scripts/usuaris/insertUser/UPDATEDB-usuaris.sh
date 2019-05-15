#! /bin/bash

# Creació fitxers ldif
python alta_users.py insert_users.txt

# Checkpoint
echo "Vols continuar?"
echo "Yes/No" 
read opcio

while true
do
	if [ "$opcio" = 'Yes' -o "$opcio" = 'y' ]
	then
		break
	elif [ "$opcio" = 'No' -o "$opcio" = 'n' ]
	then
		exit 1
	else
		echo "Indiqui que vol fer: Continuar - Yes o Cancel·lar - No" 
		read opcio 
	fi
done

# Informació addicional

# Inserció usuaris

ldapadd -x -w secret -h ldap.edt.org -D "cn=Manager,dc=edt,dc=org" -f usuaris_alta.ldif

# Afegir usuaris al grup

ldapadd -x -w secret -h ldap.edt.org -D "cn=Manager,dc=edt,dc=org" -f usuaris_append_grup.ldif


# Inserció kerberos

bash create_kerberos.sh insert_users.txt

# Creació home

bash create_homes.sh userhomes.txt

