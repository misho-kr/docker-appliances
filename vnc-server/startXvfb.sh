#!/bin/bash

Xvfb :1 +xinerama +extension GLX +extension RANDR -screen 0 1024x780x24 &
DISPLAY=:1 /usr/bin/openbox-session &

exec x11vnc -forever -usepw -noncache -display :1
