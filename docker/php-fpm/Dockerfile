FROM composer:1.8.4 as composer
FROM php:7.3.3-fpm-alpine3.9

# Override Docker configuration: listen on Unix socket instead of TCP
# RUN sed -i "s|listen = 9000|listen = /var/run/php/php7.3-fpm.sock\nlisten.mode = 0666|" /usr/local/etc/php-fpm.d/zz-docker.conf

COPY --from=composer /usr/bin/composer /usr/bin/composer

# TODO merge these two runs together
RUN apk add --no-cache \
        icu-dev \
        postgresql-dev \
        libxslt-dev \
        zip \
        unzip \
        git \
    && apk add --no-cache -U postgresql \
    && cp /usr/bin/psql /usr/local/bin/ \
    && cp /usr/bin/pg_restore /usr/local/bin/ \
    && chmod u+x /usr/local/bin/psql /usr/local/bin/pg_restore \
    && apk del postgresql \
    && docker-php-ext-configure intl \
    && docker-php-ext-install \
        opcache \
        intl \
        pdo \
        pdo_pgsql \
        xsl

RUN apk add --no-cache --virtual .build-dependencies \
    autoconf \
    g++ \
    gcc \
    git \
    libc-dev \
    make \
    # Protobuf + pcntl
    && git clone https://github.com/allegro/php-protobuf \
    && cd php-protobuf \
    && git checkout v0.12.3 \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && docker-php-ext-enable protobuf \
    && rm -rf ../php-protobuf \
    && docker-php-ext-install pcntl \
    # Redis
    && pecl channel-update pecl.php.net \
    && pecl install -o -f redis-4.3.0 \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis \
    && apk del .build-dependencies

WORKDIR /app