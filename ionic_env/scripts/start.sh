#!/bin/bash
echo 'Cloning Instapp repo...'
git clone https://github.com/IoTitude/Instapp.git  /usr/src/Instapp
cd /usr/src/Instapp
git fetch --tags
latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
git checkout $latestTag
sed -i "/BASE_URL/c\  'BASE_URL': 'http://localhost:9100',/" /usr/src/Instapp/www/js/services.js
echo 'Starting Instapp' $latestTag
sh /usr/src/scripts/instapp.sh
