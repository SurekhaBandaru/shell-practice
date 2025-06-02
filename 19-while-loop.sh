#!/bin/bash


#Ctlc+c to comment
# a=0

# while [ $a -lt 10 ]
# do
#     echo $a
#     a=`expr $a + 1`
# done

#Here IFS is used to separate line by line, -r is to read special characters as well
#IFS -> Internal field separator
#the following loop will take input from 17-set.sh and reads line by line and prints everything starting from bin bash command
while IFS= read -r line 
do
    echo $line 
done < 17-set.sh