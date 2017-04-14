# Cache Mirror

A proxy cache nginx that forces the cache of resources and make conditional get request to the proxified server to check if the resource must be redownloaded.

The "remote" is the proxyfied server.

Check those env variables to customise the instance:
- `REMOTE_PROTOCOLE`: the remote protocol. default 'https'
- `REMOTE_HOST`: the ip or fqdn of the remote
- `CACHE_TTL`: the time to live for cached resources. Remember that invalidated cache only leads to a conditonal GET request based on If-Modified-Since header. default '5m'
- `MAX_CACHE_SIZE`: default '10g'
- `MAX_CLIENT_CONNECTED`: limit the number of concurent connections. Return 503 to new clients if reached. default infinite
- `CACHE_LOCK_TIMEOUT`: lock a ressource being cached in order to avoid multiple downloads. Default '10s'


### Usage :
```bash
docker run -ti -p 8070:80 \
    -e "REMOTE_PROTOCOLE=https" \ 
    -e "REMOTE_HOST=10.10.12.14" \
    -e "CACHE_TTL=1h" \
    -e "MAX_CLIENT_CONNECTED=500" \
    -e "CACHE_LOCK_TIMEOUT=1m" \
    -v "./cache:/var/cache/mirror"
    banian/cache-mirror:latest
```

