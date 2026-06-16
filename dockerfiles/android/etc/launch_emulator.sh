#!/usr/bin/env bash

set -x

if [ "$ANDROID_API_LEVEL" = "34" ]; then
  AVD_NAME="Pixel_8"
  SYSDIR="$ANDROID_HOME/system-images/android-34/google_apis/x86_64/"
else
  AVD_NAME="test_nexus"
  SYSDIR="$ANDROID_HOME/system-images/android-$ANDROID_API_LEVEL/default/x86/"
fi

/root/Android/emulator/emulator \
  -avd "$AVD_NAME" \
  -sysdir "$SYSDIR" \
  -no-audio \
  -no-snapshot \
  -no-boot-anim

# cd /usr/src/app && /usr/bin/xfce4-terminal -x "npm start run"
# cd /usr/src/app && /usr/bin/xfce4-terminal -x "npx react-native run-android"

# bash
