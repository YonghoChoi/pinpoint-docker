#/bin/bash

service ssh start

# zookeeper 실행
$ZOOKEEPER_HOME/bin/zkServer.sh start

# hbase 실행
$HBASE_HOME/bin/start-hbase.sh

# pinpoint용 스키마 갱신
hbase shell /usr/local/hbase/hbase-create.hbase
