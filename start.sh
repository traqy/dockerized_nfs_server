#!/bin/bash
set -e

DOCKERNAME=acme-oss-nfs-server
SCRIPTPATH=`pwd`

echo $SCRIPTPATH

ipv4_regex="([0-9]{1,3}[\.]){3}[0-9]{1,3}"

docker run -d --net acme-su-net --ip 172.18.0.2 --name ${DOCKERNAME} --privileged traqy/${DOCKERNAME} $@

nfsip=`docker inspect ${DOCKERNAME} | grep -iw ipaddress | grep -Eo $ipv4_regex`

# Source the script to populate MYNFSIP env var
export MYNFSIP=$nfsip

echo "Nfs Server IP: "$MYNFSIP
