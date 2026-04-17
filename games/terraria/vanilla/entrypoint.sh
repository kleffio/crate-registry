#!/bin/sh
set -e

INSTALL_DIR=/data

mkdir -p "$INSTALL_DIR/Worlds"

if [ ! -f "$INSTALL_DIR/TerrariaServer.bin.x86_64" ] || [ "${AUTO_UPDATE:-0}" = "1" ]; then
    echo "Downloading Terraria dedicated server..."

    if [ "${TERRARIA_VERSION:-latest}" = "latest" ]; then
        FILENAME=$(curl -sSL "https://terraria.org/api/get/dedicated-servers-names" | jq -r '.[]' | head -1)
    else
        CLEAN=$(echo "${TERRARIA_VERSION}" | tr -d '.')
        FILENAME="terraria-server-${CLEAN}.zip"
    fi

    DOWNLOAD_URL="https://terraria.org/api/download/pc-dedicated-server/${FILENAME}"
    echo "Fetching: ${DOWNLOAD_URL}"
    curl -sSL "${DOWNLOAD_URL}" -o /tmp/terraria-server.zip

    echo "Extracting..."
    unzip -q /tmp/terraria-server.zip -d /tmp/terraria-server
    rm /tmp/terraria-server.zip

    VERSION_DIR=$(ls /tmp/terraria-server/)
    cp -R "/tmp/terraria-server/${VERSION_DIR}/Linux/." "$INSTALL_DIR/"
    chmod +x "$INSTALL_DIR/TerrariaServer.bin.x86_64"
    rm -rf /tmp/terraria-server

    echo "Terraria server installed."
fi

printf 'world=%s/Worlds/%s.wld\nautocreate=%s\nworldname=%s\ndifficulty=%s\nmaxplayers=%s\nport=7777\npassword=%s\n' \
  "$INSTALL_DIR" \
  "${WORLD:-World}" \
  "${AUTOCREATE:-2}" \
  "${WORLD:-World}" \
  "${DIFFICULTY:-0}" \
  "${MAXPLAYERS:-8}" \
  "${PASSWORD:-}" \
  > "$INSTALL_DIR/serverconfig.txt"

cd "$INSTALL_DIR"
exec ./TerrariaServer.bin.x86_64 -config serverconfig.txt
