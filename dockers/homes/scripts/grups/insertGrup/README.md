# SCRIPTS GRUPS

## INJECCIÓ


**insercio-grups.py** -> Script que reb grups amb el format `/etc/group` i els transforma amb format **ldif**.


**create-homes.py** -> Script que crea el **directori del grup** on estaran els homes dels usuaris d'aquell grup posteriorment.


**grups-alta.ldif** -> Fitxer ldif resultat de l'execució del script **insercio-grups.py** amb el fitxer **Grups-to-insert.txt** (grups format `/etc/group`)


**UPDATEDB-insertGrup.sh** -> Script que atomatizta el procès de creat dels grups. 


`errors` -> Directori amb els fitxers d'error que s'han anat generant durant l'execució dels scripts


