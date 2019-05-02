#! /usr/bin/python
# -*- coding: utf-8 -*-

import sys 
import subprocess 
import os
# Funcions

def delete_user(user):
	'''
	Funció que et crea el format ldif per borrar la entrada.
	Entrada: String (usuari)
	Sortida: String format ldif
	'''
	# Creem la linia usuari
	line = 'uid=%s,ou=usuaris,dc=edt,dc=org\n\n' % (user)
	
	return line

def delete_user_entry(user):
	'''
	Funció que crea el format ldif per borrar un usuari d'un grup
	Entrada: String(usuari)
	Sortida: String format ldif
	'''

# https://itsecureadmin.com/2010/02/removing-memberuid-from-openldap-group/



# Declarem
fileIn = sys.argv[1] # Usuaris
fileOut_1 = 'usuaris_delete.ldif' # Fitxer ldif amb usuaris a borrar
fileOut_2 = 'usuaris_group_del.ldif' # Fitxer ldif borrar usuari del grup

# Obrim fitxers
entrada = open(fileIn,"rw")
sortida_user = open(fileOut_1,"a")
sortida_grup = open(fileOut_2, "a")
# err = open(error_log,"a")

# Treballem
for user in entrada:
	
	# Fitxer ldif delete usuaris
	#print user.strip()
	
	line = delete_user(user.strip())
	
	sortida_user.write(line)


	
# Tancament	
#err.close()
entrada.close()
sortida_user.close()
sortida_grup.close()





