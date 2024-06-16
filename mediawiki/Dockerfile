FROM mediawiki:1.41

ENV DEBIAN_FRONTEND noninteractive

# We need pandoc for html > tex > pdf conversion in MakePdfBook
RUN apt-get --assume-yes --no-install-recommends install pandoc
RUN apt-get --assume-yes --no-install-recommends install texlive-latex-base 
RUN apt-get --assume-yes --no-install-recommends install texlive-latex-extra
RUN apt-get --assume-yes --no-install-recommends install texlive-fonts-recommended
RUN apt-get --assume-yes --no-install-recommends install texlive-fonts-extra
RUN apt-get --assume-yes --no-install-recommends install cron
RUN apt-get clean

WORKDIR /var/www/html/extensions
RUN git clone https://github.com/MoratNZ/MakePdfBook.git && git clone https://github.com/DavisNT/ExternalRedirect.git 

COPY --chmod 744 \
  ./bin/backup_images.sh \
  ./bin/restore_images.sh \
  ./bin/startup.sh \
  ./bin/tidy_backups.sh \
  /scripts/
  
COPY --chmod 600 /bin/crontab /etc/crontab



WORKDIR /var/www/html

ENTRYPOINT [ "/scripts/startup.sh" ]
CMD ["apache2-foreground"]
