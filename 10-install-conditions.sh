#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR:: Please run the script with root access"
    exit 1 # give other than 0 till 127
else
    echo "You are running with root access"
fi

#whehter mysq already installed using

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "Not installed....Going to install MySQL"
    dnf install mysql -y

   if [ $? -eq 0 ] #if the installation is success
        then 
        echo "Installing mysql is ... SUCCESS"
    else
         echo "Installing mysql is a .... FAILURE"
        exit 1
    fi

else
    echo "Already Mysql was isntalled, nothing to do"
fi



