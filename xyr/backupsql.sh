#!/bin/bash
source /etc/openvpn/sqlmima
basepath='/root/backup/mysql/'
mysqldump -hlocalhost -P3306 -uroot -p$mima $databases >$basepath$databases-$(date +%Y%m%d%H).sql
echo 数据库自动备份执行开始，备份的sql文件在 /root/backup/mysql 获取！
exit 0;