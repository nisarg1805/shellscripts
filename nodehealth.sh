#!/bin/bash
###############
# Author: Nisarg
# 
# Date: 24/01/2025
# 
# This script output the node health
# 
# Version: v1
###############

set -x #Debug mode
set -e #exit the script if there is an error
set -o #pipe failed

#set -exo #fipefailed same command

df -h #for printing disk space

free -g #for printing the memory

nproc  #printing the resources

ps -ef | grep amazon | awk -F " " '{print $2}' #printing process ID

ps -ef | grep amazon | awk -F " " '{print $1}' #printing users
