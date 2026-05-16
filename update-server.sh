#!/bin/bash
if [ -z "$1" ]; then
  echo "Usage: ./update-server.sh <minecraft_version>"
  echo "Example: ./update-server.sh 26.2.0"
  exit 1
fi

echo "Updating server to Minecraft $1..."
wget -O fabric-installer.jar https://maven.fabricmc.net/net/fabricmc/fabric-installer/1.0.1/fabric-installer-1.0.1.jar
java -jar fabric-installer.jar server -mcversion $1 -downloadMinecraft
echo "Update complete! You can now start the server with ./start.sh"
