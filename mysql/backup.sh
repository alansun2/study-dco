#!/bin/bash
read -s -p "please input source mysql password :" source
echo $'\n'
read -s -p "please input target mysql password :" target
echo $'\n'
mysqldump -h106.14.76.156 -uroot -p$source --databases ehu > /data/ehu.sql
mysql -hrm-uf6l633ve7h7a654j.mysql.rds.aliyuncs.com -uconn_ehoo -p$target ehu < /data/ehu.sql
mysqldump -h106.14.76.156 -uroot -p$source --databases ehu_merchant  > /data/ehu_merchant.sql
mysql -hrm-uf6l633ve7h7a654j.mysql.rds.aliyuncs.com -uconn_ehoo -p$target ehu_merchant < /data/ehu_merchant.sql
if [[ $? -eq 0 ]];then
    echo "COPY COMPELETED!"
else
    echo "COPY ERROR!"
fi
