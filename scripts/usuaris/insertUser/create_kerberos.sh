#! /bin/bash
# Script per crear el principal de kerberos per cada nou usuari introduit a LDAP 

fileUsers=$1 # 	Fitxer del format /etc/passwd 
creats=0
fails=0


while read -r line
do
  user=$(echo "$line" | cut -f1 -d ':')
  kadmin -p admin -w admin -q "addprinc -pw  $user $user" &> /dev/null

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

