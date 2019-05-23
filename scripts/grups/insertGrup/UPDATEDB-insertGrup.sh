#! /bin/bash

# Creació LDIF
python insercio_grups.py insert_groups.txt

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

echo ""
echo "ATENCIO"
echo "Ara s'afegiran els grups a la DB de LDAP"
sleep 5 

# Injecció grups

ldapadd -x -w operador -h ldap.edt.org -D "uid=operador,ou=usuaris,dc=edt,dc=org" -f grups_alta.ldif

echo ""
echo "Ara es crearan els directoris dels nous grups"
sleep 5

# Creació directori del grup

bash create_homes.sh grups_acceptats.txt


echo ""
echo "SCRIPT D'INJECCIO DE GRUPS FINALITZAT"
exit 0
