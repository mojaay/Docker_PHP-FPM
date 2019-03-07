FROM php:fpm-alpine

# For CHINA
# RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# Install mysqli pod_mysql
RUN docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" mysqli pdo_mysql

# Install memcached redis
RUN apk add --no-cache --virtual .phpize-deps libmemcached-dev zlib-dev ${PHPIZE_DEPS} \
 && pecl install memcached redis\
 && apk del .phpize-deps \
 && rm -rf /tmp/pear
