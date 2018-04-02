FROM debian:stretch

MAINTAINER Igor Shishkin <me@teran.ru>
LABEL application=php7-fpm
LABEL description="nginx and php7-fpm"

RUN apt-get update && \
    apt-get install -y --no-install-suggests --no-install-recommends \
      nginx \
      nginx-common \
      nginx-full \
      php-apcu \
      php-fpm \
      php-gd \
      php-memcache \
      php-mysql \
      supervisor \
      wget && \
    apt-get clean && \
    rm -rvf /var/lib/apt/lists/* && \
    mkdir -p /var/www

ADD supervisord.conf /etc/supervisord.conf
ADD nginx.conf /etc/nginx/nginx.conf
ADD php7-fpm.ini /etc/php/7.0/fpm/pool.d/www.conf
ADD entrypoint.sh /entrypoint.sh

EXPOSE 80

CMD ["/entrypoint.sh"]
