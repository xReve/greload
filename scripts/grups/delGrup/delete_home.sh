#! /bin/bash
# SCRIPT PER ESBORRAR EL DIRECTORI DEL GRUP ESBORRAT DEL VOLUME
# Eric Escriba
# M14 PROJECTE

fileGrups=$1 # Fitxer amb els noms de grup acceptats
esborrats=0
fails=0

while read -r grup
do
  rm -rf /home/grups/$grup &> /dev/null

  if [ $? -eq 0 ]
  then
      echo "$grup esborrat correctament"
      esborrats=$((esborrats+1))
  else
      echo "$grup no s'ha pogut esborrar"
      fails=$((fails+1))
  fi
done < $fileGrups

echo "TOTAL:"
echo "Succeed: $esborrats"
echo "Fail: $fails"

exit 0
