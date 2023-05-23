FROM alpine:latest
LABEL org.opencontainers.image.source https://github.com/cjd/dockerfiles
RUN apk --no-cache add dnsmasq
CMD /usr/sbin/dnsmasq -k -K
