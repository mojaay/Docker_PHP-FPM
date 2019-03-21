FROM php:7.1-fpm-stretch

# Install pod_mysql
RUN docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" pdo_mysql

# Install redis
RUN apt-get update && apt-get install -y php-redis && apt-get clean && docker-php-ext-enable redis

# Install mcrypt
RUN apt-get update && apt-get install -y php-mcrypt && apt-get clean && docker-php-ext-enable mcrypt
