#!/bin/bash

echo "All variables passed to the script: $@"
echo "Number of varables passed to script: $#"
echo "Current script name: $0"
echo "Present working directory: $PWD"
echo "Home directory of the user who is running the script: $HOME"
echo "Which usee is running the script: $USER"
echo "PID of current script: $$"
sleep 50 &
echo "PID of last command running in background: $!"