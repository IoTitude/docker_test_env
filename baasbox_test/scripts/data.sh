#!/bin/bash
BBsession=""
echo $BBsession
length=${#BBsession}
echo $length
url="localhost:9000"
echo $url

# Login loop
while test $length -eq 0
do
curl http://$url/login     -d "username=admin"    -d "password=admin"    -d "appcode=1234567890"  > output.txt
sed -i -n -e 's/.*X-BB-SESSION":"//p' output.txt
sed -it -n -e 's/ *".*//p' output.txt
BBsession=$(cat output.txt)
length=${#BBsession}
echo $BBsession
sleep 2
done

# Admin collection
curl -X POST http://$url/admin/collection/Admin \
     -H X-BB-SESSION:$BBsession

curl -X POST http://$url/document/Admin \
     -d '{"hash": "re/he8CmJGoDDitu4mmaF9SnD/Q="}' \
     -H Content-type:application/json \
     -H X-BB-SESSION:$BBsession


# Device collection
curl -X POST http://$url/admin/collection/Device \
     -H X-BB-SESSION:$BBsession

curl -X POST http://$url/document/Device \
     -d '{ "mac": "40-A8-F0-66-89-04", "hash": "3tP9bqWaoTKYYIuGU8O9jZPi0fk="}' \
     -H Content-type:application/json \
     -H X-BB-SESSION:$BBsession

curl -X POST http://$url/document/Device \
     -d '{  "mac": "02-42-AC-11-00-02",  "hash": "o7cHH4e7ojrbUTOsW2T8iRZxww0="}' \
     -H Content-type:application/json \
     -H X-BB-SESSION:$BBsession

curl -X POST http://$url/document/Device \
     -d '{  "mac": "02-42-AC-11-00-04",  "hash": "cDMlvpVQLc84NtrPc1YFQS8jINw="}' \
     -H Content-type:application/json \
     -H X-BB-SESSION:$BBsession

curl -X POST http://$url/document/Device \
     -d '{  "mac": "B8-27-EB-A2-C3-12",  "hash": "/0QALDuCQFRzm6mDmShCWGewkww="}' \
     -H Content-type:application/json \
     -H X-BB-SESSION:$BBsession


# Master collection
curl -X POST http://$url/admin/collection/Master \
     -H X-BB-SESSION:$BBsession

curl -X POST http://$url/document/Master \
     -d '{  "mac": "00-00-00-00-00-01",  "hash": "hash-for-kaa",  "installer": "name-of-installer",  "address": "location-of-installation",  "location": {    "long": "longitude",    "lat": "latitude"  },  "enabled": false,  "status": 1,  "sensors": {},  "installationDate": "date-of-installation",  "sensorHeight": 0,  "swVersion": "version-of-current-software",  "activeProfile": "joku rofiili"}' \
     -H Content-type:application/json \
     -H X-BB-SESSION:$BBsession

curl -X POST http://$url/document/Master \
     -d '{  "mac": "00-00-00-00-00-02",  "hash": "hash-for-kaa",  "installer": "name-of-installer",  "address": "location-of-installation",  "location": {    "long": "longitude",    "lat": "latitude"  },  "enabled": false,  "status": 1,  "sensors": {},  "installationDate": "date-of-installation",  "sensorHeight": 0,  "swVersion": "version-of-current-software",  "activeProfile": "joku rofiili"}' \
     -H Content-type:application/json \
     -H X-BB-SESSION:$BBsession

curl -X POST http://$url/document/Master \
     -d '{  "mac": "00-00-00-00-00-03",  "hash": "hash-for-kaa",  "installer": "name-of-installer",  "address": "location-of-installation",  "location": {    "long": "longitude",    "lat": "latitude"  },  "enabled": false,  "status": 1,  "sensors": {},  "installationDate": "date-of-installation",  "sensorHeight": 0,  "swVersion": "version-of-current-software",  "activeProfile": "joku rofiili"}' \
     -H Content-type:application/json \
     -H X-BB-SESSION:$BBsession

curl -X POST http://$url/document/Master \
     -d '{  "mac": "00-00-00-00-00-04",  "hash": "hash-for-kaa",  "installer": "name-of-installer",  "installationDate": "date-of-installation",  "address": "location-of-installation",  "location": {    "long": "longitude",    "lat": "latitude"  },  "sensorHeight": 0,  "enabled": true,  "status": 1,  "swVersion": "version-of-current-software",  "sensors": {},  "activeProfile": "joku rofiili"}' \
     -H Content-type:application/json \
     -H X-BB-SESSION:$BBsession

# Profile collection
curl -X POST http://$url/admin/collection/Profile \
     -H X-BB-SESSION:$BBsession

curl -X POST http://$url/document/Profile \
     -d '{  "name": "Water level",  "profileId": "2"}' \
     -H Content-type:application/json \
     -H X-BB-SESSION:$BBsession

curl -X POST http://$url/document/Profile \
     -d '{  "name": "Water flow",  "profileId": "1"}' \
     -H Content-type:application/json \
     -H X-BB-SESSION:$BBsession

# Version collection
curl -X POST http://$url/admin/collection/Version \
     -H X-BB-SESSION:$BBsession

curl -X POST http://$url/document/Version \
     -d '{  "number": "0.4.2"}' \
     -H Content-type:application/json \
     -H X-BB-SESSION:$BBsession

curl -X POST http://$url/document/Version \
     -d '{   "number": "0.4.4"}' \
     -H Content-type:application/json \
     -H X-BB-SESSION:$BBsession

curl -X POST http://$url/document/Version \
     -d '{   "number": "0.4.6"}' \
     -H Content-type:application/json \
     -H X-BB-SESSION:$BBsession
