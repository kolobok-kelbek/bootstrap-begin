#!/usr/bin/env bash

SSH_DIR=~/.ssh

if ! [[ -d ${SSH_DIR} ]]; then
    mkdir ${SSH_DIR}
fi

ssh-keygen -t rsa -f ${SSH_DIR}/id_rsa -q -P "" \
    && cat ${SSH_DIR}/id_rsa.pub