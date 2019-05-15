#! /bin/bash
# Script per crear el home de l'usuari

fileUsers=$1 # Fitxer amb el format del /etc/passwd que conte els usuaris que se li han de crear el home 
creats=0
fails=0

while read -r line
do
  user=$(echo "$line" | cut -f1 -d ':')
  
  



done < $fileUsers


