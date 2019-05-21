#! /bin/bash
# Script automatizat per l'esborrat de grups (entrada a la DB i el seu directori)

# Creació LDIF
python baixa_grups.py Grups_to_delete.txt

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


# Esborrat Grups

ldapdelete -x -w secret -h ldap.edt.org -D "cn=Manager,dc=edt,dc=org" -f grup_delete.ldif

# Esborrat directori grup

bash delete_home.sh Grups_to_delete.txt


