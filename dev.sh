#!/bin/bash
docker build -t banian/cache-mirror .

rm -rf ./data

echo "http://localhost:8080/wikipedia/commons/thumb/8/88/Badger_attributed_Two_Children_Detail_of_Boy.jpg/359px-Badger_attributed_Two_Children_Detail_of_Boy.jpg?width=300&quality=50"

docker run -it --rm \
    -p 8080:80 \
    -v "`pwd`/data:/data" \
    -e "REMOTE_PROTO=https" \
    -e "REMOTE_HOST=upload.wikimedia.org" \
    -e "REWRITE_HOST=localhost:8080" \
    -e "REWRITE_PROTO=http" \
    -e "MODE=cache" \
    -e "IMAGE=on" \
    banian/cache-mirror
