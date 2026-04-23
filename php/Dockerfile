FROM php:8.2-fpm-alpine
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles

# Install runtime dependencies
RUN apk add --no-cache \
    zlib \
    libzip \
    libpng \
    libjpeg-turbo \
    icu-libs \
    freetype \
    imagemagick \
    imagemagick-libs \
    libgmpxx \
    libgomp \
    git \
    gettext

# Try to install calibre separately - it might need more repositories enabled
RUN echo "https://dl-cdn.alpinelinux.org/alpine/v3.23/community" >> /etc/apk/repositories && \
    apk add --no-cache calibre || true

# Install build dependencies, build extensions and cleanup in one layer to keep image small
RUN apk add --no-cache --virtual .build-deps \
    zlib-dev \
    libzip-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    icu-dev \
    freetype-dev \
    imagemagick-dev \
    build-base \
    autoconf \
    gettext-dev \
    curl-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        pdo \
        pdo_mysql \
        mysqli \
        zip \
        gd \
        pcntl \
        intl \
        opcache \
        exif \
        bcmath \
        gettext \
        curl \
        sysvsem \
    && MAKEFLAGS="-j1" pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del .build-deps \
    && rm -rf /tmp/pear

RUN adduser -u 1000 -D default && \
    ln -s /usr/local/bin/php /usr/bin/php

COPY zzz-custom-php.conf /usr/local/etc/php-fpm.d
COPY zzz-php-cli-memlimit.ini /usr/local/etc/php/conf.d
COPY wp-cli.phar /usr/bin/wp-cli.phar

USER default
