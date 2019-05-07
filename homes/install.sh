#! /bin/bash
# 2018-2019
# HOMES
# -----------------------------------------------------------
mkdir /home/edt
mkdir /home/edt/pere
mkdir /home/edt/pau
mkdir /home/edt/anna
mkdir /home/edt/marta
mkdir /home/edt/admin

cp welcome.md /home/edt/pere
cp welcome.md /home/edt/pau
cp welcome.md /home/edt/anna
cp welcome.md /home/edt/marta
cp welcome.md /home/edt/admin

chown -R pere.especial /home/edt/pere
chown -R pau.especial /home/edt/pau
chown -R anna.especial /home/edt/anna
chown -R marta.especial /home/edt/marta
chown -R admin.admin /home/edt/admin

# -----------------------------------------------------------
