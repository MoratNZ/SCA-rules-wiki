#!/bin/bash
echo Running startup script

cp -r $IMAGE_BACKUPS /var/www/html/images

exec "$@"