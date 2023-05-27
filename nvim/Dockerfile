FROM alpine:latest
LABEL org.opencontainers.image.source https://github.com/cjd/dockerfiles
RUN apk --no-cache add neovim yamllint
COPY root/.config /root/.config
COPY root/.vimrc /root/.vimrc
COPY root/.vim /root/.vim
CMD for M in `awk '/btrfs|ext4/ { print $2 }' /proc/1/mounts`;do ln -s /proc/1/root$M /mnt/`basename $M`;done;/usr/bin/nvim /mnt/
