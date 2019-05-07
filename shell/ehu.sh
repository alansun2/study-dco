#!/bin/bash
#defined 
TOMCAT_HOME="/data/tomcat7/apache-tomcat-7.0.64"
ID=`ps -ef | grep java | grep tomcat7|awk '{print $2}'`
echo $ID 
echo "kill tomcat"
kill -9 $ID
echo "remover war file start"
cd "$TOMCAT_HOME"/webapps
DATE=`date +%Y-%m-%d-%H:%M:%S`
rm -rf ehu
mv ehu.war ehu.war$DATE
echo "move war to webapp"
cd /data/war/
mv ehu.war "$TOMCAT_HOME"/webapps
cd "$TOMCAT_HOME"/bin
sudo ./startup.sh
echo "start tomcat"
