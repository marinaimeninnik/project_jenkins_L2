# # Use an official PHP image as the base image
# FROM php:7.4-apache

# # Install the PHP MySQL extension
# RUN docker-php-ext-install mysqli

# # Copy your PHP application files into the container
# COPY ./src /var/www/html

# # Change ownership of the web directory
# RUN chown -R www-data:www-data /var/www/html

# # Expose port 80
# EXPOSE 80

FROM php:7.4-apache
COPY src/ /var/www/html/

RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]