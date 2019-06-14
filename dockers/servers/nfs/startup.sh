#! /bin/bash
# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
# startup.sh
# -------------------------------------

/opt/docker/install.sh && echo "Install Ok"
/usr/sbin/nslcd && echo "nslcd Ok"
/usr/sbin/nscd && echo "nscd Ok"

/usr/sbin/rpcbind && echo "rpcbind Ok"
/usr/sbin/rpc.statd && echo "rpc.stad Ok"
/usr/sbin/rpc.nfsd && echo "rpc.nfsd Ok"
/usr/sbin/exportfs -av
/usr/sbin/rpc.mountd -F


#while [ 1 ]
#do
#  a=1
#done

