# SCA-rules-wiki
A containerised solution for deploying a MediaWiki instance customised for SCA combat rules.

## Getting Started
### Install Docker
If you don't already have it

### Create mediawiki container image
```docker build -t sca-rules-wiki:latest mediawiki/```

### Create mysql container image
```docker build -t sca-rules-db:latest database/```

### Create a context directory
This is a dir to persist database dumps and image files.

Pick a location, create a directory with ```images/``` and ```db_dump``` subdirectories, and reach out to David to get the content to stick in there.

In the fullness of time, we won't need an out of band distribution of seed images & db, but I haven't yet created a clean (secret free) base DB dump

### Create a .env file
```cp example.env .env```
Edit ```.env``` in your favourite editor, and replace the ```{placeholders}``` wit appropriate values.

### Start containers
``` docker compose up ```

### Access the wiki
Go to ```http://localhost``` from your preferred web browser

## Contributing
Um, like, ping me, I guess
