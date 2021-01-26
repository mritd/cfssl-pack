## cfssl-pack

> 本仓库为 cfssl 二进制文件生安装包，方便在宿主机安装以及配置。

### 一、使用

可直接从 [release](https://github.com/mritd/cfssl-pack/releases) 页面下载对应版本安装包，然后执行 `cfssl_*.run install` 既可安装。

```sh
➜ ~ ./cfssl_v1.5.0.run
Verifying archive integrity...  100%   MD5 checksums are OK. All good.
Uncompressing cfssl - Cloudflare's PKI and TLS toolkit  100%

NAME:
    cfssl_v1.5.0.run - cfssl install tool

USAGE:
    cfssl_v1.5.0.run command

AUTHOR:
    mritd <mritd@linux.com>

COMMANDS:
    install     Install cfssl to the system
    uninstall   Remove cfssl from the system

COPYRIGHT:
   Copyright (c) 2021 mritd, All rights reserved.
```

### 二、配置

默认情况下，**安装包会释放 `/etc/cfssl` 目录，该目录存放一些样例配置和样例脚本:**

- create.sh: cfssl 创建证书脚本
- etcd-csr.json: cfssl 证书 csr 配置
- etcd-gencert.json: cfssl 证书生成配置
- etcd-root-ca-csr.json: cfssl 生成 etcd CA 配置

可自行修改相关配置，从而实现为各种基础设施签发特定证书。
