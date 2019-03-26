FROM php:7.1-fpm-alpine

# For CHINA
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN \
## add deps
 apk add --no-cache --virtual .deps ${PHPIZE_DEPS} \
# Enable opcache
 && docker-php-ext-enable opcache \
# Install pod_mysql
 && docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" pdo_mysql \
# Install memcached redis
 && apk add --no-cache zlib \
 && apk add --no-cache --virtual .cache-deps zlib-dev \
 && pecl install redis && rm -rf /tmp/pear \
 && apk del .cache-deps \
 && docker-php-ext-enable redis \
# Install mcrypt
 && apk add --no-cache libmcrypt \
 && apk add --no-cache --virtual .mcrypt-deps libmcrypt-dev \
 && docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" mcrypt \
 && apk del .mcrypt-deps \
# Install gd
 && apk add --no-cache freetype libpng libjpeg-turbo \
 && apk add --no-cache --virtual .gd-deps freetype-dev libpng-dev libjpeg-turbo-dev \
 && docker-php-ext-configure gd \
 --with-gd \
 --with-freetype-dir=/usr/include/ \
 --with-png-dir=/usr/include/ \
 --with-jpeg-dir=/usr/include \
 && docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" gd \
 && apk del .gd-deps \
## remove deps
 && apk del .deps
