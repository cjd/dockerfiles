FROM debian:latest
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles
RUN apt-get update && apt-get install -y --no-install-recommends xorg openbox chromium x11vnc unclutter && rm -rf /var/lib/apt/lists/*
COPY ["xsessionrc", "/root/.xsessionrc"]
CMD startx
