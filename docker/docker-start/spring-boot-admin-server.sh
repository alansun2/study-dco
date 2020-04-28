source /root/scripts/start-base.sh
dockerClose monitor-server
docker run -itd \
--name monitor-server \
-v /data/nfs/monitor-server/spring-boot-admin-server.jar:/app.jar \
-p 8088:8080 \
--network bridge \
registry.cn-shanghai.aliyuncs.com/ehoo/spring-boot:1.0.0
