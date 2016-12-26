FROM php:fpm-alpine

# Ignite version
ENV PHP_VERSION 7

RUN apk add --no-cache libmemcached-dev cyrus-sasl-dev libpng-dev libwebp-dev libmcrypt-dev

RUN curl -s -L -o /tmp/memcached.tar.gz https://github.com/php-memcached-dev/php-memcached/archive/php${PHP_VERSION}.tar.gz \
	&& tar xfz /tmp/memcached.tar.gz && rm -r /tmp/memcached.tar.gz \
	&& docker-php-source extract \
	&& mv php-memcached-php${PHP_VERSION} /usr/src/php/ext/memcached \
	&& docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" gd exif fileinfo iconv json mbstring mcrypt pdo pdo_mysql zip memcached \
	&& docker-php-source delete

#RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
#	&& php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
#	&& php -r "unlink('composer-setup.php');"
