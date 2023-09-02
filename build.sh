#!/usr/bin/env bash

set -x

ANDROID_API_LEVEL=28
SCREEN_RESOLUTION=1366x768

# docker rmi docker-emulator

set -ex

# build openbox as base
cd dockerfiles/ubuntu
  docker build . -t docker-emulator
cd -

  # build openbox as base
  cd dockerfiles/openbox
    docker build . -t docker-emulator
  cd -

  # build appium
  cd dockerfiles/appium
    docker build . -t docker-emulator
  cd -

  cd dockerfiles/noVNC
    docker build . -t docker-emulator
  cd -

  # build android emulator
  cd dockerfiles/android
    docker build -f dockerfile.base . \
      --build-arg="ANDROID_API_LEVEL=$ANDROID_API_LEVEL" \
      --build-arg="SCREEN_RESOLUTION=$SCREEN_RESOLUTION" \
      -t docker-emulator
  cd -

# finialize docker
cd dockerfiles/final
  docker build . \
    --build-arg="ANDROID_API_LEVEL=$ANDROID_API_LEVEL" \
    -t docker-emulator
cd -

cd dockerfiles/android
  docker build . \
    --build-arg="ANDROID_API_LEVEL=$ANDROID_API_LEVEL" \
    --build-arg="SCREEN_RESOLUTION=$SCREEN_RESOLUTION" \
    -t docker-emulator
cd -

# docker image tag docker-emulator 192.168.10.61:5000/logickee/docker-emulator

# docker push 192.168.10.61:5000/logickee/docker-emulator 

# docker run -d -p 5000:5000 --restart=always --name registry -v $(pwd)/docker-registry:/var/lib/registry registry:latest
# docker image tag docker/getting-started localhost:5000/getting-started:0.1
# docker push localhost:5000/getting-started:0.1

# docker run --rm -itd --privileged --device /dev/kvm -v ./share:/share  -v ./app:/usr/src/app  -p 6080:6080  --name emulator docker-emulator

