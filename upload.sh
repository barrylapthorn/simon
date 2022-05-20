#!/usr/bin/env bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR=$THIS_DIR

if [ -z ${FTP_URL+x } ]; then
    echo Please set FTP_URL, e.g. export FTP_URL=ftp.yoursite.com
    exit 1
fi

if [ -z ${FTP_USERNAME+x } ]; then
    echo Please set FTP_USERNAME, e.g. export FTP_USERNAME=you@yoursite.com
    exit 1
fi

if [ -z ${FTP_PASSWORD+x } ]; then
    echo Please set FTP_PASSWORD, e.g. export FTP_PASSWORD=pAssW0rd!
    exit 1
fi

# Must build in root
cd $ROOT_DIR

# Build site into this folder
# hugo -d public_html
make prod

echo Uploading using curl
# Upload it!
find public_html -type f -exec curl -v --user $FTP_USERNAME:$FTP_PASSWORD --ftp-create-dirs -T {} ftp://$FTP_URL/{} \;
# find public -type f -exec curl --silent --user $FTP_USERNAME:$FTP_PASSWORD --ftp-create-dirs -T {} ftp://$FTP_URL/{} \;

echo Uploading using curl finished
