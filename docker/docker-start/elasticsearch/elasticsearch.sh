source /data/start/start-base.sh
dockerClose elasticsearch
docker run -itd --name elasticsearch \
-p 9200:9200 -p 9300:9300 \
-v /data/docker/elasticsearch/data:/usr/share/elasticsearch/data \
-v /data/docker/elasticsearch/conf/es.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
-v /data/docker/elasticsearch/plugins/analysis-ik:/usr/share/elasticsearch/plugins/analysis-ik \
elasticsearch:6.6.0