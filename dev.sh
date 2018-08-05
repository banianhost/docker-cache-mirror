#!/bin/bash
docker build -t banian/cache-mirror .

rm -rf ./data

docker run -it --rm \
    -p 8080:80 \
    -v "`pwd`/data:/data" \
    -e "REMOTE_PROTO=https" \
    -e "REMOTE_HOST=npm.taobao.org" \
    -e "REWRITE_HOST=localhost:8080" \
    -e "REWRITE_PROTO=http" \
    banian/cache-mirror
