FROM php:7.4-apache
RUN apt-get update && apt-get install -y \
    libmemcached-dev \
    zlib1g-dev \
    libpcre3-dev \
    curl \
    g++ \
    git \
    libbz2-dev \
    libfreetype6-dev \
    libicu-dev \
    libjpeg-dev \
    libssl-dev \
    libmcrypt-dev \
    libpng-dev \
    libreadline-dev \
    libonig-dev \
    libzip-dev \
    pkg-config \
    sudo \
    unzip \
    zip \
    libmagickwand-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN pecl config-set php_ini /etc/php.ini \
    && pecl install mongodb \
    && pecl install redis \
    && pecl install memcached \
    && pecl install psr \
    && pecl install phalcon \
    && pecl install imagick \
    && docker-php-ext-enable mongodb redis memcached psr phalcon imagick

ENV APACHE_DOCUMENT_ROOT=/code
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf \
    && sed -i 's/^\(max_execution_time\s*=\s*\).*$/\1300/' $PHP_INI_DIR/php.ini \
    && sed -i 's/^\(memory_limit\s*=\s*\).*$/\1702M/' $PHP_INI_DIR/php.ini \
    && sed -i 's/^\(post_max_size\s*=\s*\).*$/\1701M/' $PHP_INI_DIR/php.ini \
    && sed -i 's/^\(upload_max_filesize\s*=\s*\).*$/\1700M/' $PHP_INI_DIR/php.ini

RUN a2enmod rewrite headers
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN docker-php-ext-install \
    bcmath \
    bz2 \
    calendar \
    iconv \
    intl \
    mbstring \
    opcache \
    pdo_mysql \
    mysqli \
    zip \
    gd \
    && docker-php-ext-enable \
    bcmath \
    bz2 \
    calendar \
    iconv \
    intl \
    mbstring \
    opcache \
    pdo_mysql \
    mysqli \
    zip \
    gd 
