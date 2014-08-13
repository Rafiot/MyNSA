#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Basename required."
    exit 1
fi

BASENAME=${1}


fuser_out=$( { fuser ${BASENAME}* ; } 2>&1 )

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for temp in ${fuser_out}; do
    f=`echo ${temp} | cut -d":" -f 1 | tr -d ' '`
    pid=`echo ${temp} | cut -d":" -f 2 | tr -d ' '`
    if [ -z $pid ]; then
        dir=$( { echo ${f} | sed -E 's/^laptop_.*_([0-9]{4})([0-9]{2})([0-9]{2}).*\.cap$/history\/\1\2\3\//' ; } )
        mkdir -p ${dir}
        mv ${f} ${dir}
    fi
done
IFS=$SAVEIFS

