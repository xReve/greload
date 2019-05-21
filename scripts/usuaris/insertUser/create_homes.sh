#! /bin/bash
# Script per crear el home de l'usuari

fileUsers=$1 # Fitxer amb els homes dels usuaris que s'han processat en el script alta_users i que s'han de crear 
creats=0
fails=0

while read -r line
do
  user=$(echo "$line" | cut -f1 -d ':')
  home=$(echo "$line" | cut -f2 -d ':')
  grup=$(echo "$line" | tr -s ':' '/' | cut -f4 -d '/')

  mkdir "$home" &> /dev/null 

  if [ $? -eq 0 ]
  then
      cp welcome.md "$home"
      chown -R "$user.$grup" "$home"
      echo "$home creat correctament"
      creats=$((creats+1))
  else
      echo "$home no s'ha pogut crear; Revisa el contingut"
      fails=$((fails+1))
  fi

done < $fileUsers
