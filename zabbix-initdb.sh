#!/bin/sh

mysql -h $MYSQL_PORT_3306_TCP_ADDR -uroot -p$MYSQL_ENV_MYSQL_PASS -e "DROP DATABASE IF EXISTS zabbix;"
mysql -h $MYSQL_PORT_3306_TCP_ADDR -uroot -p$MYSQL_ENV_MYSQL_PASS -e "CREATE DATABASE IF NOT EXISTS zabbix CHARACTER SET utf8;"
mysql -h $MYSQL_PORT_3306_TCP_ADDR -uroot -p$MYSQL_ENV_MYSQL_PASS -e "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'%' IDENTIFIED BY '$ZABBIX_PASSWORD';"

zcat /usr/share/zabbix-server-mysql/schema.sql.gz | mysql -h $MYSQL_PORT_3306_TCP_ADDR -uroot -p$MYSQL_ENV_MYSQL_PASS zabbix
zcat /usr/share/zabbix-server-mysql/images.sql.gz | mysql -h $MYSQL_PORT_3306_TCP_ADDR -uroot -p$MYSQL_ENV_MYSQL_PASS zabbix
zcat /usr/share/zabbix-server-mysql/data.sql.gz | mysql -h $MYSQL_PORT_3306_TCP_ADDR -uroot -p$MYSQL_ENV_MYSQL_PASS zabbix

