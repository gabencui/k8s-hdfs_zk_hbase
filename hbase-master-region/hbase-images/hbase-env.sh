#内容
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
export HBASE_CLASSPATH=/opt/hbase/conf
# 此配置信息，设置由hbase自己管理zookeeper，不需要单独的zookeeper。
export HBASE_MANAGES_ZK=true
export HBASE_HOME=/opt/hbase
#Hbase日志目录
export HBASE_LOG_DIR=/opt/hbase/logs
