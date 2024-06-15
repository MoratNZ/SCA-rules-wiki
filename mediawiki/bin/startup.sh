#!/bin/bash
echo Running startup script

cp -r $BACKUPS_LOCATION /var/www/html/images

exec "$@"