#!/bin/bash

# Dump the database to /db_backups
FILENAME=$(date +"%Y%m%d%H%M")_mediawiki
mysqldump --add-drop-database -u root -p$MYSQL_ROOT_PASSWORD --all-databases > /docker-entrypoint-initdb.d/archive/$FILENAME.sql

# remove problematic attempt to drop 'mysql' database
sed -i 's/\/\*!40000 DROP DATABASE IF EXISTS `mysql`\*\/;/ /g' /docker-entrypoint-initdb.d/archive/$FILENAME.sql

cp /docker-entrypoint-initdb.d/archive/$FILENAME.sql /docker-entrypoint-initdb.d/latest.sql