#!/bin/bash
FORCE=false
# Process command line flags
while getopts 'f' OPTION; do
    case "$OPTION" in
        f) 
            FORCE=true
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