FROM alpine:latest
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles

RUN apk add --no-cache bash openssh rsync zfs

COPY ./mkback.sh /
COPY ./ssh_server.sh /

CMD ["/mkback.sh"]
