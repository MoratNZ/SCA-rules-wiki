#!/bin/bash

# create the archive dir if it doesn't exist.
if [ ! -d $BACKUPS_LOCATION/archive ];
    then;
    mkdir -p $BACKUPS_LOCATION/archive;
fi

# Dump the database to /db_backups
FILENAME=$(date +"%Y%m%d%H%M")_mediawiki
/usr/bin/mysqldump --add-drop-database -u root -p$MYSQL_ROOT_PASSWORD --all-databases > $BACKUPS_LOCATION/archive/$FILENAME.sql

# remove problematic attempt to drop 'mysql' database
/usr/bin/sed -i 's/\/\*!40000 DROP DATABASE IF EXISTS `mysql`\*\/;/ /g' $BACKUPS_LOCATION/archive/$FILENAME.sql

/usr/bin/cp $BACKUPS_LOCATION/archive/$FILENAME.sql $BACKUPS_LOCATION/latest.sql