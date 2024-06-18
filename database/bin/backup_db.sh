#!/bin/bash

PROGRAM_NAME=$0

function usage {
    echo "usage: $PROGRAM_NAME [-fh]"
    printf "
This script backs up the mediawiki database.
Unless the -f flag is set, the backup will only be saved if the database has
changed since the last backup was taken.

Backup files are stored at the location set in the \$BACKUPS_LOCATION 
environment variable (in the current environment this is set to 
\`$BACKUPS_LOCATION\`) as latest.sql, and in \$BACKUPS_LOCATION/archive/ as 
[ datestamp ]_mediawiki.sql (e.g., 202406182110_mediawiki.sql)

"
    echo "  -f      Force a backup, even if there have been no changes to the database"
    echo "  -h      display help"
    exit 1
}

FORCE=false
# Process command line flags
while getopts 'fh' OPTION; do
    case "$OPTION" in
        f) 
            FORCE=true
            ;;
        h) 
            usage
            ;;
    esac
done


# create the archive dir if it doesn't exist.
if [ ! -d $BACKUPS_LOCATION/archive ]; then
    /usr/bin/mkdir -p $BACKUPS_LOCATION/archive
fi

# Dump the database to /db_backups
/usr/bin/mysqldump --add-drop-database -u root -p$MYSQL_ROOT_PASSWORD --all-databases > $BACKUPS_LOCATION/candidate.sql

# remove problematic attempt to drop 'mysql' database
/usr/bin/sed -i 's/\/\*!40000 DROP DATABASE IF EXISTS `mysql`\*\/;/ /g' $BACKUPS_LOCATION/candidate.sql

# Compare the candidate dump with the latest dump
/usr/bin/diff --brief <(head -n -1 $BACKUPS_LOCATION/latest.sql) <(head -n -1 $BACKUPS_LOCATION/candidate.sql) > /dev/null 
CHANGED=$?

if $FORCE || [ $CHANGED = 1 ]; then 
    /usr/bin/echo "$( date ) - backup_db.sh run: Database changed; saving backup"
    ARCHIVE_FILENAME=$(date +"%Y%m%d%H%M")_mediawiki.sql
    /usr/bin/cp $BACKUPS_LOCATION/candidate.sql $BACKUPS_LOCATION/archive/$ARCHIVE_FILENAME
    /usr/bin/cp $BACKUPS_LOCATION/candidate.sql $BACKUPS_LOCATION/latest.sql
else
    /usr/bin/echo "$( date ) - backup_db.sh run: No change to the database"
fi

# Clean up candidate file
rm $BACKUPS_LOCATION/candidate.sql