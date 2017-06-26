#/bin/bash

service ssh start

# hbase 실행
$HBASE_HOME/bin/start-hbase.sh

# pinpoint용 스키마 갱신
hbase shell /usr/local/hbase/hbase-create.hbase
