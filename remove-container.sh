#!/usr/bin/env bash

source ./globals.sh

docker stop ${CONTAINER_NAME} | xargs docker rm || :