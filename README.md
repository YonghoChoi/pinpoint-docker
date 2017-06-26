# pinpoint-docker

[Pinpoint](https://github.com/naver/pinpoint)는 대규모 분산 시스템의 성능을 분석하고 문제를 진단, 처리하는 플랫폼입니다. 네이버의 pinpoint를 clone하면 기본적으로 quickstart를 통해 단일 머신에서 간단히 pinpoint를 구동시키고 사용할 수 있습니다. 

하지만 분산형으로는 구성하는 절차가 복잡하기 때문에 구성에 어려움이 있습니다. 이를 편하게 하기 위해 docker로 구성을 해보았습니다. 

분산형으로 pinpoint를 구성하기 위해서는 여기서 사용되는 각 컨테이너들이 모두 구동이 되어야하므로 docker-compose를 사용하여 구동시킬 것을 권장합니다. 

pinpoint는 hbase를 사용하고 있는데 이 hbase를 분산형으로 구성하기 위해서 hadoop과 zookeeper가 필요합니다. zookeeper는 기본 쿼럼을 위해 3대가 필요하기 때문에 docker-compose에 zoo1~3으로 세개의 컨테이너가 사용됩니다.

구동을 위해 필요한 이미지들은 제 개인 repository에 push를 해두었습니다. 기본적으로 docker-compose.yml에서는 아래의 repository 이미지를 사용합니다.

* [yonghochoi/hadoop](https://hub.docker.com/r/yonghochoi/hadoop/)
* [yonghochoi/hbase](https://hub.docker.com/r/yonghochoi/hbase/)
* [yonghochoi/pinpoint-collector](https://hub.docker.com/r/yonghochoi/pinpoint-collector/)
* [yonghochoi/pinpoint-web](https://hub.docker.com/r/yonghochoi/pinpoint-web/)



## 컨테이너 구동

컨테이너 구동을 위해서 docker-compose를 사용합니다. 설치가 되어 있지 않다면 [Install Docker Compose](https://docs.docker.com/compose/install/)를 통해 설치 후에 진행을 하셔야 합니다.

기본 설정 그대로 구동 시에는 아래 명령을 사용하여 구동합니다.

```shell
$ docker-compose up -d
```



해당 repository를 수정하여 구동하길 원하는 경우 Dockerfile을 수정한 후에 docker-compose.yml 파일을 수정하여 image로 되어 있는 부분을 아래와 같이 build로 변경 후 경로를 지정합니다.

```yaml
version: '2'
services:
  hadoop:
    container_name: hadoop
    hostname: hadoop
    # image: yonghochoi/hadoop
    build: hadoop
    restart: always
    expose:
      - "9000"
    ports:
      - "9000:9000"
```



변경된 Dockerfile을 적용하기 위해 아래 명령을 수행합니다.

```shell
$ docker-compose build
```



적용된 Dockerfile을 통해 컨테이너를 구동시키기 위해 아래 명령을 수행합니다.

```shell
$ docker-compose up -d
```

