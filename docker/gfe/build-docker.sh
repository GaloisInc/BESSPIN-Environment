#! /usr/bin/env bash

# This script was originally copied from: https://gitlab-ext.galois.com/ssith/gfe/-/blob/develop/docker/build_docker.sh
set -eux

IMAGE_NAME=galoisinc/besspin
IMAGE_TAG=gfe
CONTAINER_NAME=besspin_gfe

# Linux and OS X ?
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     SUDO=sudo;;
    Darwin*)    SUDO=;;
    *)          echo "Unknown machine. "; exit 1;;
esac

# Assume the file is in its own location at ${BESSPIN-Tool-Suite}/BESSPIN-Environment/docker/gfe directory
GFE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
echo "GFE_PATH=$GFE_PATH"

if [[ "$GFE_PATH" != *BESSPIN-Environment/docker/gfe ]]; then
  echo "Error: The script relies on relative paths. Please do not move it to a different location"
  exit 1
fi

DATETIME=$(date +"%Y-%m-%d %T")

echo "[$DATETIME] Start building $CONTAINER_NAME Image."

echo "[$DATETIME] Create image locally."
$SUDO docker build -t "master_image" .
if [[ $? -ne 0 ]]
then
  echo "Error: Create image locally."
  exit 1
fi

echo "[$DATETIME] Create container $CONTAINER_NAME."
$SUDO docker run -t -d -P -v $GFE_PATH:/gfe --name=$CONTAINER_NAME  --privileged master_image
if [[ $? -ne 0 ]]
then
  echo "Error: Create container $CONTAINER_NAME."
  exit 1
fi


echo "Building toolchains"
$SUDO docker exec -u 0 $CONTAINER_NAME /bin/bash -c "/gfe/build-freebsd-toolchain.sh"
$SUDO docker exec -u 0 $CONTAINER_NAME /bin/bash -c "/gfe/build-toolchain.sh"

# Build and install OpenOCD
$SUDO docker exec -u 0 $CONTAINER_NAME /bin/bash -c "/gfe/build-openocd.sh"

if [[ $? -ne 0 ]]
then
  echo "Error: deps installation"
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

echo "[$DATETIME] Publish and clean the image."
#$SUDO docker push $IMAGE_NAME:$IMAGE_TAG
if [[ $? -ne 0 ]]
then
  echo "Error: Publish the image."
  exit 1
fi

echo "[$DATETIME] Docker $CONTAINER_NAME container installed successfully."
