ARG NODE_VERSION=16
ARG BUN_VERSION=latest
ARG PYTHON_VERSION=3
ARG NODE_BASE_IMAGE_TAG=bullseye

FROM node:${NODE_VERSION}-${NODE_BASE_IMAGE_TAG} AS node

RUN apt update 
# bun required
RUN apt install curl unzip -y
# 如果BUN_VERSION为latest，则安装最新版本，否则安装指定版本
RUN if [ "$(uname -m)" = "aarch64" ]; then \
    ARCH="aarch64"; \
    else \
    ARCH="x64"; \
    fi && \
    if [ -z "${BUN_VERSION}" ] || [ "${BUN_VERSION}" = "latest" ]; then \
    curl -fsSL https://bun.sh/install | bash; \
    else \
    curl -fsSL https://bun.sh/install | bash -s "bun-v${BUN_VERSION}-linux-${ARCH}"; \
    fi

RUN if [ "$PYTHON_VERSION" = "2" ]; then \
    apt install python -y; \
    else \
    apt install python${PYTHON_VERSION} -y; \
    fi

RUN npm install yarn -g --production --force

RUN apt clean  

RUN mkdir -p /app

WORKDIR /app

SHELL ["/bin/bash", "-l"]

VOLUME /app
