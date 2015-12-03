#!/usr/bin/env bash

set -e

ROOT_PASSWORD=root

function setup-users() {
    echo 'Changing root password'
    echo "root:${ROOT_PASSWORD}" | chpasswd
}

function install-ssh() {
    echo 'Installing SSH Server'
    apt-get install -y openssh-server

    sshd_config=/etc/ssh/sshd_config
    sed -i 's|#PasswordAuthentication|PasswordAuthentication|g' ${sshd_config}
    sed -i 's|PasswordAuthentication no|PasswordAuthentication yes|g' ${sshd_config}

    sed -i 's|#PermitRootLogin|PermitRootLogin|g' ${sshd_config}
    sed -i 's|PermitRootLogin without-password|PermitRootLogin yes|g' ${sshd_config}

    sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd
}

function fix-oozie-core-site() {
    target_file=/etc/oozie/conf/hadoop-conf/core-site.xml
    fixed_config_tag='<configuration><property><name>fs.defaultFS</name><value>hdfs://localhost:8020</value></property>'
    sed -i "s|<configuration>|${fixed_config_tag}|" ${target_file}
    #cat ${target_file}
}

setup-users
install-ssh
fix-oozie-core-site

#/etc/hadoop/conf/yarn-site.xml
