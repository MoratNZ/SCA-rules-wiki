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
COPY ./bin/startup.sh /scripts/
RUN chmod 744 /scripts/startup.sh
COPY /bin/crontab /etc/crontab
RUN chmod 600 /etc/crontab

# This stanza is a hack to allow us to call the elaborate mysqld entrypoint
# script from another script. 
# I hope there is a better way.
RUN cp /entrypoint.sh /entrypoint.sh.bak
RUN head -n -3 /entrypoint.sh.bak > /entrypoint.sh
RUN echo '_main mysqld' >> /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT [ "/scripts/startup.sh" ]
