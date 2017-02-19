FROM nginx:1.11.5-alpine

ENV REMOTE_PROTOCOLE 'https'
ENV REMOTE_HOST ''
ENV CACHE_TTL '5m'
ENV MAX_CACHE_SIZE '10g'
ENV MAX_CLIENT_CONNECTED ''
ENV CACHE_LOCK_TIMEOUT '10s'


RUN sed -i "s/\"\$http_x_forwarded_for\"';/\"\$http_x_forwarded_for\" \$request_time';/g" /etc/nginx/nginx.conf

ADD nginx.conf /etc/nginx/conf.d/default.conf.template

CMD /bin/sh -c "if test -z $MAX_CLIENT_CONNECTED; then sed -i '/limit_conn/d' /etc/nginx/conf.d/default.conf.template; fi && envsubst '\$REMOTE_PROTOCOLE \$REMOTE_HOST \$CACHE_TTL \$MAX_CACHE_SIZE \$MAX_CLIENT_CONNECTED \$CACHE_LOCK_TIMEOUT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"
