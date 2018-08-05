```
   ______           __            __  ____
  / ____/___ ______/ /_  ___     /  |/  (_)_____________  _____
 / /   / __ `/ ___/ __ \/ _ \   / /|_/ / / ___/ ___/ __ \/ ___/
/ /___/ /_/ / /__/ / / /  __/  / /  / / / /  / /  / /_/ / /
\____/\__,_/\___/_/ /_/\___/  /_/  /_/_/_/  /_/   \____/_/
```

A proxy cache nginx that forces the cache of resources and make conditional get request to the proxified server to check if the resource must be redownloaded. The "remote" is the proxyfied server.

## Environment variables

Variable                  | Default      | Description
--------------------------|--------------|---------------
REMOTE_PROTO              | http        | Remote protocol
REMOTE_HOST               | -            | IP or fqdn of the remote
REMOTE_URI                | -            | Pass requests to a specific URI
CACHE_TTL                 | 5m           | Time to live for cached resources. Remember that invalidated cache only leads to a conditonal GET request based on If-Modified-Since header
MAX_CACHE_SIZE            | 10g          |
MAX_CLIENT_CONNECTED      | ∞            | Limit the number of concurent connections. Return 503 to new clients if reached
CACHE_LOCK_TIMEOUT        | 10s          | Lock a ressource being cached in order to avoid multiple downloads
CACHE_INACTIVE            | 3M           | Cached data that are not accessed during the time specified by the inactive parameter get removed from the cache regardless of their freshness. (defaults to 3 month)
REWRITE_HOST		      | -            | Rewrites `$REMOTE_HOST` value in responses with `$REWRITE_HOST` without changing Last-Modified
REWRITE_PROTO             | $REMOTE_PROTO| Rewrites all `http://` and  `https://` values with `$REWRITE_PROTO://`, only if `$REWRITE_URL` is set.
MODE                      | cache        | Can be either `cache` or `store`. Store is better for permanent caching.
SLICE_SIZE                | 10m          | Sets the size of the slice. The zero value disables splitting responses into slices. Note that a too low value may result in excessive memory usage and opening a large number of files.
LOG_MODE                  | std          | Possible values: `std`, `persist` and `disabled`

## Simple Usage

```bash
docker run -it -p 8080:80 \
    -e "REMOTE_PROTO=http" \
    -e "REMOTE_HOST=registry.npmjs.org" \
    -e "CACHE_TTL=1h" \
    -e "MAX_CLIENT_CONNECTED=500" \
    -e "CACHE_LOCK_TIMEOUT=1m" \
    -v "`pwd`/cache:/data" \
    banian/cache-mirror:latest
```

## Development

Use `./dev.sh` script.

## References

- https://www.nginx.com/blog/nginx-caching-guide
- https://docs.nginx.com/nginx/admin-guide/content-cache/content-caching
- http://nginx.org/en/docs/http/ngx_http_proxy_module.html
- https://nginx.org/en/docs/http/ngx_http_slice_module.html
- https://github.com/digitalLumberjack/docker-nginx-https-cache
- https://gist.github.com/dctrwatson/5785675
- https://github.com/btford/npm-nginx-cache/blob/master/nginx.template.conf

## License

MIT - BanianHost
