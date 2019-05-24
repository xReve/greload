#! /bin/bash
# SCRIPT D'ESBORRAT DEL HOME DEL USUARI
# Eric Escriba
# M14 PROJECTE

CON='ldap.edt.org'
fileUsers=$1
esborrats=0
fails=0

while read -r user
do
  home=$(ldapsearch -x -LLL -h $CON -b 'dc=edt,dc=org'  'uid='$user 'homeDirectory' \
	| grep 'homeDirectory' | cut -f2 -d':' | cut -f2 -d ' ')
  
  rm -r "$home" &> /dev/null
  if [ $? -eq 0 ]
  then
    echo "$home esborrat correctament"
    esborrats=$((esborrats+1))
  else
    echo "L'esborrat de $home ha fallat"
    fails=$((fails+1))
  fi

done < $fileUsers

echo "TOTAL"
echo "Esborrats: $esborrats"
echo "Failed: $fails"
exit 0
