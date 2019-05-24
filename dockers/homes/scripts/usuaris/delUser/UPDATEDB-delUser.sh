#! /bin/bash
# SCRIPT COMPLERT DE L'ESBORRAT DE COMPTES D'USUARI
# RECOPILA TOTS ELS SCRIPTS EN UN SOL SCRIPT QUE HO FA TOT
# Eric Escriba
# M14 PROJECTE

# Creació fitxers ldif
python delete_entries.py delete_users.txt

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
echo "ARA S'ESBORRARAN ELS HOMES DELS USUARIS"
sleep 5

# Esborrar homes dels usuaris

bash delete_home.sh usuaris_acceptats.txt

echo ""
echo "ARA S'ESBORRARAN ELS USUARIS A LA DB de LDAP"
sleep 5

# Esborrar usuaris de LDAP

ldapdelete -x -w operador -h ldap.edt.org -D "uid=operador,ou=usuaris,dc=edt,dc=org" -f usuaris_delete.ldif 

echo ""
echo "ARA S'ESBORRARAN ELS USUARIS DELS SEUS GRUPS CORRESPONENTS"
sleep 5

# Esborrar usuaris del grup

ldapmodify -x -w operador -h ldap.edt.org -D "uid=operador,ou=usuaris,dc=edt,dc=org" -f usuaris_group_del.ldif

echo ""
echo "ATENCIO"
echo "Ara es borraran els principals de kerberos"
sleep 5

# Esborrar usuaris de kerberos

bash delete_kerberos.sh usuaris_acceptats.txt

# Esborrar usuaris de samba

python delete_samba.py usuaris_acceptats.txt

chmod +x usuaris_samba.sh

scp usuaris_samba.sh root@samba.edt.org:/tmp

ssh root@samba.edt.org "bash /tmp/usuaris_samba.sh"

echo ""
echo "SCRIPT D'ESBORRAT D'USUARIS FINALITZAT"
exit 0 

