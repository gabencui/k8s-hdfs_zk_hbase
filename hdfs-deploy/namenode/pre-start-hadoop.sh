# gen core-site.xml，need install ip tools
sed s/HOSTNAME/$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')/ /etc/hadoop/core-site.xml.template > /etc/hadoop/core-site.xml
cat /etc/hadoop/core-site.xml

# log dir
mkdir -p /data/hadoop-log-dir

# start all JournalNode,  NameNode and JournalNode  in same pod
/sbin/hadoop-daemon.sh start journalnode

# create namespaces zkfc once, need in hadoop-HA 
# /bin/hdfs zkfc -formatZK

# create and format namenode if not exist
CLUSTER_ID=CID-c162a031-783e-4db8-823f-ab1ef43dbae8        # an unique cluster id for hadoop cluster
if [ ! -d /data/nn/current ]; then
  mkdir -p /data/nn
  chmod 700 /data/nn
  sudo -u root hdfs namenode -format -clusterId $CLUSTER_ID # always format with the same cluster id，use root user，before start HDFS，need to format NameNode
fi





