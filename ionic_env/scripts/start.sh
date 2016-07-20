#!/bin/bash
echo 'Cloning Instapp repo...'
git clone https://github.com/IoTitude/Instapp.git  /usr/src/Instapp
cd /usr/src/Instapp
git fetch --tags
latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
git checkout $latestTag
source setup.sh
sed -i "/BASE_URL/c\ 'BASE_URL': 'http://localhost:9000'," /usr/src/Instapp/www/js/baasbox/baasbox.config.js
gulp minjs
echo 'Starting Instapp' $latestTag
ionic serve --all --nobrowser --nolivereload --port=8100 
