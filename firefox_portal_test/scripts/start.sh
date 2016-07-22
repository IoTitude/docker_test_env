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
mkdir -p /home/root/test
cd /home/root/test
git init
git remote add -f origin https://github.com/IoTitude/portal_tests.git
git config core.sparseCheckout true
echo "robot-framework/" >> .git/info/sparse-checkout
git pull origin master
echo 'Starting robot tests...'
cd /home/root/test/robot-framework
testList=$(awk '/firefox/,/@@@/{if ($0!="@@@" && $2!="firefox"){print}}' tests.txt)
# test connection loop
success=""
length=${#success}
while test $length -eq 0
do
echo "Waiting for Portal..."
success=$(curl -s --head http://localhost:3000/ | head -n 1 | grep "HTTP/1.[01] [23]..")
length=${#success}
echo $success
sleep 5
done
# test Baasbox loop
success=""
length=${#success}
while test $length -eq 0
do
echo "Waiting for Baasbox..."
success=$(curl -s --head http://localhost:9000/ | head -n 1 | grep "HTTP/1.[01] [23]..")
length=${#success}
echo $success
sleep 5
done
robot $testList
echo 'Copying test results...'
mv /home/root/test/robot-framework/log.html /var/jenkins_home/volume/log.html
mv /home/root/test/robot-framework/output.xml /var/jenkins_home/volume/output.xml
mv /home/root/test/robot-framework/report.html /var/jenkins_home/volume/report.html
