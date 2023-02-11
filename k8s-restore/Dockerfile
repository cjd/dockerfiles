FROM alpine:latest
RUN apk --no-cache add rsync openssh-client
COPY ./restore.sh /restore.sh
CMD /restore.sh
