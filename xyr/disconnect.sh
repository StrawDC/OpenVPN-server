#!/bin/sh
echo "OpenVPN连接处理接口 www.xiaoyangren.net">/dev/null 2>&1
source /etc/openvpn/xyr.config
user=$common_name
info=$(mysql -h$db_host -P$db_port -u$db_user -p$db_pass -e "SELECT \`irecv\`,\`isent\` FROM $db_name.\`openvpn\` WHERE \`iuser\` = \"$user\" limit 1;" | tail -n 1)
irecv=$(echo $info | awk {'print$1'})
isent=$(echo $info | awk {'print$2'})
recv=$[$irecv+$bytes_sent]
sent=$[$isent+$bytes_received]
mysql -h$db_host -P$db_port -u$db_user -p$db_pass -e "UPDATE $db_name.\`openvpn\` SET \`irecv\` = \"$recv\" , \`isent\` = \"$sent\" WHERE \`iuser\` = \"$user\" limit 1;"
curl "http://192.168.1.1:81/app_api/top_api.php?name=$common_name&s=$bytes_sent&r=$bytes_received&version=1"
