#!/bin/bash
# idle-shutdown.sh
# Script to shut down the AWS instance if no players are online for 15 minutes.
# Add to crontab: */5 * * * * /home/admin/idle-shutdown.sh >> /var/log/idle-shutdown.log 2>&1

IDLE_FILE="/tmp/minecraft_idle_count"
MAX_IDLE_CHECKS=48 # 48 checks * 5 mins = 4 hours (240 minutes)

# Check active connections on port 25565.
# If players are connected, port 25565 will have ESTABLISHED connections.
CONNECTIONS=$(ss -tn state established \'( dport = :25565 or sport = :25565 )\' | wc -l)
# ss outputs a header line, so if no connections, wc -l is 1. If 1 connection, wc -l is 2.

if [ "$CONNECTIONS" -gt 1 ]; then
    echo "$(date): Players are connected. Resetting idle counter."
    echo "0" > "$IDLE_FILE"
else
    # No players connected
    if [ ! -f "$IDLE_FILE" ]; then
        echo "0" > "$IDLE_FILE"
    fi
    
    IDLE_COUNT=$(cat "$IDLE_FILE")
    IDLE_COUNT=$((IDLE_COUNT + 1))
    
    echo "$(date): Server is idle. Idle count: $IDLE_COUNT / $MAX_IDLE_CHECKS"
    echo "$IDLE_COUNT" > "$IDLE_FILE"
    
    if [ "$IDLE_COUNT" -ge "$MAX_IDLE_CHECKS" ]; then
        echo "$(date): Idle timeout reached. Shutting down server."
        sudo poweroff
    fi
fi
