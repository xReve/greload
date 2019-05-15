#! /bin/bash
# Script per crear el directori del grup al VOLUME de homes

fileGrups=$1
creats=0
fails=0

while read -r line
do
  gname=$(echo "$line" | cut -f1 -d ':')
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


