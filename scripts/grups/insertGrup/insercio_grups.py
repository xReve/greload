#! /usr/bin/python
# -*- coding: utf-8 -*-

import sys 

# Funcions

def group_ldif(gname,gid,user_list):
	'''
	Funció que crea un format ldif per afegir grups a la BBDD
	Entrada: 2 strings (gname i gid)
	Sortida: String format ldif
	'''
	line = 'dn: cn=%s,ou=grups,dc=edt,dc=org \n' \
	'cn: %s\n' \
	'gidNumber: %s\n' \
	'description: Grup de %s\n' \
	'objectclass: posixGroup\n' % (gname,gname,gid,gname)
	
	# Comprovació llista usuaris
	if user_list != '\n':
		# En cas que si els afegim conjuntament amb el grup
		users = user_list.split(',')
		for user in users:
			line += 'memberUid: %s\n' % (user)
	else:
		line += '\n'
		
	return line

# Declarem
fileIn = sys.argv[1] # Grups
fileOut = 'grups_alta.ldif' # Fitxer ldif sortida
error_log = "error_log/grups_error.log" # Fitxer errors

# Obrim fitxers
entrada = open(fileIn,"rw")
sortida = open(fileOut,"a")
err = open(error_log,"a")

# Contadors
lectura = 0
accept = 0
denied = 0

# Llegim grup per grup
for linia in entrada:
	lectura += 1
	try:
	# Separem camps
		llista_camps = linia.split(':')
		gname = llista_camps[0]
		gid = llista_camps[2]
		user_list = llista_camps[3]
		
		try:
			# Creem fitxer ldif
			entrada_grup = group_ldif(gname,gid,user_list)
		
			# Guardem fitxer ldif
			sortida.write(entrada_grup)
			accept +=1
		except:
			err.write('Error en la escriptura: LINIA %s' % (lectura))
			denied += 1
	except:
		err.write('Linia de grup incorrecta: LINIA %s' % (lectura))
		denied += 1

# Tancament	
err.close()
entrada.close()
sortida.close()

print 'Total processats:'
print 'Acceptats: %s (Consultar grups_alta.ldif)' % accept
print 'Denegats: %s (Consultar grups_error.log)' % denied

exit(0)


	
