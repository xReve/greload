#! /usr/bin/python
# -*- coding: utf-8 -*-

import sys 
import subprocess 

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
			'memberUid: %s\n\n' % (grup,user)
	
	return line

# CONSTANTS
CON = 'ldap.edt.org'

# Declarem
fileIn = sys.argv[1] # Usuaris
fileOut_1 = 'usuaris_delete.ldif' # Fitxer ldif amb usuaris a borrar
fileOut_2 = 'usuaris_group_del.ldif' # Fitxer ldif borrar usuari del grup
error_log = "error_log/usuarisDel_error.log" # Fitxer errors

# Obrim fitxers
entrada = open(fileIn,"rw")
sortida_user = open(fileOut_1,"a")
sortida_grup = open(fileOut_2, "a")
err = open(error_log,"a")

# Contadors
lectura = 0
accept = 0
denied = 0

# Treballem
for user in entrada:
	lectura += 1 
	user = user.strip()
	
	try:
		# Comprovar que l'usuari existeix a la BDD.
		check = "ldapsearch -x -LLL -h %s -b 'dc=edt,dc=org' 'uid=%s' 'dn'" % (CON,user)
		pipeData = subprocess.check_output([check],stderr=subprocess.STDOUT,shell=True)
		user_id = pipeData.strip()
		
		# Si l'usuari existeix 
		if user_id != '':	
			#Cerca dels grups en els que es troba l'usuari 
			search = "ldapsearch -x -LLL -h %s -b 'dc=edt,dc=org' 'memberUid=%s' 'dn'" \
			" | cut -f1 -d ',' | cut -f2 -d ' ' | cut -f2 -d '=' " % (CON,user)
			pipeData = subprocess.check_output([search],stderr=subprocess.STDOUT,shell=True)
			sortida = pipeData.split('\n')
			
			# Processem els grups resultants 
			for grup in sortida:
				if grup != '':
					# Fitxer ldif delete usuaris del grup
					group_line = delete_user_entry(user,grup)
					
			# Fitxer ldif delete usuaris
			user_line = delete_user(user)
			
			# Grabem	
			sortida_user.write(user_line)
			sortida_grup.write(group_line)			
			accept += 1
		# Si no enviem missatge error
		else:
			err.write("L'usuari %s no existeix a LDAP\n" % (user)) 
			denied += 1
	except subprocess.CalledProcessError:
		sys.stderr.write('Bad connexion with LDAP\n')
		exit(1)

	
# Tancament	
err.close()
entrada.close()
sortida_user.close()
sortida_grup.close()

print 'Total processats:'
print 'Acceptats: %s (Consultar usuaris_delete.ldif)' % accept
print 'Denegats: %s (Consultar usuarisDel_error.log)' % denied

exit(0)



