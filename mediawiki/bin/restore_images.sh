BACKUP_FILE=$BACKUPS_LOCATION/latest.tar.gz
if [ -f $BACKUP_FILE]
    then
    rm -rf /var/www/html/images
    tar -xvf $BACKUP_FILE -C /var/www/html
    fi