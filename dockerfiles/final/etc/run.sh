#!/usr/bin/env bash

set -x

# /usr/bin/supervisord -c /etc/supervisord-screen.conf &
# /etc/supervisord-appium.conf &

# cat /etc/supervisord-emulator.conf 
# cat /etc/launch_emulator.sh 

cd /usr/src/app && npm install

/usr/bin/supervisord -c /etc/supervisord.conf
