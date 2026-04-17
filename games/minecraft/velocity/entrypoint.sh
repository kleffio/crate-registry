#!/bin/sh
set -e

INSTALL_DIR=/data
VELOCITY_VERSION="${VELOCITY_VERSION:-latest}"

mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

if [ "$VELOCITY_VERSION" = "latest" ]; then
    VELOCITY_VERSION=$(curl -fsSL "https://api.papermc.io/v2/projects/velocity" \
        | jq -r '.versions[-1]')
fi

if [ ! -f "velocity.jar" ] || [ "${AUTO_UPDATE:-0}" = "1" ]; then
    echo "Downloading Velocity $VELOCITY_VERSION..."
    VELOCITY_BUILD=$(curl -fsSL \
        "https://api.papermc.io/v2/projects/velocity/versions/${VELOCITY_VERSION}" \
        | jq -r '.builds[-1]')
    curl -fsSL \
        "https://api.papermc.io/v2/projects/velocity/versions/${VELOCITY_VERSION}/builds/${VELOCITY_BUILD}/downloads/velocity-${VELOCITY_VERSION}-${VELOCITY_BUILD}.jar" \
        -o velocity.jar
fi

exec java \
  -Xms"${MIN_MEMORY:-512M}" \
  -Xmx"${SERVER_MEMORY:-2048M}" \
  -XX:+UseG1GC \
  -XX:G1HeapRegionSize=4M \
  -XX:+UnlockExperimentalVMOptions \
  -XX:+ParallelRefProcEnabled \
  -XX:+AlwaysPreTouch \
  -jar velocity.jar
