#!/usr/bin/env bash

set -x

# /usr/bin/supervisord -c /etc/supervisord-screen.conf &
# /etc/supervisord-appium.conf &

# cat /etc/supervisord-emulator.conf 
# cat /etc/launch_emulator.sh 

cd /usr/src/app && npm install &

wait %1

for i in /etc/supervisord*.conf; do
  /usr/bin/supervisord -c  $i &
done

wait %2 %3 %4
