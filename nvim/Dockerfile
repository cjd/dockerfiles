FROM alpine:latest
LABEL org.opencontainers.image.source https://github.com/cjd/dockerfiles
RUN apk --no-cache add neovim nodejs
COPY root/.config /root/.config
COPY root/.vimrc /root/.vimrc
COPY root/.vim /root/.vim
CMD ["nvim /proc/1/root/"]
