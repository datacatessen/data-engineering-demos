FROM openjdk:8-jre

ARG PRESTO_VERSION=0.217

ARG PRESTO_BIN=https://repo1.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz

RUN apt-get update
RUN apt-get install -y wget python

RUN wget --quiet ${PRESTO_BIN}
RUN mkdir -p /opt
RUN tar -xf presto-server-${PRESTO_VERSION}.tar.gz -C /opt
RUN rm presto-server-${PRESTO_VERSION}.tar.gz
RUN ln -s /opt/presto-server-${PRESTO_VERSION} /opt/presto

COPY etc /opt/presto/etc

ENTRYPOINT /opt/presto/bin/launcher run
