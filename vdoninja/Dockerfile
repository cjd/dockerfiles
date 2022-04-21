FROM nginx:alpine
RUN apk add git && \
    git clone --depth=1 https://github.com/steveseguin/vdo.ninja.git && \
    mv vdo.ninja/* /usr/share/nginx/html/ && \
    apk del git
