#!/bin/bash

USERID=$(id -u)

if[ $USERID -ne 0 ]
    echo "ERROR:: Please run the script with root access"
    exit 1 # give other than 0 till 127
else
    echo "You are running with root access"
fi

dnf install mysql -y

if [ $? -eq 0 ]
then 
    echo "Installing mysql is ... SUCCESS"
else
    echo "Instlling mysql is a "FAILURE"
    exit 1
fi
