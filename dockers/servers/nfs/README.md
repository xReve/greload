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
/home/grups 192.168.*.*(rw,sync)
```

* En aquest cas, com que volem que els homes s'exportin en un host el qual els clients atacaran, ho definim de la manera en que ho exporti per la xarxa 192.168.x.x de forma
que pugin escriure i que els canvis es guardin al disc una vegada fets. 

* Pel que respecta al servidor, per poder obtenir tot el que volem, es necessari tenir activats uns quant serveis:

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


* Aquest servidor està dissenyat per funcionar en mode **detach**:

```
/usr/sbin/rpc.mountd -V 3 -F
```


* En cas de voler ser **executat** sense cap altre component, és pot fer de la següent manera:


```
docker run --rm --name nfs.edt.org -h nfs.edt.org --network network_name --privileged --volumes-from homes.edt.org -d eescriba/nfsserver:greload 
```

* En cas de voler ser **executat** sense cap altre component, és pot fer de la següent manera:


* En aquesta execució podem apreciar la opció **--volumes-from** la qual ens permet montar els homes dels usuaris del docker **homes** dins del docker **nfs**.


