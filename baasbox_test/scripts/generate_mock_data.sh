#!/bin/bash

# This script can generate a set ammount of kamus with random hashes to the database.
# It's not perfect; leading zeros are not printed but this functionality is good enough.
# should look into printf.

BBsession=""
echo $BBsession
length=${#BBsession}
echo $length
url="localhost:9000"
echo $url

# Login loop
echo "Loggin in..."
while test $length -eq 0
do
curl http://$url/login     -d "username=admin"    -d "password=admin"    -d "appcode=1234567890"  > output.txt
sed -i -n -e 's/.*X-BB-SESSION":"//p' output.txt
sed -i -n -e 's/ *".*//p' output.txt
BBsession=$(cat output.txt)
rm output.txt
length=${#BBsession}
echo $BBsession
sleep 2
done

# Creates 20 kamus
for i in {1..20}
do
  RANGE=255
  #set integer ceiling

  number=$RANDOM
  numbera=$RANDOM
  numberb=$RANDOM
  numberc=$RANDOM
  numberd=$RANDOM
  numbere=$RANDOM
  #generate random numbers

  let "number %= $RANGE"
  let "numbera %= $RANGE"
  let "numberb %= $RANGE"
  let "numberc %= $RANGE"
  let "numberd %= $RANGE"
  let "numbere %= $RANGE"
  #ensure they are less than ceiling

  octeta=`echo "obase=16;$number" | bc`
  octetb=`echo "obase=16;$numbera" | bc`
  octetc=`echo "obase=16;$numberb" | bc`
  octetd=`echo "obase=16;$numberc" | bc`
  octete=`echo "obase=16;$numberd" | bc`
  octetf=`echo "obase=16;$numbere" | bc`
  #use a command line tool to change int to hex(bc is pretty standard)
  #they're not really octets.  just sections.

  macadd="${octeta}-${octetb}-${octetc}-${octetd}-${octete}-${octetf}"
  #concatenate values and add dashes

  echo $macadd

  curl -X POST http://$url/document/Master \
       -d '{  "mac": "'"$macadd"'",  "hash": "hash-for-kaa",  "installer": "name-of-installer",  "address": "location-of-installation",  "location": {    "long": "longitude",    "lat": "latitude"  },  "enabled": false,  "status": 1,  "sensors": {},  "installationDate": "date-of-installation",  "sensorHeight": 0,  "swVersion": "version-of-current-software",  "activeProfile": "joku rofiili"}' \
       -H Content-type:application/json \
       -H X-BB-SESSION:$BBsession
done
