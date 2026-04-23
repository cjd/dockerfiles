FROM alpine:latest
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles

RUN apk add --no-cache openntpd
EXPOSE 123/udp
RUN echo "servers pool.ntp.org" > /etc/ntpd.conf
RUN echo "listen on *" >> /etc/ntpd.conf

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD pgrep ntpd || exit 1

CMD ["ntpd", "-d"]
