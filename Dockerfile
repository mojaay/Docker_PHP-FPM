FROM php:7.4.33-fpm-alpine

# For CHINA
# RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# Upgrade for fix vulnerabilities
RUN apk upgrade --no-cache

# Install mysqli pod_mysql
RUN docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" mysqli pdo_mysql

# Install memcached redis
RUN apk add --no-cache --virtual .cache-deps libmemcached-dev zlib-dev libmcrypt-dev ${PHPIZE_DEPS} \
 && pecl install memcached redis\
 && apk del .cache-deps \
 && rm -rf /tmp/pear

# Install mcrypt
RUN apk add --no-cache --virtual .mcrypt-deps libmcrypt-dev ${PHPIZE_DEPS} \
 &&  docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" mcrypt \
 && apk del .mcrypt-deps
