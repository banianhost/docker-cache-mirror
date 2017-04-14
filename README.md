# Cache Mirror

A proxy cache nginx that forces the cache of resources and make conditional get request to the proxified server to check if the resource must be redownloaded.

The "remote" is the proxyfied server.

### Env variables

Variable                  | Default  | Description
--------------------------|----------|---------------
REMOTE_PROTOCOLE          | https    | Remote protocol
REMOTE_HOST               |          | IP or fqdn of the remote
CACHE_TTL                 | 5m       | Time to live for cached resources. Remember that invalidated cache only leads to a conditonal GET request based on If-Modified-Since header
MAX_CACHE_SIZE            | 10g      | 
MAX_CLIENT_CONNECTED      | ∞        | Limit the number of concurent connections. Return 503 to new clients if reached
CACHE_LOCK_TIMEOUT        | 10s      | Lck a ressource being cached in order to avoid multiple downloads


### Usage :
```bash
docker run -it -p 8080:80 \
    -e "REMOTE_PROTOCOLE=https" \
    -e "REMOTE_HOST=registry.npmjs.org" \
    -e "CACHE_TTL=1h" \
    -e "MAX_CLIENT_CONNECTED=500" \
    -e "CACHE_LOCK_TIMEOUT=1m" \
    -v "`pwd`/cache:/var/cache/mirror" \
    banian/cache-mirror:latest
```

# License
MIT

Originally started as a fork of digitalLumberjack/docker-nginx-https-cache