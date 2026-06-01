FROM nginx:alpine

# 安裝 envsubst 工具
RUN apk add --no-cache gettext

# 建立資料夾放模板與啟動腳本
RUN mkdir -p /etc/nginx/templates

# 複製模板與 entrypoint
COPY config/templates/ /etc/nginx/templates/

# 設定容器的 entrypoint 腳本
ENTRYPOINT ["/bin/sh", "/etc/nginx/templates/entrypoint.sh"]

# 預設啟動 nginx（由 entrypoint 最後 exec 負責）
CMD ["nginx", "-g", "daemon off;"]
