#!/usr/bin/env bash
# Copyright (C) 2023, Ava Labs, Inc. All rights reserved.
# See the file LICENSE for licensing terms.

set -e

VERSION=v0.1.0

ARCH=$(uname -m)
[ $ARCH = x86_64 ] && ARCH=amd64
[ $ARCH = aarch64 ] && ARCH=arm64

IMAGE_NAME=linux-${ARCH}:${VERSION}
FILE_NAME=foundry_${VERSION}_linux_${ARCH}.tar.gz

docker build -t ${IMAGE_NAME} -f Dockerfile.build-linux .
docker rm -f dummy || true
docker create --name dummy ${IMAGE_NAME}
docker cp dummy:/opt/foundry/foundry_linux.tar.gz ${FILE_NAME}
