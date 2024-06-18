#!/bin/bash

# create the archive dir if it doesn't exist.
if [ ! -d $BACKUPS_LOCATION/archive ]; then
    /usr/bin/mkdir -p $BACKUPS_LOCATION/archive
fi

# Dump the database to /db_backups
/usr/bin/mysqldump --add-drop-database -u root -p$MYSQL_ROOT_PASSWORD --all-databases > $BACKUPS_LOCATION/candidate.sql

# remove problematic attempt to drop 'mysql' database
/usr/bin/sed -i 's/\/\*!40000 DROP DATABASE IF EXISTS `mysql`\*\/;/ /g' $BACKUPS_LOCATION/candidate.sql

# Compare the candidate dump with the latest dump
if /usr/bin/diff --brief <(head -n -1 $BACKUPS_LOCATION/latest.sql) <(head -n -1 $BACKUPS_LOCATION/candidate.sql) > /dev/null ; then 
    /usr/bin/echo "No change to the database"
else
    /usr/bin/echo "Database changed; saving backup"
    ARCHIVE_FILENAME=$(date +"%Y%m%d%H%M")_mediawiki.sql
    /usr/bin/cp $BACKUPS_LOCATION/candidate.sql $BACKUPS_LOCATION/archive/$ARCHIVE_FILENAME.sql
    /usr/bin/cp $BACKUPS_LOCATION/candidate.sql $BACKUPS_LOCATION/latest.sql
fi

# Clean up candidate file
rm $BACKUPS_LOCATION/archive/candidate.sql