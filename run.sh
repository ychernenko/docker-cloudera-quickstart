#!/usr/bin/env bash

source ./globals.sh

docker run \
    -d \
    -h ${CONTAINER_HOSTNAME} \
    --name=${CONTAINER_NAME} \
    ${IMAGE_NAME}