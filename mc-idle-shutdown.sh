#!/bin/bash
# mc-idle-shutdown.sh
# Stops the MINECRAFT SERVER (not the AWS instance) if no players are online for 4 hours.
# Add to crontab: */5 * * * * /home/admin/fabric-server/mc-idle-shutdown.sh >> /var/log/mc-idle-shutdown.log 2>&1

IDLE_FILE="/tmp/mc_idle_count"
MAX_IDLE_CHECKS=48 # 48 checks * 5 mins = 4 hours (240 minutes)

# Check if Minecraft service is actually running before doing anything.
if ! systemctl is-active --quiet minecraft; then
    echo "$(date): Minecraft service is not running. Skipping check."
    rm -f "$IDLE_FILE"
    exit 0
fi

# Check active connections on port 25565.
# ss outputs a header line, so 1 line means no players.
CONNECTIONS=$(ss -tn state established '( dport = :25565 or sport = :25565 )' | wc -l)

if [ "$CONNECTIONS" -gt 1 ]; then
    echo "$(date): Players are connected ($((CONNECTIONS - 1)) connections). Resetting MC idle counter."
    echo "0" > "$IDLE_FILE"
else
    # No players connected
    if [ ! -f "$IDLE_FILE" ]; then
        echo "0" > "$IDLE_FILE"
    fi

    IDLE_COUNT=$(cat "$IDLE_FILE")
    IDLE_COUNT=$((IDLE_COUNT + 1))

    echo "$(date): Minecraft is idle. Idle count: $IDLE_COUNT / $MAX_IDLE_CHECKS"
    echo "$IDLE_COUNT" > "$IDLE_FILE"

    if [ "$IDLE_COUNT" -ge "$MAX_IDLE_CHECKS" ]; then
        echo "$(date): MC idle timeout reached (4 hours). Stopping Minecraft service."
        rm -f "$IDLE_FILE"
        sudo systemctl stop minecraft
    fi
fi
