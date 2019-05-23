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

echo ""
echo "ARA S'INJECTARAN ELS USUARIS A LA DB de LDAP"
sleep 5

# Inserció usuaris

ldapadd -x -w operador -h ldap.edt.org -D "uid=operador,ou=usuaris,dc=edt,dc=org" -f usuaris_alta.ldif


echo ""
echo "ARA S'AFEGIRAN ELS USUARIS ALS SEUS GRUPS CORRESPONENTS"
sleep 5

# Afegir usuaris al grup

ldapadd -x -w operador -h ldap.edt.org -D "uid=operador,ou=usuaris,dc=edt,dc=org" -f usuaris_append_grup.ldif

echo ""
echo "ATENCIO"
echo "Ara es crearan els principals de kerberos"
sleep 5

# Inserció kerberos

bash create_kerberos.sh userhomes.txt

echo ""
echo "CONNEXIO AMB SAMBA"
echo "Injecció d'usuaris Samba"
echo ""

# Insercio samba

python create_samba.py userhomes.txt

chmod +x usuaris_samba.sh

scp usuaris_samba.sh root@samba.edt.org:/tmp

ssh root@samba.edt.org "bash /tmp/usuaris_samba.sh"

echo ""
echo "CREACIO HOMES DEL USUARIS"
sleep 5

# Creació home

bash create_homes.sh userhomes.txt

echo ""
echo "SCRIPT D'INJECCIÓ D'USUARIS FINALITZAT"
exit 0 

