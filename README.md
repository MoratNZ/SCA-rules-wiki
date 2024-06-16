# SCA-rules-wiki
A containerised solution for deploying a MediaWiki instance customised for SCA combat rules.

## Getting Started
### Install Docker
If you don't already have it

### Create mediawiki container image
```docker build -t sca-rules-wiki:latest mediawiki/```

### Create mysql container image
```docker build -t sca-rules-db:latest database/```

### Create a context directory (optional)
This is a dir to persist database dumps and image files.
There is a basic / example context dir included in this repository (```context/```). It provides a minimum wiki setup.
This isn't intended to significant use - just for familiarisation. 
If you're going to be actually running this, copy context/ to a location outside the repository. 
**Advanced note:** it's also possible to bootstrap the DB content from scratch. Details below

### Create a .env file
```cp example.env .env```
Edit ```.env``` in your favourite editor, and make any tweaks to it that you prefer. 

### Start the containers
```docker compose up```

### Access the wiki
Go to ```http://localhost``` from your preferred web browser

Log in; the default user name is ```Admin```, password ```Admin``` (you'll get prompted to change this to a password that sucks less on first login)

## Required container environment
For the containers to stand up correctly, they need the following environment (all of this is provided by the included `docker-compose.yml`, its associated `.env` file, and this repo's `context/` directory - this is for documentation purposes):
- sca-rules-wiki
  - Environment variables set on container:
      - SITE_NAME
      - BASE_URL
      - WIKI_EMAIL
      - DB_URL
      - DB_NAME
      - DB_USER
      - DB_PASSWORD
      - DB_SECRET_KEY
      - DB_UPGRADE_KEY
      - BACKUPS_LOCATION
  - Volumes
    - An appropriate `LocalSettings.php` file mounted at`/var/www/html/LocalSettings.php `
    - A directory mounted at `/image_backups` to optionally initialise `/var/www/html/images` from, and to periodically back the contents of `/var/www/html/images` up into.
- sca-rules-db
  - Environment variables set on container:
      - DB_NAME
      - MYSQL_USER
      - MYSQL_PASSWORD
      - MYSQL_ROOT_PASSWORD
      - BACKUPS_LOCATION
  - Volumes
    - A directory mounted at `/db_backups` to initialise the database from, and to back up the datbase to. This needs to contain a valid mysql dump (for the moment; this will hopefully change).

## Contributing
Um, like, ping me, I guess

## Bootstrapping an install from scratch
(These are notes to self)
- run docker-compose from bootstrap directory
- load mediawiki, jump through setup hoops
- run ```scripts/backup.sh```