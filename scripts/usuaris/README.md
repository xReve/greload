# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

# SCRIPTS D'USUARIS

`insertUser` -> Scripts destinats a la **injecció d'usuaris**

* En aquest apartat tracatem l'injecció d'usuaris, és a dir, ens arribarà un fitxer amb comptes d'usuari que hem de tractar.

* Aquest fitxer té el format d'un fitxer `/etc/password`, **login:passwd:uid:gid:gecos:home:shell**

* Per cada usuari haurem de fer un seguit de passos per aconseguir crear un compte d'usuari complert en tots els àmbits.

* En cas que algun usuari no es pugi injectar en qualsevol lloc, s'informarà per pantalla o bé es generarà un fitxer d'errors informant del problema.

* Aquest apartat consta de diferentes parts cadascuna separada i enfocada a la seva feina en concret.

* Existeix d'un script global que inclou cadascuna d'aquestes parts i permet l'injecció de l'usuari a travès d'una sola execució.

* Finalment també trobarem un petit script de neteja dels fitxers creats durant l'injecció d'usuaris, els quals una vegada utilitzats
ja no resulten d'utilitat i seràn esborrats per cedir pas als nous.

* L'explicació més precissa de cada part es troba dins del directori `insertUser`.


`delUser` -> Scripts destinats a l'**esborrat d'usuaris**

* En aquest apartat tractarem l'esborrat d'usuaris, és a dir, ens arribarà un fitxer amb noms d'usuari que hem de tractar.

* Aquest fitxer contindrà un nom d'usuari a cada línia.

* Per cada usuari haurem de fer un seguit de passos per fer que sigui un esborrat complert i eficaç.

* En cas de que algun usuari no es pugi esborrar s'informarà per pantalla o bé es generarà un fitxer d'errors informant del problema.

* Aquest apartat consta de diferentes parts cadascuna separada i enfocada a la seva feina en concret.

* Existeix d'un script global que inclou cadascuna d'aquestes parts i permet l'esborrat de l'usuari a travès d'una sola execució.

* Finalment també trobarem un petit script de neteja dels fitxers creats durant l'esborrat d'usuaris, els quals una vegada utilitzats
ja no resulten d'utilitat i seràn esborrats per cedir pas als nous.

* L'explicació més precissa de cada part es troba dins del directori `delUser`.
