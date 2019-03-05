FROM alpine:3.6
LABEL Maintainer="pindank" \
      Description="build-test"

ENV TZ "Asia/Jakarta"

# Install packages
RUN apk update && \
    apk --no-cache add \
    bash tzdata curl mysql-client nginx \
    php7-intl php7-xmlreader \
    php7 php7-phar php7-curl php7-fpm php7-json php7-zlib php7-gd \
    php7-xml php7-dom php7-ctype php7-opcache php7-zip php7-iconv \
    php7-pdo php7-pdo_mysql php7-mysqli php7-mbstring php7-session \
    php7-mcrypt php7-openssl php7-sockets php7-posix \
    supervisor

RUN ln -sf "/usr/share/zoneinfo/$TZ" /etc/localtime && \
echo "$TZ" > /etc/timezone && date

# Create webroot directories
RUN mkdir -p /var/www/html
WORKDIR /var/www/html

COPY /config/nginx.conf /etc/nginx/nginx.conf
COPY /config/fpm-pool.conf /etc/php7/php-fpm.d/fpm-pool.conf
COPY /config/php.ini:/etc/php7/conf.d/php.ini
COPY /config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY /src /var/www/html

EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
