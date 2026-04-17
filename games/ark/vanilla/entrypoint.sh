#!/bin/sh
set -e

STEAMCMD=/home/container/steamcmd/steamcmd.sh
INSTALL_DIR=/data
ARK_APP_ID=376030

mkdir -p "$INSTALL_DIR"

if [ ! -f "$INSTALL_DIR/ShooterGame/Binaries/Linux/ShooterGameServer" ] || [ "${AUTO_UPDATE:-0}" = "1" ]; then
    echo "Downloading ARK: Survival Evolved dedicated server via SteamCMD..."
    $STEAMCMD +force_install_dir "$INSTALL_DIR" \
              +login anonymous \
              +app_update $ARK_APP_ID validate \
              +quit
fi

MAP="${MAP:-TheIsland}"
SESSION_NAME="${SESSION_NAME:-ARK Server}"
MAX_PLAYERS="${MAX_PLAYERS:-20}"
SERVER_PASSWORD="${SERVER_PASSWORD:-}"
ADMIN_PASSWORD="${ADMIN_PASSWORD:-changeme}"

cd "$INSTALL_DIR"
exec ./ShooterGame/Binaries/Linux/ShooterGameServer \
  "${MAP}?listen?SessionName=${SESSION_NAME}?MaxPlayers=${MAX_PLAYERS}?ServerPassword=${SERVER_PASSWORD}?ServerAdminPassword=${ADMIN_PASSWORD}" \
  -port=7777 -queryport=27015 -rconport=27020 -rconEnabled=True
