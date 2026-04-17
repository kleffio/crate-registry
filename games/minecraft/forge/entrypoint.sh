#!/bin/sh
set -e

INSTALL_DIR=/data
MC_VERSION="${MC_VERSION:-1.20.1}"
FORGE_VERSION="${FORGE_VERSION:-latest}"

mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

if [ ! -f "run.sh" ] && [ ! -f "forge-server.jar" ] || [ "${AUTO_UPDATE:-0}" = "1" ]; then
    echo "Installing Forge for Minecraft $MC_VERSION..."

    if [ "$FORGE_VERSION" = "latest" ]; then
        FORGE_VERSION=$(curl -fsSL \
            "https://files.minecraftforge.net/net/minecraftforge/forge/promotions_slim.json" \
            | jq -r --arg v "$MC_VERSION" \
                '.promos[$v + "-recommended"] // .promos[$v + "-latest"]')
    fi

    FORGE_FULL="${MC_VERSION}-${FORGE_VERSION}"
    curl -fsSL \
        "https://maven.minecraftforge.net/net/minecraftforge/forge/${FORGE_FULL}/forge-${FORGE_FULL}-installer.jar" \
        -o forge-installer.jar

    java -jar forge-installer.jar --installServer
    rm -f forge-installer.jar forge-installer.jar.log
fi

echo "eula=true" > eula.txt

if [ -f "run.sh" ]; then
    chmod +x run.sh
    printf -- '-Xms%s\n-Xmx%s\n' "${MIN_MEMORY:-512M}" "${SERVER_MEMORY:-2048M}" > user_jvm_args.txt
    exec ./run.sh nogui
else
    FORGE_JAR=$(ls forge-*-universal.jar forge-*-server.jar 2>/dev/null | head -1)
    exec java \
      -Xms"${MIN_MEMORY:-512M}" \
      -Xmx"${SERVER_MEMORY:-2048M}" \
      -jar "$FORGE_JAR" nogui
fi
