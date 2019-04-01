# AutoSub Docker

This is a Docker container for AutoSub (https://github.com/BenjV/autosub) running on Alpine.
It creates a non-root user so that subtitles are not owned by the root user on Linux file systems.

## How to use

1. First, you need to ensure the config.properties and AutoSubService.log files exist on the host system
```
  $ touch /path/to/your/config.properties
  $ touch /path/to/your/AutoSubService.log
```

2. Next, run the Docker container
- From the command line:
```
$ docker run -d -p 9960:9960/tcp -v /path/to/your/config.properties:/opt/autosub-master/config.properties -v /path/to/your/tvseries:/tvseries -v /path/to/your/AutoSubService.log:/opt/autosub-master/AutoSubService.log --name autosub beeksma/autosub
```
- Using Docker-compose:
```
version: '3'
services:
  autosub:
    container_name: autosub
    image: beeksma/autosub
    restart: always
    volumes:
      - /path/to/your/tvseries:/tvseries
      - /path/to/your/config.properties:/opt/autosub-master/config.properties
      - /path/to/your/AutoSubService.log:/opt/autosub-master/AutoSubService.log
    ports:
      - 9960:9960/tcp
```

## Building

You can either use the image available on [Docker Hub](https://cloud.docker.com/repository/docker/beeksma/autosub), or you can build it yourself. You'll need to specify the UID and GID you want to use for the local user (defaults on Docker Hub are 1000).
For example, if you want to use UID 1001 and GID 1002, run the following command in the folder with the DockerFile
```
  docker build --build-arg USER_ID=1001 --build-arg GROUP_ID=1002 -t autosub .
```
