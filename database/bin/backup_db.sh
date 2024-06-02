#!/bin/bash

# Dump the database to /db_backups
FILENAME=$(date +"%Y%m%d%H%M")_mediawiki
/usr/bin/mysqldump --add-drop-database -u root -p$MYSQL_ROOT_PASSWORD --all-databases > /docker-entrypoint-initdb.d/archive/$FILENAME.sql

# remove problematic attempt to drop 'mysql' database
/usr/bin/sed -i 's/\/\*!40000 DROP DATABASE IF EXISTS `mysql`\*\/;/ /g' /docker-entrypoint-initdb.d/archive/$FILENAME.sql

/usr/bin/cp /docker-entrypoint-initdb.d/archive/$FILENAME.sql /docker-entrypoint-initdb.d/latest.sql