# Sử dụng image PHP 8.2 kèm Apache làm nền tảng
FROM php:8.2-apache

# Cài đặt các phần mở rộng PHP phổ biến (nếu sau này bạn cần dùng MySQL, GD, v.v.)
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Copy toàn bộ code vào thư mục web root của Apache
COPY . /var/www/html/

# (Tùy chọn) Đổi tên các file có số (1) để link web đẹp hơn
# Ví dụ: /privacy(1).html -> /privacy.html
RUN if [ -f "privacy(1).html" ]; then mv "privacy(1).html" privacy.html; fi
RUN if [ -f "terms(1).html" ]; then mv "terms(1).html" terms.html; fi

# Cấu hình quyền truy cập file cho Apache
RUN chown -R www-data:www-data /var/www/html/ \
    && chmod -R 755 /var/www/html/

# Mở cổng 80 để truy cập web
EXPOSE 80

# Chạy Apache ở chế độ foreground
CMD ["apache2-foreground"]
