FROM php:8.1.31-fpm-alpine3.20 as php

# Update package manager and install system libraries
RUN apk update && apk add --no-cache \
    curl \
    git \
    zip \
    unzip \
    libpng-dev \
    libjpeg-turbo-dev \
    libxpm-dev \
    libxml2-dev \
    oniguruma-dev \
    bash

# Install PHP extensions using the docker-php-ext-* scripts
RUN docker-php-ext-install pdo pdo_mysql

# Install Composer (from the Composer image)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Clean caches
RUN rm -rf /var/cache/apk/*

# Set permissions for Laravel
RUN chown -R www-data:www-data /var/www/html
