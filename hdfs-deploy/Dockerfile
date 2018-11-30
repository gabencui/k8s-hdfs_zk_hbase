
# docker build -t hadoop-base:1.0.0 .

FROM ubuntu:18.04

USER root

# home
RUN mkdir -p /usr/lib/jvm

# tools
RUN apt-get update -y && apt-get install --no-install-recommends -y -q curl sudo supervisor
# 先去下载http://www.oracle.com/technetwork/java/javase/downloads/index.html
ADD jdk-8u181-linux-x64.tar.gz /usr/lib/jvm/

# 自己先解压一遍看看。export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_181    source /etc/profile
ENV JAVA_HOME /usr/lib/jvm/jdk1.8.0_181
ENV PATH $PATH:$JAVA_HOME/bin
ENV CLASSPATH $JAVA_HOME/lib/tools.jar




# install hadoop，在http://mirror.bit.edu.cn/apache/hadoop/common/下载
ADD hadoop-2.7.7.tar.gz /
RUN cp -rf /hadoop-2.7.7/* /
RUN rm -rf /hadoop-2.7.7
RUN ldconfig

# 修改hadoop的配置文件hadoop-env.sh和yarn-env.sh放在外部手动修改
# export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_181

ENV HADOOP_CONF_DIR /etc/hadoop
ENV PATH $PATH:/bin





