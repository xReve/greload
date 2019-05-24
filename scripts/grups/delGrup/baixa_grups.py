#! /usr/bin/python
# -*- coding: utf-8 -*-
# Eric Escriba
# M14 PROJECTE

import sys 
import subprocess 

# Funcions
def delete_grup(group):
	'''
	Funció que et crea el format ldif per borrar la entrada.
	Entrada: String (group)
	Sortida: String format ldif
	'''
	# Creem la linia usuari
	line = 'cn=%s,ou=grups,dc=edt,dc=org\n\n' % (group)
	
	return line

# CONSTANTS
CON = 'ldap.edt.org'

# Declarem
fileIn = sys.argv[1] # Grups
fileOut = 'grup_delete.ldif' # Fitxer ldif amb grups a borrar
fileGrups = 'grups_acceptats.txt' # Llista grups acceptats
error_log = 'error_log/grupDel_error.log' # Fitxer errors esborrat grups

# Obrim fitxers
entrada = open(fileIn,"rw")
sortida_grup = open(fileOut,"a")
grups_ok = open(fileGrups, "a")
err = open(error_log,"a")

# Contadors
lectura = 0
accept = 0
denied = 0

# Treballem
for grup in entrada:
	lectura += 1 
	grup = grup.strip()
	try:
		# Comprovar que el grup existeix a la BDD.
		check = "ldapsearch -x -LLL -h %s -b 'dc=edt,dc=org' 'cn=%s' 'dn'" % (CON,grup)
		pipeData = subprocess.check_output([check],stderr=subprocess.STDOUT,shell=True)
		group_id = pipeData.strip() 
		
		# Si el grup existeix
		if group_id != '':
			# Comprovar si el grup te usuaris
			search = "ldapsearch -h %s -x -LLL -b 'ou=grups,dc=edt,dc=org' '(&(cn=%s)(memberUid=*))' 'dn'" % (CON,grup)
			pipeData = subprocess.check_output([search],stderr=subprocess.STDOUT,shell=True)
			# La connexio ha funcionat, per tant s'ha obtingut un valor
			grup_output = pipeData.strip()

			# Si en te, no crear entrada ldif
			if grup_output != '':
				err.write("El grup %s conte usuaris. Siusplau, esborri els usuaris del grup per poder esborra'l \n" % (grup) ) 
				denied += 1
			# Sino, creem la entrada i la guardem
			else:
				linia = delete_grup(grup)
				sortida_grup.write(linia)
				grups_ok.write(grup + '\n')
				accept +=1
		# Si no existeix
		else:
			err.write('El grup %s no existeix a LDAP\n' % (grup))
			denied += 1 
	# S'ha produit un error en la connexio
	except subprocess.CalledProcessError:
		sys.stderr.write('Bad connexion with LDAP\n')
		exit(1)
		
# Tancament	
err.close()
entrada.close()
sortida_grup.close()
grups_ok.close()

print 'Total processats:'
print 'Acceptats: %s (Consultar grup_delete.ldif)' % accept
print 'Denegats: %s (Consultar grupDel_error.log)' % denied

exit(0)


