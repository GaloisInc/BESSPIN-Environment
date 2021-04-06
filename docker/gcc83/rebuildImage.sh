#! /usr/bin/env bash

# This script was originally copied from: https://gitlab-ext.galois.com/ssith/gfe/-/blob/develop/docker/build_docker.sh
set -eux

if ([ $# -ge 1 ] && [ "$1" == "-p" ]); then doPublish=1; else doPublish=0; fi

IMAGE_NAME=galoisinc/besspin
IMAGE_TAG=gcc83
CONTAINER_NAME=besspin_gcc83

# Linux and OS X ?
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     SUDO=sudo;;
    Darwin*)    SUDO=;;
    *)          echo "Unknown machine. "; exit 1;;
esac

# Assume the file is in its own location at ${BESSPIN-Tool-Suite}/BESSPIN-Environment/docker/gcc83 directory
GCC83_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
echo "GCC83_PATH=$GCC83_PATH"

if [[ "$GCC83_PATH" != *BESSPIN-Environment/docker/gcc83 ]]; then
  echo "Error: The script relies on relative paths. Please do not move it to a different location."
  exit 1
fi

DATETIME=$(date +"%Y-%m-%d %T")

echo "[$DATETIME] Start building $CONTAINER_NAME Image."

echo "[$DATETIME] Create image locally."
$SUDO docker build -t "gcc83_local_image" .
if [ $? -ne 0 ]
then
  echo "Error: Create image locally."
  exit 1
fi

echo "[$DATETIME] Create container $CONTAINER_NAME."
$SUDO docker run -t -d -P -v $GCC83_PATH:/gcc83 --name=$CONTAINER_NAME  --privileged gcc83_local_image
if [ $? -ne 0 ]
then
  echo "Error: Create container $CONTAINER_NAME."
  exit 1
fi


echo "Building toolchains"
$SUDO docker exec -u 0 $CONTAINER_NAME /bin/bash -c "/gcc83/build-toolchain.sh"
if [[ $? -ne 0 ]]
then
  echo "Error: Building toolchains"
  exit 1
fi

echo "[$DATETIME] Commit and tag docker container."
$SUDO docker commit $($SUDO docker ps -aqf "name=$CONTAINER_NAME") $IMAGE_NAME:$IMAGE_TAG
$SUDO docker container stop $CONTAINER_NAME
$SUDO docker container rm $CONTAINER_NAME
if [[ $? -ne 0 ]]
then
  echo "Error: Commit and tag docker container."
  exit 1
fi

if [ $doPublish -eq 1 ]; then
  echo "[$DATETIME] Publish and clean the image."
  $SUDO docker push $IMAGE_NAME:$IMAGE_TAG
  if [[ $? -ne 0 ]]
  then
    echo "Error: Publish the image."
    exit 1
  fi
fi

echo "[$DATETIME] Docker $CONTAINER_NAME container built successfully."