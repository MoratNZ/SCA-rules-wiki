#!/bin/bash

echo "Setting up cron"
sed -i "s/mysqlpassword/$MYSQL_ROOT_PASSWORD/" /etc/crontab
/etc/init.d/cron start

echo removing default bootstrap.sh
rm /docker-entrypoint-initdb.d/bootstrap.sh

echo Moving latest backup to bootstrap folder
cp /db_backups/latest.sql /docker-entrypoint-initdb.d/latest.sql
chmod 666 /docker-entrypoint-initdb.d/latest.sql

echo Updating password and perms for mediawiki user \'$MYSQL_USER\'
echo "GRANT ALL ON $DB_NAME.* TO '$MYSQL_USER'@'%';" >> /docker-entrypoint-initdb.d/latest.sql
echo "ALTER USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> /docker-entrypoint-initdb.d/latest.sql

exec /entrypoint.sh mysqld