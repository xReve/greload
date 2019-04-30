#! /usr/bin/python
# -*- coding: utf-8 -*-

import sys 


# Declarem
fileIn = sys.argv[1] # Grups
fileOut = 'grups_alta.ldif' # Fitxer ldif sortida

# Obrim fitxers
entrada = open(fileIn,"rw")
sortida = open(fileOut,"a")
# err = open(error_log,"a")

for linia in entrada:
	
	llista_camps = linia.split(':')
	gname = llista_camps[0]
	gid = llista_camps[2]
	user_list = llista_camps[3]
	
	line1 = 'dn: cn=%s,ou=grups,dc=edt,dc=org \n' \
	'cn: %s \n' \
	'gidNumber: %s \n' \
	'description: Grup de %s \n'
	'objectclass: posixGroup \n' 
	
dn: cn=2asix,ou=grups,dc=edt,dc=org
cn: 2asix
gidNumber: 204
description: Grup de 2asix
objectclass: posixGroup
