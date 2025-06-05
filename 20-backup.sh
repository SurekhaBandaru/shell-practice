#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #if DAYS are provided that will be considered $3 otherwise 14 days

LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_DIR=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_DIR.log"

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

USAGE() {
    echo -e "$R USAGE:: $N sh 20-backup.sh <source-dir> <destination-dir> <days(optional)>"
}

if [ $# -lt 2 ]; then
    USAGE
fi

#check if directory exists -d <dir>
#below is if dir not exist
if [ ! -d $SOURCE_DIR ]; then
    echo -e "$R source directory $SOURCE_DIR does not exist, please check $N"
    exit 1
fi

if [ ! -d $DEST_DIR ]; then
    echo -e "$R destination directory $DEST_DIR does not exist, please check $N"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

if [ ! -z "$FILES" ]; then
    echo "Files to zip are: $FILES"
    TIME_STAMP=$(date +%F-%H-%M-%S)
    ZIP_FILE="$DEST_DIR/app-logs-$TIME_STAMP.zip"
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ "$ZIP_FILE"

    if [ -f $ZIP_FILE ]; then
        echo -e "$Y Successfully created Zip file in $DEST_DIR $N"
        while IFS= read -r filepath; do
            echo "Deleting file: $filepath" | tee -a $LOG_FILE
            rm -rf $filepath
        done <<< $FILES
        echo -e "Log files older than $DAYS from source directory removed ... &G SUCCESS $N"
    else
        echo -e "$R FAILURE $N.... Zip file is not created"

    fi
else
    echo -e "No log files found older than 14 days ... $Y SKIPPING $N"
fi
