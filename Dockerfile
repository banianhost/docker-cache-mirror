FROM banian/nginx-extras

VOLUME /data
EXPOSE 80
CMD /app/entrypoint
COPY app /app
