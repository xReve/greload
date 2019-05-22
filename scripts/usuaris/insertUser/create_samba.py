#! /usr/bin/python
# -*- coding: utf-8 -*-

import sys

# Funcions

def insert_sambaUser(user,passwd):
	'''
	Funció que donat un usuari i un passwd prepara l'estructura per afegeir-lo com a 
	usuari samba
	Entrada: string (usuari), string (password) 
	Sortida: String
	'''
	line = 'echo -e "%s\\n%s" | smbpasswd -a %s\n' % (passwd,passwd,user)
	
	return line


# Declarem
fileIn = sys.argv[1] # Usuaris
fileOut = 'usuaris_samba.sh' # Fitxer sortida preparat per introduir users a samba

# Obrim fitxers
entrada = open(fileIn,"r")
sortida_user = open(fileOut,"a")

# Afegim el shebang

sortida_user.write('#! /bin/bash\n')


# Treballem
for line in entrada:
	
	llista_camps = line.split(':')
	user = llista_camps[0]
	
	# Creem la linia
	sortida = insert_sambaUser(user,user)
	
	# Grabem la linia
	sortida_user.write(sortida)



# Tancament files
entrada.close()
sortida_user.close()



