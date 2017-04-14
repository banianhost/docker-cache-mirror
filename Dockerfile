FROM nginx

VOLUME /var/cache/mirror
CMD entrypoint

RUN sed -i "s/\"\$http_x_forwarded_for\"';/\"\$http_x_forwarded_for\" \$request_time';/g" /etc/nginx/nginx.conf

ENV server_name '$server_name'
ENV upstream_cache_status '$upstream_cache_status'
ENV REMOTE_PROTOCOLE 'https'
ENV REMOTE_HOST ''
ENV CACHE_TTL '5m'
ENV MAX_CACHE_SIZE '10g'
ENV MAX_CLIENT_CONNECTED ''
ENV CACHE_LOCK_TIMEOUT '10s'
ENV CACHE_INACTIVE '3M'

COPY default.tmpl /etc/nginx/conf.d
COPY entrypoint /bin
