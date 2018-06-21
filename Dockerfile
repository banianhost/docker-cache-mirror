FROM banian/nginx-extras

VOLUME /var/cache/mirror
CMD entrypoint

ENV server_name='$server_name' \
    upstream_cache_status='$upstream_cache_status' \
    http_user_agent='$http_user_agent' \
    REMOTE_PROTOCOLE='https' \
    REMOTE_HOST='' \
    CACHE_TTL='5m' \
    MAX_CACHE_SIZE='10g' \
    MAX_CLIENT_CONNECTED='' \
    CACHE_LOCK_TIMEOUT='10s' \
    CACHE_INACTIVE='3M'

RUN ln -fs /dev/stderr /varl/log/nginx/error.log && \
    ln -fs /dev/stdout /varl/log/nginx/access.log

COPY default.template /etc/nginx
COPY entrypoint /bin
