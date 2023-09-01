#!/usr/bin/env bash

set -x

/root/Android/emulator/emulator \
  -avd test_nexus \
  -sysdir $ANDROID_HOME/system-images/android-$ANDROID_API_LEVEL/default/x86/


function wait_emulator_to_be_ready() {
  adb devices | grep emulator | cut -f1 | while read line; do adb -s $line emu kill; done
  emulator -avd test -no-audio -no-boot-anim -no-window -accel on -gpu off -skin 1440x2880 &
boot_completed=false
  while [ "$boot_completed" == false ]; do
    status=$(adb wait-for-device shell getprop sys.boot_completed | tr -d '\r')
    echo "Boot Status: $status"

    if [ "$status" == "1" ]; then
      boot_completed=true
    else
      sleep 1
    fi
  done
}

function disable_animation() {
  adb shell "settings put global window_animation_scale 0.0"
  adb shell "settings put global transition_animation_scale 0.0"
  adb shell "settings put global animator_duration_scale 0.0"
}

wait_emulator_to_be_ready
sleep 1
disable_animation

cd /usr/src/app && /usr/bin/xfce4-terminal -x "npm start run"
cd /usr/src/app && /usr/bin/xfce4-terminal -x "npx react-native run-android"

# bash
