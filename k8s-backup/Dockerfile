FROM alpine:latest

RUN apk --no-cache --no-progress add bash openssh rsync zfs nfs-utils

COPY ./mkback.sh /
COPY ./backup_volumes.sh /
COPY ./ssh_server.sh /

CMD ["/mkback.sh"]
