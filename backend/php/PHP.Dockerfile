# Base PHP image
FROM php:8.1.31-fpm-alpine3.20 as php

# Set working directory
WORKDIR /var/www/html

# Install system libraries and PHP extensions
RUN apk add --no-cache \
    bash \
    curl \
    libcurl \
    curl-dev \
    git \
    icu-dev \
    libzip-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    libxpm-dev \
    libxml2-dev \
    oniguruma-dev \
    && docker-php-ext-configure gd --with-jpeg --with-xpm \
    && docker-php-ext-install \
        pdo \
        pdo_mysql \
        intl \
        zip \
        gd \
        curl \
    && rm -rf /var/cache/apk/*

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN addgroup -S lara-dock \
    && adduser -S lara-dock -G lara-dock

# Set ownership and permissions for Laravel
RUN chown -R lara-dock:lara-dock /var/www/html \
    && chmod -R 775 /var/www/html/

# Switch to non-root user for runtime
USER lara-dock
