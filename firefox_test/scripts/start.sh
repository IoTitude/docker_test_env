#!/bin/bash
set -e
date
# firefox -version
firefox --version 2>/dev/null
echo 'Starting Xvfb ...'
export DISPLAY=:99
2>/dev/null 1>&2 Xvfb :99 -shmem -screen 0 1366x768x16 &
exec "$@"
echo 'Cloning test repo...'
git clone https://github.com/IoTitude/instapp_firefox_tests.git  /home/root/test
echo 'Starting robot tests...'
testList=$(cat /home/root/test/tests.txt)
cd /home/root/test
robot $testList
mv /home/root/test/log.html /home/root/volume
mv /home/root/test/output.xml /home/root/volume
mv /home/root/test/report.html /home/root/volume
