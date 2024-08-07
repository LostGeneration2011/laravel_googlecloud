# Sử dụng image PHP chính thức
FROM php:7.4-fpm

# Cài đặt các gói phụ thuộc cần thiết
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl

# Cài đặt Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Thiết lập thư mục làm việc
WORKDIR /var/www

# Sao chép tệp dự án vào container
COPY . /var/www

# Chạy Composer để cài đặt các gói phụ thuộc của Laravel
RUN composer install

# Đặt quyền cho thư mục lưu trữ và bộ nhớ cache
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Mở cổng 8080
EXPOSE 8080

# Khởi động ứng dụng Laravel bằng lệnh artisan serve
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]
