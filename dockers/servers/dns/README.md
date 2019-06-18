# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

### SERVIDOR DNS

* En aquesta part del projecte està desenvolupat el servidor **DNS**.

* Aquest servidor s'encarrega de la resolució de noms en els clients, fent així més sencilla i visual la configuració d'aquest envers els servidors als quals ataca.

* Per representar l'estructura informàtica de l'Escola del treball, utilitzarem el mot **gandhi** per referirnos a la xarxa o lloc on estàn desenvolupats tots els servidors que utiltiza el host. 

* El host client ataca sempre contra **gandhi** ja sigui per fer consultes contra **ldap**, **kerveros**, **samba**, **nfs** etc.  
Per tant això significa que tots aquests servidors apuntaran a gandhi.

* Per representar això en forma de configuració, tindrem que el servidor principal es dirà **gandhi** i que tots els altres servidors (ldap,kerberos,samba,nfs) seràn un **CNAME** de gandhi.

* Aquest servidor dns està configurat perquè resolgui els noms i apunti al host **192.168.2.44** (host on es troben tots els servidors en la xarxa interna de docker).

### CONFIGURACIÓ

* Per tal de configurar l'explicat anteriorment, instal·larem el paquet **bind**:

```
dnf -y install procps bind
```

* Aquest packet ens proporcionarà un fitxer de configuració on definir el nostre servidor **dns**. El fitxer és el `named.conf`.

* El servidor **dns** és el primer servidor en ser executat dins de la plataforma, per tant com que estàn dins de la xarxa **172.30.0.0/16**, ell agafarà la ip **172.30.0.2**.

* Tenint en compte això, configurarem el servidor perquè escolti per aquesta ip i per a **localhost** al port **53**.

```
listen-on port 53 { 127.0.0.1; 172.30.0.2;}
```

* Aquest fitxer de configuració es guarda a `/etc`.

* El servidor té definides dos zones: **edt.org.zone.db** i **edt.org.rev.zone.db** (la inversa de la primera)

```
zone "edt.org" {
notify no;
type master;
file "edt.org.zone.db";
};

zone "0.168.192.in-addr.arpa" {
notify no;
type master;
file "edt.org.rev.zone.db";
};

```

* Aquestes zones es troben configurades a `/var/named`.


cat **edt.org.zone.db**

```
; Fitxer de configuració dels hosts de la zona:
; 	dns.edt.org  

$TTL 3D
@ IN SOA gandhi.edt.org. gandhi.edt.org. 1 3H 15M 1W 1D
   NS gandhi
    
;Hosts same net

gandhi		IN		A	192.168.2.44
dns		CNAME 			gandhi
dhcp		CNAME			gandhi	
ldap		CNAME			gandhi
kserver		CNAME			gandhi
homes		CNAME			gandhi
samba		CNAME			gandhi
nfs		CNAME			gandhi
ssh		CNAME			gandhi
http		CNAME 			gandhi
```

* Com hem dit abans, tots els servidors són un **CNAME** de gandhi.

* Tots apunten al host **192.168.2.44*

cat **edt.org.rev.zone.db**

```
; Fitxer de configuració dels hosts de la zona:
;   0.30.172.in-addr.arpa.

$TTL 3D
2.168.192.in-addr.arpa.  IN SOA gandhi.edt.org. gandhi.edt.org. 1 3M 1M 1W 1D
    NS gandhi.edt.org.

; llistat dels servidors i components troncals

44	PTR	gandhi
```

### ALTRES PUNTS

* Aquest servidor està fet ser executat en mode **detach**.

```
/usr/sbin/named -u named -f
```

* En cas de reutilitzar aquest servidor, és essencial canviar el **host** a qui apunta.

* En cas de voler ser **executat** sense cap altre component, és pot fer de la següent manera:

```
docker run --rm --name dns.edt.org -h dns.edt.org --network network_name --privileged -d eescriba/dnsserver:greload
```

* La comprovació del funcionament del servidor es troba dins dels clients **físics**.
