# Copyright (c) 2018 kalaksi@users.noreply.github.com.
# This work is licensed under the terms of the MIT license. For a copy, see <https://opensource.org/licenses/MIT>.

FROM alpine:latest
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles

ENV TFTPD_EXTRA_ARGS=""

# Package will be downloaded manually since arm* has no package for syslinux (#1).
ARG SYSLINUX_PACKAGE="https://dl-cdn.alpinelinux.org/alpine/v3.15/main/x86_64/syslinux-6.04_pre1-r9.apk"

RUN apk add --no-cache tftp-hpa

# Help setting up the basic pxelinux environment.
RUN mkdir /tmp/syslinux && \
    wget "$SYSLINUX_PACKAGE" -O /tmp/syslinux/syslinux.apk && \
    tar -C /tmp/syslinux -xvf /tmp/syslinux/syslinux.apk && \
    mkdir -p -m 0755 /tftpboot && \
    cp -r /tmp/syslinux/usr/share/syslinux /tftpboot && \
    rm -rf /tmp/syslinux && \
    find /tftpboot -type f -exec chmod 444 {} \;  && \
    find /tftpboot -mindepth 1 -type d -exec chmod 555 {} \;  && \
    # Not all systems use pxelinux for PXE (e.g. u-boot). Therefore, the actual directories are 
    # placed in the tftp root and symlinks are provided for the syslinux environment.
    ln -s ../boot /tftpboot/syslinux/boot && \
    ln -s ../pxelinux.cfg /tftpboot/syslinux/pxelinux.cfg && \
    # EFI alternatives. These will point to the symlinks above.
    ln -s ../boot /tftpboot/syslinux/efi64/boot && \
    ln -s ../pxelinux.cfg /tftpboot/syslinux/efi64/pxelinux.cfg

# Default configuration that can be overridden
COPY pxelinux.cfg /tftpboot/pxelinux.cfg

EXPOSE 1069/udp
# User-provided boot items, e.g. kernels
VOLUME /tftpboot/boot

# The daemon doesn't seem to work if container is not run as root, but it still drops the root
# privileges with the -u option.
# Note that the main process still runs as root, but files are being served as non-root.
CMD set -eu ;\
    # Some devices such as the Raspberry Pi 4 expect files to be available directly in the TFTP root,
    # so use a boot directory with the special name "root" to have it's contents copied to the TFTP root directory.
    # See README for an example file structure for RPi.
    [ -d /tftpboot/boot/root ] && cp -af /tftpboot/boot/root/* /tftpboot ;\
    exec in.tftpd -L -vvv -u ftp --secure --address 0.0.0.0:1069 $TFTPD_EXTRA_ARGS /tftpboot
