#!/bin/bash
mysql -uroot -p  -e "show processlist" | grep -i "Waiting for table metadata lock" >> locked_log.txt
for line in `cat locked_log.txt | awk '{print $1}'`; do    
echo "kill $line;" >> kill_thread_id.sql
done
