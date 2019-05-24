#! /bin/bash
# SCRIPT D'ESBORRAT DEL PRINCIPAL DE KERBEROS PER CADA USUARI
# Eric Escriba
# M14 PROJECTE

fileUsers=$1
esborrats=0
fails=0


while read -r user
do
  echo "yes" | kadmin -p operador -w operador -q "delete_principal $user" &> /dev/null
  kadmin -p operador -w operador "listprincs" | grep "$user" &> /dev/null
  if [ $? -eq 0 ]
  then
      echo "ERROR: No s'ha pogut esborrar el principal $user"
      fails=$((fails+1))
  else
      echo "$user ha estat esborrat correctament" 
      esborrats=$((esborrats+1))
  fi
done < $fileUsers

echo "TOTAL"
echo "Esborrats: $esborrats"
echo "Failed: $fails"
exit 0
