#!/bin/sh
set -e

INSTALL_DIR=/data
MC_VERSION="${MC_VERSION:-latest}"
FABRIC_LOADER_VERSION="${FABRIC_LOADER_VERSION:-latest}"

mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

if [ "$MC_VERSION" = "latest" ]; then
    MC_VERSION=$(curl -fsSL "https://meta.fabricmc.net/v2/versions/game" \
        | jq -r '[.[] | select(.stable == true)] | .[0].version')
fi

if [ "$FABRIC_LOADER_VERSION" = "latest" ]; then
    FABRIC_LOADER_VERSION=$(curl -fsSL "https://meta.fabricmc.net/v2/versions/loader" \
        | jq -r '[.[] | select(.stable == true)] | .[0].version')
fi

if [ ! -f "fabric-server.jar" ] || [ "${AUTO_UPDATE:-0}" = "1" ]; then
    echo "Downloading Fabric $FABRIC_LOADER_VERSION for Minecraft $MC_VERSION..."
    INSTALLER_VERSION=$(curl -fsSL "https://meta.fabricmc.net/v2/versions/installer" \
        | jq -r '[.[] | select(.stable == true)] | .[0].version')
    curl -fsSL \
        "https://meta.fabricmc.net/v2/versions/loader/${MC_VERSION}/${FABRIC_LOADER_VERSION}/${INSTALLER_VERSION}/server/jar" \
        -o fabric-server.jar
fi

echo "eula=true" > eula.txt

exec java \
  -Xms"${MIN_MEMORY:-512M}" \
  -Xmx"${SERVER_MEMORY:-2048M}" \
  -jar fabric-server.jar nogui
