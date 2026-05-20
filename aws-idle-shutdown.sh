#!/bin/bash
# aws-idle-shutdown.sh
# Powers off the AWS INSTANCE if Minecraft has been stopped for 6 hours.
# This is the "last resort" shutdown to prevent runaway costs.
# Add to crontab: */5 * * * * /home/admin/fabric-server/aws-idle-shutdown.sh >> /var/log/aws-idle-shutdown.log 2>&1

IDLE_FILE="/tmp/aws_idle_count"
MAX_IDLE_CHECKS=72 # 72 checks * 5 mins = 6 hours (360 minutes)

# Check if Minecraft service is running.
if systemctl is-active --quiet minecraft; then
    echo "$(date): Minecraft service is running. Resetting AWS idle counter."
    echo "0" > "$IDLE_FILE"
    exit 0
fi

# Minecraft is NOT running — start counting down to AWS shutdown.
if [ ! -f "$IDLE_FILE" ]; then
    echo "0" > "$IDLE_FILE"
fi

IDLE_COUNT=$(cat "$IDLE_FILE")
IDLE_COUNT=$((IDLE_COUNT + 1))

echo "$(date): Minecraft is offline. AWS idle count: $IDLE_COUNT / $MAX_IDLE_CHECKS"
echo "$IDLE_COUNT" > "$IDLE_FILE"

if [ "$IDLE_COUNT" -ge "$MAX_IDLE_CHECKS" ]; then
    echo "$(date): AWS idle timeout reached (6 hours). Powering off instance."
    rm -f "$IDLE_FILE"
    sudo poweroff
fi
