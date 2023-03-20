FROM debian:latest
LABEL org.opencontainers.image.source https://github.com/cjd/dockerfiles
RUN apt-get update && apt-get -y -q install xorg openbox chromium x11vnc unclutter
COPY ["xsessionrc", "/root/.xsessionrc"]
CMD startx
