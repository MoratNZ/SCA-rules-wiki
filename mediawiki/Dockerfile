FROM mediawiki:1.41

# We need pandoc for html > tex > pdf conversion in MakePdfBook
RUN apt-get --assume-yes install pandoc
RUN apt-get --assume-yes install texlive-latex-base 
RUN apt-get --assume-yes install texlive-latex-extra
RUN apt-get --assume-yes install texlive-fonts-recommended
RUN apt-get --assume-yes install texlive-fonts-extra
RUN apt-get --assume-yes install cron
RUN apt-get clean

WORKDIR /var/www/html/extensions
RUN git clone https://github.com/MoratNZ/MakePdfBook.git && git clone https://github.com/DavisNT/ExternalRedirect.git 

COPY ./bin/restore_images.sh /scripts/
RUN chmod 744 /scripts/restore_images.sh
COPY ./bin/backup_images.sh /scripts/
RUN chmod 744 /scripts/backup_images.sh
COPY ./bin/tidy_backups.sh /scripts/
RUN chmod 744 /scripts/tidy_backups.sh
COPY ./bin/startup.sh /scripts/
RUN chmod 744 /scripts/startup.sh
COPY /bin/crontab /etc/crontab
RUN chmod 600 /etc/crontab



WORKDIR /var/www/html

ENTRYPOINT [ "/scripts/startup.sh" ]
CMD ["apache2-foreground"]