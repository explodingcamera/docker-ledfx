#!/bin/sh

PUID=${PUID:-1000}
PGID=${PGID:-1000}

groupmod -o -g "$PGID" ledfx
usermod -o -u "$PUID" ledfx

# docker doesn't set the group id of the audio group correctly
chown root:audio /dev/snd/*

set -e

echo "
-------------------------------------
LedFx Docker by explodingcamera
-------------------------------------
-------------------------------------
User:        $(whoami)    
User uid:    $(id -u ledfx)
User gid:    $(id -g ledfx)
-------------------------------------
"

chown -R ledfx:ledfx /home/ledfx

echo "-- Starting ledfx..."

export PYTHONUNBUFFERED=1
exec gosu ledfx ledfx $@