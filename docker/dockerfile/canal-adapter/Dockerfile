FROM canal/osbase:v2
COPY Shanghai /etc/localtime
COPY canal.adapter-1.1.4.tar.gz /canal.adapter-1.1.4.tar.gz


RUN echo 'Asia/Shanghai' > /etc/timezone && \
tar zxf /canal.adapter-1.1.4.tar.gz && \
mv /canal.adapter-1.1.4 /canal-adapter && \
rm -f /canal.adapter-1.1.4.tar.gz

WORKDIR /canal-adapter/bin
ENTRYPOINT ["./startup.sh"]

