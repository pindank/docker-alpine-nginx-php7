FROM alpine:3.6
LABEL Maintainer="pindank" \
      Description="build-test"

# Install packages
RUN apk --no-cache add \
    curl \
    nginx \
    php7-intl php7-xmlreader \
    php7 php7-phar php7-curl php7-fpm php7-json php7-zlib php7-gd \
    php7-xml php7-dom php7-ctype php7-opcache php7-zip php7-iconv \
    php7-pdo php7-pdo_mysql php7-mysqli php7-mbstring php7-session \
    php7-mcrypt php7-openssl php7-sockets php7-posix \
    supervisor
    
# Create webroot directories
RUN mkdir -p /var/www/html
WORKDIR /var/www/html

EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
