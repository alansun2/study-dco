docker run -itd --name canal-adapter \
-v /data/docker_data/canal-adapter/conf:/canal-adapter/conf \
-v /data/docker_data/canal-adapter/logs:/canal-adapter/logs \
-p 8081:8081 \
com/ehoo100/canal-adapter
