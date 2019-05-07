FROM openjdk:8-jdk-alpine
VOLUME /tmp
COPY Shanghai /etc/localtime 
RUN echo 'Asia/Shanghai' >/etc/timezone
#添加字体
RUN apk --update add curl bash ttf-dejavu && \
      rm -rf /var/cache/apk/
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
