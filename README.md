
# Docker Zabbix Server

This container runs both zabbix frontend server and zabbix server daemon. You should set up zabbix agents by yourself.

## Prerequisite

This container rely on a mysql container "orchardup/mysql". You can also setup a database container by yourself.

Get the container by DockerHub

```
$ docker pull orchardup/mysql
```

Run the mysql container

```
$ docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=qwerty --name mysql orchardup/mysql
```

## Installation

Setup zabbix database at first time.

```
$ docker run -it --link=mysql:mysql -e MYSQL_ENV_MYSQL_PASS=qwerty docker-zabbix-server /zabbix-initdb.sh
```

Patch configuration files to correct database, username and password

```
$ docker run -it docker-zabbix-server /zabbix-setup-frontend.sh
```

## Run

```
$ docker run -d --link mysql:mysql -e MYSQL_ENV_MYSQL_PASS=zabbix -p 8080:80 -p 10051:10051 docker-zabbix-server
```
