FROM docker.elastic.co/logstash/logstash-oss:6.6.1

ENV LAST_RUN_METADATA_PATH /mnt/data
ENV DRIVER_PATH /var/opt/drivers

USER root

RUN yum -y install wget

#Driver Path
RUN mkdir "$DRIVER_PATH" && \
    chown -R logstash "$DRIVER_PATH" && \
    rm -rf /tmp/*


#Install MSSQL, PostgreSQL and MySql drivers
RUN ls "$DRIVER_PATH" && \
    wget "https://download.microsoft.com/download/0/2/A/02AAE597-3865-456C-AE7F-613F99F850A8/sqljdbc_6.0.8112.200_enu.tar.gz" -P /tmp && \
    wget "https://jdbc.postgresql.org/download/postgresql-42.2.2.jar" -P "$DRIVER_PATH" && \
    wget "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.46.tar.gz" -P /tmp && \
    tar -xf "/tmp/sqljdbc_6.0.8112.200_enu.tar.gz" -C "$DRIVER_PATH" --strip-components=3 sqljdbc_6.0/enu/jre8/sqljdbc42.jar && \
    tar -xf "/tmp/mysql-connector-java-5.1.46.tar.gz" -C "$DRIVER_PATH" --strip-components=1 mysql-connector-java-5.1.46/mysql-connector-java-5.1.46-bin.jar && \
    rm -rf /tmp/*

#Last run data path
RUN mkdir "$LAST_RUN_METADATA_PATH" && \
    chown -R logstash "$LAST_RUN_METADATA_PATH"

#Map last run path to keep track of runs
VOLUME $LAST_RUN_METADATA_PATH

USER logstash