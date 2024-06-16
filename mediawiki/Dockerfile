# For reference the trail of images goes:
# debian:bookworm-slim used by php:8.1-apache
# php:8.1-apache used by mediawiki:1.4.1
# mediawiki:1.4.1 is used here.
FROM mediawiki:1.41

ENV DEBIAN_FRONTEND noninteractive

# We need pandoc for html > tex > pdf conversion in MakePdfBook
# For the sake of sanity, keep the list of packages sorted.
RUN apt-get -y update && apt-get --assume-yes --no-install-recommends install \
    cron \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-latex-base \
    texlive-latex-extra \
    pandoc && \
    apt-get clean ; rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html/extensions
RUN git clone https://github.com/MoratNZ/MakePdfBook.git && git clone https://github.com/DavisNT/ExternalRedirect.git 

COPY --chmod=744 \
  ./bin/backup_images.sh \
  ./bin/restore_images.sh \
  ./bin/startup.sh \
  ./bin/tidy_backups.sh \
  /scripts/
  
COPY --chmod=600 /bin/crontab /etc/crontab



WORKDIR /var/www/html

ENTRYPOINT [ "/scripts/startup.sh" ]
CMD ["apache2-foreground"]
