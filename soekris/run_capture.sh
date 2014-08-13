#!/bin/bash

BASENAME=${1}

tshark -B 50 -i vr1 -i vr2 -b duration:600 -n -s 0 -w ${BASENAME}.cap
