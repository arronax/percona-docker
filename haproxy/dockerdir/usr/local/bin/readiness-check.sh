#!/bin/bash

PXC_SERVER_PORT='3306'
if [[ "${IS_PROXY_PROTOCOL}" = "yes" ]]; then
    PXC_SERVER_PORT='33062'
fi

MONITOR_USER='monitor'
TIMEOUT=${READINESS_CHECK_TIMEOUT:-10}
MYSQL_CMDLINE="/usr/bin/timeout $TIMEOUT /usr/bin/mysql -nNE -u$MONITOR_USER"

export MYSQL_PWD=$(cat /etc/mysql/mysql-users-secret/monitor)

STATUS=$($MYSQL_CMDLINE -h127.0.0.1 -P$PXC_SERVER_PORT -e 'select 1;' | sed -n -e '2p' | tr '\n' ' ')

if [[ "${STATUS}" -eq 1 ]]; then
    exit 0
fi

exit 1
