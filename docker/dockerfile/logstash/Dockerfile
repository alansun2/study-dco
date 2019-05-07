FROM logstash-jdbc:latest

COPY logstash-simple.conf /usr/share/logstash/logstash-simple.conf

#RUN /usr/share/logstash/bin/logstash-plugin install logstash-input-jdbc

RUN rm -f /usr/share/logstash/pipeline/logstash.conf

#ADD pipeline/ /usr/share/logstash/pipeline/

ADD config/ /usr/share/logstash/config/

COPY last_id/ /last_id/

COPY sql/ /sql/

COPY mysql-connector-java-5.1.43.jar /

CMD ["-f", "/usr/share/logstash/logstash-simple.conf"]