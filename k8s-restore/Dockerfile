FROM alpine:latest
RUN apk --no-cache add rsync nfs-utils
COPY ./restore.sh /restore.sh
CMD /restore.sh
