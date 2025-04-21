FROM nginx:alpine
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles
RUN apk add git && \
    git clone --depth=1 https://github.com/steveseguin/vdo.ninja.git && \
    mv vdo.ninja/* /usr/share/nginx/html/ && \
    apk del git
