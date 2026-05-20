#!/bin/bash
# check-mc.sh
# Outputs a simple JSON-like status for the Minecraft server.
# Called via AWS SSM to check if the Minecraft service is running.

IS_ACTIVE=$(systemctl is-active minecraft)
CONNECTIONS=0

if [ "$IS_ACTIVE" = "active" ]; then
    CONNECTIONS=$(ss -tn state established '( dport = :25565 or sport = :25565 )' | wc -l)
    CONNECTIONS=$((CONNECTIONS - 1))
    if [ "$CONNECTIONS" -lt 0 ]; then
        CONNECTIONS=0
    fi
fi

echo "{\"service\":\"$IS_ACTIVE\",\"players\":$CONNECTIONS}"
