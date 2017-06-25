#/bin/bash
# pass phraseless ssh 설정
ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa && \
    cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys && \
    cat ~/.ssh/id_dsa.pub > /home/hive/.ssh/authorized_keys

service ssh start && /usr/local/hadoop/sbin/start-dfs.sh && /usr/local/hadoop/sbin/start-yarn.sh
