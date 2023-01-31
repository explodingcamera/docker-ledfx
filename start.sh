#!/bin/sh

PUID=${PUID:-1000}
PGID=${PGID:-1000}

groupmod -o -g "$PGID" ledfx
usermod -o -u "$PUID" ledfx

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
exec gosu ledfx ledfx
