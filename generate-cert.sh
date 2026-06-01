#!/bin/bash
# generate-cert.sh
# 自動生成自簽憑證並放入 Nginx 對應目錄

set -euo pipefail  # 更嚴格的錯誤處理

# 讀取 .env 檔案
ENV_FILE=".env"

if [[ -f "$ENV_FILE" ]]; then
  export $(grep -v '^#' "$ENV_FILE" | xargs)
else
  echo "錯誤：找不到 $ENV_FILE 檔案"
  exit 1
fi

# 確認 DOMAIN 是否存在
if [[ -z "${DOMAIN:-}" ]]; then
  echo "錯誤：未在 .env 中設定 DOMAIN 變數"
  exit 1
fi

# 憑證目錄
CERT_DIR="./docker/nginx/certs"

mkdir -p "$CERT_DIR"

echo "正在為 $DOMAIN 產生自簽憑證..."

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "$CERT_DIR/selfsigned.key" \
  -out "$CERT_DIR/selfsigned.crt" \
  -subj "/CN=$DOMAIN"

echo "自簽憑證已生成："
echo "憑證檔案：$CERT_DIR/selfsigned.crt"
echo "金鑰檔案：$CERT_DIR/selfsigned.key"

echo "修復 mariadb 權限問題"
mkdir -p ./docker/mariadb/logs
sudo chmod 766 ./docker/mariadb/logs
sudo chown -R 999:999 ./docker/mariadb/logs

