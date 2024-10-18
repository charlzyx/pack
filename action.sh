#!/bin/bash

# 获取标签
TAG=${GITHUB_REF#refs/tags/}

# 解析 NODE_VERSION
NODE_VERSION=$(echo $TAG | sed -E 's/^node([0-9]+(\.[0-9]+)*).*/\1/')

# 解析其他版本信息
BUN_VERSION=$(echo $TAG | grep -oP 'bun\K[0-9.]+' || echo "")
PYTHON_VERSION=$(echo $TAG | grep -oP 'python\K[0-9.]+' || echo "")
NODE_BASE_IMAGE_TAG=$(echo $TAG | grep -oP '(bullseye|buster)' || echo "")

# 设置默认值
BUN_VERSION=${BUN_VERSION:-latest}
PYTHON_VERSION=${PYTHON_VERSION:-3}

# 根据 NODE_VERSION 判断 NODE_BASE_IMAGE_TAG
if [ -z "$NODE_BASE_IMAGE_TAG" ]; then
    if [ "${NODE_VERSION%%.*}" -le 10 ]; then
        NODE_BASE_IMAGE_TAG="buster"
    else
        NODE_BASE_IMAGE_TAG="bullseye"
    fi
fi

# 检查是否包含 -slim，如果包含则追加到 NODE_BASE_IMAGE_TAG
if [[ $TAG == *"-slim"* ]]; then
    NODE_BASE_IMAGE_TAG="${NODE_BASE_IMAGE_TAG}-slim"
fi

# 输出结果到 GITHUB_OUTPUT
echo "TAG=${TAG}" >> $GITHUB_OUTPUT
echo "NODE_VERSION=${NODE_VERSION}" >> $GITHUB_OUTPUT
echo "BUN_VERSION=${BUN_VERSION}" >> $GITHUB_OUTPUT
echo "PYTHON_VERSION=${PYTHON_VERSION}" >> $GITHUB_OUTPUT
echo "NODE_BASE_IMAGE_TAG=${NODE_BASE_IMAGE_TAG}" >> $GITHUB_OUTPUT

# 为 Docker 构建参数设置环境变量
echo "NODE_VERSION=${NODE_VERSION}" >> $GITHUB_ENV
echo "BUN_VERSION=${BUN_VERSION}" >> $GITHUB_ENV
echo "PYTHON_VERSION=${PYTHON_VERSION}" >> $GITHUB_ENV
echo "NODE_BASE_IMAGE_TAG=${NODE_BASE_IMAGE_TAG}" >> $GITHUB_ENV

# 打印变量值（用于调试）
echo "TAG: ${TAG}"
echo "NODE_VERSION: ${NODE_VERSION}"
echo "BUN_VERSION: ${BUN_VERSION}"
echo "PYTHON_VERSION: ${PYTHON_VERSION}"
echo "NODE_BASE_IMAGE_TAG: ${NODE_BASE_IMAGE_TAG}"
