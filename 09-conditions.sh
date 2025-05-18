#!/bin/bash

NUMBER=$1 #take first variable entered on cmd

# -gt
#-lt
#-eq
#-ne

if [ $NUMBER -lt 10 ]
then
    echo "Given Number $NUMBER is less than 10"
else
    echo "Given Number $NUMBER is not less than 10"
fi