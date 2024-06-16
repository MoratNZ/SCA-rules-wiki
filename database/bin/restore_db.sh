#!/bin/bash

mysql -u $MYSQL_USER –p $DB_NAME < $BACKUPS_LOCATION/latest.sql

php /var/www/html/maintenance/update.php
