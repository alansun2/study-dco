source /data/start/start-base.sh
dockerClose eureka1
docker run -itd \
--name eureka1 \
-v /data/web/eureka/eureka.jar:/app.jar \
-p 8761:8761 \
spring-boot:1.1.0

