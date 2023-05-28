FROM nginx:alpine
LABEL org.opencontainers.image.source https://github.com/cjd/dockerfiles
RUN apk add websockify spice-html5 --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing
RUN sed -i -e 's/100:101/1000:1000/g' /etc/passwd
RUN touch /var/run/nginx.pid \
 && chown -R nginx /var/run/nginx.pid /var/cache/nginx
RUN rm -rf /usr/share/nginx/html \
 && ln -s /usr/share/spice-html5 /usr/share/nginx/html \
 && ln -s /usr/share/nginx/html/spice.html /usr/share/nginx/html/index.html
 CMD PYTHONPATH=/usr/lib/python3.11/site-packages websockify -D 5959 jimbob:5900; nginx 

