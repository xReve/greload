#! /bin/bash
# Eric Escriba
# M14 PROJECTE
# Script de neteja dels fitxers creats durant l'esborrat d'usuaris

rm -rf *.ldif error_log/* usuaris_acceptats.txt usuaris_samba.sh &> /dev/null

exit 0 
