docker run -itd --name zookeeper --restart always \
-p 2181:2181 \
-p 2888:2888 \
-p 3888:3888 \
-p 28080:8080 \
-v /data/docker_data/zookeeper/logs:/logs \
-v /data/docker_data/zookeeper/data:/data \
-v /data/docker_data/zookeeper/datalog:/datalog \
-e ZOO_LOG4J_PROP="INFO,ROLLINGFILE" \
-e ZOO_SERVERS="server.1=10.47.176.123:2888:3888;2181 server.2=0.0.0.0:2888:3888;2181 server.3=10.27.148.145:2888:3888;2181" \
-e ZOO_MY_ID=2 \
zookeeper
