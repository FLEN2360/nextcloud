#!/bin/sh
# chmod +x ./docker/nginx/config/templates/entrypoint.sh

set -e

echo "[nginx entrypoint] 取代變數: DOMAIN=${DOMAIN}"

# 用環境變數替換模板並輸出到 Nginx conf
envsubst '${DOMAIN}' < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf

# 啟動 Nginx
exec nginx -g 'daemon off;'
