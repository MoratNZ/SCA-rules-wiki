This directory contains the minimum requirements for spinning up a wiki instance. 

Copy it to outside the repository, then copy the example .env file `cp example.env .env` and edit `.env`
to fill in more appropriate values.

This is currently using a private repo for the images, so you'll need to do a `docker login` before running `docker compose up`