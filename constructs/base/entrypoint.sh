#!/bin/sh
set -e
printf '%s' "$STARTUP_SCRIPT" > /tmp/startup.sh
chmod +x /tmp/startup.sh
exec /tmp/startup.sh
