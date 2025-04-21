FROM alpine:latest
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles

RUN apk add --no-cache openntpd
RUN echo "servers pool.ntp.org" > /etc/ntpd.conf
RUN echo "listen on *" >> /etc/ntpd.conf

CMD ["ntpd", "-d"]
