#!/bin/bash
# ---------------------------------------------------------

# start headless X server and window manager
XSERVER_EXT="+xinerama +extension GLX +extension RANDR"
XSERVER_SIZE="1024x780x24"

exec /usr/bin/xvfb-run -n 1 \
    -s "${XSERVER_EXT} -screen 0 ${XSERVER_SIZE}" \
    -w 1 /usr/bin/openbox-session
