#! /usr/bin/python
# -*- coding: utf-8 -*-

import sys 

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

def delete_user_entry(user,grup):
	'''
	Funció que crea el format ldif per borrar un usuari d'un grup
	Entrada: String(usuari), string(grup)
	Sortida: String format ldif
	'''
	
	line = 'dn: cn=%s,ou=grups,dc=edt,dc=org\n' \
			'changetype: modify\n' \
			'delete: memberUidn\n' \
			'memberUid: %s\n' % (grup,user)
	
	return line


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
	
	user = user.strip()
	# Fitxer ldif delete usuaris
	
	user_line = delete_user(user)
	group_line = delete_user_entry(user,'GROUP')
	
	sortida_user.write(user_line)
	sortida_grup.write(group_line)

	
# Tancament	
#err.close()
entrada.close()
sortida_user.close()
sortida_grup.close()





