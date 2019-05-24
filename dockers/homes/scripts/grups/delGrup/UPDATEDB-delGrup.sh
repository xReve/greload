#! /bin/bash
# SCRIPT COMPLERT DE L'ESBORRAT DE GRUPS
# RECOPILA TOTS ELS SCRIPTS EN UN SOL SCRIPT QUE HO FA TOT
# Eric Escriba
# M14 PROJECTE

# Creació LDIF
python baixa_grups.py delete_groups.txt

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
echo "Ara s'esborraran el grups seleccionats anteriorment"
sleep 5

# Esborrat Grups

ldapdelete -x -w operador -h ldap.edt.org -D "uid=operador,ou=usuaris,dc=edt,dc=org" -f grup_delete.ldif

echo ""
echo "Ara s'esborraran els directoris dels grups esborrats"
sleep 5

# Esborrat directori grup

bash delete_home.sh grups_acceptats.txt


echo ""
echo "SCRIPT D'ESBORRAT DE GRUPS FINALITZAT"
exit 0

