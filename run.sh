#!/usr/bin/env bash

source ./globals.sh

docker run \
    -d \
    --name=${CONTAINER_NAME} \
    ${IMAGE_NAME}