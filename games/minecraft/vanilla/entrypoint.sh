#!/bin/sh
set -e

INSTALL_DIR=/data
MC_VERSION="${MC_VERSION:-latest}"

mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

if [ "$MC_VERSION" = "latest" ]; then
    MC_VERSION=$(curl -fsSL "https://launchermeta.mojang.com/mc/game/version_manifest.json" \
        | jq -r '.latest.release')
fi

if [ ! -f "server.jar" ] || [ "${AUTO_UPDATE:-0}" = "1" ]; then
    echo "Downloading Minecraft $MC_VERSION..."
    VERSION_URL=$(curl -fsSL "https://launchermeta.mojang.com/mc/game/version_manifest.json" \
        | jq -r --arg v "$MC_VERSION" '.versions[] | select(.id == $v) | .url')
    JAR_URL=$(curl -fsSL "$VERSION_URL" | jq -r '.downloads.server.url')
    curl -fsSL "$JAR_URL" -o server.jar
fi

echo "eula=true" > eula.txt

exec java \
  -Xms"${MIN_MEMORY:-512M}" \
  -Xmx"${SERVER_MEMORY:-2048M}" \
  -jar server.jar nogui
