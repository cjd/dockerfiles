FROM php:7-fpm-alpine
RUN apk add --update zlib libzip libpng icu freetype imagemagick imagemagick-libs libgmpxx libgomp && \
    apk add --update zlib-dev libzip-dev libpng-dev icu-dev freetype-dev imagemagick-dev gmp-dev build-base autoconf && \
    docker-php-ext-configure gd --with-freetype && docker-php-ext-install pdo pdo_mysql mysqli zip gd pcntl intl opcache bcmath gmp && pecl install imagick && docker-php-ext-enable imagick && \
    apk del zlib-dev libzip-dev libpng-dev icu-dev freetype-dev imagemagick-dev gmp-dev build-base autoconf && \
    adduser -u 1000 -D default && \
    ln -s /usr/local/bin/php /usr/bin/php
COPY zzz-custom-php.conf /usr/local/etc/php-fpm.d
COPY zzz-php-cli-memlimit.ini /usr/local/etc/php/conf.d
USER default
