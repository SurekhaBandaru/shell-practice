#!/bin/bash

#get disk usage without header
DISK_USAGE=$(df -hT | grep -v Filesystem)
DISK_THRESHOLD=1 #usually be 75 in real projects
MSG=""

#space must be there after IFS=
while IFS= read line
do
USAGE=$(echo $line | awk '{print $6F}' | cut -d "%" -f1) #get the Use% column (without header) and without %
PARTITION=$(echo $line | awk '{print $7F}') #get the Filesytem column where we can see at which location this memory used
if [ $DISK_USAGE -ge $DISK_THRESHOLD ]
then
$MSG="High disk usage on $PARTITION: $USAGE"
fi 
echo "$MSG"
done <<< $DISK_USAGE