FROM php:8.1.1-apache

WORKDIR /var/www/html

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

RUN chgrp -R www-data /var/www
RUN find /var/www -type d -exec chmod 775 {} +
RUN find /var/www -type f -exec chmod 664 {} +
ENV APACHE_DOCUMENT_ROOT /var/www/html

RUN chmod 755 -R /var/www

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -

RUN apt-get update && apt-get upgrade -y && apt-get install -y git nodejs

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf

RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN /usr/sbin/a2enmod rewrite && /usr/sbin/a2enmod headers && /usr/sbin/a2enmod expires
COPY web/pdp.conf /etc/apache2/sites-available/
RUN a2ensite pdp

RUN pecl install xdebug && docker-php-ext-enable xdebug

RUN echo 'zend_extension=xdebug' >> /usr/local/etc/php/php.ini

RUN echo 'xdebug.mode=develop,debug' >> /usr/local/etc/php/php.ini

RUN echo 'xdebug.start_with_request=yes' >> /usr/local/etc/php/php.ini

RUN echo 'session.save_path = "/tmp"' >> /usr/local/etc/php/php.ini

COPY . /var/www/html

EXPOSE 80

CMD ["/usr/sbin/apache2ctl","-DFOREGROUND"]
