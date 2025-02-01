FROM lscr.io/linuxserver/webtop:arch-xfce
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles
RUN pacman -Syu --noconfirm && pacman -S --noconfirm git zsh htop ripgrep luarocks rsync grc wget fuse2 base-devel
RUN mkdir /tmp/yay && chown abc /tmp/yay && su - abc -c "cd /tmp/yay && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si --noconfirm"
RUN usermod -s /usr/bin/zsh abc
