#!/bin/bash
set +e
date
# firefox -version
firefox --version 2>/dev/null
echo 'Starting Xvfb ...'
export DISPLAY=:99
2>/dev/null 1>&2 Xvfb :99 -shmem -screen 0 1366x768x16 &
exec "$@"
echo 'Cloning test repo...'
mkdir /home/root/test
cd /home/root/test
git init
git remote add -f origin https://github.com/IoTitude/instapp_tests.git
git config core.sparseCheckout true
echo "robot-framework/" >> .git/info/sparse-checkout
git pull origin master
echo 'Starting robot tests...'
testList=$(awk '$0~//{ if ($2=="chrome") {f=1}; if ($0=="@@@" && f==1) {exit}; if ($2!="chrome" && f==1) {print} }' tests.txt)
cd /home/root/test
robot $testList
echo 'Copying test results...'
mv /home/root/test/log.html /var/jenkins_home/volume/log.html
mv /home/root/test/output.xml /var/jenkins_home/volume/output.xml
mv /home/root/test/report.html /var/jenkins_home/volume/report.html
