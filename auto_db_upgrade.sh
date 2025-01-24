#!/bin/bash

###################
# Author: Nisarg
# Date: 24/01/2025
#
# This script Automate the Database Upgrade
#
# Version: v1
###################
# Variables

DB_NAME="your_database_name"
DB_USER="your_database_user"
DB_PASS="your_database_password"
DB_HOST="localhost"
BACKUP_DIR="/path/to/backup"
UPGRADE_SCRIPT="/path/to/upg_script.sh"
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
BACKUP_FILE="$BACKUP_DIR/$DB_NAME-backup-$TIMESTAMP.sql"
LOG_FILE="$BACKUP_DIR/upgrade_log_$TIMESTAMP.log"

#function
function log_message {
	echo "[$(date "+%Y-%m-%d %H-%M-%S")] $1" | tee -a "$LOG_FILE"
}

#first take backup of current database
log_message "Starting database backup..."
mysqldump -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_FILE"
if [ $? -eq 0 ]; then
    log_message "Database backup successful: $BACKUP_FILE"
else
    log_message "Database backup failed!"
    exit 1
fi

#Apply the upgrade script
log_message "Verify the database upgrade..."
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < "$UPGRADE_SCRIPT"
if [ $? -eq 0 ]; then
    log_message "Upgrade script applied successfully."
else
    log_message "Upgrade script failed!"
    exit 1
fi

#verify logic
VERIFICATION_QUERY="SELECT COUNT(*) FROM upgraded_table;"
VERIFICATION_RESULT=$(mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" -e "$VERIFICATION_QUERY" "$DB_NAME" | tail -n 1)

if [ "$VERIFICATION_RESULT" -gt 0 ]; then
    log_message "Verification successful. Database upgrade complete."
else
    log_message "Verification failed. Check the upgrade process."
    exit 1
fi

#completion
log_message "Database upgrade process completed successfully."
exit 0



