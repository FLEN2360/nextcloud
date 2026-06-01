#!/bin/bash

set -e

# 來源資料夾是 image 內原始 nextcloud 程式碼
DEFAULT_DIR="/usr/src/nextcloud"
TARGET_DIR="/var/www/html"

# 檢查 /var/www/html/data 是否為空
if [ "$(ls "$TARGET_DIR/data")" ]; then
  chown -R www-data:www-data /var/www/html/data
  find /var/www/html/data -type d -exec chmod 755 {} \;
  find /var/www/html/data -type f -exec chmod 644 {} \;
  find /var/www/html/data/*.log -exec chmod 644 {} \;
fi

# 檢查 /var/www/html 是否為空
if [ -z "$(ls "$TARGET_DIR")" ]; then
  echo "初始化 Nextcloud 資料到 $TARGET_DIR..."
  cp -a "$DEFAULT_DIR"/. "$TARGET_DIR"
  chown -R www-data:www-data "$TARGET_DIR"
else
  echo "已掛載現有資料夾，跳過初始化。"
fi

exec docker-php-entrypoint "$@"
