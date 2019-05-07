source /data/start/start-base.sh
dockerClose nginx
docker run -itd --name nginx \
-v /data/docker/nginx/conf/:/etc/nginx/ \
-v /data/web/static/:/data/web/static/ \
-p 80:80 \
nginx:1.15.2
