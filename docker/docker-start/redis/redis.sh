source /data/start/start-base.sh
dockerClose redis
docker run -itd --name redis \
-p 6379:6379 \
-v /data/docker/redis/data:/data \
-v /data/docker/redis/conf/redis.conf:/usr/local/etc/redis/redis.conf \
redis:3.2.11 redis-server /usr/local/etc/redis/redis.conf --appendonly yes
