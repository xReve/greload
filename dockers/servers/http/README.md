# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

### SERVIDOR HTTP

* En aquesta part del projecte està desenvolupat el servidor **HTTP**

* Aquest servidor té la finalitat de donar servei a una plataforma web.

* En aquest cas el servidor respondrà al port **80** del host en que s'estigui exectuant, és a dir, al port 80 del host **192.168.2.44** ja que és el host on estarà desplegat.

* El servidor dona servei de la presentació del projecte a aquell qui es vulgi connectar.


### CONFIGURACIÓ

* Per desplegar el servidor és necessari instal·lar el paquet que contè els fitxers de configuració:

```
dnf -y install httpd
```

* Per tal de modificar el contingut que dona el servidor, hem d'editar els fitxers de dins del directori `/var/www/html` 

```
cp /opt/docker/index.html /var/www/html/index.html
cp /opt/docker/estil.css /var/www/html/estil.css
cp /opt/docker/hello.gif /var/www/html/hello.gif
cp /opt/docker/docker_cloud.png /var/www/html/docker_cloud.png
cp /opt/docker/host.png /var/www/html/host.png
```

* Ara nomès faria falta activar el servei:

```
/usr/sbin/httpd
```

### COMPROVACIÓ

**telnet 192.168.2.44 80**

```
Trying 192.168.2.44...
Connected to 192.168.2.44.
Escape character is '^]'.
GET / HTTP/1.0

HTTP/1.1 200 OK
Date: Tue, 18 Jun 2019 11:18:41 GMT
Server: Apache/2.4.34 (Fedora)
Last-Modified: Mon, 17 Jun 2019 12:11:14 GMT
ETag: "1dba-58b980257bcf2"
Accept-Ranges: bytes
Content-Length: 7610
Connection: close
Content-Type: text/html; charset=UTF-8


<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="Content-Style-Type" content="text/css" />
  <meta name="generator" content="pandoc" />
  <meta name="author" content="Èric Escribà" />
  <title>GANDHI RELOAD</title>
  <style type="text/css">
      code{white-space: pre-wrap;}
      span.smallcaps{font-variant: small-caps;}
      span.underline{text-decoration: underline;}
      div.column{display: inline-block; vertical-align: top; width: 50%;}
  </style>
  <link rel="stylesheet" type="text/css" media="screen, projection, print"
    href="https://www.w3.org/Talks/Tools/Slidy2/styles/slidy.css" />
  <link rel="stylesheet" type="text/css" media="screen, projection, print"
   href="estil.css" />
  <script src="https://www.w3.org/Talks/Tools/Slidy2/scripts/slidy.js"
    charset="utf-8" type="text/javascript"></script>
</head>
<body>
<div class="slide titlepage">
  <h1 class="title">GANDHI RELOAD</h1>
  <p class="author">
Èric Escribà
  </p>
</div>
<div id="seccions-i-objectius" class="slide section level1">
<h1>SECCIONS I OBJECTIUS</h1>
<ul>
<li><p>ESTRUCTURA INFORMÀTICA (servidors,clients)</p></li>
<li><p>SCRIPTING (alta i baixa usuaris/grups)</p></li>
<li><p>Lloc de treball</p></li>
<li><p>Eficient i reutilitzable</p></li>
<li><p>Automatització de tasques</p></li>
</ul>
</div>
.
.
.
```

### ALTRES PUNTS

* Aquest servidor s'exectua en mode **detach**.

```
/usr/sbin/httpd -X
```

* En cas de ser executat sense cap altre component, és pot fer de la següent manera:

```
docker run --rm --name http.edt.org -h http.edt.org --network network_name --privileged -d eescriba/httpserver
```


