#! /usr/bin/python
# -*- coding: utf-8 -*-

import sys 

def add_info_user(user,nom,mail,mobile,description):
	'''
	Funció que reb informació addicional del usuari LDAP i la transforma 
	a format LDIF
	Entrada: 4 strings
	Sortida: String format ldif
	'''
	line = 'dn: uid=%s,ou=usuaris,dc=edt,dc=org\n' \
			'changetype: modify\n' \
			'add: mail\n' \
			'mail: %s\n' \
			'-\n' \
			'add: mobile\n' \
			'mobile: %s\n' \
			'-\n' \
			'add: description\n' \
			'description: %s\n' \
			'-\n' \
			'add: displayName\n' \
			'displayName: %s\n\n' % (user,mail,mobile,description,nom)
	
	return line
	

print 'FORMULARI INFORMACIÓ BÁSICA'

uid = str(raw_input('USERNAME: '))

nom = str(raw_input('FULL NAME: '))

mail = str(raw_input('EMAIL: '))

mobile = int(raw_input('TELEPHONE: '))

desc = str(raw_input('DESCRIPTION: '))


# Processem el fitxer de sortida
fileOut = 'usuari_more_data.ldif' # Fitxer ldif sortida
sortida_user = open(fileOut,"a")

# Afegim informació

sortida_user.write(add_info_user(uid,nom,mail,mobile,desc))

# Tanquem fitxer
sortida_user.close()


