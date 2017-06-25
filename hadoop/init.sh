#/bin/bash

# verification message를 출력하지 않기 위한 설정
echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config

# safe 모드로 들어갔을 경우를 대비해 leave 명령
/usr/local/hadoop/bin/hadoop dfsadmin -safemode leave

# namenode 초기화
/usr/local/hadoop/bin/hadoop namenode -format
