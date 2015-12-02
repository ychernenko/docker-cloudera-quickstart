#!/usr/bin/env bash
source ./globals.sh
(docker images | grep $1 | awk '{print $3}' | xargs docker rmi) || :