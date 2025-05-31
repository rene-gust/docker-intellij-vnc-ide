#!/bin/bash

# Start a virtual X display
Xvfb :0 -screen 0 1680x1050x24 &

# Wait a bit to ensure Xvfb is ready
sleep 2

# Start xfce session
export DISPLAY=:0
startxfce4 &

# Start x11vnc bound to the virtual display
x11vnc -display :0 -forever -usepw -shared