FROM mysql:8.0-debian

RUN apt-get update
RUN apt-get --assume-yes install cron
RUN apt-get --assume-yes install vim
RUN apt-get clean

COPY ./bin/restore_db.sh /scripts/
RUN chmod 744 /scripts/restore_db.sh
COPY ./bin/backup_db.sh /scripts/
RUN chmod 744 /scripts/backup_db.sh
COPY ./bin/tidy_backups.sh /scripts/
RUN chmod 744 /scripts/tidy_backups.sh

COPY /bin/backup_cron /etc/cron.d/backup_cron
RUN chmod 644 /etc/cron.d/backup_cron