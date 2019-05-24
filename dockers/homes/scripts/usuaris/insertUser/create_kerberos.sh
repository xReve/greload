#! /bin/bash
# SCRIPT DE CREACIÓ DELS PRINCIPALS DE KERBEROS PER CADA USUARI ACCEPTAT
# Eric Escriba
# M14 PROJECTE

fileUsers=$1 # Fitxer amb els users i homes valids 
creats=0
fails=0


while read -r line
do
  user=$(echo "$line" | cut -f1 -d ':')
  kadmin -p operador -w operador -q "addprinc -pw  $user $user" &> /dev/null
  kadmin -p operador -w operador "listprincs" | grep "$user" &> /dev/null 
  if [ $? -eq 0 ]
  then
      echo "$user creat correctament"
      creats=$((creats+1))
  else
      echo "ERROR: No s'ha pogut crear el principal per l'usuari $user" 
      fails=$((fails+1))
  fi
done < $fileUsers


echo "TOTAL:"
echo "Succeed: $creats"
echo "Fail: $fails"
exit 0
