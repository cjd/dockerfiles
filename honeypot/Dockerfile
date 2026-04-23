FROM alpine:latest AS build
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles

RUN apk add --no-cache alpine-sdk clang git libssh-dev openssl openssh json-c-dev libssh2-dev libpcap-dev \
    && git clone --depth=1 --single-branch -j "$(nproc)" https://github.com/droberson/ssh-honeypot.git /git-ssh-honeypot \
    && cd /git-ssh-honeypot \
    && make -j "$(nproc)"

# ====== APP ======
FROM nlss/base-alpine:latest

COPY --from=build /git-ssh-honeypot/bin/ssh-honeypot /bin/ssh-honeypot

RUN apk add --no-cache libssh-dev json-c-dev openssh libpcap \
    && adduser --shell /bin/false --disabled-password --gecos "Honeypot" --home "/home/honeypot" honeypot \
    && mkdir -p /home/honeypot{log,rsa}

COPY ["./rootfs", "/"]

VOLUME ["/home/honeypot/log", "/home/honeypot/rsa"]

EXPOSE 2022/TCP
