#! /usr/bin/python
# -*- coding: utf-8 -*-
# Eric Escriba
# M14 PROJECTE

import sys

# Funcions

def delete_sambaUser(user):
	'''
	Funció que donat un usuari et retorna l'estructura per esborrar
	aquest usuari de la DB de samba.
	Entrada: string (usuari)
	Sortida: string (format per esborrar usuaris de samba)
	'''
	
	line = "smbpasswd -x %s\n" % (user)
	
	return line 

# Declarem
fileIn = sys.argv[1] # Fitxer d'usuaris
fileOut = 'usuaris_samba.sh' # Fitxer sortida preparat per esborrar usuaris de samba

# Obrim fitxers
entrada = open(fileIn,"r")
sortida_user = open(fileOut,"a")

# Afegim el shebang
sortida_user.write('#! /bin/bash\n')

# Treballem
for user in entrada:
	user = user.strip()
	# Creem la linia
	sortida = delete_sambaUser(user)
	
	# Grabem la linia
	sortida_user.write(sortida)

# Tancament files
entrada.close()
sortida_user.close()

exit(0)
