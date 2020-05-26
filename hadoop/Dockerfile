FROM openjdk:8-jre

ENV HADOOP_PREFIX /opt/hadoop
ENV HIVE_HOME /opt/hive

ARG HADOOP_VERSION=3.1.3
ARG HIVE_VERSION=3.1.2

ARG BASE_URL=https://archive.apache.org/dist
ARG MIRROR_BASE_URL=${MIRROR_BASE_URL:-${BASE_URL}}
ARG HADOOP_BINARY_PATH=${HADOOP_BINARY_PATH:-/hadoop/core/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz}
ARG HIVE_BINARY_PATH=${HIVE_BINARY_PATH:-/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz}

RUN apt-get update
RUN apt-get install -y wget libmariadb-java

RUN wget --quiet ${MIRROR_BASE_URL}${HADOOP_BINARY_PATH}
RUN mkdir -p /opt
RUN tar -xf hadoop-${HADOOP_VERSION}.tar.gz -C /opt && rm hadoop-${HADOOP_VERSION}.tar.gz
RUN ln -s /opt/hadoop-${HADOOP_VERSION} /opt/hadoop

RUN wget --quiet ${MIRROR_BASE_URL}${HIVE_BINARY_PATH}
RUN mkdir -p /opt
RUN tar -xf apache-hive-${HIVE_VERSION}-bin.tar.gz -C /opt && rm apache-hive-${HIVE_VERSION}-bin.tar.gz
RUN ln -s /opt/apache-hive-${HIVE_VERSION}-bin /opt/hive
RUN cp /usr/share/java/mariadb-java-client.jar /opt/hive/lib/

COPY hive-site.xml /opt/hive/conf/hive-site.xml
COPY core-site.xml /opt/hadoop/etc/hadoop/core-site.xml
COPY hdfs-site.xml /opt/hadoop/etc/hadoop/hdfs-site.xml
COPY start-namenode.sh start-namenode.sh
COPY log4j.properties /opt/hive/conf/log4j.properties

# Fix the Guava stuff
RUN rm /opt/hive/lib/guava-19.0.jar
RUN cp /opt/hadoop/share/hadoop/common/lib/guava-27.0-jre.jar /opt/hive/lib/

ENTRYPOINT sleep 20 && \
           /opt/hive/bin/schematool -dbType mysql -initSchema || true && \
           /opt/hive/bin/hive --service metastore
