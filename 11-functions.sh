#!/bin/bash
USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR:: Please run the script with root access"
    exit 1 # give other than 0 till 127
else
    echo "You are running with root access"
fi

VALIDATE () {

if [ $1 -eq 0 ] #if the installation is success
#here $1 is first param (exit status), $2 is second param (software name)
    then 
        echo "Installing $2 is ... SUCCESS"
    else
         echo "Installing $2 is a .... FAILURE"
        exit 1
    fi
}

#mysql
dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "Not installed....Going to install MySQL"
    dnf install mysql -y
   VALIDATE $? "MySQL"

else
    echo "Already Mysql was isntalled, nothing to do"
fi

#python
dnf list installed python3

if [ $? -ne 0 ]
then
    echo "Not installed....Going to install python3"
    dnf install python3 -y

   VALIDATE $? "Python3"

else
    echo "Already python3 was isntalled, nothing to do"
fi

#Nginx
dnf list installed nginx

if [ $? -ne 0 ]
then
    echo "Not installed....Going to install nginx"
    dnf install nginx -y

   VALIDATE $? "Nginx"

else
    echo "Already Nginx was isntalled, nothing to do"
fi
