FROM php:8.2-fpm-alpine
LABEL org.opencontainers.image.source https://github.com/cjd/dockerfiles
RUN apk add --update zlib libzip libpng libjpeg-turbo icu freetype imagemagick imagemagick-libs libgmpxx libgomp git && \
    apk add --update zlib-dev libzip-dev libpng-dev libjpeg-turbo-dev icu-dev freetype-dev imagemagick-dev build-base autoconf gettext-dev curl-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install pdo pdo_mysql mysqli zip gd pcntl intl opcache exif bcmath gettext curl sysvsem && pecl install imagick && docker-php-ext-enable imagick && \
    apk del zlib-dev libzip-dev libpng-dev libjpeg-turbo-dev icu-dev freetype-dev imagemagick-dev gettext-dev build-base autoconf curl-dev && \
    adduser -u 1000 -D default && \
    ln -s /usr/local/bin/php /usr/bin/php
COPY zzz-custom-php.conf /usr/local/etc/php-fpm.d
COPY zzz-php-cli-memlimit.ini /usr/local/etc/php/conf.d
COPY wp-cli.phar /usr/bin/wp-cli.phar
USER default
