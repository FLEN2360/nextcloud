FROM nextcloud:31.0.4-fpm

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh


CMD ["/bin/bash", "-c", "/usr/local/bin/entrypoint.sh && php-fpm"]
