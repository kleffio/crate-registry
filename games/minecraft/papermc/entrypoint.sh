#!/bin/sh
set -e

INSTALL_DIR=/data
MC_VERSION="${MC_VERSION:-latest}"

mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

if [ "$MC_VERSION" = "latest" ]; then
    MC_VERSION=$(curl -fsSL "https://api.papermc.io/v2/projects/paper" \
        | jq -r '.versions[-1]')
fi

if [ ! -f "paper.jar" ] || [ "${AUTO_UPDATE:-0}" = "1" ]; then
    echo "Downloading PaperMC $MC_VERSION..."
    PAPER_BUILD=$(curl -fsSL "https://api.papermc.io/v2/projects/paper/versions/${MC_VERSION}" \
        | jq -r '.builds[-1]')
    curl -fsSL \
        "https://api.papermc.io/v2/projects/paper/versions/${MC_VERSION}/builds/${PAPER_BUILD}/downloads/paper-${MC_VERSION}-${PAPER_BUILD}.jar" \
        -o paper.jar
fi

echo "eula=true" > eula.txt

exec java \
  -Xms"${MIN_MEMORY:-512M}" \
  -Xmx"${SERVER_MEMORY:-2048M}" \
  -jar paper.jar nogui
