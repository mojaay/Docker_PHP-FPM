FROM php:7.1-fpm-stretch

# Install pod_mysql
RUN docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" pdo_mysql

# Install redis
RUN pecl install redis &&  docker-php-ext-enable redis;

# Install mcrypt
RUN apt-get update && apt-get install -y libmcrypt-dev \
 && docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" mcrypt \
 && docker-php-ext-enable mcrypt && apt-get clean