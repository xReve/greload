# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

## SCRIPTS DE GRUPS


`insertGrup` -> Directori amb els scripts d'injecció de grups.

* En aquest apartat tractem l'injecció de grups, és a dir, ens arribarà un fitxer amb grups a tractar.

* Aquest fitxer té el format del fitxer `/etc/group`, **gname:passwd:gid,users**.

* Per cada grup haurem de fer dos passos essencials per poder tenir el grup creat correctament.

* En cas que algun grup no es pugi injectar, s'informarà per pantalla o bé es generarà un fitxer d'errors informant del problema.

* Aquest apartat consta de diferentes parts cadascuna separada i enfocada a la seva feina en concret.

* Existeix d'un script global que inclou cadascuna d'aquestes parts i permet l'injecció del grup a travès d'una sola execució.

* Finalment també trobarem un petit script de neteja dels fitxers creats durant l'injecció de grups, els quals una vegada utilitzats
ja no resulten d'utilitat i seràn esborrats per cedir pas als nous.

* L'explicació més precissa de cada part es troba dins del directori `insertGrup`.


`delGrup` -> Directori amb els scripts d'esborrat de grups.

* En aquest apartat tractarem l'esborrat de grups, és a dir, ens arribarà un fitxer amb noms de grup que hem de tractar.

* Aquest fitxer contindrà un nom de grup a cada línia.

* Per cada grup haurem de fer un seguit de passos per fer que sigui un esborrat complert i eficaç.

* En cas de que algun grup no es pugi esborrar s'informarà per pantalla o bé es generarà un fitxer d'errors informant del problema.

* Aquest apartat consta de diferentes parts cadascuna separada i enfocada a la seva feina en concret.

* Existeix d'un script global que inclou cadascuna d'aquestes parts i permet l'esborrat del grup  a travès d'una sola execució.

* Finalment també trobarem un petit script de neteja dels fitxers creats durant l'esborrat de grups, els quals una vegada utilitzats
ja no resulten d'utilitat i seràn esborrats per cedir pas als nous.

* L'explicació més precissa de cada part es troba dins del directori `delGrup`.



