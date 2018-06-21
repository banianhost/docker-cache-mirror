# Cache Mirror

A proxy cache nginx that forces the cache of resources and make conditional get request to the proxified server to check if the resource must be redownloaded. The "remote" is the proxyfied server.

### Environment variables

Variable                  | Default    | Description
--------------------------|------------|---------------
REMOTE_PROTO              | https      | Remote protocol
REMOTE_HOST               | -          | IP or fqdn of the remote
CACHE_TTL                 | 5m         | Time to live for cached resources. Remember that invalidated cache only leads to a conditonal GET request based on If-Modified-Since header
MAX_CACHE_SIZE            | 10g        | 
MAX_CLIENT_CONNECTED      | ∞          | Limit the number of concurent connections. Return 503 to new clients if reached
CACHE_LOCK_TIMEOUT        | 10s        | Lock a ressource being cached in order to avoid multiple downloads
CACHE_INACTIVE            | 3M         | Cached data that are not accessed during the time specified by the inactive parameter get removed from the cache regardless of their freshness. (defaults to 3 month)
REWRITE_URL				  | -          | Rewrites `$REWRITE_HOST` value in responses with `$REWRITE_URL` without changing Last-Modified
REWRITE_HOST			  |$REMOTE_HOST| 

### Simple Usage

```bash
docker run -it -p 8080:80 \
    -e "REMOTE_PROTO=http" \
    -e "REMOTE_HOST=registry.npmjs.org" \
    -e "CACHE_TTL=1h" \
    -e "MAX_CLIENT_CONNECTED=500" \
    -e "CACHE_LOCK_TIMEOUT=1m" \
    -v "`pwd`/cache:/var/cache/mirror" \
    banian/cache-mirror:latest
```

# References

- http://nginx.org/en/docs/http/ngx_http_proxy_module.html
- https://github.com/digitalLumberjack/docker-nginx-https-cache (Fork)
- https://gist.github.com/dctrwatson/5785675
- https://github.com/btford/npm-nginx-cache/blob/master/nginx.template.conf

# License

MIT - BanianHost
