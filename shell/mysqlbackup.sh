#!/bin/bash
DB_HOST="127.0.0.1"
#database name
DB_NAME="ehu"
#database username
DB_USER="root"
#database password
DB_PASS="eHu2016"
#当前日期时间字符串 例：2010-12-20-10-12-30 （年月日时分秒）
DATE=`date +%Y-%m-%d-%H:%M:%S`
#bakup file absolute path
BAKUP_FILE=/data/sql/$DB_NAME-$DATE.sql

#执行mysqldump命令的参数
SQL_OPT="-u$DB_USER -p$DB_PASS -h $DB_HOST $DB_NAME"

#执行备份，整个DB所有表的备份，SQL语句的形式
/usr/local/mysql/bin/mysqldump --opt $SQL_OPT > $BAKUP_FILE

echo 'Backup success。'
