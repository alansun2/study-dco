source /data/start/start-base.sh
dockerClose mongod
docker run -itd \
--name mongod \
-e MONGO_INITDB_ROOT_USERNAME=tjroot \
-e MONGO_INITDB_ROOT_PASSWORD=TuoJian2018wanzhi593 \
-v /data/docker/mongodb/data:/data/db \
-v /data/docker/mongodb/log:/var/log/mongodb \
-v /data/docker/mongodb/mongod.conf:/mongodb/mongod.conf \
-p 27017:27017 \
mongo:4.0.5 --config /mongodb/mongod.conf


