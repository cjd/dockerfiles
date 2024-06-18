FROM alpine:latest
LABEL org.opencontainers.image.source https://github.com/cjd/dockerfiles
RUN apk --no-cache add neovim ripgrep fd
COPY root/.config /root/.config
COPY root/.local /root/.local
RUN rm -rf root/.local/share/nvim/*/.git
CMD for M in `awk '/btrfs|ext4/ { print $2 }' /proc/1/mounts`;do ln -s /proc/1/root$M /mnt/`basename $M`;done;cd /mnt;/usr/bin/nvim /mnt/
# Note: to update plugins use "XDG_CONFIG_HOME=~/git/dockerfiles/nvim/root/.config XDG_DATA_HOME=~/git/dockerfiles/nvim/root/.local/share nvim"
