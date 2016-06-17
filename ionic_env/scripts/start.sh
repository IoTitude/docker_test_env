#!/bin/bash
echo 'Cloning Instapp repo...'
git clone https://github.com/IoTitude/Instapp.git  /usr/src/Instapp
cd /usr/src/Instapp
git fetch --tags
latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
git checkout $latestTag
echo 'Starting Instapp' $latestTag
sh /usr/src/scripts/instapp.sh
