#! /usr/bin/python
# -*- coding: utf-8 -*-

import sys 
import subprocess 
import os

# Funcions
def delete_grup(user):
	'''
	Funció que et crea el format ldif per borrar la entrada.
	Entrada: String (usuari)
	Sortida: String format ldif
	'''
	# Creem la linia usuari
	line = 'cn=%s,ou=grups,dc=edt,dc=org\n\n' % (user)
	
	return line



# Declarem
fileIn = sys.argv[1] # Grups
fileOut = 'grup_delete.ldif' # Fitxer ldif amb grups a borrar
error_log = 'errors/grupDelErr.txt' # Fitxer errors esborrat grups

# Obrim fitxers
entrada = open(fileIn,"rw")
sortida_grup = open(fileOut,"a")
err = open(error_log,"a")

# Contadors
lectura = 0
accept = 0
denied = 0

# Treballem
for grup in entrada:
	lectura += 1 
	try:
	# Comprovar si te usuaris 
		grup = grup.strip()
		search = "ldapsearch -h ldap.edt.org -x -LLL -b 'ou=grups,dc=edt,dc=org' 'cn=%s' | grep memberUid" % grup
		pipeData = subprocess.Popen([search],stdout=subprocess.PIPE,shell=True)
		usuari = ''
		
		for line in pipeData.stdout:
			usuari = line
		
		# Si en te, no crear entrada ldif
		if usuari != '':
			err.write("El grup %s conte usuaris. Siusplau, esborri els usuaris del grup per poder esborra'l \n" % (grup) ) 
			denied += 1
		# Sino, creem la entrada i la guardem
		else:
			linia = delete_grup(grup)
			sortida_grup.write(linia)
			accept +=1
	except:
		sys.stderr.write('Bad connexion with LDAP')
		exit(1)

# Tancament	
err.close()
entrada.close()
sortida_grup.close()

print 'Total processats:'
print 'Acceptats: %s (Consultar grup_delete.ldif)' % accept
print 'Denegats: %s (Consultar grupDel_error.log)' % denied

exit(0)


