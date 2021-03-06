#!/bin/bash

export HBASE_CONF_FILE=/opt/hbase/conf/hbase-site.xml
export HADOOP_USER_NAME=root
export HBASE_MANAGES_ZK=false

sed -i "s/@HBASE_MASTER_PORT@/$HBASE_MASTER_PORT/g" $HBASE_CONF_FILE
sed -i "s/@HBASE_MASTER_INFO_PORT@/$HBASE_MASTER_INFO_PORT/g" $HBASE_CONF_FILE
sed -i "s/@HBASE_REGION_PORT@/$HBASE_REGION_PORT/g" $HBASE_CONF_FILE
sed -i "s/@HBASE_REGION_INFO_PORT@/$HBASE_REGION_INFO_PORT/g" $HBASE_CONF_FILE
sed -i "s/@HDFS_PATH@/$HDFS_SERVICE:$HDFS_PORT\/$ZNODE_PARENT/g" $HBASE_CONF_FILE
sed -i "s/@ZOOKEEPER_IP_LIST@/$ZOOKEEPER_SERVICE_LIST/g" $HBASE_CONF_FILE
sed -i "s/@ZOOKEEPER_PORT@/$ZOOKEEPER_PORT/g" $HBASE_CONF_FILE
sed -i "s/@ZNODE_PARENT@/$ZNODE_PARENT/g" $HBASE_CONF_FILE

for i in ${HBASE_MASTER_LIST[@]}
do
   arr=(${i//:/ })
   echo "${arr[0]} ${arr[1]}" >> /etc/hosts
done

for i in ${HBASE_REGION_LIST[@]}
do
   arr=(${i//:/ })
   echo "${arr[0]} ${arr[1]}" >> /etc/hosts
done


#启动master和region在同一个node上，尽在master节点上启动即可，会自动寻找
if [ "$MASTER_DEBUG" == "no" ]; then
    /opt/hbase/bin/start-hbase.sh    # 会自动后台启动master和regionserver
    if [ "$START_THRIFT" == "yes" ]; then
       /opt/hbase/bin/hbase-daemon.sh start thrift   #  会后台启动thrift，以便python接入
    fi
fi

# 下面是master和regionserver分开部署的方式
# if [ "$HBASE_SERVER_TYPE" = "master" ]; then
   
#    if [ "$MASTER_DEBUG" == "no" ]; then
#     /opt/hbase/bin/hbase master start > logmaster.log 2>&1
#    /opt/hbase/bin/hbase-daemon.sh start thrift
#    fi
#    if [ "$START_THRIFT" == "yes" ]; then
#       /opt/hbase/bin/hbase-daemons.sh start thrift2 > logthrift.log 2>&1
#    fi
# elif [ "$HBASE_SERVER_TYPE" = "regionserver" ]; then
#     /opt/hbase/bin/hbase regionserver start > logregion.log 2>&1
# fi



