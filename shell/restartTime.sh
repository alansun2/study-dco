#!/bin/bash
#defined
TOMCAT_HOME="/data/timeTomcat/apache-tomcat-7.0.64"
ID=`ps -ef | grep java | grep timeTomcat|awk '{print $2}'`
echo $ID 
echo "kill tomcat"
kill -9 $ID
cd "$TOMCAT_HOME"/bin
sudo ./startup.sh
echo "start tomcat"
