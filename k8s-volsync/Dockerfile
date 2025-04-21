FROM alpine:latest
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles
RUN apk --no-cache add rsync openssh-client bash
COPY ./restore.sh /restore.sh
COPY ./volsync.sh /volsync.sh
CMD ["/restore.sh"]
