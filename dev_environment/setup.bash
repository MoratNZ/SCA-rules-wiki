if [ -f .env ]; then
    echo ".env file already exists. Skipping copy."
else
    echo "Copying example.env to .env"
    cp example.env .env
fi

if [ -d context/images ]; then
    echo "Images directory already exists. Skipping extraction."
else
    echo "Extracting images from image_backups/latest.tar.gz"
    cd context
    mkdir -p images
    tar -xvf image_backups/latest.tar.gz images/
fi
