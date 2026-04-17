#!/bin/sh
set -e

INSTALL_DIR=/data

mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

if [ ! -f "Server/HytaleServer.jar" ] || [ "${AUTO_UPDATE:-0}" = "1" ]; then
    echo "Downloading Hytale server..."
    curl -fsSL https://downloader.hytale.com/hytale-downloader.zip -o hytale-downloader.zip
    unzip -o hytale-downloader.zip -d hytale-downloader
    mv hytale-downloader/hytale-downloader-linux-amd64 hytale-downloader/hytale-downloader-linux
    chmod +x hytale-downloader/hytale-downloader-linux
    ./hytale-downloader/hytale-downloader-linux \
        -patchline "${HYTALE_PATCHLINE:-release}" \
        -download-path HytaleServer.zip
    unzip -o HytaleServer.zip
    rm -f hytale-downloader.zip HytaleServer.zip
fi

exec java \
  -Xms128M \
  -Xmx"${SERVER_MEMORY:-4096}M" \
  -jar Server/HytaleServer.jar \
  --auth-mode "${HYTALE_AUTH_MODE:-authenticated}" \
  --assets Assets.zip \
  --bind "0.0.0.0:5520"
