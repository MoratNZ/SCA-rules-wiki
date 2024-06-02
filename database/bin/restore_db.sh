#!/bin/bash

LATEST_BACKUP=`find /db_backups -type f -exec ls -t {} + | head -1`
mysql -u $DB_USER –p $DB_NAME < $LATEST_BACKUP

php /var/www/html/maintenance/update.php
