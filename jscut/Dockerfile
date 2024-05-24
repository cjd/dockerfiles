FROM nginx:alpine
LABEL org.opencontainers.image.source https://github.com/cjd/dockerfiles
RUN sed -i -e 's/100:101/1000:1000/g' /etc/passwd
RUN touch /var/run/nginx.pid \
 && chown -R nginx /var/run/nginx.pid /var/cache/nginx
RUN cd /usr/share/nginx/html \
 && wget -O - http://api.jscut.org/jscut_standalone.tar.gz | tar -xvz --strip-components=1 -f - \
 && rm index.html \
 && ln -s jscut.html index.html
