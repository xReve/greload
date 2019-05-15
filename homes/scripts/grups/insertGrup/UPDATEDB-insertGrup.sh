#! /bin/bash

# Creació LDIF
python insercio_grups.py Grups_to_insert.txt

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

# Injecció grups

ldapadd -x -w secret -h ldap.edt.org -D "cn=Manager,dc=edt,dc=org" -f grups_alta.ldif


# Creació directori del grup

bash create_homes.sh Grups_to_insert.txt

