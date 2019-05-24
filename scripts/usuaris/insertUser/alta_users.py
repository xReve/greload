#! /usr/bin/python
# -*- coding: utf-8 -*-

import sys
import subprocess 

# Funcions

# Comprova linia usuari

def check_userline(line):
	'''
	Funció que reb una linia del /etc/passwd i comprova que estigui en 
	el format adient
	Entrada: String
	Sortida: Bool
	'''
	llista_camps = line.split(':')
	
	if len(llista_camps) != 7:
		return False
	
	return True

	

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

# CONSTANTS
CON = 'ldap.edt.org'

# Declarem
fileIn = sys.argv[1] # Usuaris
fileOut = 'usuaris_alta.ldif' # Fitxer ldif sortida
fileOutmod = 'usuaris_append_grup.ldif' # Fitxer modificació grup
fileHomes = 'userhomes.txt' # Fitxer amb els homes dels usuaris i el login
error_log = "error_log/usuaris_error.log" # Fitxer errors

# Obrim fitxers
entrada = open(fileIn,"r")
sortida_user = open(fileOut,"a")
sortida_grup = open(fileOutmod, "a")
sortida_homes = open(fileHomes,"a")
err = open(error_log,"a")

# Contadors
lectura = 0
accept = 0
denied = 0

# Treballem
for linia in entrada:
	lectura += 1
	# Comprovem que la linia es correcta (sense analitzar el contingut)
	if check_userline(linia):
		# Distingim els camps de cada usuari
		llista_camps = linia.split(':')
		login = llista_camps[0]
		uid = llista_camps[2]
		gid = llista_camps[3]
		shell = llista_camps[6]
		
		try:
			# Comprovar que l'usuari no existeix a la BDD.
			check = "ldapsearch -x -LLL -h %s -b 'dc=edt,dc=org' 'uid=%s' 'dn'" % (CON,login)
			pipeData = subprocess.check_output([check],stderr=subprocess.STDOUT,shell=True)
			user_id = pipeData.strip()
			# Si l'usuari no esta a LDAP
			if user_id == '':
				# Obtenció del grup
				# Connexió LDAP	
				search = "ldapsearch -x -LLL -h %s -b 'dc=edt,dc=org' " \
				"'gidNumber=%s' 'dn' | cut -f1 -d ',' | cut -f2 -d ' ' | cut -f2 -d '=' " % (CON,gid)
				pipeData = subprocess.check_output([search],stderr=subprocess.STDOUT,shell=True)
				grup = pipeData.strip()
				
				# Si l'usuari no té un grup a la BBDD no es pot afegir
				if grup == '':
					err.write('User %s no te un grup existent a la BBDD. Crei el grup i despres afegeix lusuari \n' % login)
					denied += 1
				else:
					# Comprovem a quin grup pertany i li creem el tag (iam,isx,iaw)
					if 'iam' in grup or 'isx' in grup or 'iaw' in grup:	
						grup_tag = grup[1:-1]
						new_login = grup_tag + login 
					else:
						new_login = login
					
					# Editem el home directory en funcio del grup
					home = '/home/grups/%s/%s' % (grup,new_login)
						
					# Creació format ldif per l'usuari
					entrada_user = insert_ldif(new_login,grup,uid,gid,shell,home)
					
					# Creació format ldif pel grup 
					entrada_user_grup = modify_ldif(grup,new_login)
					
					# Guardem dos fitxers ldif
					sortida_user.write(entrada_user)
					sortida_grup.write(entrada_user_grup)
					sortida_homes.write(new_login + ':' + home + '\n')
					accept += 1
			# Si l'usuari ja existeix a LDAP
			else:
				err.write("L'usuari %s ja existeix a LDAP\n" % (login))
				denied += 1 
		except subprocess.CalledProcessError:
			sys.stderr.write('Bad connexion with LDAP\n')
			exit(1)
	# Linia incorrecta
	else:	
		err.write("Linia d'usuari incorrecta, revisi la linia %s \n" % (lectura))
		denied += 1

# Tancament	
err.close()
entrada.close()
sortida_user.close()
sortida_grup.close()
sortida_homes.close()

print 'Total processats:'
print 'Acceptats: %s (Consultar usuaris_alta.ldif)' % accept
print 'Denegats: %s (Consultar usuaris_error.log)' % denied

exit(0)



