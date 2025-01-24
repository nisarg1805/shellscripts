#!/bin/bash

#####################
# Author: Nisarg
# Date: 24/01/2025
#
# This script for generate alert in slack whenever any service goes down in system
#
# Version: v1
#####################
#Variables

SLACK_WEBHOOKS_URL=" https://address of webhook"
SERVICES=("nginx","mysql","redis")#list services to monitor
CHECK_INTERVAL=60 #time in seconds between check

#function to send alert
send_slack_alert() {
	local service_name=$1
	local status=$2

	curl -X POST -H 'Content-type: application/json' --data "{
        \"text\": \" Alert: Service *$service_name* is $status on $(hostname)\"
    }" $SLACK_WEBHOOK_URL
}

# Function to check services
check_services() {
    for service in "${SERVICES[@]}"; do
        if systemctl is-active --quiet "$service"; then
            echo "$(date): $service is running"
        else
            echo "$(date): $service is down"
            send_slack_alert "$service" "DOWN"
        fi
    done
}

# Main loop
while true; do
    check_services
    sleep $CHECK_INTERVAL
done

