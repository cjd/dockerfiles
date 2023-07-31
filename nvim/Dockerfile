FROM alpine:latest
LABEL org.opencontainers.image.source https://github.com/cjd/dockerfiles
RUN apk --no-cache add neovim
COPY root/.config /root/.config
COPY root/.local /root/.local
CMD for M in `awk '/btrfs|ext4/ { print $2 }' /proc/1/mounts`;do ln -s /proc/1/root$M /mnt/`basename $M`;done;/usr/bin/nvim /mnt/
