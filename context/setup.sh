#!/usr/bin/env bash

set -e

ROOT_PASSWORD=root
BIGDATA_USER=bigdata
BIGDATA_PASSWORD=bigdata

function setup-users() {
    echo 'Changing root password'
    echo "root:$ROOT_PASSWORD" | chpasswd

    add-user ${BIGDATA_USER} ${BIGDATA_PASSWORD}
}

function add-user() {
    echo "Adding user $1"
    encrypted_pass=$(perl -e 'print crypt($ARGV[0], "password")' $2)
    useradd -p ${encrypted_pass} $1
}

function install-ssh() {
    echo 'Installing SSH Server'
    apt-get install -y openssh-server

    sshd_config=/etc/ssh/sshd_config
    sed -i 's|#PasswordAuthentication|PasswordAuthentication|g' ${sshd_config}
    sed -i 's|PasswordAuthentication no|PasswordAuthentication yes|g' ${sshd_config}
}

function fix-oozie-core-site() {
    target_file=/etc/oozie/conf/hadoop-conf/core-site.xml
    fixed_config_tag='<configuration><property><name>fs.defaultFS</name><value>hdfs://localhost:8020</value></property>'
    sed -i "s|<configuration>|${fixed_config_tag}|" ${target_file}
    cat ${target_file}
}

setup-users
install-ssh
fix-oozie-core-site

#/etc/hadoop/conf/yarn-site.xml
