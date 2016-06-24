#!/bin/bash

# Пути к директориям
public='/srv/BE_current/public'

# Названия архивов
BE_current="BE_current_"`date +%d-%m-%Y`".tar.gz"

tar -czf $BE_current -pC $public .
pg_dump -U backuper notabenoid | gzip >  notabenoid_`date +%d-%m-%Y`.gz
pg_dump -U backuper kursomir_production | gzip >  kursomir_production_`date +%d-%m-%Y`.gz
tar -cf full_backup_`date +%d-%m-%Y`.tar . --exclude=*.sh
sshpass -p "password" scp full_backup_`date +%d-%m-%Y`.tar user@server:/home/backup_server/kursomir
rm ./*.tar.gz && rm ./*.gz && rm ./*.tar
