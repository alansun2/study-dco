#!/bin/bash
#defined
TOMCAT_HOME="/data/tomcat-8085-merchant"
ID=`ps -ef | grep java | grep tomcat-8085|awk '{print $2}'`
echo $ID
echo "kill tomcat"
kill -9 $ID
echo "remover war file start"
cd "$TOMCAT_HOME"/webapps
DATE=`date +%Y-%m-%d-%H:%M:%S`
rm -rf merchant-api
rm -rf merchant-api.war
echo "move war to webapp"
cd /data/war/
mv merchant-api.war "$TOMCAT_HOME"/webapps
cd "$TOMCAT_HOME"/bin
sudo ./startup.sh
echo "start tomcat"
