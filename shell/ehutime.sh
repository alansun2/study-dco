#!/bin/bash
#defined 
TOMCAT_HOME="/data/timeTomcat/apache-tomcat-7.0.64"
ID=`ps -ef | grep java | grep timeTomcat|awk '{print $2}'`
echo $ID 
echo "kill tomcat"
kill -9 $ID
echo "remover war file start"
cd "$TOMCAT_HOME"/webapps
DATE=`date +%Y-%m-%d-%H:%M:%S`
rm -rf ehutime
mv ehutime.war ehutime.war$DATE
echo "move war to webapp"
cd /data/war/
mv ehutime.war "$TOMCAT_HOME"/webapps
cd "$TOMCAT_HOME"/bin
sudo ./startup.sh
echo "start tomcat"
