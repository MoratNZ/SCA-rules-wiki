#!/bin/bash
echo Running startup script

echo "Start up cron"
/etc/init.d/cron start

echo "Restoring image backup to /var/www/html/images"
/scripts/restore_images.sh

echo "Starting mediawiki"

exec "$@"