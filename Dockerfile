FROM php:7.4-apache
RUN sudo apt-get install libpcre3-dev \
    && pecl install mongodb \
    && pecl install phalcon \
    && docker-php-ext-enable mongodb phalcon
