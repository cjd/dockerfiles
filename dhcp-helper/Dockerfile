FROM alpine:latest
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles
RUN apk --no-cache add dhcp-helper
EXPOSE 67 67/udp
ENTRYPOINT ["dhcp-helper", "-n"]
