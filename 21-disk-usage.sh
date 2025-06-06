#!/bin/bash

#get disk usage without header
DISK_USAGE=$(df -hT | grep -v Filesystem)
DISK_THRESHOLD=1 #usually be 75 in real projects
MSG=""
IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4) #to get private ip

#space must be there after IFS=
while IFS= read line; do
    USAGE=$(echo $line | awk '{print $6F}' | cut -d "%" -f1) #get the Use% column (without header) and without %
    PARTITION=$(echo $line | awk '{print $7F}')              #get the Filesytem column where we can see at which location this memory used
    if [ $USAGE -ge $DISK_THRESHOLD ]; then
    #hre + is to append to existing MSG, if not it is printing only last line
        #MSG+="High disk usage on $PARTITION: $USAGE \n" #\n i snew line in linux

         MSG+="High disk usage on $PARTITION: $USAGE <br>" #here we need to split by new line in html so, user <br>
    fi
    
done <<< $DISK_USAGE
#echo -e "$MSG"
#sometimes we need to put variables in "" "$IP"
sh mail.sh "Developers team" "High Disk Usage" "$IP" "$MSG" "surekhagidithuri@gmail.com" "ALERT-High Disk Usage"
