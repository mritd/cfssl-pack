#!/usr/bin/env bash

set -e

VERSION=${1}
MAKESELF_VERSION=${MAKESELF_VERSION:-"2.4.3"}
MAKESELF_INSTALL_DIR=$(mktemp -d makeself.XXXXXX)
DOWNLOAD_TPL="https://github.com/cloudflare/cfssl/releases/download/v%s/%s_%s_linux_amd64"
CFSSL_FILES=(cfssl cfssl-bundle cfssl-certinfo cfssl-newkey cfssl-scan cfssljson mkbundle multirootca)

check_version(){
    if [ -z "${VERSION}" ]; then
        warn "cfssl version not specified, use default version 1.5.0."
        VERSION="1.5.0"
    fi
}

check_makeself(){
    if ! command -v makeself.sh >/dev/null 2>&1; then
        wget -q https://github.com/megastep/makeself/releases/download/release-${MAKESELF_VERSION}/makeself-${MAKESELF_VERSION}.run
        bash makeself-${MAKESELF_VERSION}.run --target ${MAKESELF_INSTALL_DIR}
        export PATH=${MAKESELF_INSTALL_DIR}:${PATH}
    fi
}

download(){
    info "download cfssl precompiled binary."
    for c in ${CFSSL_FILES[@]}; do
        info "download => [${c}]..."
        wget -q -O pack/bin/${c} $(printf "${DOWNLOAD_TPL}" ${VERSION} ${c} ${VERSION})
    done
}

build(){
    info "building..."
    cat > LSM <<EOF
Begin4
Title:          cfssl
Version:        ${VERSION}
Description:    Cloudflare's PKI and TLS toolkit
Keywords:       cfssl pki tls
Author:         Cloudflare
Maintained-by:  mritd (mritd@linux.com)
Original-site:  https://github.com/cloudflare/cfssl
Platform:       Linux
Copying-policy: BSD 2-Clause "Simplified" License
End
EOF
    makeself.sh --lsm LSM pack cfssl_v${VERSION}.run "cfssl - Cloudflare's PKI and TLS toolkit" ./helper.sh cfssl_v${VERSION}.run
}

clean(){
    info "clean files."
    rm -rf pack/bin/* makeself* ${MAKESELF_INSTALL_DIR} LSM
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

check_version
check_makeself
download
build
clean

