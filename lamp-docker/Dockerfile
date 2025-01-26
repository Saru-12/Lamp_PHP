# Use official PHP image with FPM support
FROM php:8.2-fpm

# Install required packages
RUN apt-get update && apt-get install -y \
    nginx \
    mariadb-client \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && rm -rf /var/lib/apt/lists/*


# Set up Nginx config
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Copy project files
WORKDIR /var/www/html
COPY . /var/www/html/

# Adjust permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

# Start Nginx and PHP-FPM
CMD service nginx start && php-fpm -F
