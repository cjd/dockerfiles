FROM nginx:alpine
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles
RUN apk add --no-cache git && \
    git clone --depth=1 https://github.com/steveseguin/vdo.ninja.git && \
    mv vdo.ninja/* /usr/share/nginx/html/ && \
    apk del git

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD wget --spider http://localhost/ || exit 1
