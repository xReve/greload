#! /usr/bin/python
# -*- coding: utf-8 -*-
# Eric Escriba
# M14 PROJECTE

import sys 
import subprocess 

# Funcions

# Comprovar linia del grup
def check_groupline(line):
	'''
	Funció que reb una linia del /etc/group i comprova que estigui en 
	el format adient
	Entrada: String
	Sortida: Bool
	'''
	llista_camps = line.split(':')
	
	if len(llista_camps) != 4:
		return False
	
	return True

# Edicio ldif
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

# CONSTANTS
CON = 'ldap.edt.org'

# Declarem
fileIn = sys.argv[1] # Grups
fileOut = 'grups_alta.ldif' # Fitxer ldif sortida
fileGrups = 'grups_acceptats.txt' # Llista grups acceptats
error_log = "error_log/grups_error.log" # Fitxer errors

# Obrim fitxers
entrada = open(fileIn,"rw")
sortida = open(fileOut,"a")
grups_ok = open (fileGrups, "a")
err = open(error_log,"a")

# Contadors
lectura = 0
accept = 0
denied = 0

# Llegim grup per grup
for linia in entrada:
	lectura += 1
	# Comprovem que la linia es correcta (sense analitzar el contingut)
	if check_groupline(linia):		
		# Separem camps
		llista_camps = linia.split(':')
		gname = llista_camps[0]
		gid = llista_camps[2]
		user_list = llista_camps[3]
		
		try:
			# Comprovar que el grup no existeix a la BDD.
			check = "ldapsearch -x -LLL -h %s -b 'dc=edt,dc=org' '(&(cn=%s)(gidNumber=%s))' 'dn'" % (CON,gname,gid)
			pipeData = subprocess.check_output([check],stderr=subprocess.STDOUT,shell=True)
			group_id = pipeData.strip() 
			
			# Si el grup no existeix
			if group_id == '':
				# Creem fitxer ldif
				entrada_grup = group_ldif(gname,gid,user_list)
			
				# Guardem fitxer ldif i el grup
				sortida.write(entrada_grup)
				grups_ok.write(gname + '\n')
				accept +=1
			# Si existeix
			else:
				err.write('El grup %s ja existeix a LDAP\n' % (gname))
				denied += 1 
		
		except subprocess.CalledProcessError:
			sys.stderr.write('Bad connexion with LDAP\n')
			exit(1)
	else:
		err.write('Linia de grup incorrecta: LINIA %s\n' % (lectura))
		denied += 1

# Tancament	
err.close()
entrada.close()
sortida.close()
grups_ok.close()

print 'Total processats:'
print 'Acceptats: %s (Consultar grups_alta.ldif)' % accept
print 'Denegats: %s (Consultar grups_error.log)' % denied

exit(0)


	
