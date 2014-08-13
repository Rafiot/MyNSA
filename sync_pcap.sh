#!/bin/bash

set -e
#set -x

rsync --partial --progress --rsh=ssh --bwlimit=500 -a root@172.16.100.127:/root/pcap/history .


HOME_DIR=`pwd`

paths=$( { find history/ -name *.cap | sort ; } )

if [ -a most_recent ]; then
    most_recent=$( { cat most_recent | cut -d"_" -f 3 | cut -d"." -f 1 ; } )
else
    most_recent=0
fi

rm -f to_import

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for path in ${paths}; do
    timestamp=$( { echo ${path} | cut -d"_" -f 3 | cut -d"." -f 1 ;} )
    if [ $most_recent -eq 0 ]; then
        echo "pcap-file ${HOME_DIR}/${path} ${HOME_DIR}/log/" >> to_import
        echo -n ${path} > most_recent
    elif [ ${timestamp} -gt ${most_recent} ]; then
        echo "pcap-file ${HOME_DIR}/${path} ${HOME_DIR}/log/" >> to_import
        echo -n ${path} > most_recent
    fi
done

IFS=$SAVEIFS

if [ -e to_import ]; then
    cat to_import | suricatasc
fi
