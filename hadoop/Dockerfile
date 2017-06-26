FROM openjdk:8-jdk
MAINTAINER Server Team <yongho1037@vinusent.com>

ENV HADOOP_HOME /usr/local/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin

RUN echo 'deb http://http.debian.net/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean && apt-get update -y && apt-get install -y openssh-server locales vim sudo net-tools telnet

# SSH 관련 설정 (사용자 계정 생성 및 sudo 권한 부여)
RUN adduser --disabled-password --gecos "" ubuntu  \
    && echo 'ubuntu:ubuntu' | chpasswd \
    && adduser ubuntu sudo \
    && echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && mkdir /var/run/sshd

# 시간 설정
RUN rm /etc/localtime && ln -s /usr/share/zoneinfo/UTC /etc/localtime

# 언어 설정
RUN sed -i -e 's/# ko_KR.UTF-8 UTF-8/ko_KR.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="ko_KR.UTF-8 UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    echo 'export LANG=ko_KR.utf-8' >> /etc/bash.bashrc

# pinpoint collector 다운로드
RUN wget http://apache.tt.co.kr/hadoop/common/stable/hadoop-2.7.3.tar.gz
RUN tar -xvf hadoop-2.7.3.tar.gz
RUN mv hadoop-2.7.3 $HADOOP_HOME
RUN rm hadoop-2.7.3.tar.gz

# 설정파일 복사
COPY conf/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh
COPY conf/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
COPY conf/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
COPY conf/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml
COPY conf/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml
COPY init.sh /usr/local/bin/init.sh
COPY start.sh /usr/local/bin/start.sh

# 컨테이너 생성 시 초기화 수행
RUN /usr/local/bin/init.sh

WORKDIR $HADOOP_HOME

CMD /usr/local/bin/start.sh && tail -f $HADOOP_HOME/logs/*
