FROM alpine:latest
RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing kubectl rsync bash jq
COPY ./backup.sh /backup.sh
CMD /backup.sh
