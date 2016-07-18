#!/bin/bash
echo 'Cloning Portal repo...'
git clone https://github.com/IoTitude/Portal.git  /usr/src/Portal
cd /usr/src/Portal
git fetch --tags
latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
#git checkout $latestTag
sed -i "/baseUrl = /c\  baseUrl = 'http://localhost:9000'" /usr/src/Portal/app/services/baasbox.service.ts
echo 'Starting Portal' $latestTag
npm install --unsafe-perm=true
npm start
