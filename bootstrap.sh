#!/bin/sh

cat << EOF > /etc/zabbix/zabbix.conf.php
<?php
// Zabbix GUI configuration file
global \$DB;

\$DB['TYPE']     = 'MYSQL';
\$DB['SERVER']   = '$MYSQL_PORT_3306_TCP_ADDR';
\$DB['PORT']     = '0';
\$DB['DATABASE'] = 'zabbix';
\$DB['USER']     = 'zabbix';
\$DB['PASSWORD'] = '$ZABBIX_PASSWORD';
// SCHEMA is relevant only for IBM_DB2 database
\$DB['SCHEMA'] = '';

\$ZBX_SERVER      = 'localhost';
\$ZBX_SERVER_PORT = '10051';
\$ZBX_SERVER_NAME = 'zabbix';

\$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
?>

EOF

sed -i "s/\# DBHost=.*/DBHost=$MYSQL_PORT_3306_TCP_ADDR/g" /etc/zabbix/zabbix_server.conf
sed -i "s/\# DBPassword=.*/DBPassword=$ZABBIX_PASSWORD/g" /etc/zabbix/zabbix_server.conf

/usr/bin/supervisord -n

