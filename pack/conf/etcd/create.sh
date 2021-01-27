#!/usr/bin/env bash

set -e

cfssl gencert --initca=true etcd-ca-csr.json | cfssljson --bare etcd-ca
cfssl gencert --ca etcd-ca.pem --ca-key etcd-ca-key.pem --config etcd-gencert.json etcd-csr.json | cfssljson --bare etcd
