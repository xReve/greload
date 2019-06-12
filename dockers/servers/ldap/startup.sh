#! /bin/bash
# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà
# Crear i engegar slapd amb edt.org
# -------------------------------------

/opt/docker/install.sh && echo "Install Ok"
/sbin/slapd -d0  && echo "slapd Ok"

