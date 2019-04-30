#! /usr/bin/python
# -*- coding: utf-8 -*-

import sys
import subprocess 
import os


# Declarem
fileIn = sys.argv[1] # Usuaris
fileOut = 'alta.ldif' # Fitxer ldf sortida
fileOutmod = 'modi.ldif' # Fitxer modificació grup
error_log = "error.log" # Fitxer errors

# Obrim fitxers
entrada = open(fileIn,"rw")
sortida = open(fileOut,"a")
err = open(error_log,"a")

# Contadors
lectura = 0
accept = 0
denied = 0

# Treballem
for linia in entrada:
	lectura += 1
	# Distingim els camps de cada usuari
	try:
		llista_camps = linia.split(':')
		login = llista_camps[0]
		uid = llista_camps[2]
		gid = llista_camps[3]
		home = llista_camps[5]
		# Obtenció del grup
		search = "ldapsearch -x -LLL -b 'ou=grups,dc=edt,dc=org' -h 172.21.0.2 gidNumber=%s dn | cut -f1 -d ',' | cut -f2 -d ' ' | cut -f2 -d '=' " % (gid)
		pipeData = subprocess.Popen([search],stdout=subprocess.PIPE,shell=True)
		count = 1
		grup = ''
		# Llegir el grup
		for line in pipeData.stdout:
			if count == 1:
				grup = line 
				count += 1
	
		# Si l'usuari no téun grup a la BBDD no es pot afegir
		if grup == '':
			err.write('User %s no te un grup existent a la BBDD. Crei el grup i despres afegeix lusuari \n ' % login)
			denied += 1
		else:
		# Edició fitxer ldif per cada usuari
			line1 = 'dn: uid=%s, ou=usuaris,dc=edt,dc=org \n' \
			'objectclass: posixAccount \n' \
			'objectclass: inetOrgPerson \n' \
			'ou : %s' \
			'cn: %s \n' \
			'uid: %s \n' \
			'uidNumber: %s \n' \
			'gidNumber: %s \n' \
			'homeDirectory: %s \n \n' % (login,grup,login,login,uid,gid,home)
			
			# Guardem al fitxer ldif
			sortida.write(line1)
			accept += 1
	except:
		err.write('Linia dusuari incorrecta, revisi la linia %s' % (lectura))
		denied += 1
# Tancament	
err.close()
entrada.close()
sortida.close()

print 'Total processats:'
print 'Acceptats: %s (Consultar alta.ldif)' % accept
print 'Denegats: %s (Consultar error.log)' % denied


