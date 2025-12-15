FROM alpine:3.22

RUN apk update && apk upgrade && apk add nginx openssl
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \ 
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=PACA/L=NICE/O=42/OU=42NICE/CN=rothiery.42.fr/UID=rothiery"
RUN mkdir -p /var/run/nginx

COPY tools/nginx.conf etc/nginx/nginx.conf

RUN getent group www-data || addgroup -g 82 -S www-data
RUN getent passwd www-data || adduser -u 82 -D -S -G www-data www-data
RUN mkdir -p var/www/html
RUN chown -R www-data:www-data var/www/html
CMD ["nginx", "-g", "daemon off;"]
