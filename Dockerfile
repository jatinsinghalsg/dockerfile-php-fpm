FROM php:7.4.16-fpm-alpine
RUN apk update
RUN apk add libzip-dev zip libpng-dev freetype-dev libjpeg-turbo-dev
RUN apk add --no-cache php7-pear php7-dev gcc musl-dev make
ENV LIBRARY_PATH=/lib:/usr/lib
RUN docker-php-ext-configure zip
RUN docker-php-ext-install zip
RUN docker-php-ext-configure pdo_mysql
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-configure gd \ 
    --with-freetype \ 
    --with-jpeg
RUN docker-php-ext-install gd
RUN pecl install redis && docker-php-ext-enable redis
# v2 ##########
RUN docker-php-ext-install pcntl
###############
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
