#!/bin/bash
docker build -t banian/cache-mirror .

docker run -it --rm \
    -p 8080:80 \
    -v "`pwd`/data:/data" \
    -e "REMOTE_PROTO=http" \
    -e "REMOTE_HOST=registry.npmjs.org" \
    banian/cache-mirror
