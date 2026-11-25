FROM  docker.io/library/mediawiki:1.46.2

RUN apt-get update && \
    apt-get --assume-yes install weasyprint python3-pypdf python3-lxml fonts-urw-base35 && \
    apt-get clean

WORKDIR /var/www/html/extensions
RUN git clone https://github.com/MoratNZ/MakePdfBook.git && git -C MakePdfBook checkout v4.1.0

WORKDIR /var/www/html

CMD ["apache2-foreground"]
