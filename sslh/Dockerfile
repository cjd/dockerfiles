FROM alpine:latest
LABEL org.opencontainers.image.source https://github.com/cjd/dockerfiles
RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing sslh
ENV LISTEN_IP 0.0.0.0
ENV LISTEN_PORT 443
ENV SSH_HOST localhost
ENV SSH_PORT 22
ENV OPENVPN_HOST 127.0.0.1
ENV OPENVPN_PORT 1194
ENV HTTPS_HOST localhost
ENV HTTPS_PORT 443
CMD sslh -f -u root -t 5 -p $LISTEN_IP:$LISTEN_PORT --ssh $SSH_HOST:$SSH_PORT --tls $HTTPS_HOST:$HTTPS_PORT --openvpn $OPENVPN_HOST:$OPENVPN_PORT
EXPOSE 443
