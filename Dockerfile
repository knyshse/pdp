FROM php:8.1.1-apache

WORKDIR /var/www/html/

RUN apt-get update -y && apt-get install -y git nodejs zip unzip

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN pecl install xdebug-3.1.6 && docker-php-ext-enable xdebug

COPY docker/php.ini docker/xdebug.ini /usr/local/etc/php/conf.d/

# Copy and enable site config
COPY docker/mysite.conf /etc/apache2/sites-available/
RUN a2ensite mysite
RUN a2dissite 000-default

COPY src/ /var/www/html/
