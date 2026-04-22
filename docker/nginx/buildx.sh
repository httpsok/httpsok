#!/bin/zsh

cd `dirname $0` && pwd

echo '开始构建镜像'

docker buildx build --platform linux/amd64,linux/arm64 -t httpsok/nginx:1.29.8 -t httpsok/nginx:latest --push -f Dockerfile .
#docker buildx build --platform linux/amd64,linux/arm64 -t httpsok/nginx:1.29.8-alpine --push -f Dockerfile-alpine .

# 本地构建镜像并且测试
# COMPOSE_BAKE=true docker-compose build httpsok-nginx-alpine
# docker-compose up httpsok-nginx-alpine

# COMPOSE_BAKE=true docker-compose build httpsok-nginx
# docker-compose up httpsok-nginx

