#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR:: Please run the script with root access $N"
    exit 1 # give other than 0 till 127
else
    echo  -e "$G You are running with root access $N"
fi

VALIDATE () {

if [ $1 -eq 0 ] #if the installation is success
#here $1 is first param (exit status $?), $2 is second param (software name)
    then 
         echo -e "Installing $2 is ... $G SUCCESS $N"
    else
         echo -e "Installing $2 is a .... $R FAILURE $N"
        exit 1
    fi
}

#mysql
#check already got installed or not with dnf list installed mysql
dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "Not installed....Going to install MySQL"
    dnf install mysql -y
   VALIDATE $? "MySQL"

else
    echo -e "$Y Already Mysql was installed $N"
fi

#python
dnf list installed python3

if [ $? -ne 0 ]
then
    echo "Not installed....Going to install python3"
    dnf install python3 -y

   VALIDATE $? "Python3"

else
    echo -e "Nothing to do, $Y already python3 was installed $N"
fi

#Nginx
dnf list installed nginx

if [ $? -ne 0 ]
then
    echo "Not installed....Going to install nginx"
    dnf install nginx -y

   VALIDATE $? "Nginx"

else
    echo -e "Nothing to do, $Y already Nginx was isntalled $N"
fi
