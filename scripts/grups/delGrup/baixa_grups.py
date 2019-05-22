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
error_log = 'error_log/grupDelErr.txt' # Fitxer errors esborrat grups

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
	# Comprovar si te usuaris 
	grup = grup.strip()
	try:
		search = "ldapsearch -h ldap.edt.org -x -LLL -b 'ou=grups,dc=edt,dc=org' '(&(cn=%s)(memberUid=*))'" % (grup)
		pipeData = subprocess.check_output([search],stderr=subprocess.STDOUT,shell=True)
		p_output = pipeData.strip()
		# La connexio ha funcionat, per tant s'ha obtingut un valor
		usuari = p_output

		# Si en te, no crear entrada ldif
		if usuari != '':
			err.write("El grup %s conte usuaris. Siusplau, esborri els usuaris del grup per poder esborra'l \n" % (grup) ) 
			denied += 1
		# Sino, creem la entrada i la guardem
		else:
			linia = delete_grup(grup)
			sortida_grup.write(linia)
			accept +=1
	# S'ha produit un error en la connexio
	except subprocess.CalledProcessError:
		sys.stderr.write('Bad connexion with LDAP\n')
		exit(1)
		
# Tancament	
err.close()
entrada.close()
sortida_grup.close()

print 'Total processats:'
print 'Acceptats: %s (Consultar grup_delete.ldif)' % accept
print 'Denegats: %s (Consultar grupDel_error.log)' % denied

exit(0)


