#!/usr/bin/bash
mysql -u root -p$MYSQL_ROOT_PASSWORD << EOF
GRANT ALL ON $DB_NAME.* TO '$MYSQL_USER'@'%';
EOF
