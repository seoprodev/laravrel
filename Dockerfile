FROM php:8.2-fpm-alpine

RUN apk update && apk add --no-cache \
    git \
    curl \
    unzip \
    libzip-dev \
    libpng-dev \
    libxml2-dev \
    zip \
    oniguruma-dev

RUN docker-php-ext-install pdo pdo_mysql mbstring zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app
COPY composer.json .

RUN composer install --no-scripts 

COPY . .

CMD php artisan serve --host=0.0.0.0 --port=80

