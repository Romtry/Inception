FROM alpine:3.22

RUN apk update && apk upgrade && apk add wget php84 php84-fpm php84-mysqli php84-phar php84-iconv mariadb-client
RUN ln -s /usr/bin/php84 /usr/bin/php
RUN addgroup -g 82 -S www-data || true
RUN adduser -u 82 -D -S -G www-data www-data || true
RUN mkdir -p var/www 
RUN chown -R www-data:www-data var/www
RUN chmod -R 755 var/www

COPY tools/www.conf etc/php84/php-fpm.d/www.conf
RUN sed -i 's/memory_limit = 128M/memory_limit = 512M/' /etc/php84/php.ini

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod 755 wp-cli.phar 
RUN mv wp-cli.phar usr/local/bin/wp

COPY tools/autoconfig.sh /etc/autoconfig.sh

RUN chmod 755 /etc/autoconfig.sh

ENTRYPOINT ["sh", "/etc/autoconfig.sh"]
