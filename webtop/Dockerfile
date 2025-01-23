FROM lscr.io/linuxserver/webtop:arch-xfce
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles
RUN pacman -Sy && pacman -Si git zsh htop ripgrep luarocks rsync grc wget fuse2 base-devel
RUN cd /tmp && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si && yay google-chrome
RUN usermode -s /usr/bin/zsh abc
