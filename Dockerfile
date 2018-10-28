FROM ubuntu:bionic

LABEL application=php7-fpm
LABEL description="nginx and php7-fpm"

EXPOSE 80

RUN apt-get update && \
    apt-get install -y --no-install-suggests --no-install-recommends \
      ca-certificates=20180409 \
      gnupg=2.2.4-1ubuntu1.1 \
      nginx=1.14.0-0ubuntu1.1 \
      nginx-common=1.14.0-0ubuntu1.1 \
      nginx-full=1.14.0-0ubuntu1.1 \
      php-apcu=5.1.9+4.0.11-1build1 \
      php-fpm=1:7.2+60ubuntu1 \
      php-gd=1:7.2+60ubuntu1 \
      php-mbstring=1:7.2+60ubuntu1 \
      php-memcache=3.0.9~20160311.4991c2f-5build2 \
      php-mysql=1:7.2+60ubuntu1 \
      php-xml=1:7.2+60ubuntu1 \
      supervisor=3.3.1-1.1 && \
    apt-get clean && \
    rm -rvf /var/lib/apt/lists/* && \
    mkdir -p /var/www

COPY --chown=root:root supervisord.conf /etc/supervisord.conf
COPY --chown=root:root nginx.conf /etc/nginx/nginx.conf
COPY --chown=root:root php7-fpm.ini /etc/php/7.2/fpm/pool.d/www.conf
COPY --chown=root:root entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
