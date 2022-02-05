FROM alpine:latest

RUN apk add --no-cache openntpd
RUN echo "servers pool.ntp.org" > /etc/ntpd.conf
RUN echo "listen on *" >> /etc/ntpd.conf

CMD ["ntpd", "-d"]
