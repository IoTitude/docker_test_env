#!/bin/bash
mkdir -p /usr/src/baasbox/db/baasbox
echo "Copying plugins..."

mv /usr/src/baasbox/files/_bb_script.cpm /usr/src/baasbox/db/baasbox/_bb_script.cpm
mv /usr/src/baasbox/files/_bb_script.pcl /usr/src/baasbox/db/baasbox/_bb_script.pcl
mv /usr/src/baasbox/files/_BB_Script.name.sbt /usr/src/baasbox/db/baasbox/_BB_Script.name.sbt
mv /usr/src/baasbox/files/baasbox.0.wal /usr/src/baasbox/db/baasbox/baasbox.0.wal

/usr/src/baasbox/scripts/data.sh & /usr/src/baasbox/start


