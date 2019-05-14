#! /bin/bash
# Script per esborrar el directori del grup del VOLUME de homes

fileGrups=$1
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
echo "Successed: $esborrats"
echo "Failed: $fails"



