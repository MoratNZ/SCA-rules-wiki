FROM mysql:8.0-debian

RUN apt-get update
RUN apt-get clean

COPY ./bin/restore_db.sh /scripts/
RUN chmod 744 /scripts/restore_db.sh
COPY ./bin/backup_db.sh /scripts/
RUN chmod 744 /scripts/backup_db.sh
COPY ./bin/startup.sh /scripts/
RUN chmod 744 /scripts/startup.sh
COPY ./bin/bootstrap.sh /docker-entrypoint-initdb.d/
RUN chmod 744 /docker-entrypoint-initdb.d/bootstrap.sh
# This stanza is a hack to allow us to call the elaborate mysqld entrypoint
# script from another script. 
# I hope there is a better way.
RUN cp /entrypoint.sh /entrypoint.sh.bak
RUN head -n -3 /entrypoint.sh.bak > /entrypoint.sh
RUN echo '_main mysqld' >> /entrypoint.sh
RUN chmod 755 /entrypoint.sh
# End filthy hack


ENTRYPOINT [ "/scripts/startup.sh" ]
