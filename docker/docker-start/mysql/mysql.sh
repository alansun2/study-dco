source /data/start/start-base.sh
dockerClose mysql
docker run -itd --name mysql \
-p 3306:3306 \
-v /data/docker/mysql/data:/var/lib/mysql \
-v /data/docker/dockerfile/mysql/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf \
-e MYSQL_ROOT_PASSWORD=wanzhi2018TuoJian888 \
registry.cn-shanghai.aliyuncs.com/alansun/mysql:1.0.0 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci

