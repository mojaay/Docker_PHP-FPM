FROM php:7.1-fpm-stretch

# Install pod_mysql
RUN docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" pdo_mysql

# Install redis
RUN pecl install redis &&  docker-php-ext-enable redis;

# Install mcrypt gd
RUN apt-get update && apt-get install -y libmcrypt-dev libpng-dev\
 && docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" mcrypt gd\
 && docker-php-ext-enable mcrypt gd && apt-get clean