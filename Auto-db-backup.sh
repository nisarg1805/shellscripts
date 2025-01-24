#!/bin/bash

#####################
# Author: Nisarg
# Date: 24/01/2025
#
# This script for Automate database backup & weekly scheduled
#
# Version: v1
#####################
#Variables
set -x

DB_USER="db_user name"
DB_PASSWORD="db password"
DB_HOST="localhost"
BACKUP_DIR="/path/to/backup"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
RETENTION_DAYS=7

#Create backup directory ,if not exists
mkdir -p "$BACKUP_DIR"

#Backup all Databases
BACKUP_FILE="$BACKUP_DIR/all_databases_$DATE.sql"
echo "Starting database backup..."
mysqldump -u "$DB_USER" -p "$DB_PASSWORD" -h "$DB_HOST" --all-databases> "$BACKUP_FILE"

if 

#Remove old Backups
find "$BACKUP_DIR" -type f -mtime +$RETENTION_DAYS -name "*.sql" -exec rm -f {} \;
echo "old backup older than $RETENTION_DAYS days has been removed."

#exit
exit 0
