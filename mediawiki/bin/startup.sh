#!/bin/bash
echo Running startup script

echo "Restoring image backup to /var/www/html/images"
/scripts/restore_images.sh

echo "Starting mediawiki"

exec "$@"