#!/bin/bash
sed -i "s/mysqlpassword/$MYSQL_ROOT_PASSWORD/" /etc/crontab
/etc/init.d/cron start

exec /entrypoint.sh mysqld