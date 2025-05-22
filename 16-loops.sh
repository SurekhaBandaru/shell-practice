#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
PACKAGES=("mysql" "python3" "nginx")

LOG_DIR="/var/log/shellscript-logs"
# command to split and get just files name excluding .sh is
# echo 14-logs.sh | cut -d "." -f1
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE=$LOG_DIR/$SCRIPT_NAME.log

mkdir -p $LOG_DIR
# | tee -a $LOG_FILE  -- to display on the screen as well as in log file
echo "Script started, executing at: $(date)"  | tee -a $LOG_FILE 

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR:: Please run the script with root access $N" | tee -a $LOG_FILE
    exit 1 # give other than 0 till 127
else
    echo  -e "$G You are running with root access $N"  | tee -a $LOG_FILE
fi
  

VALIDATE () {

if [ $1 -eq 0 ] #if the installation is success
#here $1 is first param (exit status $?), $2 is second param (software name)
    then 
         echo -e "Installing $2 is ... $G SUCCESS $N" | tee -a $LOG_FILE 
    else
         echo -e "Installing $2 is a .... $R FAILURE $N" | tee -a $LOG_FILE
        exit 1
    fi
}

# this is for sending from here in the script for package in ${PACKAGES[@]}

for package $@
    do  
        dnf list installed $package &>>$LOG_FILE
        if [ $? -ne 0 ]
        then
            echo "$package Not installed....Going to install it" | tee -a $LOG_FILE
            dnf install $package -y &>>$LOG_FILE
            VALIDATE $? "$package"

        else
            echo -e "Nothing to do ... $Y Already $package was installed $N" | tee -a $LOG_FILE
        fi 
done
