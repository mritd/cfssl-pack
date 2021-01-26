#!/usr/bin/env bash

set -e

CFSSL_FILES=(cfssl cfssl-bundle cfssl-certinfo cfssl-newkey cfssl-scan cfssljson mkbundle multirootca)

function install(){
    info "install cfssl to the system..."
    for c in ${CFSSL_FILES[@]}; do
        info "copy => [${c}]..."
        cp bin/${c} /usr/bin/${c}
    done
    info "copy => [conf]..."
    cp -r conf /etc/cfssl

    fix_permissions
}

function uninstall(){
    info "remove cfssl from the system..."
    for c in ${CFSSL_FILES[@]}; do
        info "remove => [${c}]..."
        rm -f /usr/bin/${c}
    done
    info "remove => [/etc/cfssl]..."
    rm -rf /etc/cfssl
}

function fix_permissions(){
    info "fix permissions..."
    for c in ${CFSSL_FILES[@]}; do
        chmod 755 /usr/bin/${c}
    done
}

function info(){
    echo -e "\033[1;32mINFO: $@\033[0m"
}

function warn(){
    echo -e "\033[1;33mWARN: $@\033[0m"
}

function err(){
    echo -e "\033[1;31mERROR: $@\033[0m"
}

case "${2}" in
    "install")
        install
        ;;
    "uninstall")
        uninstall
        ;;
    *)
        cat <<EOF

NAME:
    ${1} - cfssl install tool

USAGE:
    ${1} command

AUTHOR:
    mritd <mritd@linux.com>

COMMANDS:
    install     Install cfssl to the system
    uninstall   Remove cfssl from the system

COPYRIGHT:
   Copyright (c) $(date "+%Y") mritd, All rights reserved.
EOF
    exit 0
        ;;
esac

