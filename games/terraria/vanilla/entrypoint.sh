#!/bin/sh
set -e

mkdir -p /serverdata/Worlds

printf 'world=/serverdata/Worlds/%s.wld\nautocreate=%s\nworldname=%s\ndifficulty=%s\nmaxplayers=%s\nport=7777\npassword=%s\n' \
  "${WORLD:-World}" \
  "${AUTOCREATE:-2}" \
  "${WORLD:-World}" \
  "${DIFFICULTY:-0}" \
  "${MAXPLAYERS:-8}" \
  "${PASSWORD:-}" \
  > serverconfig.txt

exec tail -f /dev/null | ./TerrariaServer.bin.x86_64 -config serverconfig.txt
