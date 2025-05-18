#!/bin/bash

NUMBER1=100
NUMBER2=220
TIMESTAMP=$(date)
echo "Script executed at: $TIMESTAMP"

SUM=$((NUMBER1+NUMBER2))

echo "$NUMBER1 and $NUMBER2 is: " $SUM