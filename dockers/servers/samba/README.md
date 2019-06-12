# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

## SERVIDOR SAMBA

* En aquesta part del projecte està desenvolupat el servidor **SAMBA**.

* Aquest servidor té la funcionalitat de montar els homes dels usuaris via **cifs**.

* Per poder duu a terme aquesta tasca primer que tot s'ha de poder accedir als **homes** dels usuaris. Això es fa mitjançant un volum que té creat el docker **homes**.

* Aquest volum, una vegada que el docker el servidor és inicialitzat, és monta a **/home** i allí podem trobem tots els directoris dels usuaris i grups.

* És important tenir en compte que aquest volum ha d'estar **montat exactament** en la ruta en que l'usuari té definit el home, ja que del contrari alhora de montar-l'ho, el servidor no serà capaç de trobar
la ruta i no farà el montatge. 

**EXPLICACIÓ**

Si el home de l'usuari user01 és /home/grups/test/user01, si montem aquest home en qualsevol lloc que no sigui aquesta ruta, el montatge fallarà, inclús indicant-li al **pam_mount.conf.xml** on es troba
exactament.

* En segon lloc és imprescindible desplegar el servidor samba que tindrà instal·lat els paquets **cifs-utils samba samba-client** per poder tenir el servidor.

* Per la configuració dels exports tenim la següent:

```
[global]
        workgroup = MYGROUP
        server string = Samba Server Version %v
        log file = /var/log/samba/log.%m
        max log size = 50
        security = user
        passdb backend = tdbsam
        load printers = yes
        cups options = raw
[homes]
        comment = Home Directories
        browseable = no
        writable = yes
```

* Important recalcar que no definim un **path** als homes ja que el servidor agafa per defecta el home de l'usuari i el va a buscar exactament a la ruta indicada. 

* Un altre factor són els permisos dels directoris, si aquests no pertanyen a l'usuari que demana el montatge, el servidor ho denegara i fallarà, per tant el punt important és definir els permisos
per tal de que els usuaris nomès pugin montar allò que és seu i no dels demès.

* Aquest servidor té contacte amb l'LDAP en cas de que en un futur es vulgi canviar el backend per **ldapsam**, nomès caldria configurar els fitxers de samba ja que ja té contacte amb el servidor LDAP. 
També és util contactar per possibles consultes o problemes.

* El servidor té uns usuaris predifinits a la seva base de dades:

```
echo -e "pere\npere" | smbpasswd -a pere
echo -e "pau\npau" | smbpasswd -a pau
echo -e "anna\nanna" | smbpasswd -a anna
echo -e "marta\nmarta" | smbpasswd -a marta
echo -e "operador\noperador" | smbpasswd -a operador

```

* A més a més, també s'ha assignat el password a **root** ja que és necessari de cara a la creació de nous usuaris samba. Samba no et permet crear usuaris a no ser que siguis l'usuari administrador, en aquest cas **root**.


* És molt important tenir en compte que una vegada un client samba intenti montar el seu home, aquestes credencials s'utilitzaran per validar l'usuari dins del servidor i saber si aquest usuari pot montar o no el seu home. Tot usuari de LDAP que vulgi montar el seu home de samba, haurà de tenir obligatoriament un compte de samba creat amb les mateixes credencials, si no el servidodr ens denegarà el mount. 


* Un extra que incorpora aquest docker és que contè un servidor **SSH** per poder rebre connexions. Aquest servidor està introduit aquí amb la finalitat de poder establir connexions segures contra el servidor per poder executar els scripts d'**injecció i esborrat** d'usuaris samba.  
Aquest punt és imprescindible ja que samba no disposa de cap eina per poder afegir o esborrar usuaris **remotament**, nomès canviar el seu password.

* Aquest servidor està dissenyat per ser executat en mode **detach**.

```
/usr/sbin/smbd && echo "smb Ok" 
/usr/sbin/nmbd && echo "nmb  Ok" 

/usr/sbin/sshd -D
```


* En cas de voler ser **executat** sense cap altre component, és pot fer de la següent manera:

```
docker run --rm --name samba.edt.org -h samba.edt.org --network network_name --privileged --volumes-from homes.edt.org -d eescriba/samba:greload

```

* En aquesta execució podem apreciar la opció **--volumes-from** la qual ens permet montar els homes dels usuaris del docker **homes** dins del docker **samba**.

