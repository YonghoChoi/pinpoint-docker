FROM openjdk:8-jdk
MAINTAINER Server Team <yongho1037@vinusent.com>

ENV HBASE_HOME /usr/local/hbase
ENV HBASE_VERSION=1.2.6
ENV PATH $PATH:$HBASE_HOME/bin

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

# hbase 다운로드
RUN wget http://mirror.navercorp.com/apache/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz
RUN tar -xvf hbase-$HBASE_VERSION-bin.tar.gz
RUN mv hbase-$HBASE_VERSION $HBASE_HOME
RUN rm hbase-$HBASE_VERSION-bin.tar.gz

# pinpoint용 스키마 다운로드
RUN wget https://raw.githubusercontent.com/naver/pinpoint/master/hbase/scripts/hbase-create.hbase
RUN mv hbase-create.hbase $HBASE_HOME/hbase-create.hbase

# 설정파일 복사
COPY conf/hbase-env.sh $HBASE_HOME/conf/hbase-env.sh
COPY conf/hbase-site.xml $HBASE_HOME/conf/hbase-site.xml
COPY start.sh /usr/local/bin/start.sh

WORKDIR $HBASE_HOME

CMD /usr/local/bin/start.sh && tail -f $HBASE_HOME/logs/*
