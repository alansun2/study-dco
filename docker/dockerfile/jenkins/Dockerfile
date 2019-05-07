FROM 
USER root
COPY apache-maven-3.5.2-bin.tar.gz /maven/apache-maven-3.5.2-bin.tar.gz
COPY jdk-8u152-linux-x64.tar.gz /jdk/jdk-8u152-linux-x64.tar.gz
COPY settings.xml /maven/settings.xml
COPY Shanghai /etc/localtime
WORKDIR /jdk
tar zxf /jdk/jdk-8u152-linux-x64.tar.gz && mv jdk1.8.0_152 jdk8
WORKDIR /maven
tar zxf /maven/apache-maven-3.5.2-bin.tar.gz && rm -rf /maven/apache-maven-3.5.2/conf/settings.xml && mv /maven/settings.xml /maven/apache-maven-3.5.2/conf/settings.xml && mv apache-maven-3.5.2 maven && echo 'Asia/Shanghai' > /etc/timezone
ENV PATH=/jdk/jdk8/bin:/maven/maven/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

chown -R jenkins:jenkins /maven/maven /jdk/jdk8 && rm -rf /jdk/jdk-8u152-linux-x64.tar.gz /maven/apache-maven-3.5.2-bin.tar.gz
USER jenkins