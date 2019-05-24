#! /bin/bash
# SCRIPT PER CREAR EL DIRECTORI DEL GRUP AL VOLUM COMPARTIT
# Eric Escriba
# M14 PROJECTE

fileGrups=$1 # Fitxer amb noms de grups acceptats per ser creats
creats=0
fails=0

while read -r gname
do
  mkdir /home/grups/"$gname" &> /dev/null
  
  if [ $? -eq 0 ]
  then
      echo "$gname creat correctament"
      creats=$((creats+1))
  else
      echo "$gname no s'ha pogut crear; Revisa el contingut"
      fails=$((fails+1))
  fi
done < $fileGrups

echo "TOTAL:"
echo "Succeed: $creats"
echo "Fail: $fails"
exit 0

