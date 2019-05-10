#! /usr/bin/python
# -*- coding: utf-8 -*-

import sys
import subprocess 
import os

# Funcions
#Insert ldif

def insert_ldif(login,grup,uid,gid,shell,home):
	'''
	Funció que reb dades d'usuari, les processa, i retorna les dades en format ldif
	Entrada: 6 strings (Dades usuari login,grup,uid,gid,shell,home)
	Sortida: String format ldif
	'''
	line = 'dn: uid=%s,ou=usuaris,dc=edt,dc=org\n' \
				'objectclass: posixAccount\n' \
				'objectclass: inetOrgPerson\n' \
				'cn: %s\n' \
				'sn: %s\n' \
				'ou: %s\n' \
				'uid: %s\n' \
				'uidNumber: %s\n' \
				'gidNumber: %s\n' \
				'loginShell: %s' \
				'homeDirectory: %s\n\n' % (login,login,login,grup,login,uid,gid,shell,home)
	
	return line

# Modify ldif

def modify_ldif(grup,user):
	'''
	Funció que crea un format ldif per afegir un usuari en un grup
	Entrada: 2 strings (grup i usuari)
	Sortida: String format ldif
	'''
	line = 'dn: cn=%s,ou=grups,dc=edt,dc=org\n' \
	'changetype: modify\n' \
	'add: memberUid\n' \
	'memberUid: %s\n\n' % (grup,user)
	
	
	return line

# Declarem
fileIn = sys.argv[1] # Usuaris
fileOut = 'usuaris_alta.ldif' # Fitxer ldif sortida
fileOutmod = 'usuaris_append_grup.ldif' # Fitxer modificació grup
error_log = "usuaris_error.log" # Fitxer errors

# Obrim fitxers
entrada = open(fileIn,"r")
sortida_user = open(fileOut,"a")
sortida_grup = open(fileOutmod, "a")
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
		shell = llista_camps[6]
		# Obtenció del grup
		# Connexió LDAP
		try:
			search = "ldapsearch -x -LLL -b 'ou=grups,dc=edt,dc=org' -h ldap.edt.org " \
			"gidNumber=%s dn | cut -f1 -d ',' | cut -f2 -d ' ' | cut -f2 -d '=' " % (gid)
			pipeData = subprocess.Popen([search],stdout=subprocess.PIPE,shell=True)
			count = 1
			grup = ''
			# Llegir el grup
			for line in pipeData.stdout:
				if count == 1:
					grup = line.strip()
					count += 1
			
			# Si l'usuari no té un grup a la BBDD no es pot afegir
			if grup == '':
				err.write('User %s no te un grup existent a la BBDD. Crei el grup i despres afegeix lusuari \n ' % login)
				denied += 1
			else:
				# Comprovem que pertany al grup d'alumnes 
				# Creem el tag del grup de l'usuari (iam,isx,iaw)
				if 'iam' in grup or 'isx' in grup or 'iaw' in grup:	
					grup_tag = grup[1:-1]
					new_login = grup_tag + login 
				else:
					new_login = login
				
				# Editem el home directory en funcio del grup
				home = '/home/grups/%s/%s' % (grup,new_login)
					
				# Edició fitxer ldif 
				entrada_user = insert_ldif(new_login,grup,uid,gid,shell,home)
				
				# Edició fitxer grup 
				entrada_user_grup = modify_ldif(grup,new_login)
				
				# Guardem dos fitxers ldif
				sortida_user.write(entrada_user)
				sortida_grup.write(entrada_user_grup)
				accept += 1
		# Connexió no establerta
		except:
			sys.stderr.write('Bad connexion with LDAP')
			sys.exit(1)
	# Linia incorrecta
	except:
		err.write('Linia dusuari incorrecta, revisi la linia %s \n' % (lectura))
		denied += 1
# Tancament	
err.close()
entrada.close()
sortida_user.close()
sortida_grup.close()

print 'Total processats:'
print 'Acceptats: %s (Consultar usuaris_alta.ldif)' % accept
print 'Denegats: %s (Consultar usuaris_error.log)' % denied

sys.exit(0)



