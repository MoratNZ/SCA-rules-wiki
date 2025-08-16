FROM mediawiki:1.43.3

# we need inkscape for image conversion in MakePdfBook
# we need pandoc for html > tex > pdf conversion in MakePdfBook
RUN apt-get update && \
    apt-get --assume-yes install inkscape && \
    apt-get --assume-yes install pandoc && \
    apt-get --assume-yes install texlive-latex-base && \
    apt-get --assume-yes install texlive-latex-extra && \
    apt-get --assume-yes install texlive-fonts-recommended && \
    apt-get --assume-yes install texlive-fonts-extra && \
    apt-get clean

WORKDIR /var/www/html/extensions
RUN git clone https://github.com/MoratNZ/MakePdfBook.git && git -C MakePdfBook checkout v2.4.9

COPY ./bin/restore_images.sh /scripts/
RUN chmod 744 /scripts/restore_images.sh
COPY ./bin/backup_images.sh /scripts/
RUN chmod 744 /scripts/backup_images.sh
COPY ./bin/startup.sh /scripts/
RUN chmod 744 /scripts/startup.sh


WORKDIR /var/www/html

ENTRYPOINT [ "/scripts/startup.sh" ]
CMD ["apache2-foreground"]