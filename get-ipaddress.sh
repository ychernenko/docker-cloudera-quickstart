#!/usr/bin/env bash

source ./globals.sh

docker inspect ${CONTAINER_NAME} | grep '"IPAddress"' | awk -F'["]' '{print $4}'