#! /usr/bin/python
# -*- coding: utf-8 -*-

import sys 


# Declarem
fileIn = sys.argv[1] # Grups
fileOut = 'grups_alta.ldif' # Fitxer ldif sortida

# Obrim fitxers
entrada = open(fileIn,"rw")
sortida = open(fileOut,"a")
# err = open(error_log,"a")

# Llegim grup per grup
for linia in entrada:
	
	# Separem camps
	llista_camps = linia.split(':')
	gname = llista_camps[0]
	gid = llista_camps[2]
	user_list = llista_camps[3]
	print llista_camps
	# Creem fitxer ldif
	line1 = 'dn: cn=%s,ou=grups,dc=edt,dc=org \n' \
	'cn: %s\n' \
	'gidNumber: %s\n' \
	'description: Grup de %s\n' \
	'objectclass: posixGroup\n' % (gname,gname,gid,gname)
	
	# Comprovem si té usuaris que tenen el grup com a secundari
	
	if user_list != '\n':
		# En cas que si els afegim conjuntament amb el grup
		users = user_list.split(',')
		for user in user_list:
			line1 += 'memberUid: %s\n' % (user)
	else:
		line1 += '\n'
	# Guardem fitxer ldif
	sortida.write(line1)
	

# Tancament	
#err.close()
entrada.close()
sortida.close()

	
	
