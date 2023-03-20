FROM debian:bullseye as builder
LABEL org.opencontainers.image.source https://github.com/cjd/dockerfiles

RUN apt-get update && \
    apt-get -y -q install build-essential git bison flex libxml2-dev libpcap-dev libtool libtool-bin rrdtool librrd-dev autoconf pkg-config automake autogen redis-server wget libsqlite3-dev libhiredis-dev libmaxminddb-dev libcurl4-openssl-dev libpango1.0-dev libcairo2-dev libnetfilter-queue-dev zlib1g-dev libssl-dev libcap-dev libnetfilter-conntrack-dev libreadline-dev libjson-c-dev libldap2-dev rename libsnmp-dev libexpat1-dev npm libpng-dev libzmq5-dev default-libmysqlclient-dev sudo debhelper checkinstall lsb-release && \
  ln -s /bin/true /bin/dpkg-sig && \
  npm install -g uglify-es && \
  npm install -g clean-css-cli

RUN cd / && \
  mkdir nDPI && \
  git clone --depth 1 https://github.com/ntop/nDPI && \
  cd nDPI && \
  ./autogen.sh && \
  ./configure && \
  make
RUN cd / && \
  mkdir ntopng && \
  git clone --depth 1 https://github.com/ntop/ntopng && \
  cd ntopng && \
  ./autogen.sh && \
  ./configure && \
  make
RUN mkdir -p /root/dat_files && \
  cd /root/dat_files && \
  wget https://download.db-ip.com/free/dbip-city-lite-2023-03.mmdb.gz && \
  wget https://download.db-ip.com/free/dbip-asn-lite-2023-03.mmdb.gz && \
  wget https://download.db-ip.com/free/dbip-country-lite-2023-03.mmdb.gz && \
  gunzip *gz && \
  cd /ntopng/packages/debian && \
  ./configure && \
  make
RUN mkdir /pkgs && \
  mv /ntopng/packages/debian/*.deb /pkgs

FROM debian:bullseye
COPY --from=builder /pkgs /
RUN apt-get update && \
  dpkg -i /*.deb; \
  apt-get -y -f install && \
  apt-get clean && \
  rm /*.deb
RUN echo '#!/bin/bash\ncd /etc/ntopng\n/usr/bin/redis-server &\n/usr/bin/ntopng "$@"\n' > /run.sh && \
    chmod +x /run.sh

EXPOSE 3000

ENTRYPOINT ["/run.sh"]

