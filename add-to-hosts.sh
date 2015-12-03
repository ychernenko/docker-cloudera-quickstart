#!/usr/bin/env bash

source ./globals.sh

set_host_ip() {
    local ip=$1
    local host=$2
    local hosts_entry="$ip $host"
    local filename="/etc/hosts"

    echo "Patching $filename ..."
    sed -i.bak "/^.*${host}/d" ${filename}
    echo "Adding: $hosts_entry"
    echo ${hosts_entry} >> ${filename}
}

ip_address=$(./get-ipaddress.sh)

set_host_ip ${ip_address} ${CONTAINER_HOSTNAME}