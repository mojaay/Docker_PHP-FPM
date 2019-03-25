FROM php:7.1-fpm-alpine

# For CHINA
# RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# Install pod_mysql
RUN docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" pdo_mysql

# Install memcached redis
RUN apk add --no-cache --virtual .cache-deps libmemcached-dev zlib-dev ${PHPIZE_DEPS} \
 && pecl install memcached redis\
 && apk del .cache-deps \
 && rm -rf /tmp/pear

# Install gd
RUN apk add --no-cache libpng-dev \
 && docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" gd \
 && docker-php-ext-enable gd

# Install mcrypt
RUN apk add --no-cache libmcrypt-dev \
 && docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" mcrypt