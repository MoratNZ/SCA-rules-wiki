FROM mediawiki:1.43.3

RUN apt-get update && \
    apt-get --assume-yes install weasyprint python3-pypdf python3-lxml fonts-urw-base35 && \
    apt-get clean

WORKDIR /var/www/html/extensions
RUN git clone https://github.com/MoratNZ/MakePdfBook.git && git -C MakePdfBook checkout v3.1.0

COPY ./bin/restore_images.sh /scripts/
RUN chmod 744 /scripts/restore_images.sh
COPY ./bin/backup_images.sh /scripts/
RUN chmod 744 /scripts/backup_images.sh
COPY ./bin/startup.sh /scripts/
RUN chmod 744 /scripts/startup.sh


WORKDIR /var/www/html

ENTRYPOINT [ "/scripts/startup.sh" ]
CMD ["apache2-foreground"]