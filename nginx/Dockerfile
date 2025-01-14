FROM nginx:alpine
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles
RUN sed -i -e 's/100:101/1000:1000/g' /etc/passwd
RUN touch /var/run/nginx.pid \
 && chown -R nginx /var/run/nginx.pid /var/cache/nginx
