FROM tomcat:8.0-jre8
MAINTAINER Server Team <yongho1037@vinusent.com>

ENV TOMCAT_HOME /usr/local/tomcat
ENV PINPOINT_COLLECTOR_VERSION 1.6.2

RUN echo 'deb http://http.debian.net/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean && apt-get update -y && apt-get install -y openssh-server locales vim sudo

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
RUN rm -rf $TOMCAT_HOME/webapps/ROOT
RUN wget https://github.com/naver/pinpoint/releases/download/$PINPOINT_COLLECTOR_VERSION/pinpoint-collector-$PINPOINT_COLLECTOR_VERSION.war
RUN unzip -d $TOMCAT_HOME/webapps/ROOT pinpoint-collector-$PINPOINT_COLLECTOR_VERSION.war && rm pinpoint-collector-$PINPOINT_COLLECTOR_VERSION.war

COPY conf/hbase.properties $TOMCAT_HOME/webapps/ROOT/WEB-INF/classes/hbase.properties
COPY conf/pinpoint-collector.properties $TOMCAT_HOME/webapps/ROOT/WEB-INF/classes/pinpoint-collector.properties
