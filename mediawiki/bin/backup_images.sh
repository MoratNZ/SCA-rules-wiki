#!/bin/bash
PROGRAM_NAME=$0

function usage {
    echo "usage: $PROGRAM_NAME [-fh]"
    printf "
This script backs up the mediawiki images directory.
Unless the -f flag is set, the backup will only be saved if something has in
the images tree has changed since the last backup was taken.

Backup files are stored at the location set in the \$BACKUPS_LOCATION 
environment variable (in the current environment this is set to 
\`$BACKUPS_LOCATION\`) as latest.tar.gz, and in \$BACKUPS_LOCATION/archive/ as 
[ datestamp ]_images.tar.gz (e.g., 202406182110_images.tar.gz

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

# Check the age of the backup
BACKUP_AGE=`/usr/bin/find $BACKUPS_LOCATION/latest.tar.gz -type f -printf '%T@'`
# Check when the latest change was made to images/
NEWEST_FILE=`/usr/bin/find /var/www/html/images -type f -printf '%T@\n'| sort -n | tail -n 1`

# if there are new changes, tar up the images folder into the archives
FILENAME=$(/usr/bin/date +"%Y%m%d%H%M")_images.tar.gz
if $FORCE|| $NEWEST_FILE -gt $BACKUP_AGE
    # create the archive dir if it doesn't exist.
    if [ ! -d $BACKUPS_LOCATION/archive ]
        then
        /usr/bin/mkdir -p $BACKUPS_LOCATION/archive
    fi
    /usr/bin/tar -czvf $BACKUPS_LOCATION/archive/$FILENAME /var/www/html/images 
    # copy
    /usr/bin/cp $BACKUPS_LOCATION/archive/$FILENAME $BACKUPS_LOCATION/latest.tar.gz
fi