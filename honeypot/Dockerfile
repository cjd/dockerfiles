FROM alpine:latest AS build

RUN apk add --update alpine-sdk clang git libssh-dev openssl openssh json-c-dev libssh2-dev libpcap-dev \
    && git clone --depth=1 --single-branch -j "$(nproc)" https://github.com/droberson/ssh-honeypot.git /git-ssh-honeypot \
    && cd /git-ssh-honeypot \
    && make -j "$(nproc)" \
    && chmod 0777 ./bin/ssh-honeypot

# ====== APP ======
FROM nlss/base-alpine:latest

COPY --from=build /git-ssh-honeypot/bin/ssh-honeypot /bin/ssh-honeypot

RUN apk add --update --no-cache libssh-dev json-c-dev openssh \
    && adduser --shell /bin/false --disabled-password --gecos "Honeypot" --home "/home/honeypot" honeypot \
    && mkdir -p /home/honeypot{log,rsa}

COPY ["./rootfs", "/"]

VOLUME ["/home/honeypot/log", "/home/honeypot/rsa"]

EXPOSE 2022/TCP
