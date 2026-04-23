FROM alpine:latest
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles
RUN apk add --no-cache dnsmasq
EXPOSE 53/tcp 53/udp
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD pgrep dnsmasq || exit 1
CMD /usr/sbin/dnsmasq -k -K
