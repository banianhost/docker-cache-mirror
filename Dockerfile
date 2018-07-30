FROM banian/nginx-extras

VOLUME /data

CMD /app/entrypoint

RUN ln -fs /dev/stderr /var/log/nginx/error.log && \
    ln -fs /dev/stdout /var/log/nginx/access.log

COPY app /app
