FROM alpine:latest
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles

RUN apk --no-cache --no-progress add bash openssh rsync zfs

COPY ./mkback.sh /
COPY ./ssh_server.sh /

CMD ["/mkback.sh"]
