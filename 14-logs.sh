#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_DIR="/var/log/shellscript-logs"
# command to split and get just files name excluding .sh is
# echo 14-logs.sh | cut -d "." -f1
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE=$LOG_DIR/$SCRIPT_NAME.log

mkdir -p $LOG_DIR

echo "Script started, executing at: $(date)" &>>$LOG_FILE 

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR:: Please run the script with root access $N" &>>$LOG_FILE 
    exit 1 # give other than 0 till 127
else
    echo  -e "$G You are running with root access $N" &>>$LOG_FILE 
fi

VALIDATE () {

if [ $1 -eq 0 ] #if the installation is success
#here $1 is first param (exit status $?), $2 is second param (software name)
    then 
         echo -e "Installing $2 is ... $G SUCCESS $N" &>>$LOG_FILE 
    else
         echo -e "Installing $2 is a .... $R FAILURE $N" &>>$LOG_FILE 
        exit 1
    fi
}

#mysql
#check already got installed or not with dnf list installed mysql
dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "Not installed....Going to install MySQL" &>>$LOG_FILE
    dnf install mysql -y &>>$LOG_FILE
   VALIDATE $? "MySQL"

else
    echo -e "$Y Already Mysql was installed $N" &>>$LOG_FILE 
fi

#python
dnf list installed python3

if [ $? -ne 0 ]
then
    echo "Not installed....Going to install python3" &>>$LOG_FILE
    dnf install python3 -y &>>$LOG_FILE

   VALIDATE $? "Python3"

else
    echo -e "Nothing to do, $Y already python3 was installed $N" &>>$LOG_FILE
fi

#Nginx
dnf list installed nginx

if [ $? -ne 0 ]
then
    echo "Not installed....Going to install nginx" &>>$LOG_FILE
    dnf install nginx -y &>>$LOG_FILE

   VALIDATE $? "Nginx"

else
    echo -e "Nothing to do, $Y already Nginx was installed $N" &>>$LOG_FILE 
fi
