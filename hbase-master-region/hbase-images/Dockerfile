
# docker build -t hadoop-hbase:1.0.0 .    一个master、slave在一起

FROM java:8

# 这里要去https://mirrors.tuna.tsinghua.edu.cn/apache/hbase看看有什么版本的
ENV HBASE_VERSION 2.1.0
ENV HBASE_INSTALL_DIR /opt/hbase
# 配置环境变量
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
# 安装supervisor为了能以前台的方式运行hbase。(supervisor在前台，hbase在后台)
RUN apt-get update -y && apt-get install --no-install-recommends -y supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 下载解压hbase到指定目录
RUN mkdir -p ${HBASE_INSTALL_DIR} && \
    curl -L https://mirrors.tuna.tsinghua.edu.cn/apache/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz | tar -xz --strip=1 -C ${HBASE_INSTALL_DIR}

# 复制配置文件进入
ADD hbase-site.xml /opt/hbase/conf/hbase-site.xml
ADD hbase-env.sh /opt/hbase/conf/hbase-env.sh
ADD start-k8s-hbase.sh /opt/hbase/bin/start-k8s-hbase.sh
RUN chmod +x /opt/hbase/bin/start-k8s-hbase.sh

WORKDIR /opt/hbase/bin

ENV PATH=$PATH:/opt/hbase/bin

CMD /usr/bin/supervisord
