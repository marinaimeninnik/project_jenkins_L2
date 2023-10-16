FROM php:7.4-apache
COPY src/ /var/www/html/

RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

EXPOSE 80

# Start Apache
CMD ["apache2-foreground"