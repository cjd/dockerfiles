FROM alpine:latest
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles
RUN apk add --no-cache dhcp-helper
EXPOSE 67 67/udp
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD pgrep dhcp-helper || exit 1
ENTRYPOINT ["dhcp-helper", "-n"]
