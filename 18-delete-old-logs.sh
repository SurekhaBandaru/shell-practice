#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

SOURCE_DIR="/home/ec2-user/app-logs"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_DIR=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_DIR.log"
FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +14)

mkdir -p $LOGS_FOLDER
echo "Script started executing at : $(date)" | tee -a $LOG_FILE

#Check if user has root access
if [ $USERID -ne 0 ]; then
    echo -e "$R ERROR:: Please run the script with sudo access $N" | tee -a $LOG_FILE
    exit 1
else
    echo -e "$Y You are running with root access $N" | tee -a $LOG_FILE
fi

VALIDATE() {
    if [ $1 -eq 0 ]; then
        echo -e "$2 is ..... $G SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e "$2 is ...... $R FAILURE $N" | tee -a $LOG_FILE
        exit 1
    fi
}

while IFS= read -r filepath; do
    echo "Deleting file: $filepath" | tee -a $LOG_FILE
    rm -rf $filepath
done <<<$FILES_TO_DELETE

echo "Script executed successfully"
