#! /bin/bash
# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
# startup.sh
# -------------------------------------
/opt/docker/install.sh && echo "Install Ok"

/usr/sbin/smbd && echo "smb Ok"
/usr/sbin/nmbd && echo "nmb  Ok"

/usr/sbin/sshd -D

