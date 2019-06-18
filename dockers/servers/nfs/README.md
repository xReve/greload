# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

## SERVIDOR NFS

* En aquest apartat del projecte tenim el servidor **NFS**. 

* Aquest servidor té la funcionalitat de montar els homes dels usuaris, una vegada hagin inciiat sessió, via **nfs**. 

* Per poder desenvolupar aquest servidor s'ha instal·lat el paquet **nfs-utils** el qual contè tot el software necessari per posar-ho tot en funcionament.

* Per poder accedir als **homes** dels usuaris també és necessari utilitzar el volum que hem creat amb el docker **homes** i montar-l'ho en el servidor en l'arrancada.

* Per definir quins recursos exporta el servidor, hem de definir-ho al `/etc/exports`:

```
/home/grups 192.168.2.0/16(rw,sync,root_squash)
```

**rw** -> El client tindrà permisos de **lectura i escriptura** sobre el recurs compartit.

**sync** -> Els canvis que s'efectuen a les dades és guarden al moment en el disc.

**root_squash** -> Mitjançant aquesta opció quan un client que estigui com usuari **root** vulgi montar el recurs compartit, l'usuari **root** es transformarà en l'usuari **nobody** per tal de treure-l'hi els permisos i d'aquesta manera no poder accedir al recurs.

* Exportem el recurs **/home/grups/** a la xarxa **192.168.2.0/16** que és on tenim els clients.

* Com que no treballem en diferentes xarxes pels clients s'ha configurat nomès la xarxa **.2** i tots els clients es connecten allí.

* En cas de tenir **diverses xarxes**, el fitxer d'exportacions podria canviar depenent del grup i la xarxa en que pertanyi.

```
/home/grups/hisx1 192.168.3.0/16(rw,sync,root_squash)
/home/grups/hisx2 192.168.2.0/16(rw,sync,root_squash)
/home/grups/wiam1 192.168.4.0/16(rw,sync,root_squash) 
/home/grups/wiam2 192.168.5.0/16(rw,sync,root_squash)
/home/grups/wiaw1 192.168.6.0/16(rw,sync,root_squash)
/home/grups/wiaw2 192.168.7.0/16(rw,sync,root_squash)
/home/grups/profes 192.168.10.0/16(rw,sync,root_squash)
```

* Pel que respecta al servidor, per poder obtenir l'exportació dels recursos i el funcionament dels serveis, es necessari tenir activat el següent

```
/usr/sbin/rpcbind && echo "rpcbind Ok"
/usr/sbin/rpc.statd && echo "rpc.stad Ok"
/usr/sbin/rpc.nfsd && echo "rpc.nfsd Ok"
/usr/sbin/rpc.mountd && echo "rpc.mountd Ok"
```

* **rpcbind** -> 

La utilitat rpcbind és un servidor que converteix els números de programa RPC en adreces universals. Ha d’executar-se a l’amfitrió per poder fer trucades RPC en un servidor d’aquesta màquina.

Quan s'inicia un servei RPC, indica a rpcbind l'adreça a la qual escolta i els números de programa RPC que està preparat per servir. Quan un client desitja fer una trucada RPC a un número de programa donat, primer contacta rpcbind a la màquina del servidor per determinar l'adreça on s'han de enviar les sol·licituds RPC.

La utilitat rpcbind s'hauria d’engegar abans de qualsevol altre servei RPC. Normalment, els servidors RPC estàndard s’inicien mitjançant monitors de port, de manera que rpcbind s’ha d’iniciar abans d’invocar els monitors de port.

Quan rpcbind s'inicia, comprova que certes trucades de traducció de noms a adreces funcionen correctament. Si no, les bases de dades de configuració de la xarxa poden estar corruptes. Atès que els serveis RPC no poden funcionar correctament en aquesta situació, rpcbind informa de la condició i finalitza.

* **rpc.statd** -> 

És un dimoni que escolta les notificacions de reinici d'altres hosts i gestiona la llista d’ordinadors que s’ha de notificar quan es reinicia el sistema local.

rpc.statd registra informació sobre cada interlocutor NFS monitoritzat en un emmagatzematge persistent. Aquesta informació descriu com posar-se en contacte amb un igual remot en cas que es reiniciï el sistema local, com reconèixer el parell supervisat que està informant d'un reinici i com notificar al gestor de bloqueig local quan un interlocutor supervisat indica que s'ha reiniciat.

* **rpc.nfsd** ->

El programa rpc.nfsd implementa la part de nivell d’usuari del NFS  servei. La funcionalitat principal es gestiona mitjançant el mòdul del nucli nfsd.
El programa d’espai d’usuari només especifica quins tipus d’accés s’utilitzen el servei del nucli hauria d’escoltar, quines versions NFS hauria de suportar,i quants fils de nucli hauria d’utilitzar.

* **rpc.mountd** ->

El protocol NFS MOUNT té diversos procediments. Els més importants són **MNT** (muntar una exportació) i **UMNT** (desmuntar una exportació).

Una sol·licitud MNT té dos arguments: un argument explícit que conté el camí del directori arrel de l'exportació que es muntarà i un argument implícit que és l'adreça IP del remitent.

Quan es rep una sol·licitud MNT d'un client NFS, rpc.mountd comprova la ruta i l'adreça IP del remitent contra la seva taula d'exportació. Si l’emissor té permís per accedir a l’exportació sol·licitada, rpc.mountd retorna al client el maneig del fitxer NFS del directori arrel de l’exportació. El client pot utilitzar les sol·licituds de fitxer arrel i NFS LOOKUP per navegar per l’estructura de directoris de l’exportació.

* Una vegada està tot activat exportem els recursos:

```
/usr/sbin/exportfs -av
```

### ALTRES PUNTS

* Aquest servidor està dissenyat per funcionar en mode **detach**:

```
/usr/sbin/rpc.mountd -F
```

* En cas de voler ser **executat** sense cap altre component, és pot fer de la següent manera:


```
docker run --rm --name nfs.edt.org -h nfs.edt.org --network network_name --privileged --volumes-from homes.edt.org -d eescriba/nfsserver:greload 
```

* En cas de voler ser **executat** sense cap altre component, és pot fer de la següent manera:


* En aquesta execució podem apreciar la opció **--volumes-from** la qual ens permet montar els homes dels usuaris del docker **homes** dins del docker **nfs**.


