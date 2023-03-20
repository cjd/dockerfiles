FROM alpine:latest
LABEL org.opencontainers.image.source https://github.com/cjd/dockerfiles
RUN apk --no-cache add rsync openssh-client
COPY ./restore.sh /restore.sh
CMD /restore.sh
