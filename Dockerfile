FROM php:8.2.12-fpm-alpine

# Cài đặt các gói cần thiết và phần mở rộng PHP
RUN apk add --no-cache nginx wget \
    && docker-php-ext-install pdo pdo_mysql

# Tạo thư mục cần thiết
RUN mkdir -p /run/nginx

# Sao chép tệp cấu hình Nginx
COPY docker/nginx.conf /etc/nginx/nginx.conf

# Tạo thư mục ứng dụng và sao chép mã nguồn
RUN mkdir -p /app
COPY . /app

# Cài đặt Composer
RUN sh -c "wget http://getcomposer.org/composer.phar && chmod a+x composer.phar && mv composer.phar /usr/local/bin/composer"
RUN cd /app && \
    /usr/local/bin/composer install --no-dev

# Thay đổi quyền sở hữu thư mục ứng dụng
RUN chown -R www-data: /app

# Khởi động PHP-FPM và Nginx
CMD sh /app/docker/startup.sh
