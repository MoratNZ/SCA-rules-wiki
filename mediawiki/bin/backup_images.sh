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
    echo "  -h      Display help"
    echo "  -v      Verbose output"
    exit 1
}

FORCE=false
VERBOSE=false
# Process command line flags
while getopts 'fhv' OPTION; do
    case "$OPTION" in
        f) 
            FORCE=true
            ;;
        h)
            usage
            ;;
        v) 
            VERBOSE=true
            ;;
    esac
done

# Check the age of the backup
BACKUP_AGE=`/usr/bin/find $BACKUPS_LOCATION/latest.tar.gz -type f -printf '%T@'`
# Check when the latest change was made to images/
NEWEST_FILE=`/usr/bin/find /var/www/html/images -type f -printf '%T@\n'| sort -n | tail -n 1`

CHANGED=`/usr/bin/echo $NEWEST_FILE $BACKUP_AGE | awk '{if ($1 > $2) print 1; else print 0}'`

# Check the current file count with the file count when the last backup was taken
#
# (This is to catch file deletions, which won't show up in the above check of 
# last updated times for files and directories, since that only checks times
# for objects that currently exist)

CURRENT_FILE_COUNT=`find /var/www/html/images  -type f | wc -l`
OLD_FILE_COUNT=`cat $BACKUPS_LOCATION/FILECOUNT`

if [ $CURRENT_FILE_COUNT -ne $OLD_FILE_COUNT ]; then
    FILECOUNT_CHANGED=1
else    
    FILECOUNT_CHANGED=0
fi

# if there are new changes, tar up the images folder into the archives
FILENAME=$(/usr/bin/date +"%Y%m%d%H%M")_images.tar.gz

if $FORCE || 
    { 
    [ $CHANGED = 1 ] || 
    [ $FILECOUNT_CHANGED = 1 ]
    }
then
    if $FORCE; then
        EXPLANATION="images/ backup forced"
    else
        A="last updated date in images/ is newer than last backup"
        B="the filecount in images/ has changed from the last backup"

        if [ $CHANGED = 1 ]; then 
            EXPLANATION=$A
        fi
        if [ $FILECOUNT_CHANGED = 1 ]; then
            if [ $CHANGED = 1 ]; then 
                EXPLANATION="$A and $B"
            else
                EXPLANATION=$B
            fi
        fi
    fi
    /usr/bin/echo "$( /usr/bin/date ) - images.sh run: $EXPLANATION; saving backup"
    # create the archive dir if it doesn't exist.
    if [ ! -d $BACKUPS_LOCATION/archive ]; then
        /usr/bin/mkdir -p $BACKUPS_LOCATION/archive
    fi
    
    find /var/www/html/images  -type f | wc -l > $BACKUPS_LOCATION/FILECOUNT

    if $VERBOSE; then
        echo "Storing following files:"
        /usr/bin/tar -C /var/www/html -czvf $BACKUPS_LOCATION/archive/$FILENAME images
    else
        /usr/bin/tar -C /var/www/html -czvf $BACKUPS_LOCATION/archive/$FILENAME images > /dev/null
    fi
    # copy
    /usr/bin/cp $BACKUPS_LOCATION/archive/$FILENAME $BACKUPS_LOCATION/latest.tar.gz
else
    /usr/bin/echo "$( /usr/bin/date ) - backup_image.sh run: No change to images/"
fi