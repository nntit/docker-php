FROM php:7.4-apache
RUN pecl install mongodb \
    && docker-php-ext-enable mongodb
