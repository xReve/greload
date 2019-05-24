#! /bin/bash

CON='ldap.edt.org'
fileUsers=$1
esborrats=0
fails=0

while read -r user
do
  home=$(ldapsearch -x -LLL -h $CON -b 'dc=edt,dc=org'  'uid='$user 'homeDirectory' | grep 'homeDirectory' | cut -f2 -d':' | cut -f2 -d ' ')
  
  rm -rf "$home" &> /dev/null
  if [ $? -eq 0 ]
  then

  else

  fi

done < $fileUsers

echo "TOTAL"
echo "Esborrats: $esborrats"
echo "Failed: $fails"


