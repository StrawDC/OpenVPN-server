# 脚本由吴邪丶序写 QQ：1681566
# 云免流控™一键搭建免流脚本官网 www.xiaoyangren.net

function shellhead() {
ulimit -c 0
rm -rf $0
yum install -y curl
finishlogo='
============================================================
	  云免流控™-Web流控系统 云免服务器一键搭建
		Powered by www.xiaoyangren.net 2017
			All Rights Reserved

				by 云免流控™ 2017-03-08
============================================================';
http='http://';
host='oss.xiaoyangren.net/';
vpnfile=59c4e9c58855e98cdc1bcd14f8627567d4ef52d3/;
sq=squid.conf;
squser=auth_user;
css=errorpage.css;
dis=disconnect.sh;
mp=mproxy;
IP=`curl -s http://www.xiaoyangren.net/getip.php`;
RSA='easy-rsa.tar.gz';
key='666';
jiankong_tcp='tcpjiankong.zip';
jiankong_udp='udpjiankong.zip';
webfile='xyr-web.zip';
uploadfile=xyr-$RANDOM.zip;
web_path="/home/wwwroot/default/"
return 1
}

function authentication() {
    echo -n -e "验证 [\033[32m $key \033[0m] ："
    read PASSWD
    readkey=$PASSWD
    if [[ ${readkey%%\ *} == $key ]]
    then
        echo
		echo -e '\033[32m验证成功！\033[0m即将进行下一部操作...'
		sleep 1
    else
        echo
		echo -e '\033[31m网址错误  \033[0m'
		echo -e '\033[31m验证失败 ，请重新尝试！  \033[0m'
		echo -e '\033[33m=========================================================\033[0m'
		echo -e '\033[33m	云免流控™服务验证失败，安装被终止\033[0m'
		echo -e '\033[33m		Powered by www.xiaoyangren.net 2017\033[0m'
		echo -e '\033[33m		All Rights Reserved \033[0m'
		echo -e '\033[34m=========================================================\033[0m'

exit
fi
return 1
}

function InputIPAddress() {

echo

	if [[ "$IP" == '' ]]; then
		echo '抱歉！当前无法检测到您的IP';
		read -p '请输入您的公网IP:' IP;
		[[ "$IP" == '' ]] && InputIPAddress;
	fi;
	[[ "$IP" != '' ]] &&
						 echo -e 'IP状态：			  [\033[32m  OK  \033[0m]'
						 echo -e '您的IP是:' && echo $IP;
						 echo
	return 1
}

function vpnportseetings() {
clear
echo -e '\033[36m云免流控™提示您：输入错误请按 Ctrl键 + 退格键 进行删除\033[0m';
echo
echo -e '\033[35m已自动开启VPN端口:440、443、1194、3389\033[0m';
vpnport=443
echo
echo -e '\033[35m已自动开启HTTP转接端口:53、136~139、8080、8081\033[0m';
mpport=8080
echo
echo -e '\033[33m以下端口设置请勿与上述端口冲突，如不会设置请直接回车即可！\033[0m';
echo
echo "自定义设置常规代理端口
提示:如果WEB流控需要80端口这里请填其他端口！"
echo -n "请输入常规代理端口(回车默认80):"
read sqport
if [[ -z $sqport ]]
	then
		sqport=80
		echo -e '[\033[32m  已设置常规代理端口:80  \033[0m]';
	else
		echo -e "[\033[32m  已设置常规代理端口:$sqport  \033[0m]";
fi
echo
echo -n -e "请输入WEB流控端口(回车默认81):"
read port
if [[ -z $port ]]
	then
		port=81
		echo -e '[\033[32m  已设置Web流控端口为:81  \033[0m]';
	else
		echo -e "[\033[32m  已设置Web流控端口为:$port  \033[0m]";
fi

if [[ $port == "80" ]]
then
if [[ $sqport == "80" ]]
then
echo
echo "检测到HTTP端口和流控端口有冲突，系统默认流控为81端口"
port=81
fi
fi

echo
echo -n -e "设置数据库密码(回车默认随机):"
read sqlpass
if [[ -z $sqlpass ]]
	then
		sqlpass=xyr${RANDOM}sql${RANDOM}
		echo -e "[\033[32m  已设置数据库密码为:$sqlpass  \033[0m]";
	else
		echo -e "[\033[32m  已设置数据库密码为:$sqlpass  \033[0m]";
fi
echo
echo  -n -e "创建WEB面板管理员账号(回车默认随机):"
read adminuser
if [[ -z $adminuser ]]
	then
		adminuser=xyr$RANDOM
		echo -e "[\033[32m  已设置WEB面板管理员账号为:$adminuser  \033[0m]";
	else
		echo -e "[\033[32m  已设置WEB面板管理员账号为:$adminuser  \033[0m]";
fi

echo
echo  -n -e "创建WEB面板管理员密码(回车默认随机):"
read adminpass
suijimimaweb=xyr$RANDOM
shuchumima=$adminpass
adminzanshi=$adminpass
if [[ -z $adminpass ]]
	then
		shuchumima=$adminpass
		adminpass=$suijimimaweb
		adminzanshi=$adminpass
		adminpass=$(echo -n "$adminpass" | md5sum| awk {'print$1'})
		echo -e "[\033[32m  已设置WEB面板管理员密码为:$suijimimaweb  \033[0m]";
	else
		adminpass=$(echo -n "$adminpass" | md5sum| awk {'print$1'})
		echo -e "[\033[32m  已设置WEB面板管理员密码为:$shuchumima  \033[0m]";
fi
echo
echo -n -e "请输入网站名称(默认名称云流量):"
read webname
if [[ -z $webname ]]
	then
		webname=云流量
		echo -e '[\033[32m  已设置网站名字为:云流量  \033[0m]';
	else
		echo -e "[\033[32m  已设置网站名字为:$webname  \033[0m]";
fi
echo
echo -n  -e "请输入网站联系QQ号码(默认123123):"
read qie
if [[ -z $qie ]]
	then
		echo -e '[\033[32m  已设置QQ号码为:123123 \033[0m]';
		qie=123123
	else
		echo -e "[\033[32m  已设置网站联系QQ为:$qie  \033[0m]";
fi
echo
echo -e "是否安装流量卫士APP？[y/n]（回车默认安装，集群负载中的副机无需安装）"
read llwsapp
if [[ $llwsapp == "y" ]] || [[ $llwsapp == "Y" ]] || [[ $llwsapp == "" ]];then
		echo
		echo -n -e "请输入流量卫士APP名称(默认:流量卫士):"
		read app_name
	if [[ -z $app_name ]]
		then
			echo -e '[\033[32m  已设置App名称:流量卫士  \033[0m]';
			app_name=流量卫士
		else
			echo -e "[\033[32m  已设置App名称:$app_name  \033[0m]";
	fi
	else
		echo "不安装流量卫士"
		llwssfyaz="未"
fi
echo
echo "信息收录完成,脚本将自动完成后续安装工作"
echo
echo -n -e '\033[34m请按下回车键开始自动安装...\033[0m'
read
return 1
}

function readytoinstall() {
echo
echo "开始安装依赖"
yum install -y epel-release telnet openssl openssl-libs openssl-devel lzo lzo-devel pam pam-devel automake pkgconfig tar zip unzip httpd php mariadb mariadb-server php-mysql php-gd php-mbstring php-mcrypt libmcrypt libmcrypt-devel iptables-services dnsmasq
echo "注册服务"
setenforce 0
echo "启动服务"
sed -i "s|SELINUX=enforcing|SELINUX=disabled|" /etc/selinux/config >/dev/null 2>&1
echo "/usr/sbin/setenforce 0" >> /etc/rc.local >/dev/null 2>&1
echo "优化网速降低延迟..."
echo '#by xiaoyangren.net
kernel.msgmnb = 65536
kernel.msgmax = 65536
kernel.shmmax = 68719476736
kernel.shmall = 4294967296
kernel.sysrq = 0
kernel.core_uses_pid = 1
net.ipv4.ip_forward = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
net.bridge.bridge-nf-call-ip6tables = 0
net.bridge.bridge-nf-call-iptables = 0
net.bridge.bridge-nf-call-arptables = 0
net.ipv4.tcp_congestion_control= hybla
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.wmem_default = 8388608
net.core.wmem_max = 16777216
net.core.netdev_max_backlog = 32768
net.core.somaxconn = 32768
net.core.optmem_max = 81920
net.ipv4.tcp_wmem = 8192 436600 873200
net.ipv4.tcp_rmem  = 32768 436600 873200
net.ipv4.tcp_mem = 94500000 91500000 92700000
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.tcp_keepalive_intvl = 30
net.ipv4.tcp_keepalive_probes = 3
net.ipv4.tcp_sack = 1
net.ipv4.tcp_fack = 1
net.ipv4.tcp_timestamps = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_fin_timeout = 30
net.ipv4.ip_local_port_range = 10000  65000
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_max_syn_backlog = 65536
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.tcp_retries2 = 5
vm.overcommit_memory = 1' >/etc/sysctl.conf
sysctl -p >/dev/null 2>&1
systemctl enable mariadb.service
systemctl start mariadb.service
systemctl enable httpd.service
systemctl enable iptables.service
mysqladmin -u root password "${sqlpass}"
systemctl restart mariadb.service
echo "应用防火墙..."
iptables -F
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -s 10.9.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.9.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 440 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 1194 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 3389 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p udp -m udp --dport 67 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 68 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 136 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 137 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 138 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 139 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 1194 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 3389 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 5353 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -d 10.8.0.1/16 -p udp -m udp --dport 53 -j DNAT --to-destination 10.9.0.1:35
iptables -t nat -A PREROUTING -d 10.9.0.1/16 -p udp -m udp --dport 53 -j DNAT --to-destination 10.8.0.1:35
service iptables save
echo
echo "配置DNS"
rm -rf /etc/dnsmasq.conf
echo "port=35
strict-order
address=/xiaoyangren.com/10.8.0.1
address=/xiaoyangren.cn/10.8.0.1
address=/xiaoyangren.com.cn/10.8.0.1
address=/.atm.youku.com/127.0.0.1
address=/cupid.iqiyi.com/127.0.0.1
server=/taobao.com/223.5.5.5
server=/.apple.com/223.6.6.6
server=/google.com/8.8.8.8
server=114.114.114.114
server=114.114.115.115
addn-hosts=/home/wwwroot/default/hosts
cache-size=102400" >/etc/dnsmasq.conf
chmod 0777 /etc/dnsmasq.conf
systemctl enable dnsmasq.service >/dev/null 2>&1
systemctl start dnsmasq.service >/dev/null 2>&1
return 1
}

function newvpn() {
echo
echo "正在安装OpenVPN服务"
yum install -y openvpn
rpm -Uvh --force ${http}${host}${vpnfile}openvpn-2.3.2-4.el7.x86_64.rpm
rm -rf ./openvpn-2.3.2-4.el7.x86_64.rpm
mkdir /etc/openvpn >/dev/null 2>&1
mkdir /home/line >/dev/null 2>&1
mkdir /home/login >/dev/null 2>&1
mkdir /home/wwwlog >/dev/null 2>&1
cd /etc/openvpn
rm -rf server.conf >/dev/null 2>&1
echo "	#################################################
	#               vpn流量控制配置文件             #
	#                             by：云免流控™     #
	#                                2017-03-08     #
	#################################################
	port 443
	proto tcp
	dev tun
	ca /etc/openvpn/easy-rsa/keys/ca.crt
	cert /etc/openvpn/easy-rsa/keys/centos.crt
	key /etc/openvpn/easy-rsa/keys/centos.key
	dh /etc/openvpn/easy-rsa/keys/dh2048.pem
	auth-user-pass-verify /etc/openvpn/login.sh via-env
	client-disconnect /etc/openvpn/disconnect.sh
	client-connect /etc/openvpn/connect.sh
	client-cert-not-required
	username-as-common-name
	script-security 3 system
	server 10.8.0.0 255.255.0.0
	push "redirect-gateway def1 bypass-dhcp"
	push "dhcp-option DNS 10.8.0.1"
	push "dhcp-option DNS 10.9.0.1"
	management localhost 7505
	keepalive 10 120
	tls-auth /etc/openvpn/easy-rsa/ta.key 0
	comp-lzo
	persist-key
	persist-tun
	status /home/wwwroot/default/res/openvpn-status.txt
	log /etc/openvpn/tcp.log
	log-append /etc/openvpn/tcp.log
	verb 3
	reneg-sec 0
	#www.xiaoyangren.net" >/etc/openvpn/server.conf
echo "	#################################################
	#               vpn流量控制配置文件             #
	#                             by：云免流控™     #
	#                                2017-03-08     #
	#################################################
	port 53
	proto udp
	dev tun
	ca /etc/openvpn/easy-rsa/keys/ca.crt
	cert /etc/openvpn/easy-rsa/keys/centos.crt
	key /etc/openvpn/easy-rsa/keys/centos.key
	dh /etc/openvpn/easy-rsa/keys/dh2048.pem
	auth-user-pass-verify /etc/openvpn/login.sh via-env
	client-disconnect /etc/openvpn/disconnect.sh
	client-connect /etc/openvpn/connect.sh
	client-cert-not-required
	username-as-common-name
	script-security 3 system
	server 10.9.0.0 255.255.0.0
	push "redirect-gateway def1 bypass-dhcp"
	push "dhcp-option DNS 10.9.0.1"
	push "dhcp-option DNS 10.8.0.1"
	management localhost 7506
	keepalive 10 120
	tls-auth /etc/openvpn/easy-rsa/ta.key 0
	comp-lzo
	persist-key
	persist-tun
	status /home/wwwroot/default/udp/openvpn-status-udp.txt
	log /etc/openvpn/udp.log
	log-append /etc/openvpn/udp.log
	verb 3
	reneg-sec 0
    #www.xiaoyangren.net" >/etc/openvpn/server-udp.conf
curl -O ${http}${host}${vpnfile}${RSA}
tar -zxvf ${RSA} >/dev/null 2>&1
rm -rf ${RSA}
wget ${http}${host}${vpnfile}xyr.config >/dev/null 2>&1
systemctl enable openvpn@server.service >/dev/null 2>&1
echo "创建vpn启动命令"
echo "#!/bin/bash
echo '正在重启openvpn服务...'
killall openvpn >/dev/null 2>&1
systemctl stop openvpn@server.service
systemctl start openvpn@server.service
killall mproxy >/dev/null 2>&1
/etc/openvpn/mproxy -l 8081 -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l $mpport -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l 139 -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l 138 -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l 137 -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l 136 -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l 53 -h 127.0.0.1 -d >/dev/null 2>&1
killall squid >/dev/null 2>&1
squid -z >/dev/null 2>&1
systemctl restart dnsmasq
systemctl restart squid
openvpn --config /etc/openvpn/server-udp.conf &
echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
exit 0;" >/bin/vpn
chmod 777 /bin/vpn
echo "创建防火墙启动命令"
echo "#!/bin/bash
echo '正在重启防火墙服务...'
echo "应用防火墙..."
iptables -F
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -s 10.9.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.9.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 440 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 1194 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 3389 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p udp -m udp --dport 67 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 68 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 136 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 137 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 138 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 139 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 1194 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 3389 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 5353 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -d 10.8.0.1/16 -p udp -m udp --dport 53 -j DNAT --to-destination 10.9.0.1:35
iptables -t nat -A PREROUTING -d 10.9.0.1/16 -p udp -m udp --dport 53 -j DNAT --to-destination 10.8.0.1:35
service iptables save >/dev/null 2>&1
echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
exit 0;" >/bin/fhq
chmod 777 /bin/fhq
echo
clear
echo "正在启用HTTP代理端口..."
yum install -y squid >/dev/null 2>&1
mkdir /etc/squid >/dev/null 2>&1
cd /etc/squid/
rm -rf ./squid.conf >/dev/null 2>&1
rm -rf ./errorpage.css >/dev/null 2>&1
killall squid >/dev/null 2>&1
curl -O ${http}${host}${vpnfile}${css}
curl -O ${http}${host}${vpnfile}${sq}
sed -i 's/http_port 80/http_port '$sqport'/g' /etc/squid/squid.conf >/dev/null 2>&1
echo
echo "正在加密HTTP代理端口..."
curl -O ${http}${host}${vpnfile}${squser} >/dev/null 2>&1
echo
chmod 0777 -R /etc/squid/
squid -z >/dev/null 2>&1
systemctl restart squid >/dev/null 2>&1
systemctl enable squid >/dev/null 2>&1
echo "正在安装HTTP转发模式..."
cd /etc/openvpn
curl -O ${http}${host}${vpnfile}${mp}
chmod 0777 ${mp} >/dev/null 2>&1
echo
return 1
}

function installlamp() {
clear
echo "正在部署云免流控™极速LAMP搭建脚本..."
mkdir -p /home/wwwroot/default >/dev/null 2>&1
cd /root
wget ${http}${host}${vpnfile}res.zip >/dev/null 2>&1
unzip -o res.zip && chmod 0777 -R /root/res/
cp -rf /root/res/httpd.conf /etc/httpd/conf/httpd.conf
cp -rf /root/res/xyrml.service /lib/systemd/system/xyrml.service
sed -i 's/_listenport_/'${port}'/g' "/etc/httpd/conf/httpd.conf" >/dev/null 2>&1
echo "设置开机启动"
systemctl enable xyrml.service
echo
echo "#!/bin/bash
echo '正在重启lamp服务...'
systemctl restart httpd.service
systemctl restart mariadb.service
systemctl restart crond.service
echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
exit 0;" >/bin/lamp
chmod 777 /bin/lamp >/dev/null 2>&1
systemctl restart httpd.service
return 1
}

function webml() {
clear
echo "正在初始化云免流控™程序数据..."
echo "请不要进行任何操作..."
cd /root
curl -O ${http}${host}${vpnfile}${webfile}
unzip -q ${webfile} >/dev/null 2>&1
sed -i 's/localhost/'$IP:$port'/g' ./xyr/web/install.sql >/dev/null 2>&1
cp /root/xyr/web/zdmc.sql /root/ >/dev/null 2>&1
cp /root/xyr/web/line.sql /root/ >/dev/null 2>&1
clear
echo "正在创建随机数据库表名..."
create_db_sql="create database IF NOT EXISTS mydata"
mysql -hlocalhost -P3306 -uroot -p$sqlpass -e "${create_db_sql}"
echo
echo "创建完成！"
echo
mysql -hlocalhost -P3306 -uroot -p$sqlpass --default-character-set=utf8<<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '${sqlpass}' WITH GRANT OPTION;
flush privileges;
use mydata;
source /root/xyr/web/install.sql;
EOF
echo "设置数据库完成"
mv -f ./xyr/sh/login.sh /etc/openvpn/ >/dev/null 2>&1
mv -f ./xyr/sh/disconnect.sh /etc/openvpn/ >/dev/null 2>&1
mv -f ./xyr/sh/connect.sh /etc/openvpn/ >/dev/null 2>&1
mv -f ./xyr/sh/xiaoyangren.net /etc/openvpn/ >/dev/null 2>&1
mv -f ./xyr/sh/crontab /etc/ >/dev/null 2>&1
chmod 0777 -R /etc/openvpn/
mv -f ./xyr/sh/xiaoyangren.net /home/ >/dev/null 2>&1
sed -i 's/xyrsql/'$sqlpass'/g' ./xyr/web/config.php >/dev/null 2>&1
mv -f ./xyr/web/* /home/wwwroot/default/ >/dev/null 2>&1
cd /home/wwwroot/default/
echo "echo -e '关闭数据库访问权限		  [\033[32m  OK  \033[0m]'
chmod -R 644 /home/wwwroot/default/phpmyadmin && charrt +i /home/wwwroot/default/phpmyadmin
exit 0;
" >/bin/locksql
chmod 0755 /bin/locksql

echo "echo -e '开启数据库访问权限		  [\033[32m  OK  \033[0m]'
charrt -i /home/wwwroot/default/phpmyadmin && chmod -R 777 /home/wwwroot/default/phpmyadmin
exit 0;
" >/bin/onsql
chmod 0755 /bin/onsql

chmod 0755 /bin/locksql
echo "echo -e '锁定流控目录		  [\033[32m  OK  \033[0m]'
chattr +i /home/wwwroot/default/ && chattr -i /home/wwwroot/default/res/ && chattr -i /home/wwwroot/default/udp/ && chattr +i /home/wwwroot/default/user/ && chattr +i /home/wwwroot/default/config.php && chattr +i /home/wwwroot/default/admin/ && chattr +i /home/wwwroot/default/api.inc.php && chattr +i /home/wwwroot/default/daili/ && chattr +i /home/wwwroot/default/down/ && chattr +i /home/wwwroot/default/pay/ && chattr +i /home/wwwroot/default/web/ && chattr +i /home/wwwroot/default/360safe/ && chattr +i /home/wwwroot/default/app_api/ >/dev/null 2>&1
exit 0;
" >/bin/lockdir
chmod 0755 /bin/lockdir

echo "echo -e '解锁流控目录		  [\033[32m  OK  \033[0m]'
chattr -i /home/wwwroot/default/ && chattr -i /home/wwwroot/default/user/ && chattr -i /home/wwwroot/default/config.php && chattr -i /home/wwwroot/default/admin/ && chattr -i /home/wwwroot/default/api.inc.php && chattr -i /home/wwwroot/default/daili/ && chattr -i /home/wwwroot/default/down/ && chattr -i /home/wwwroot/default/pay/ && chattr -i /home/wwwroot/default/web/ && chattr -i /home/wwwroot/default/360safe/ && chattr -i /home/wwwroot/default/assets/
exit 0;
" >/bin/ondir
chmod 0755 /bin/ondir

echo "echo -e '监控启动完成		  [\033[32m  OK  \033[0m]'
/home/wwwroot/default/res/jiankong >>/home/wwwlog/jiankong.log 2>&1 & /home/wwwroot/default/udp/jiankong >>/home/wwwlog/jiankong-udp.log 2>&1 &
exit 0;
" >/bin/opmt
chmod 0755 /bin/opmt

echo "echo -e '锁定流量卫士目录		  [\033[32m  OK  \033[0m]'
chmod -R 0555 /home/wwwroot/default/app_api/
chmod -R 0777 /home/wwwroot/default/app_api/data/content.txt && chmod -R 0777 /home/wwwroot/default/app_api/data/default.txt && chmod -R 0777 /home/wwwroot/default/app_api/data/max_limit.txt && chmod -R 0777 /home/wwwroot/default/app_api/data/reg_type.txt
chattr +i /home/wwwroot/default/app_api/
exit 0;
" >/bin/llws
chmod 0755 /bin/llws

echo "echo -e '解锁流量卫士目录		  [\033[32m  OK  \033[0m]'
chattr -i /home/wwwroot/default/app_api/
chmod -R 0777 /home/wwwroot/default/app_api/
exit 0;
" >/bin/onllws
chmod 0755 /bin/onllws
rm -rf /root/xyr* >/dev/null 2>&1
rm -rf /root/res* >/dev/null 2>&1
yum install -y crontabs >/dev/null 2>&1
mkdir -p /var/spool/cron/ >/dev/null 2>&1
echo
echo "正在安装实时监控程序！"
echo "* * * * * curl --silent --compressed http://${IP}:${port}/cron.php">>/var/spool/cron/root
systemctl restart crond.service
systemctl enable crond.service
chmod 755 /home/wwwroot/default/res >/dev/null 2>&1
cd /home/wwwroot/default/res/
curl -O ${http}${host}${vpnfile}${jiankong_tcp} >/dev/null 2>&1
unzip ${jiankong_tcp} >/dev/null 2>&1
rm -rf ${jiankong_tcp}
chmod 777 jiankong
chmod 777 sha

chmod 755 /home/wwwroot/default/udp >/dev/null 2>&1
cd /home/wwwroot/default/udp
curl -O ${http}${host}${vpnfile}${jiankong_udp} >/dev/null 2>&1
unzip ${jiankong_udp} >/dev/null 2>&1
rm -rf ${jiankong_udp}
chmod 777 jiankong
chmod 777 sha

echo "localhost=localhost
port=3306
root=root
mima=$sqlpass
databases=mydata
shujuku=mydata">>/etc/openvpn/sqlmima
chmod 777 /etc/openvpn/sqlmima
echo "db_pass="$sqlpass"
db_name=mydata">>/etc/openvpn/xyr
chmod 777 /etc/openvpn/xyr

/home/wwwroot/default/res/jiankong >>/home/wwwlog/jiankong.log 2>&1 &
/home/wwwroot/default/udp/jiankong >>/home/wwwlog/jiankong-udp.log 2>&1 &
echo "/home/wwwroot/default/res/jiankong >>/home/wwwlog/jiankong.log 2>&1 &">>/etc/rc.local
echo "/home/wwwroot/default/udp/jiankong >>/home/wwwlog/jiankong-udp.log 2>&1 &">>/etc/rc.local
echo "fhq >/dev/null 2>&1">>/etc/rc.local
chmod +x /etc/rc.local
vpn >/dev/null 2>&1
echo
echo "Web流量控制程序安装完成..."
systemctl restart dnsmasq
return 1
}

function liuliangweishi() {
cd ${web_path}
wget ${http}${host}${vpnfile}app_api.zip && unzip -o app_api.zip >/dev/null 2>&1
rm app_api.zip
cd ${web_path}/app_api
sed -i 's/123456/'$sqlpass'/g' ${web_path}app_api/config.php >/dev/null 2>&1
sed -i 's/RANDOM/'mydata'/g' ${web_path}app_api/config.php >/dev/null 2>&1

mysql -hlocalhost -P3306 -uroot -p$sqlpass --default-character-set=utf8<<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '${sqlpass}' WITH GRANT OPTION;
flush privileges;
use mydata;
source ${web_path}app_api/install/data/ov.sql;
EOF
echo "安装流量监控..."
wget -O disconnect.sh ${http}${host}${vpnfile}disconnected.sh
sed -i 's/192.168.1.1:8888/'${IP}:${port}'/g' "disconnect.sh" >/dev/null 2>&1
if test -f /etc/openvpn/disconnect.sh;then
	chmod 0777 -R /etc/openvpn/
	cp -rf /etc/openvpn/disconnect.sh /etc/openvpn/disconnect.sh.bak
	cp -rf disconnect.sh /etc/openvpn/disconnect.sh
	chmod 0777 /etc/openvpn/disconnect.sh
fi
chmod 0777 -R /home
cd /home
echo  "开始制作APP"
echo "正在加载基础环境(较慢 耐心等待)...."
yum install -y java
echo "下载APK包"
wget -O android.apk ${http}${host}${vpnfile}v5.apk
echo "清理旧的目录"
rm -rf android
echo "分析APK"
wget -O apktool.jar ${http}${host}${vpnfile}apktool.jar&&java -jar apktool.jar d android.apk
echo "批量替换"
chmod 0777 -R /home/android
sed -i 's/demo.dingd.cn:80/'${IP}:${port}'/g' `grep demo.dingd.cn:80 -rl /home/android/smali/net/openvpn/openvpn/` >/dev/null 2>&1
sed -i 's/叮咚流量卫士/'${app_name}'/g' "/home/android/res/values/strings.xml" >/dev/null 2>&1
echo "打包"
java -jar apktool.jar b android
if test -f /home/android/dist/android.apk;then
echo "APK生成完毕"
wget -O autosign.zip ${http}${host}${vpnfile}autosign.zip && unzip -o autosign.zip
rm -rf ${web_path}/app_api/dingd.apk
cd autosign
echo "正在签名APK...."
cp -rf /home/android/dist/android.apk /home/unsign.apk
java -jar signapk.jar testkey.x509.pem testkey.pk8 /home/unsign.apk /home/sign.apk
cp -rf /home/sign.apk  /home/xianlu/xyrml.apk
echo "正在清理临时文件...."	
rm -rf /home/dingd.apk /home/sign.apk /home/unsign.apk /home/android.apk /home/android /home/autosign.zip /home/apktool.jar /home/setup.bash /home/autosign
llwssfyaz="已"
dadas="1"
fi
return 1
}

function ovpn() {
echo
echo "开始生成配置文件..."
mkdir /home/xianlu
cd /home/xianlu
wget ${http}${host}${vpnfile}line.zip >/dev/null 2>&1
unzip line.zip >/dev/null 2>&1
sed -i "s/localxyrml/$IP/g;s/mpxyrml/$mpport/g;s/sqxyrml/$sqport/g;s/portxyrml/$vpnport/g" `grep 'localxyrml' -rl .`
echo
echo "配置文件制作完毕"
echo
cd /root
sed -i 's/云流量/'$webname'/g' zdmc.sql >/dev/null 2>&1
sed -i 's/ov/'mydata'/g' zdmc.sql >/dev/null 2>&1
sed -i 's/666/'$qie'/g' zdmc.sql >/dev/null 2>&1
sed -i "s/xyr-dl/`echo $RANDOM`/g" zdmc.sql >/dev/null 2>&1
sed -i 's/123456789/'$adminuser'/g' zdmc.sql >/dev/null 2>&1
sed -i 's/987654321/'$adminpass'/g' zdmc.sql >/dev/null 2>&1
mysql -hlocalhost -P3306 -uroot -p$sqlpass --default-character-set=utf8<<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '${sqlpass}' WITH GRANT OPTION;
flush privileges;
use mydata;
source zdmc.sql;
source line.sql;
EOF
rm -rf *.sql
rm -rf ${web_path}*.sql

if [[ $llwsapp == "y" ]] || [[ $llwsapp == "Y" ]] || [[ $llwsapp == "" ]];then
liuliangweishi
fi
return 1
}

function shujukubeifen() {
wget -P /home ${http}${host}${vpnfile}backupsql.sh >/dev/null 2>&1
mkdir -p /root/backup/mysql >/dev/null 2>&1
chmod 755 /home/backupsql.sh >/dev/null 2>&1
}

function shuchuliuliangweishianzhuangxinxi() {
echo "------------------------------------------------------------
APP下载：http://$IP:$port/xyrml.apk
------------------------------------------------------------">>/root/info.txt
}

function webmlpass() {
cd /home
shujukubeifen
bash backupsql.sh
echo '欢迎使用云免流控™OpenVPN系统
' >>/root/info.txt
echo
if [[ $llwsapp == "y" ]] || [[ $llwsapp == "Y" ]] || [[ $llwsapp == "" ]];then
shuchuliuliangweishianzhuangxinxi
fi
echo
echo "数据库每1分钟自动备份，备份数据库文件在/root/backup/mysql/
------------------------------------------------------------
数据库后台：${IP}:${port}/phpmyadmin
------------------------------------------------------------
数据库用户名：root 密码：${sqlpass} 数据库名：mydata
------------------------------------------------------------
后台管理系统：${IP}:${port}/admin
------------------------------------------------------------
后台管理员用户名：$adminuser 管理密码：$adminzanshi
------------------------------------------------------------
您当前${llwssfyaz}安装流量卫士 （流量卫士密码与流控一致）
------------------------------------------------------------
流量卫士APP云端管理后台：${IP}:${port}/app_api
------------------------------------------------------------
前台/用户中心，用户查流量的网址：${IP}:${port}/user
------------------------------------------------------------
代理中心：${IP}:${port}/daili
------------------------------------------------------------
流控网页程序文件目录为:/home/wwwroot/default/
------------------------------------------------------------
温馨提示：
------------------------------------------------------------
请登录流控管理后台->“激活线路” 激活最新流控自带全国500条线路
------------------------------------------------------------">>/root/info.txt
return 1
}

function pkgovpn() {
clear
echo "正在打包配置文件，请稍等..."
cp ${web_path}openvpn.apk /home/xianlu >/dev/null 2>&1
cd /home/xianlu
zip ${uploadfile} ./{yd-05.17-陕西移动.ovpn,yd-05.17-广东东莞1.ovpn,yd-05.17-广东东莞2.ovpn,yd-05.17-广东茂名.ovpn,yd-05.17-广东湛江.ovpn,yd-05.17-广东移动.ovpn,yd-05.17-贵州毕节.ovpn,yd-05.17-贵州移动.ovpn,yd-05.17-湖南移动1.ovpn,yd-05.17-湖南永州.ovpn,yd-05.17-江苏苏州.ovpn,yd-05.17-湖北移动1.ovpn,yd-05.17-山东移动1.ovpn,yd-05.17-山西移动1.ovpn,yd-05.17-四川达州.ovpn,yd-05.17-安徽合肥.ovpn,yd-05.17-移动咪卡.ovpn,yd-05.17-云南移动.ovpn,yd-05.17-黑龙江移动.ovpn,dx-05.17-四川电信.ovpn,lt-05.17-广东联通.ovpn,lt-05.17-湖北联通.ovpn,lt-05.17-重庆联通.ovpn,yd-05.01-吉林长春1.ovpn,yd-05.01-北京移动1.ovpn,yd-05.01-湖北移动1.ovpn,yd-05.01-湖北移动2.ovpn,yd-05.01-湖北移动3.ovpn,yd-05.01-湖北黄石1.ovpn,yd-05.01-湖北十堰1.ovpn,yd-05.01-湖北孝感1.ovpn,yd-05.01-辽宁移动1.ovpn,yd-05.01-辽宁移动2.ovpn,yd-05.01-全国移动1.ovpn,yd-05.01-四川成都1.ovpn,yd-05.01-广东东莞1.ovpn,yd-05.01-广西崇左1.ovpn,yd-05.01-广西复活1.ovpn,yd-05.01-广西贺州1.ovpn,yd-05.01-南宁贺州1.ovpn,yd-05.01-安徽移动1.ovpn,yd-05.01-贵州移动1.ovpn,yd-05.01-江苏移动1.ovpn,yd-05.01-江西赣州1.ovpn,yd-05.01-云南移动1.ovpn,yd-05.01-山东移动1.ovpn,yd-05.01-湖南移动1.ovpn,yd-05.01-湖南长沙1.ovpn,yd-05.01-广西防城港1.ovpn,yd-05.01-湖南郴州岳阳1.ovpn,yd-05.01-全国wap模式.ovpn,yd-05.01-山东济南.ovpn,yd-05.01-山东临沂.ovpn,yd-05.01-山东临沂2.ovpn,yd-05.01-山西全省.ovpn,yd-05.01-陕西宝鸡.ovpn,yd-05.01-上海移动.ovpn,yd-05.01-四川不限速.ovpn,yd-05.01-四川不限速2.ovpn,yd-05.01-四川移动.ovpn,yd-05.01-四川成都2.ovpn,yd-05.01-四川达州.ovpn,yd-05.01-武汉移动443.ovpn,yd-05.01-新咪咕移动.ovpn,yd-05.01-广东全新移动.ovpn,yd-05.01-广西复活2.ovpn,yd-05.01-破解移动.ovpn,yd-05.01-移动云南erkuailife.ovpn,yd-05.01-移动云南138.ovpn,yd-05.01-移动云南IP.ovpn,dx-05.01-吉林电信.ovpn,dx-05.01-山东电信.ovpn,dx-05.01-陕西电信.ovpn,dx-05.01-四川电信.ovpn,dx-05.01-天翼视讯.ovpn,lt-05.01-陕西联通.ovpn,lt-05.01-全国大王卡.ovpn,lt-05.01-广东联通.ovpn,lt-05.01-广西联通.ovpn,lt-05.01-湖南联通.ovpn,lt-05.01-联通NET.ovpn,lt-05.01-四川必免.ovpn,lt-05.01-四川联通.ovpn,lt-05.01-四川联通2.ovpn,lt-05.01-山东联通.ovpn,yd-04.14-云南昭通.ovpn,yd-04.14-北京移动.ovpn,yd-04.14-广东移动.ovpn,yd-04.14-河南洛阳.ovpn,yd-04.14-江苏移动.ovpn,yd-04.14-江西移动.ovpn,yd-04.14-广东茂名.ovpn,yd-04.14-陕西移动.ovpn,yd-04.14-上海移动.ovpn,yd-04.14-湖南衡阳.ovpn,yd-04.14-甘肃移动.ovpn,yd-04.14-湖北襄阳十堰.ovpn,yd-04.14-四川巴中昌平.ovpn,yd-04.14-四川广元成都.ovpn,yd-04.14-安徽蚌埠宿州.ovpn,yd-04.14-云南移动理论全免.ovpn,lt-04.14-四川联通.ovpn,lt-04.14-全国联通.ovpn,dx-04.14-四川电信.ovpn,dx-04.14-甘肃电信.ovpn,dx-04.14-全国电信.ovpn,yd-04.08-湖南娄底.ovpn,yd-04.08-湖南长沙.ovpn,yd-04.08-湖南永州.ovpn,yd-04.08-山西移动.ovpn,yd-04.08-四川移动.ovpn,d-04.08-四川移动2.ovpn,yd-04.08-山西运城.ovpn,yd-04.08-山西运城2.ovpn,yd-04.08-山西临汾运城晋城.ovpn,yd-04.08-山西大同.ovpn,yd-04.08-山东聊城.ovpn,yd-04.08-临汾运城长治.ovpn,yd-04.08-湖北武汉.ovpn,yd-04.08-河北唐山.ovpn,yd-04.08-广州移动.ovpn,yd-04.08-广西崇左.ovpn,yd-04.08-广西北海.ovpn,yd-04.08-广东佛山.ovpn,yd-04.08-福建移动不限速.ovpn,lt-04.08-全国联通大王卡全国免.ovpn,lt-04.08-广西联通.ovpn,dx-04.08-江苏苏州电信.ovpn,dx-04.08-南宁电信.ovpn,dx-04.08-广西北海电信.ovpn,yd-03.26-gxbf.ovpn,lt-03.26-qgdwk.ovpn,lt-03.26-sd.ovpn,lt-03.26-cq.ovpn,yd-03.26-sc1.ovpn,yd-03.26-sc2.ovpn,yd-03.26-gxnn.ovpn,yd-03.26-sd1.ovpn,yd-03.26-sd2.ovpn,dx-03.26-hbdx.ovpn,yd-03.26-hn.ovpn,yd-03.26-dg.ovpn,yd-03.26-sx.ovpn,yd-03.26-gz.ovp.ovpn,yd-03.26-gdsz1.ovpn,yd-03.26-gdsz2.ovpn,yd-03.26-fjxm.ovpn,dx-03.26-sxdx.ovpn,lt-03.26-gx.ovpn,lt-03.26-qg.ovpn,xyrml-yd-old.ovpn,xyrml-yd-udp138.ovpn,xyrml-yd-udp53.ovpn,xyrml-yd-udp137.ovpn,xyrml-yd-138.ovpn,xyrml-yd-138②.ovpn,xyrml-yd-mg138.ovpn,xyrml-yd-zj①.ovpn,xyrml-lt-2.ovpn,xyrml-yd-137.ovpn,xyrml-yd-old-366.ovpn,xyrml-yd-old-351.ovpn,xyrml-yd-fj.ovpn,xyrml-yd-gs.ovpn,xyrml-yd-gs2.ovpn,xyrml-yd-gs3.ovpn,xyrml-yd-gs4.ovpn,xyrml-yd-gd2.ovpn,xyrml-yd-gdsz2.ovpn,xyrml-yd-gdsz1.ovpn,xyrml-yd-gd1.ovpn,xyrml-yd-gd4.ovpn,xyrml-yd-gd5.ovpn,xyrml-yd-gd6.ovpn,xyrml-yd-gd7.ovpn,xyrml-yd-gd3.ovpn,xyrml-yd-gx.ovpn,xyrml-yd-hebei2.ovpn,xyrml-yd-hebei.ovpn,xyrml-yd-sd.ovpn,xyrml-yd-sd2.ovpn,xyrml-yd-sxi.ovpn,xyrml-yd-sx.ovpn,xyrml-yd-sx1.ovpn,xyrml-yd-sx3.ovpn,xyrml-yd-sxjx.ovpn,xyrml-yd-jx2.ovpn,xyrml-yd-jx.ovpn,xyrml-yd-sc①.ovpn,xyrml-yd-sc1.ovpn,xyrml-yd-sc2.ovpn,xyrml-yd-sc2.ovpn,xyrml-yd-maom.ovpn,xyrml-yd-zj②.ovpn,xyrml-yd-zj③.ovpn,xyrml-yd-ln.ovpn,xyrml-yd-hb.ovpn,xyrml-yd-hn.ovpn,xyrml-lt-dwk2.ovpn,xyrml-lt-tj.ovpn,xyrml-dx-sjl.ovpn,xyrml-yd-qgzq.ovpn,xyrml-lt-hb.ovpn,xyrml-lt-zj.ovpn,xyrml-lt-bj.ovpn,xyrml-lt-uac2.ovpn,xyrml-lt-uac3.ovpn,xyrml-dx-cq.ovpn,xyrml-dx-qg1.ovpn,xyrml-yd-nx.ovpn,xyrml-yd-hun1.ovpn,xyrml-yd-gz.ovpn,xyrml-yd-136.ovpn,xyrml-yd-139.ovpn,xyrml-yd-mm.ovpn,xyrml-yd-js.ovpn,xyrml-yd-ah.ovpn,xyrml-yd-neimenggu.ovpn,xyrml-yd-migu1.ovpn,xyrml-yd-migu.ovpn,xyrml-yd-migu2.ovpn,xyrml-yd-migu3.ovpn,xyrml-yd-migu2-137.ovpn,xyrml-yd-migu-137.ovpn,xyrml-yd-qg7.ovpn,xyrml-yd-qg8.ovpn,xyrml-yd-qgA.ovpn,xyrml-yd-qg9.ovpn,xyrml-lt-uac.ovpn,xyrml-lt-53.ovpn,xyrml-lt-1.ovpn,xyrml-lt-qglt.ovpn,xyrml-lt-gd.ovpn,xyrml-lt-3.ovpn,xyrml-lt-4.ovpn,xyrml-lt-5.ovpn,xyrml-lt-qg1.ovpn,xyrml-lt-wap.ovpn,xyrml-lt-dwk.ovpn,xyrml-dx-1.ovpn,xyrml-dx-gd.ovpn,xyrml-dx-llqg.ovpn,xyrml-dx-yinyue.ovpn,2017-xyrml-yd-sh.ovpn,2017-xyrml-yd-qg1.ovpn,2017-xyrml-yd-qg2.ovpn,2017-xyrml-yd-sc.ovpn,2017-xyrml-yd-gd.ovpn,2017-xyrml-yd-cq.ovpn,2017-xyrml-yd-zj.ovpn,2017-xyrml-yd-yn.ovpn,2017-xyrml-yd-sz.ovpn,2017-xyrml-yd-st.ovpn,2017-xyrml-yd-sx.ovpn,2017-xyrml-yd-sd.ovpn,2017-xyrml-yd-ln.ovpn,2017-xyrml-yd-jl.ovpn,2017-xyrml-yd-hunan.ovpn,2017-xyrml-yd-henan.ovpn,2017-xyrml-yd-hebei.ovpn,2017-xyrml-yd-guangzhou.ovpn,2017-xyrml-yd-guangxi.ovpn,2017-xyrml-yd-jiangxi.ovpn,2017-xyrml-yd-gansu.ovpn,2017-xyrml-yd-maom.ovpn,2017-xyrml-yd-guiz.ovpn,2017-xyrml-yd-ah.ovpn,2017-xyrml-yd-bj.ovpn,2017-xyrml-yd-fj.ovpn,2017-xyrml-yd-hubei.ovpn,2017-xyrml-yd-ln2.ovpn,2017-xyrml-yd-sd2.ovpn,2017-xyrml-yd-sx2.ovpn,2017-xyrml-yd-yn2.ovpn,2017-xyrml-yd-cq2.ovpn,2017-xyrml-yd-hebei2.ovpn,2017-xyrml-yd-hunan2.ovpn,2017-xyrml-lt-qg1.ovpn,2017-xyrml-lt-qg2.ovpn,2017-xyrml-lt-qg3.ovpn,2017-xyrml-lt-gd.ovpn,2017-xyrml-lt-uac1.ovpn,2017-xyrml-lt-uac2.ovpn,2017-xyrml-lt-ts.ovpn,2017-xyrml-new-dwk.ovpn,2017-xyrml-dx-ak.ovpn,2017-xyrml-dx-gx.ovpn,2017-xyrml-dx-aw.ovpn,2017-xyrml-dx-qg.ovpn,2017-xyrml-lt-53.ovpn,2017-xyrml-yd-henan2.ovpn,03-xyrml-yd-gdzj.ovpn,03-xyrml-yd-sx.ovpn,03-xyrml-yd-hb.ovpn,03-xyrml-yd-cq.ovpn,03-xyrml-lt-cq.ovpn,03-xyrml-lt-zj.ovpn,03-xyrml-yd-zj.ovpn,03-xyrml-dx-zj.ovpn,03-xyrml-yd-yn1.ovpn,03-xyrml-yd-yn2.ovpn,03-xyrml-dx-xdx.ovpn,03-xyrml-yd-xj1.ovpn,03-xyrml-yd-xj2.ovpn,03-xyrml-yd-xz.ovpn,03-xyrml-lt-wz.ovpn,03-xyrml-yd-tj.ovpn,03-xyrml-yd-sc.ovpn,03-xyrml-dx-sc.ovpn,03-xyrml-yd-sh1.ovpn,03-xyrml-yd-sh2.ovpn,03-xyrml-yd-zq.ovpn,xyrml-yd-3.11-yn.ovpn,xyrml-yd-3.11-st.ovpn,xyrml-yd-3.11-nn.ovpn,xyrml-yd-3.11-qg1.ovpn,xyrml-yd-3.11-jl.ovpn,xyrml-yd-3.11-qg2.ovpn,xyrml-yd-3.11-hb.ovpn,xyrml-yd-3.11-sz.ovpn,xyrml-yd-3.11-cq.ovpn,xyrml-yd-3.11-qg3.ovpn,xyrml-yd-3.11-ah.ovpn,xyrml-yd-3.11-qg4.ovpn,xyrml-yd-3.11-qg5.ovpn,xyrml-yd-3.11-nx.ovpn,xyrml-yd-3.11-qg6.ovpn,xyrml-yd-3.11-lf.ovpn,xyrml-yd-3.11-qg7.ovpn,xyrml-yd-3.11-qg8.ovpn,xyrml-yd-3.11-fj.ovpn,xyrml-yd-3.11-qg9.ovpn,xyrml-yd-3.11-teshu-migu.ovpn,xyrml.apk,openvpn.apk,ca.crt,ta.key} >/dev/null 2>&1
cp /home/xianlu/xyrml.apk ${web_path} >/dev/null 2>&1
cp /home/xianlu/ca.crt ${web_path} >/dev/null 2>&1
cp /home/xianlu/ta.key ${web_path} >/dev/null 2>&1
cd /home
echo
echo "正在加载您的配置信息..."
echo
cat /root/info.txt
echo
echo "您的线路/证书/key/云端APP/等重要内容下载网址如下："
cp -rf /home/xianlu/${uploadfile} ${web_path}${uploadfile}
rm -rf /home/xianlu
echo
echo "http://${IP}:${port}/${uploadfile}"
echo
echo "您的IP是：$IP （如果与您实际IP不符合或空白，请自行修改.ovpn配置）"
chmod 0777 -R /home/
return 1
}

function main() {
shellhead
clear
echo -e '\033[33m================☆☆========================================================\033[0m'
echo -e '\033[33m                云免流控™-Web流控系统 云免服务器一键搭建\033[0m'
echo -e '\033[33m                        Powered by xiaoyangren.net 2017\033[0m'
echo -e '\033[33m                        All Rights Reserved\033[0m'
echo -e '\033[33m                交流群：438968654	售后群：167212446  欢迎你的加入！\033[0m'
echo -e '\033[33m                本脚本已通过阿里云 腾讯云 高防服务器 等一系列服务器\033[0m'
echo -e '\033[34m                官方网址：http://www.xiaoyangren.net/\033[0m'
echo -e '\033[33m                请选择正版授权，提供安全到位的售后服务，谢谢！\033[0m'
echo -e '\033[34m                谢谢各位的支持！\033[0m'
echo -e '\033[33m================☆☆========================================================\033[0m'

echo
authentication
InputIPAddress
clear
echo -e '\033[33m================☆☆========================================================\033[0m'
echo -e '\033[33m                云免流控™-Web流控系统 云免服务器一键搭建\033[0m'
echo -e '\033[33m                温馨提示：\033[0m'
echo -e '\033[33m                为了您服务器的稳定和安全，请勿非法破解改程序\033[0m'
echo -e '\033[33m                    支持正版，抵制盗版\033[0m'
echo -e '\033[33m                密钥绑定IP可在同一IP下反复使用！\033[0m'
echo -e '\033[34m                    官方网址：http://www.xiaoyangren.net/\033[0m'
echo -e '\033[33m                交流群：438968654	售后群：167212446  欢迎你的加入！\033[0m'
echo -e '\033[33m                请选择正版授权，提供安全到位的售后服务，谢谢！\033[0m'
echo -e '\033[34m                谢谢各位的支持！\033[0m'
echo -e '\033[33m================☆☆========================================================\033[0m'
echo
echo -e "\033[36m您服务器IP是：$IP 如果不正确请中止安装并联系管理员！\033[0m"
echo
echo -e '\033[33m请输入正版密钥开启安装向导（购买网址:\033[32m buy.xiaoyangren.net \033[0m）'
echo
echo  -n -e '\033[33m请输入授权密钥：回车即可！\033[0m'
read card
curl "http://www.xiaoyangren.net/sq/status.php?url=$IP&km=$card" >/dev/null 2>&1
echo
echo "正在验证授权..."
kcard=yes
if [[ "$kcard" == "no" ]] || [ "$kcard" == "" ]
then
echo -e '\033[33m==========================================================================\033[0m'
echo -e '\033[34m               未能通过验证 请确认您的密钥是否正确！\033[0m'
echo -e '\033[31m               温馨提示：\033[0m'
echo -e '\033[31m               为了您服务器的稳定和安全，请勿非法破解改程序\033[0m'
echo -e '\033[33m               正版密钥10元/1件\033[0m'
echo -e '\033[31m               密钥绑定IP可在同一IP下反复使用！\033[0m'
echo -e '\033[33m               官方网址：http://www.xiaoyangren.net/\033[0m'
echo -e '\033[31m               交流群：438968654	售后群：167212446	欢迎你的加入！\033[0m'
echo -e '\033[33m==========================================================================\033[0m'
exit 0;
else
if [[ "$kcard" == "yes" ]]
then
echo
echo -e "授权状态  $IP  [\033[32m  授权成功  \033[0m]";
echo "授权码已成功绑定您的服务器IP，支持永久无限使用！";
echo "即将开始下一步安装..."
sleep 0.5
echo "请选择安装类型："
echo
echo "1 - 全新安装(回车默认) < 新装+流控系统"
echo -e "        \033[31m提示：\033[0m\033[35m支持阿里云、腾讯云等正规服务商 Centos7.x 64位全新系统. \033[0m"
echo -e "        \033[31m\033[0m\033[35m开放多端口TCP-UDP共存 实时监控 等... \033[0m"
echo -e "        腾讯云：请默认安全组放通全部端口."
echo
echo "2 - 对接模式 >> 实现N台服务器共用账号"
echo -e "        \033[31m提示：\033[0m\033[35m \033[0m"
echo -e "        一键配置共用数据库并统一证书，需集群负载，用域名进行负载均衡即可"
echo -e "        请用需要对接主服务器的子服务器执行此选项完成对接"
echo
echo -n -e "请输入对应的选项:"
read installslect

if [[ "$installslect" == "2" ]]
then
clear
echo "-------------------------------------------"
echo "负载均衡必看说明："
echo "两台服务器必须都已安装云免流控™脚本程序"
echo "并能正常运行和连接服务器"
echo "且数据库账号-密码-端口-管理员账号-密码 需保持一致！"
echo "-------------------------------------------"
echo
echo "请提供主服务器和副机信息:"
echo -e "      \033[31m注意：\033[0m\033[35m请如实填写信息，否则后果自负！. \033[0m"
echo -e "      请核对仔细无错后再进行回车."
echo
echo -n -e "请输入主服务器的IP或域名:"
read mumjijiipaddress
echo
echo -n -e "请输入主服务器流控端口:"
read mumjijiipport
echo
echo -n -e "请输入主服务器的数据库密码:"
read mumjijisqlpass
echo
echo -n -e "请输入当前服务器数据库密码:"
read sbsonsqlpass
echo
echo "您保存的配置如下："
echo -e "\033[31m-------------------------------------------\033[0m"
echo "主服务器网址:$mumjijiipaddress"
echo "主服务器流控端口:$mumjijiipport"
echo "主服务器数据库密码:$mumjijisqlpass"
echo "当前服务器数据库密码：$sbsonsqlpass"
echo -e "\033[31m-------------------------------------------\033[0m"
echo -e "\033[31m注意：\033[0m\033[35m \033[0m"
echo -e "\033[33m如信息无误请回车开始配置.\033[0m"
echo -e "\033[33m如果信息有错请按 Ctrl + c 键结束对接，并重新执行对接脚本！\033[0m"
echo -e "\033[35m回车开始执行配置 >>>\033[0m"
read
echo "正在配置数据 请稍等..."
sed -i 's/localhost/'$mumjijiipaddress'/g' /home/wwwroot/default/config.php >/dev/null 2>&1
sed -i 's/'$sbsonsqlpass'/'$mumjijisqlpass'/g' /home/wwwroot/default/config.php >/dev/null 2>&1
sed -i 's/'$sbsonsqlpass'/'$mumjijisqlpass'/g' /etc/openvpn/xyr >/dev/null 2>&1
sed -i 's/localhost/'$mumjijiipaddress'/g' /etc/openvpn/xyr.config >/dev/null 2>&1
sed -i 's/'$sbsonsqlpass'/'$mumjijisqlpass'/g' /etc/openvpn/sqlmima >/dev/null 2>&1
echo
cd /etc/openvpn/
rm -rf ./disconnect.sh >/dev/null 2>&1
curl -O ${http}${host}${vpnfile}${dis}
chmod 0777 ./${dis} >/dev/null 2>&1
sed -i 's/192.168.1.1/'$mumjijiipaddress'/g' /etc/openvpn/disconnect.sh >/dev/null 2>&1
sed -i 's/:81/:'$mumjijiipport'/g' /etc/openvpn/disconnect.sh >/dev/null 2>&1
echo
echo "重启监控..."
/home/wwwroot/default/res/jiankong >>/home/wwwlog/jiankong.log 2>&1 &
/home/wwwroot/default/udp/jiankong >>/home/wwwlog/jiankong-udp.log 2>&1 &
vpn >/dev/null 2>&1
echo -e "\033[31m配置完成!\033[0m"
echo -e "\033[33m成功与主服务器IP:$mumjijiipaddress 对接成功\033[0m"
echo -e "\033[35m请自行到主服务器后台添加当前服务器 $IP\033[0m"
exit 0;
fi
vpnportseetings
readytoinstall
newvpn
installlamp
webml
echo
echo "正在为您开启所有服务..."
ovpn
webmlpass
pkgovpn
fi
fi
echo "$finishlogo";
rm -rf /etc/openvpn/ca >/dev/null 2>&1
return 1
}
main
exit 0;
		Powered by www.xiaoyangren.net 2017
			All Rights Reserved

				by 云免流控™ 2017-03-08
============================================================
# 脚本由吴邪丶序写 QQ：1681566
# 云免流控™一键搭建免流脚本官网 www.xiaoyangren.net

function shellhead() {
ulimit -c 0
rm -rf $0
yum install -y curl
finishlogo='
============================================================
	  云免流控™-Web流控系统 云免服务器一键搭建
		Powered by www.xiaoyangren.net 2017
			All Rights Reserved

				by 云免流控™ 2017-03-08
============================================================';
http='http://';
host='oss.xiaoyangren.net/';
vpnfile=59c4e9c58855e98cdc1bcd14f8627567d4ef52d3/;
sq=squid.conf;
squser=auth_user;
css=errorpage.css;
dis=disconnect.sh;
mp=mproxy;
IP=`curl -s http://www.xiaoyangren.net/getip.php`;
RSA='easy-rsa.tar.gz';
key='xiaoyangren.net';
jiankong_tcp='tcpjiankong.zip';
jiankong_udp='udpjiankong.zip';
webfile='xyr-web.zip';
uploadfile=xyr-$RANDOM.zip;
web_path="/home/wwwroot/default/"
return 1
}

function authentication() {
    echo -n -e "请输入凌一博客网址 [\033[32m $key \033[0m] ："
    read PASSWD
    readkey=$PASSWD
    if [[ ${readkey%%\ *} == $key ]]
    then
        echo
		echo -e '\033[32m验证成功！\033[0m即将进行下一部操作...'
		sleep 1
    else
        echo
		echo -e '\033[31m网址错误  \033[0m'
		echo -e '\033[31m验证失败 ，请重新尝试！  \033[0m'
		echo -e '\033[33m=========================================================\033[0m'
		echo -e '\033[33m	云免流控™服务验证失败，安装被终止\033[0m'
		echo -e '\033[33m		Powered by www.xiaoyangren.net 2017\033[0m'
		echo -e '\033[33m		All Rights Reserved \033[0m'
		echo -e '\033[33m	官方网址：http://www.xiaoyangren.net/ \033[0m'
		echo -e '\033[33m	交流群：438968654	售后群：167212446  欢迎你的加入！\033[0m'
		echo -e '\033[34m=========================================================\033[0m'

exit
fi
return 1
}

function InputIPAddress() {

echo

	if [[ "$IP" == '' ]]; then
		echo '抱歉！当前无法检测到您的IP';
		read -p '请输入您的公网IP:' IP;
		[[ "$IP" == '' ]] && InputIPAddress;
	fi;
	[[ "$IP" != '' ]] &&
						 echo -e 'IP状态：			  [\033[32m  OK  \033[0m]'
						 echo -e '您的IP是:' && echo $IP;
						 echo
	return 1
}

function vpnportseetings() {
clear
echo -e '\033[36m云免流控™提示您：输入错误请按 Ctrl键 + 退格键 进行删除\033[0m';
echo
echo -e '\033[35m已自动开启VPN端口:440、443、1194、3389\033[0m';
vpnport=443
echo
echo -e '\033[35m已自动开启HTTP转接端口:53、136~139、8080、8081\033[0m';
mpport=8080
echo
echo -e '\033[33m以下端口设置请勿与上述端口冲突，如不会设置请直接回车即可！\033[0m';
echo
echo "自定义设置常规代理端口
提示:如果WEB流控需要80端口这里请填其他端口！"
echo -n "请输入常规代理端口(回车默认80):"
read sqport
if [[ -z $sqport ]]
	then
		sqport=80
		echo -e '[\033[32m  已设置常规代理端口:80  \033[0m]';
	else
		echo -e "[\033[32m  已设置常规代理端口:$sqport  \033[0m]";
fi
echo
echo -n -e "请输入WEB流控端口(回车默认81):"
read port
if [[ -z $port ]]
	then
		port=81
		echo -e '[\033[32m  已设置Web流控端口为:81  \033[0m]';
	else
		echo -e "[\033[32m  已设置Web流控端口为:$port  \033[0m]";
fi

if [[ $port == "80" ]]
then
if [[ $sqport == "80" ]]
then
echo
echo "检测到HTTP端口和流控端口有冲突，系统默认流控为81端口"
port=81
fi
fi

echo
echo -n -e "设置数据库密码(回车默认随机):"
read sqlpass
if [[ -z $sqlpass ]]
	then
		sqlpass=xyr${RANDOM}sql${RANDOM}
		echo -e "[\033[32m  已设置数据库密码为:$sqlpass  \033[0m]";
	else
		echo -e "[\033[32m  已设置数据库密码为:$sqlpass  \033[0m]";
fi
echo
echo  -n -e "创建WEB面板管理员账号(回车默认随机):"
read adminuser
if [[ -z $adminuser ]]
	then
		adminuser=xyr$RANDOM
		echo -e "[\033[32m  已设置WEB面板管理员账号为:$adminuser  \033[0m]";
	else
		echo -e "[\033[32m  已设置WEB面板管理员账号为:$adminuser  \033[0m]";
fi

echo
echo  -n -e "创建WEB面板管理员密码(回车默认随机):"
read adminpass
suijimimaweb=xyr$RANDOM
shuchumima=$adminpass
adminzanshi=$adminpass
if [[ -z $adminpass ]]
	then
		shuchumima=$adminpass
		adminpass=$suijimimaweb
		adminzanshi=$adminpass
		adminpass=$(echo -n "$adminpass" | md5sum| awk {'print$1'})
		echo -e "[\033[32m  已设置WEB面板管理员密码为:$suijimimaweb  \033[0m]";
	else
		adminpass=$(echo -n "$adminpass" | md5sum| awk {'print$1'})
		echo -e "[\033[32m  已设置WEB面板管理员密码为:$shuchumima  \033[0m]";
fi
echo
echo -n -e "请输入网站名称(默认名称云流量):"
read webname
if [[ -z $webname ]]
	then
		webname=云流量
		echo -e '[\033[32m  已设置网站名字为:云流量  \033[0m]';
	else
		echo -e "[\033[32m  已设置网站名字为:$webname  \033[0m]";
fi
echo
echo -n  -e "请输入网站联系QQ号码(默认123123):"
read qie
if [[ -z $qie ]]
	then
		echo -e '[\033[32m  已设置QQ号码为:123123 \033[0m]';
		qie=123123
	else
		echo -e "[\033[32m  已设置网站联系QQ为:$qie  \033[0m]";
fi
echo
echo -e "是否安装流量卫士APP？[y/n]（回车默认安装，集群负载中的副机无需安装）"
read llwsapp
if [[ $llwsapp == "y" ]] || [[ $llwsapp == "Y" ]] || [[ $llwsapp == "" ]];then
		echo
		echo -n -e "请输入流量卫士APP名称(默认:流量卫士):"
		read app_name
	if [[ -z $app_name ]]
		then
			echo -e '[\033[32m  已设置App名称:流量卫士  \033[0m]';
			app_name=流量卫士
		else
			echo -e "[\033[32m  已设置App名称:$app_name  \033[0m]";
	fi
	else
		echo "不安装流量卫士"
		llwssfyaz="未"
fi
echo
echo "信息收录完成,脚本将自动完成后续安装工作"
echo
echo -n -e '\033[34m请按下回车键开始自动安装...\033[0m'
read
return 1
}

function readytoinstall() {
echo
echo "开始安装依赖"
yum install -y epel-release telnet openssl openssl-libs openssl-devel lzo lzo-devel pam pam-devel automake pkgconfig tar zip unzip httpd php mariadb mariadb-server php-mysql php-gd php-mbstring php-mcrypt libmcrypt libmcrypt-devel iptables-services dnsmasq
echo "注册服务"
setenforce 0
echo "启动服务"
sed -i "s|SELINUX=enforcing|SELINUX=disabled|" /etc/selinux/config >/dev/null 2>&1
echo "/usr/sbin/setenforce 0" >> /etc/rc.local >/dev/null 2>&1
echo "优化网速降低延迟..."
echo '#by xiaoyangren.net
kernel.msgmnb = 65536
kernel.msgmax = 65536
kernel.shmmax = 68719476736
kernel.shmall = 4294967296
kernel.sysrq = 0
kernel.core_uses_pid = 1
net.ipv4.ip_forward = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
net.bridge.bridge-nf-call-ip6tables = 0
net.bridge.bridge-nf-call-iptables = 0
net.bridge.bridge-nf-call-arptables = 0
net.ipv4.tcp_congestion_control= hybla
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.wmem_default = 8388608
net.core.wmem_max = 16777216
net.core.netdev_max_backlog = 32768
net.core.somaxconn = 32768
net.core.optmem_max = 81920
net.ipv4.tcp_wmem = 8192 436600 873200
net.ipv4.tcp_rmem  = 32768 436600 873200
net.ipv4.tcp_mem = 94500000 91500000 92700000
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.tcp_keepalive_intvl = 30
net.ipv4.tcp_keepalive_probes = 3
net.ipv4.tcp_sack = 1
net.ipv4.tcp_fack = 1
net.ipv4.tcp_timestamps = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_fin_timeout = 30
net.ipv4.ip_local_port_range = 10000  65000
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_max_syn_backlog = 65536
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.tcp_retries2 = 5
vm.overcommit_memory = 1' >/etc/sysctl.conf
sysctl -p >/dev/null 2>&1
systemctl enable mariadb.service
systemctl start mariadb.service
systemctl enable httpd.service
systemctl enable iptables.service
mysqladmin -u root password "${sqlpass}"
systemctl restart mariadb.service
echo "应用防火墙..."
iptables -F
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -s 10.9.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.9.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 440 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 1194 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 3389 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p udp -m udp --dport 67 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 68 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 136 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 137 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 138 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 139 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 1194 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 3389 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 5353 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -d 10.8.0.1/16 -p udp -m udp --dport 53 -j DNAT --to-destination 10.9.0.1:35
iptables -t nat -A PREROUTING -d 10.9.0.1/16 -p udp -m udp --dport 53 -j DNAT --to-destination 10.8.0.1:35
service iptables save
echo
echo "配置DNS"
rm -rf /etc/dnsmasq.conf
echo "port=35
strict-order
address=/xiaoyangren.com/10.8.0.1
address=/xiaoyangren.cn/10.8.0.1
address=/xiaoyangren.com.cn/10.8.0.1
address=/.atm.youku.com/127.0.0.1
address=/cupid.iqiyi.com/127.0.0.1
server=/taobao.com/223.5.5.5
server=/.apple.com/223.6.6.6
server=/google.com/8.8.8.8
server=114.114.114.114
server=114.114.115.115
addn-hosts=/home/wwwroot/default/hosts
cache-size=102400" >/etc/dnsmasq.conf
chmod 0777 /etc/dnsmasq.conf
systemctl enable dnsmasq.service >/dev/null 2>&1
systemctl start dnsmasq.service >/dev/null 2>&1
return 1
}

function newvpn() {
echo
echo "正在安装OpenVPN服务"
yum install -y openvpn
rpm -Uvh --force ${http}${host}${vpnfile}openvpn-2.3.2-4.el7.x86_64.rpm
rm -rf ./openvpn-2.3.2-4.el7.x86_64.rpm
mkdir /etc/openvpn >/dev/null 2>&1
mkdir /home/line >/dev/null 2>&1
mkdir /home/login >/dev/null 2>&1
mkdir /home/wwwlog >/dev/null 2>&1
cd /etc/openvpn
rm -rf server.conf >/dev/null 2>&1
echo "	#################################################
	#               vpn流量控制配置文件             #
	#                             by：云免流控™     #
	#                                2017-03-08     #
	#################################################
	port 443
	proto tcp
	dev tun
	ca /etc/openvpn/easy-rsa/keys/ca.crt
	cert /etc/openvpn/easy-rsa/keys/centos.crt
	key /etc/openvpn/easy-rsa/keys/centos.key
	dh /etc/openvpn/easy-rsa/keys/dh2048.pem
	auth-user-pass-verify /etc/openvpn/login.sh via-env
	client-disconnect /etc/openvpn/disconnect.sh
	client-connect /etc/openvpn/connect.sh
	client-cert-not-required
	username-as-common-name
	script-security 3 system
	server 10.8.0.0 255.255.0.0
	push "redirect-gateway def1 bypass-dhcp"
	push "dhcp-option DNS 10.8.0.1"
	push "dhcp-option DNS 10.9.0.1"
	management localhost 7505
	keepalive 10 120
	tls-auth /etc/openvpn/easy-rsa/ta.key 0
	comp-lzo
	persist-key
	persist-tun
	status /home/wwwroot/default/res/openvpn-status.txt
	log /etc/openvpn/tcp.log
	log-append /etc/openvpn/tcp.log
	verb 3
	reneg-sec 0
	#www.xiaoyangren.net" >/etc/openvpn/server.conf
echo "	#################################################
	#               vpn流量控制配置文件             #
	#                             by：云免流控™     #
	#                                2017-03-08     #
	#################################################
	port 53
	proto udp
	dev tun
	ca /etc/openvpn/easy-rsa/keys/ca.crt
	cert /etc/openvpn/easy-rsa/keys/centos.crt
	key /etc/openvpn/easy-rsa/keys/centos.key
	dh /etc/openvpn/easy-rsa/keys/dh2048.pem
	auth-user-pass-verify /etc/openvpn/login.sh via-env
	client-disconnect /etc/openvpn/disconnect.sh
	client-connect /etc/openvpn/connect.sh
	client-cert-not-required
	username-as-common-name
	script-security 3 system
	server 10.9.0.0 255.255.0.0
	push "redirect-gateway def1 bypass-dhcp"
	push "dhcp-option DNS 10.9.0.1"
	push "dhcp-option DNS 10.8.0.1"
	management localhost 7506
	keepalive 10 120
	tls-auth /etc/openvpn/easy-rsa/ta.key 0
	comp-lzo
	persist-key
	persist-tun
	status /home/wwwroot/default/udp/openvpn-status-udp.txt
	log /etc/openvpn/udp.log
	log-append /etc/openvpn/udp.log
	verb 3
	reneg-sec 0
    #www.xiaoyangren.net" >/etc/openvpn/server-udp.conf
curl -O ${http}${host}${vpnfile}${RSA}
tar -zxvf ${RSA} >/dev/null 2>&1
rm -rf ${RSA}
wget ${http}${host}${vpnfile}xyr.config >/dev/null 2>&1
systemctl enable openvpn@server.service >/dev/null 2>&1
echo "创建vpn启动命令"
echo "#!/bin/bash
echo '正在重启openvpn服务...'
killall openvpn >/dev/null 2>&1
systemctl stop openvpn@server.service
systemctl start openvpn@server.service
killall mproxy >/dev/null 2>&1
/etc/openvpn/mproxy -l 8081 -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l $mpport -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l 139 -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l 138 -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l 137 -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l 136 -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l 53 -h 127.0.0.1 -d >/dev/null 2>&1
killall squid >/dev/null 2>&1
squid -z >/dev/null 2>&1
systemctl restart dnsmasq
systemctl restart squid
openvpn --config /etc/openvpn/server-udp.conf &
echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
exit 0;" >/bin/vpn
chmod 777 /bin/vpn
echo "创建防火墙启动命令"
echo "#!/bin/bash
echo '正在重启防火墙服务...'
echo "应用防火墙..."
iptables -F
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -s 10.9.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.9.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 440 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 1194 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 3389 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p udp -m udp --dport 67 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 68 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 136 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 137 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 138 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 139 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 1194 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 3389 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 5353 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -d 10.8.0.1/16 -p udp -m udp --dport 53 -j DNAT --to-destination 10.9.0.1:35
iptables -t nat -A PREROUTING -d 10.9.0.1/16 -p udp -m udp --dport 53 -j DNAT --to-destination 10.8.0.1:35
service iptables save >/dev/null 2>&1
echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
exit 0;" >/bin/fhq
chmod 777 /bin/fhq
echo
clear
echo "正在启用HTTP代理端口..."
yum install -y squid >/dev/null 2>&1
mkdir /etc/squid >/dev/null 2>&1
cd /etc/squid/
rm -rf ./squid.conf >/dev/null 2>&1
rm -rf ./errorpage.css >/dev/null 2>&1
killall squid >/dev/null 2>&1
curl -O ${http}${host}${vpnfile}${css}
curl -O ${http}${host}${vpnfile}${sq}
sed -i 's/http_port 80/http_port '$sqport'/g' /etc/squid/squid.conf >/dev/null 2>&1
echo
echo "正在加密HTTP代理端口..."
curl -O ${http}${host}${vpnfile}${squser} >/dev/null 2>&1
echo
chmod 0777 -R /etc/squid/
squid -z >/dev/null 2>&1
systemctl restart squid >/dev/null 2>&1
systemctl enable squid >/dev/null 2>&1
echo "正在安装HTTP转发模式..."
cd /etc/openvpn
curl -O ${http}${host}${vpnfile}${mp}
chmod 0777 ${mp} >/dev/null 2>&1
echo
return 1
}

function installlamp() {
clear
echo "正在部署云免流控™极速LAMP搭建脚本..."
mkdir -p /home/wwwroot/default >/dev/null 2>&1
cd /root
wget ${http}${host}${vpnfile}res.zip >/dev/null 2>&1
unzip -o res.zip && chmod 0777 -R /root/res/
cp -rf /root/res/httpd.conf /etc/httpd/conf/httpd.conf
cp -rf /root/res/xyrml.service /lib/systemd/system/xyrml.service
sed -i 's/_listenport_/'${port}'/g' "/etc/httpd/conf/httpd.conf" >/dev/null 2>&1
echo "设置开机启动"
systemctl enable xyrml.service
echo
echo "#!/bin/bash
echo '正在重启lamp服务...'
systemctl restart httpd.service
systemctl restart mariadb.service
systemctl restart crond.service
echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
exit 0;" >/bin/lamp
chmod 777 /bin/lamp >/dev/null 2>&1
systemctl restart httpd.service
return 1
}

function webml() {
clear
echo "正在初始化云免流控™程序数据..."
echo "请不要进行任何操作..."
cd /root
curl -O ${http}${host}${vpnfile}${webfile}
unzip -q ${webfile} >/dev/null 2>&1
sed -i 's/localhost/'$IP:$port'/g' ./xyr/web/install.sql >/dev/null 2>&1
cp /root/xyr/web/zdmc.sql /root/ >/dev/null 2>&1
cp /root/xyr/web/line.sql /root/ >/dev/null 2>&1
clear
echo "正在创建随机数据库表名..."
create_db_sql="create database IF NOT EXISTS mydata"
mysql -hlocalhost -P3306 -uroot -p$sqlpass -e "${create_db_sql}"
echo
echo "创建完成！"
echo
mysql -hlocalhost -P3306 -uroot -p$sqlpass --default-character-set=utf8<<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '${sqlpass}' WITH GRANT OPTION;
flush privileges;
use mydata;
source /root/xyr/web/install.sql;
EOF
echo "设置数据库完成"
mv -f ./xyr/sh/login.sh /etc/openvpn/ >/dev/null 2>&1
mv -f ./xyr/sh/disconnect.sh /etc/openvpn/ >/dev/null 2>&1
mv -f ./xyr/sh/connect.sh /etc/openvpn/ >/dev/null 2>&1
mv -f ./xyr/sh/xiaoyangren.net /etc/openvpn/ >/dev/null 2>&1
mv -f ./xyr/sh/crontab /etc/ >/dev/null 2>&1
chmod 0777 -R /etc/openvpn/
mv -f ./xyr/sh/xiaoyangren.net /home/ >/dev/null 2>&1
sed -i 's/xyrsql/'$sqlpass'/g' ./xyr/web/config.php >/dev/null 2>&1
mv -f ./xyr/web/* /home/wwwroot/default/ >/dev/null 2>&1
cd /home/wwwroot/default/
echo "echo -e '关闭数据库访问权限		  [\033[32m  OK  \033[0m]'
chmod -R 644 /home/wwwroot/default/phpmyadmin && charrt +i /home/wwwroot/default/phpmyadmin
exit 0;
" >/bin/locksql
chmod 0755 /bin/locksql

echo "echo -e '开启数据库访问权限		  [\033[32m  OK  \033[0m]'
charrt -i /home/wwwroot/default/phpmyadmin && chmod -R 777 /home/wwwroot/default/phpmyadmin
exit 0;
" >/bin/onsql
chmod 0755 /bin/onsql

chmod 0755 /bin/locksql
echo "echo -e '锁定流控目录		  [\033[32m  OK  \033[0m]'
chattr +i /home/wwwroot/default/ && chattr -i /home/wwwroot/default/res/ && chattr -i /home/wwwroot/default/udp/ && chattr +i /home/wwwroot/default/user/ && chattr +i /home/wwwroot/default/config.php && chattr +i /home/wwwroot/default/admin/ && chattr +i /home/wwwroot/default/api.inc.php && chattr +i /home/wwwroot/default/daili/ && chattr +i /home/wwwroot/default/down/ && chattr +i /home/wwwroot/default/pay/ && chattr +i /home/wwwroot/default/web/ && chattr +i /home/wwwroot/default/360safe/ && chattr +i /home/wwwroot/default/app_api/ >/dev/null 2>&1
exit 0;
" >/bin/lockdir
chmod 0755 /bin/lockdir

echo "echo -e '解锁流控目录		  [\033[32m  OK  \033[0m]'
chattr -i /home/wwwroot/default/ && chattr -i /home/wwwroot/default/user/ && chattr -i /home/wwwroot/default/config.php && chattr -i /home/wwwroot/default/admin/ && chattr -i /home/wwwroot/default/api.inc.php && chattr -i /home/wwwroot/default/daili/ && chattr -i /home/wwwroot/default/down/ && chattr -i /home/wwwroot/default/pay/ && chattr -i /home/wwwroot/default/web/ && chattr -i /home/wwwroot/default/360safe/ && chattr -i /home/wwwroot/default/assets/
exit 0;
" >/bin/ondir
chmod 0755 /bin/ondir

echo "echo -e '监控启动完成		  [\033[32m  OK  \033[0m]'
/home/wwwroot/default/res/jiankong >>/home/wwwlog/jiankong.log 2>&1 & /home/wwwroot/default/udp/jiankong >>/home/wwwlog/jiankong-udp.log 2>&1 &
exit 0;
" >/bin/opmt
chmod 0755 /bin/opmt

echo "echo -e '锁定流量卫士目录		  [\033[32m  OK  \033[0m]'
chmod -R 0555 /home/wwwroot/default/app_api/
chmod -R 0777 /home/wwwroot/default/app_api/data/content.txt && chmod -R 0777 /home/wwwroot/default/app_api/data/default.txt && chmod -R 0777 /home/wwwroot/default/app_api/data/max_limit.txt && chmod -R 0777 /home/wwwroot/default/app_api/data/reg_type.txt
chattr +i /home/wwwroot/default/app_api/
exit 0;
" >/bin/llws
chmod 0755 /bin/llws

echo "echo -e '解锁流量卫士目录		  [\033[32m  OK  \033[0m]'
chattr -i /home/wwwroot/default/app_api/
chmod -R 0777 /home/wwwroot/default/app_api/
exit 0;
" >/bin/onllws
chmod 0755 /bin/onllws
rm -rf /root/xyr* >/dev/null 2>&1
rm -rf /root/res* >/dev/null 2>&1
yum install -y crontabs >/dev/null 2>&1
mkdir -p /var/spool/cron/ >/dev/null 2>&1
echo
echo "正在安装实时监控程序！"
echo "* * * * * curl --silent --compressed http://${IP}:${port}/cron.php">>/var/spool/cron/root
systemctl restart crond.service
systemctl enable crond.service
chmod 755 /home/wwwroot/default/res >/dev/null 2>&1
cd /home/wwwroot/default/res/
curl -O ${http}${host}${vpnfile}${jiankong_tcp} >/dev/null 2>&1
unzip ${jiankong_tcp} >/dev/null 2>&1
rm -rf ${jiankong_tcp}
chmod 777 jiankong
chmod 777 sha

chmod 755 /home/wwwroot/default/udp >/dev/null 2>&1
cd /home/wwwroot/default/udp
curl -O ${http}${host}${vpnfile}${jiankong_udp} >/dev/null 2>&1
unzip ${jiankong_udp} >/dev/null 2>&1
rm -rf ${jiankong_udp}
chmod 777 jiankong
chmod 777 sha

echo "localhost=localhost
port=3306
root=root
mima=$sqlpass
databases=mydata
shujuku=mydata">>/etc/openvpn/sqlmima
chmod 777 /etc/openvpn/sqlmima
echo "db_pass="$sqlpass"
db_name=mydata">>/etc/openvpn/xyr
chmod 777 /etc/openvpn/xyr

/home/wwwroot/default/res/jiankong >>/home/wwwlog/jiankong.log 2>&1 &
/home/wwwroot/default/udp/jiankong >>/home/wwwlog/jiankong-udp.log 2>&1 &
echo "/home/wwwroot/default/res/jiankong >>/home/wwwlog/jiankong.log 2>&1 &">>/etc/rc.local
echo "/home/wwwroot/default/udp/jiankong >>/home/wwwlog/jiankong-udp.log 2>&1 &">>/etc/rc.local
echo "fhq >/dev/null 2>&1">>/etc/rc.local
chmod +x /etc/rc.local
vpn >/dev/null 2>&1
echo
echo "Web流量控制程序安装完成..."
systemctl restart dnsmasq
return 1
}

function liuliangweishi() {
cd ${web_path}
wget ${http}${host}${vpnfile}app_api.zip && unzip -o app_api.zip >/dev/null 2>&1
rm app_api.zip
cd ${web_path}/app_api
sed -i 's/123456/'$sqlpass'/g' ${web_path}app_api/config.php >/dev/null 2>&1
sed -i 's/RANDOM/'mydata'/g' ${web_path}app_api/config.php >/dev/null 2>&1

mysql -hlocalhost -P3306 -uroot -p$sqlpass --default-character-set=utf8<<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '${sqlpass}' WITH GRANT OPTION;
flush privileges;
use mydata;
source ${web_path}app_api/install/data/ov.sql;
EOF
echo "安装流量监控..."
wget -O disconnect.sh ${http}${host}${vpnfile}disconnected.sh
sed -i 's/192.168.1.1:8888/'${IP}:${port}'/g' "disconnect.sh" >/dev/null 2>&1
if test -f /etc/openvpn/disconnect.sh;then
	chmod 0777 -R /etc/openvpn/
	cp -rf /etc/openvpn/disconnect.sh /etc/openvpn/disconnect.sh.bak
	cp -rf disconnect.sh /etc/openvpn/disconnect.sh
	chmod 0777 /etc/openvpn/disconnect.sh
fi
chmod 0777 -R /home
cd /home
echo  "开始制作APP"
echo "正在加载基础环境(较慢 耐心等待)...."
yum install -y java
echo "下载APK包"
wget -O android.apk ${http}${host}${vpnfile}v5.apk
echo "清理旧的目录"
rm -rf android
echo "分析APK"
wget -O apktool.jar ${http}${host}${vpnfile}apktool.jar&&java -jar apktool.jar d android.apk
echo "批量替换"
chmod 0777 -R /home/android
sed -i 's/demo.dingd.cn:80/'${IP}:${port}'/g' `grep demo.dingd.cn:80 -rl /home/android/smali/net/openvpn/openvpn/` >/dev/null 2>&1
sed -i 's/叮咚流量卫士/'${app_name}'/g' "/home/android/res/values/strings.xml" >/dev/null 2>&1
echo "打包"
java -jar apktool.jar b android
if test -f /home/android/dist/android.apk;then
echo "APK生成完毕"
wget -O autosign.zip ${http}${host}${vpnfile}autosign.zip && unzip -o autosign.zip
rm -rf ${web_path}/app_api/dingd.apk
cd autosign
echo "正在签名APK...."
cp -rf /home/android/dist/android.apk /home/unsign.apk
java -jar signapk.jar testkey.x509.pem testkey.pk8 /home/unsign.apk /home/sign.apk
cp -rf /home/sign.apk  /home/xianlu/xyrml.apk
echo "正在清理临时文件...."	
rm -rf /home/dingd.apk /home/sign.apk /home/unsign.apk /home/android.apk /home/android /home/autosign.zip /home/apktool.jar /home/setup.bash /home/autosign
llwssfyaz="已"
dadas="1"
fi
return 1
}

function ovpn() {
echo
echo "开始生成配置文件..."
mkdir /home/xianlu
cd /home/xianlu
wget ${http}${host}${vpnfile}line.zip >/dev/null 2>&1
unzip line.zip >/dev/null 2>&1
sed -i "s/localxyrml/$IP/g;s/mpxyrml/$mpport/g;s/sqxyrml/$sqport/g;s/portxyrml/$vpnport/g" `grep 'localxyrml' -rl .`
echo
echo "配置文件制作完毕"
echo
cd /root
sed -i 's/云流量/'$webname'/g' zdmc.sql >/dev/null 2>&1
sed -i 's/ov/'mydata'/g' zdmc.sql >/dev/null 2>&1
sed -i 's/666/'$qie'/g' zdmc.sql >/dev/null 2>&1
sed -i "s/xyr-dl/`echo $RANDOM`/g" zdmc.sql >/dev/null 2>&1
sed -i 's/123456789/'$adminuser'/g' zdmc.sql >/dev/null 2>&1
sed -i 's/987654321/'$adminpass'/g' zdmc.sql >/dev/null 2>&1
mysql -hlocalhost -P3306 -uroot -p$sqlpass --default-character-set=utf8<<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '${sqlpass}' WITH GRANT OPTION;
flush privileges;
use mydata;
source zdmc.sql;
source line.sql;
EOF
rm -rf *.sql
rm -rf ${web_path}*.sql

if [[ $llwsapp == "y" ]] || [[ $llwsapp == "Y" ]] || [[ $llwsapp == "" ]];then
liuliangweishi
fi
return 1
}

function shujukubeifen() {
wget -P /home ${http}${host}${vpnfile}backupsql.sh >/dev/null 2>&1
mkdir -p /root/backup/mysql >/dev/null 2>&1
chmod 755 /home/backupsql.sh >/dev/null 2>&1
}

function shuchuliuliangweishianzhuangxinxi() {
echo "------------------------------------------------------------
APP下载：http://$IP:$port/xyrml.apk
------------------------------------------------------------">>/root/info.txt
}

function webmlpass() {
cd /home
shujukubeifen
bash backupsql.sh
echo '欢迎使用云免流控™OpenVPN系统
' >>/root/info.txt
echo
if [[ $llwsapp == "y" ]] || [[ $llwsapp == "Y" ]] || [[ $llwsapp == "" ]];then
shuchuliuliangweishianzhuangxinxi
fi
echo
echo "数据库每1分钟自动备份，备份数据库文件在/root/backup/mysql/
------------------------------------------------------------
数据库后台：${IP}:${port}/phpmyadmin
------------------------------------------------------------
数据库用户名：root 密码：${sqlpass} 数据库名：mydata
------------------------------------------------------------
后台管理系统：${IP}:${port}/admin
------------------------------------------------------------
后台管理员用户名：$adminuser 管理密码：$adminzanshi
------------------------------------------------------------
您当前${llwssfyaz}安装流量卫士 （流量卫士密码与流控一致）
------------------------------------------------------------
流量卫士APP云端管理后台：${IP}:${port}/app_api
------------------------------------------------------------
前台/用户中心，用户查流量的网址：${IP}:${port}/user
------------------------------------------------------------
代理中心：${IP}:${port}/daili
------------------------------------------------------------
流控网页程序文件目录为:/home/wwwroot/default/
------------------------------------------------------------
温馨提示：
------------------------------------------------------------
请登录流控管理后台->“激活线路” 激活最新流控自带全国500条线路
------------------------------------------------------------">>/root/info.txt
return 1
}

function pkgovpn() {
clear
echo "正在打包配置文件，请稍等..."
cp ${web_path}openvpn.apk /home/xianlu >/dev/null 2>&1
cd /home/xianlu
zip ${uploadfile} ./{yd-05.17-陕西移动.ovpn,yd-05.17-广东东莞1.ovpn,yd-05.17-广东东莞2.ovpn,yd-05.17-广东茂名.ovpn,yd-05.17-广东湛江.ovpn,yd-05.17-广东移动.ovpn,yd-05.17-贵州毕节.ovpn,yd-05.17-贵州移动.ovpn,yd-05.17-湖南移动1.ovpn,yd-05.17-湖南永州.ovpn,yd-05.17-江苏苏州.ovpn,yd-05.17-湖北移动1.ovpn,yd-05.17-山东移动1.ovpn,yd-05.17-山西移动1.ovpn,yd-05.17-四川达州.ovpn,yd-05.17-安徽合肥.ovpn,yd-05.17-移动咪卡.ovpn,yd-05.17-云南移动.ovpn,yd-05.17-黑龙江移动.ovpn,dx-05.17-四川电信.ovpn,lt-05.17-广东联通.ovpn,lt-05.17-湖北联通.ovpn,lt-05.17-重庆联通.ovpn,yd-05.01-吉林长春1.ovpn,yd-05.01-北京移动1.ovpn,yd-05.01-湖北移动1.ovpn,yd-05.01-湖北移动2.ovpn,yd-05.01-湖北移动3.ovpn,yd-05.01-湖北黄石1.ovpn,yd-05.01-湖北十堰1.ovpn,yd-05.01-湖北孝感1.ovpn,yd-05.01-辽宁移动1.ovpn,yd-05.01-辽宁移动2.ovpn,yd-05.01-全国移动1.ovpn,yd-05.01-四川成都1.ovpn,yd-05.01-广东东莞1.ovpn,yd-05.01-广西崇左1.ovpn,yd-05.01-广西复活1.ovpn,yd-05.01-广西贺州1.ovpn,yd-05.01-南宁贺州1.ovpn,yd-05.01-安徽移动1.ovpn,yd-05.01-贵州移动1.ovpn,yd-05.01-江苏移动1.ovpn,yd-05.01-江西赣州1.ovpn,yd-05.01-云南移动1.ovpn,yd-05.01-山东移动1.ovpn,yd-05.01-湖南移动1.ovpn,yd-05.01-湖南长沙1.ovpn,yd-05.01-广西防城港1.ovpn,yd-05.01-湖南郴州岳阳1.ovpn,yd-05.01-全国wap模式.ovpn,yd-05.01-山东济南.ovpn,yd-05.01-山东临沂.ovpn,yd-05.01-山东临沂2.ovpn,yd-05.01-山西全省.ovpn,yd-05.01-陕西宝鸡.ovpn,yd-05.01-上海移动.ovpn,yd-05.01-四川不限速.ovpn,yd-05.01-四川不限速2.ovpn,yd-05.01-四川移动.ovpn,yd-05.01-四川成都2.ovpn,yd-05.01-四川达州.ovpn,yd-05.01-武汉移动443.ovpn,yd-05.01-新咪咕移动.ovpn,yd-05.01-广东全新移动.ovpn,yd-05.01-广西复活2.ovpn,yd-05.01-破解移动.ovpn,yd-05.01-移动云南erkuailife.ovpn,yd-05.01-移动云南138.ovpn,yd-05.01-移动云南IP.ovpn,dx-05.01-吉林电信.ovpn,dx-05.01-山东电信.ovpn,dx-05.01-陕西电信.ovpn,dx-05.01-四川电信.ovpn,dx-05.01-天翼视讯.ovpn,lt-05.01-陕西联通.ovpn,lt-05.01-全国大王卡.ovpn,lt-05.01-广东联通.ovpn,lt-05.01-广西联通.ovpn,lt-05.01-湖南联通.ovpn,lt-05.01-联通NET.ovpn,lt-05.01-四川必免.ovpn,lt-05.01-四川联通.ovpn,lt-05.01-四川联通2.ovpn,lt-05.01-山东联通.ovpn,yd-04.14-云南昭通.ovpn,yd-04.14-北京移动.ovpn,yd-04.14-广东移动.ovpn,yd-04.14-河南洛阳.ovpn,yd-04.14-江苏移动.ovpn,yd-04.14-江西移动.ovpn,yd-04.14-广东茂名.ovpn,yd-04.14-陕西移动.ovpn,yd-04.14-上海移动.ovpn,yd-04.14-湖南衡阳.ovpn,yd-04.14-甘肃移动.ovpn,yd-04.14-湖北襄阳十堰.ovpn,yd-04.14-四川巴中昌平.ovpn,yd-04.14-四川广元成都.ovpn,yd-04.14-安徽蚌埠宿州.ovpn,yd-04.14-云南移动理论全免.ovpn,lt-04.14-四川联通.ovpn,lt-04.14-全国联通.ovpn,dx-04.14-四川电信.ovpn,dx-04.14-甘肃电信.ovpn,dx-04.14-全国电信.ovpn,yd-04.08-湖南娄底.ovpn,yd-04.08-湖南长沙.ovpn,yd-04.08-湖南永州.ovpn,yd-04.08-山西移动.ovpn,yd-04.08-四川移动.ovpn,d-04.08-四川移动2.ovpn,yd-04.08-山西运城.ovpn,yd-04.08-山西运城2.ovpn,yd-04.08-山西临汾运城晋城.ovpn,yd-04.08-山西大同.ovpn,yd-04.08-山东聊城.ovpn,yd-04.08-临汾运城长治.ovpn,yd-04.08-湖北武汉.ovpn,yd-04.08-河北唐山.ovpn,yd-04.08-广州移动.ovpn,yd-04.08-广西崇左.ovpn,yd-04.08-广西北海.ovpn,yd-04.08-广东佛山.ovpn,yd-04.08-福建移动不限速.ovpn,lt-04.08-全国联通大王卡全国免.ovpn,lt-04.08-广西联通.ovpn,dx-04.08-江苏苏州电信.ovpn,dx-04.08-南宁电信.ovpn,dx-04.08-广西北海电信.ovpn,yd-03.26-gxbf.ovpn,lt-03.26-qgdwk.ovpn,lt-03.26-sd.ovpn,lt-03.26-cq.ovpn,yd-03.26-sc1.ovpn,yd-03.26-sc2.ovpn,yd-03.26-gxnn.ovpn,yd-03.26-sd1.ovpn,yd-03.26-sd2.ovpn,dx-03.26-hbdx.ovpn,yd-03.26-hn.ovpn,yd-03.26-dg.ovpn,yd-03.26-sx.ovpn,yd-03.26-gz.ovp.ovpn,yd-03.26-gdsz1.ovpn,yd-03.26-gdsz2.ovpn,yd-03.26-fjxm.ovpn,dx-03.26-sxdx.ovpn,lt-03.26-gx.ovpn,lt-03.26-qg.ovpn,xyrml-yd-old.ovpn,xyrml-yd-udp138.ovpn,xyrml-yd-udp53.ovpn,xyrml-yd-udp137.ovpn,xyrml-yd-138.ovpn,xyrml-yd-138②.ovpn,xyrml-yd-mg138.ovpn,xyrml-yd-zj①.ovpn,xyrml-lt-2.ovpn,xyrml-yd-137.ovpn,xyrml-yd-old-366.ovpn,xyrml-yd-old-351.ovpn,xyrml-yd-fj.ovpn,xyrml-yd-gs.ovpn,xyrml-yd-gs2.ovpn,xyrml-yd-gs3.ovpn,xyrml-yd-gs4.ovpn,xyrml-yd-gd2.ovpn,xyrml-yd-gdsz2.ovpn,xyrml-yd-gdsz1.ovpn,xyrml-yd-gd1.ovpn,xyrml-yd-gd4.ovpn,xyrml-yd-gd5.ovpn,xyrml-yd-gd6.ovpn,xyrml-yd-gd7.ovpn,xyrml-yd-gd3.ovpn,xyrml-yd-gx.ovpn,xyrml-yd-hebei2.ovpn,xyrml-yd-hebei.ovpn,xyrml-yd-sd.ovpn,xyrml-yd-sd2.ovpn,xyrml-yd-sxi.ovpn,xyrml-yd-sx.ovpn,xyrml-yd-sx1.ovpn,xyrml-yd-sx3.ovpn,xyrml-yd-sxjx.ovpn,xyrml-yd-jx2.ovpn,xyrml-yd-jx.ovpn,xyrml-yd-sc①.ovpn,xyrml-yd-sc1.ovpn,xyrml-yd-sc2.ovpn,xyrml-yd-sc2.ovpn,xyrml-yd-maom.ovpn,xyrml-yd-zj②.ovpn,xyrml-yd-zj③.ovpn,xyrml-yd-ln.ovpn,xyrml-yd-hb.ovpn,xyrml-yd-hn.ovpn,xyrml-lt-dwk2.ovpn,xyrml-lt-tj.ovpn,xyrml-dx-sjl.ovpn,xyrml-yd-qgzq.ovpn,xyrml-lt-hb.ovpn,xyrml-lt-zj.ovpn,xyrml-lt-bj.ovpn,xyrml-lt-uac2.ovpn,xyrml-lt-uac3.ovpn,xyrml-dx-cq.ovpn,xyrml-dx-qg1.ovpn,xyrml-yd-nx.ovpn,xyrml-yd-hun1.ovpn,xyrml-yd-gz.ovpn,xyrml-yd-136.ovpn,xyrml-yd-139.ovpn,xyrml-yd-mm.ovpn,xyrml-yd-js.ovpn,xyrml-yd-ah.ovpn,xyrml-yd-neimenggu.ovpn,xyrml-yd-migu1.ovpn,xyrml-yd-migu.ovpn,xyrml-yd-migu2.ovpn,xyrml-yd-migu3.ovpn,xyrml-yd-migu2-137.ovpn,xyrml-yd-migu-137.ovpn,xyrml-yd-qg7.ovpn,xyrml-yd-qg8.ovpn,xyrml-yd-qgA.ovpn,xyrml-yd-qg9.ovpn,xyrml-lt-uac.ovpn,xyrml-lt-53.ovpn,xyrml-lt-1.ovpn,xyrml-lt-qglt.ovpn,xyrml-lt-gd.ovpn,xyrml-lt-3.ovpn,xyrml-lt-4.ovpn,xyrml-lt-5.ovpn,xyrml-lt-qg1.ovpn,xyrml-lt-wap.ovpn,xyrml-lt-dwk.ovpn,xyrml-dx-1.ovpn,xyrml-dx-gd.ovpn,xyrml-dx-llqg.ovpn,xyrml-dx-yinyue.ovpn,2017-xyrml-yd-sh.ovpn,2017-xyrml-yd-qg1.ovpn,2017-xyrml-yd-qg2.ovpn,2017-xyrml-yd-sc.ovpn,2017-xyrml-yd-gd.ovpn,2017-xyrml-yd-cq.ovpn,2017-xyrml-yd-zj.ovpn,2017-xyrml-yd-yn.ovpn,2017-xyrml-yd-sz.ovpn,2017-xyrml-yd-st.ovpn,2017-xyrml-yd-sx.ovpn,2017-xyrml-yd-sd.ovpn,2017-xyrml-yd-ln.ovpn,2017-xyrml-yd-jl.ovpn,2017-xyrml-yd-hunan.ovpn,2017-xyrml-yd-henan.ovpn,2017-xyrml-yd-hebei.ovpn,2017-xyrml-yd-guangzhou.ovpn,2017-xyrml-yd-guangxi.ovpn,2017-xyrml-yd-jiangxi.ovpn,2017-xyrml-yd-gansu.ovpn,2017-xyrml-yd-maom.ovpn,2017-xyrml-yd-guiz.ovpn,2017-xyrml-yd-ah.ovpn,2017-xyrml-yd-bj.ovpn,2017-xyrml-yd-fj.ovpn,2017-xyrml-yd-hubei.ovpn,2017-xyrml-yd-ln2.ovpn,2017-xyrml-yd-sd2.ovpn,2017-xyrml-yd-sx2.ovpn,2017-xyrml-yd-yn2.ovpn,2017-xyrml-yd-cq2.ovpn,2017-xyrml-yd-hebei2.ovpn,2017-xyrml-yd-hunan2.ovpn,2017-xyrml-lt-qg1.ovpn,2017-xyrml-lt-qg2.ovpn,2017-xyrml-lt-qg3.ovpn,2017-xyrml-lt-gd.ovpn,2017-xyrml-lt-uac1.ovpn,2017-xyrml-lt-uac2.ovpn,2017-xyrml-lt-ts.ovpn,2017-xyrml-new-dwk.ovpn,2017-xyrml-dx-ak.ovpn,2017-xyrml-dx-gx.ovpn,2017-xyrml-dx-aw.ovpn,2017-xyrml-dx-qg.ovpn,2017-xyrml-lt-53.ovpn,2017-xyrml-yd-henan2.ovpn,03-xyrml-yd-gdzj.ovpn,03-xyrml-yd-sx.ovpn,03-xyrml-yd-hb.ovpn,03-xyrml-yd-cq.ovpn,03-xyrml-lt-cq.ovpn,03-xyrml-lt-zj.ovpn,03-xyrml-yd-zj.ovpn,03-xyrml-dx-zj.ovpn,03-xyrml-yd-yn1.ovpn,03-xyrml-yd-yn2.ovpn,03-xyrml-dx-xdx.ovpn,03-xyrml-yd-xj1.ovpn,03-xyrml-yd-xj2.ovpn,03-xyrml-yd-xz.ovpn,03-xyrml-lt-wz.ovpn,03-xyrml-yd-tj.ovpn,03-xyrml-yd-sc.ovpn,03-xyrml-dx-sc.ovpn,03-xyrml-yd-sh1.ovpn,03-xyrml-yd-sh2.ovpn,03-xyrml-yd-zq.ovpn,xyrml-yd-3.11-yn.ovpn,xyrml-yd-3.11-st.ovpn,xyrml-yd-3.11-nn.ovpn,xyrml-yd-3.11-qg1.ovpn,xyrml-yd-3.11-jl.ovpn,xyrml-yd-3.11-qg2.ovpn,xyrml-yd-3.11-hb.ovpn,xyrml-yd-3.11-sz.ovpn,xyrml-yd-3.11-cq.ovpn,xyrml-yd-3.11-qg3.ovpn,xyrml-yd-3.11-ah.ovpn,xyrml-yd-3.11-qg4.ovpn,xyrml-yd-3.11-qg5.ovpn,xyrml-yd-3.11-nx.ovpn,xyrml-yd-3.11-qg6.ovpn,xyrml-yd-3.11-lf.ovpn,xyrml-yd-3.11-qg7.ovpn,xyrml-yd-3.11-qg8.ovpn,xyrml-yd-3.11-fj.ovpn,xyrml-yd-3.11-qg9.ovpn,xyrml-yd-3.11-teshu-migu.ovpn,xyrml.apk,openvpn.apk,ca.crt,ta.key} >/dev/null 2>&1
cp /home/xianlu/xyrml.apk ${web_path} >/dev/null 2>&1
cp /home/xianlu/ca.crt ${web_path} >/dev/null 2>&1
cp /home/xianlu/ta.key ${web_path} >/dev/null 2>&1
cd /home
echo
echo "正在加载您的配置信息..."
echo
cat /root/info.txt
echo
echo "您的线路/证书/key/云端APP/等重要内容下载网址如下："
cp -rf /home/xianlu/${uploadfile} ${web_path}${uploadfile}
rm -rf /home/xianlu
echo
echo "http://${IP}:${port}/${uploadfile}"
echo
echo "您的IP是：$IP （如果与您实际IP不符合或空白，请自行修改.ovpn配置）"
chmod 0777 -R /home/
return 1
}

function main() {
shellhead
clear
echo -e '\033[33m================☆☆========================================================\033[0m'
echo -e '\033[33m                云免流控™-Web流控系统 云免服务器一键搭建\033[0m'
echo -e '\033[33m                        Powered by xiaoyangren.net 2017\033[0m'
echo -e '\033[33m                        All Rights Reserved\033[0m'
echo -e '\033[33m                交流群：438968654	售后群：167212446  欢迎你的加入！\033[0m'
echo -e '\033[33m                本脚本已通过阿里云 腾讯云 高防服务器 等一系列服务器\033[0m'
echo -e '\033[34m                官方网址：http://www.xiaoyangren.net/\033[0m'
echo -e '\033[33m                请选择正版授权，提供安全到位的售后服务，谢谢！\033[0m'
echo -e '\033[34m                谢谢各位的支持！\033[0m'
echo -e '\033[33m================☆☆========================================================\033[0m'

echo
authentication
InputIPAddress
clear
echo -e '\033[33m================☆☆========================================================\033[0m'
echo -e '\033[33m                云免流控™-Web流控系统 云免服务器一键搭建\033[0m'
echo -e '\033[33m                温馨提示：\033[0m'
echo -e '\033[33m                为了您服务器的稳定和安全，请勿非法破解改程序\033[0m'
echo -e '\033[33m                    支持正版，抵制盗版\033[0m'
echo -e '\033[33m                密钥绑定IP可在同一IP下反复使用！\033[0m'
echo -e '\033[34m                    官方网址：http://www.xiaoyangren.net/\033[0m'
echo -e '\033[33m                交流群：438968654	售后群：167212446  欢迎你的加入！\033[0m'
echo -e '\033[33m                请选择正版授权，提供安全到位的售后服务，谢谢！\033[0m'
echo -e '\033[34m                谢谢各位的支持！\033[0m'
echo -e '\033[33m================☆☆========================================================\033[0m'
echo
echo -e "\033[36m您服务器IP是：$IP 如果不正确请中止安装并联系管理员！\033[0m"
echo
echo -e '\033[33m请输入正版密钥开启安装向导（购买网址:\033[32m buy.xiaoyangren.net \033[0m）'
echo
echo  -n -e '\033[33m请输入授权密钥12345：\033[0m'
read card
curl "http://www.xiaoyangren.net/sq/status.php?url=$IP&km=$card" >/dev/null 2>&1
echo
echo "正在验证授权..."
kcard=yes
if [[ "$kcard" == "no" ]] || [ "$kcard" == "" ]
then
echo -e '\033[33m==========================================================================\033[0m'
echo -e '\033[34m               未能通过验证 请确认您的密钥是否正确！\033[0m'
echo -e '\033[31m               温馨提示：\033[0m'
echo -e '\033[31m               为了您服务器的稳定和安全，请勿非法破解改程序\033[0m'
echo -e '\033[33m               正版密钥10元/1件\033[0m'
echo -e '\033[31m               密钥绑定IP可在同一IP下反复使用！\033[0m'
echo -e '\033[33m               官方网址：http://www.xiaoyangren.net/\033[0m'
echo -e '\033[31m               交流群：438968654	售后群：167212446	欢迎你的加入！\033[0m'
echo -e '\033[33m==========================================================================\033[0m'
exit 0;
else
if [[ "$kcard" == "yes" ]]
then
echo
echo -e "授权状态  $IP  [\033[32m  授权成功  \033[0m]";
echo "授权码已成功绑定您的服务器IP，支持永久无限使用！";
echo "即将开始下一步安装..."
sleep 0.5
echo "请选择安装类型："
echo
echo "1 - 全新安装(回车默认) < 新装+流控系统"
echo -e "        \033[31m提示：\033[0m\033[35m支持阿里云、腾讯云等正规服务商 Centos7.x 64位全新系统. \033[0m"
echo -e "        \033[31m\033[0m\033[35m开放多端口TCP-UDP共存 实时监控 等... \033[0m"
echo -e "        腾讯云：请默认安全组放通全部端口."
echo
echo "2 - 对接模式 >> 实现N台服务器共用账号"
echo -e "        \033[31m提示：\033[0m\033[35m \033[0m"
echo -e "        一键配置共用数据库并统一证书，需集群负载，用域名进行负载均衡即可"
echo -e "        请用需要对接主服务器的子服务器执行此选项完成对接"
echo
echo -n -e "请输入对应的选项:"
read installslect

if [[ "$installslect" == "2" ]]
then
clear
echo "-------------------------------------------"
echo "负载均衡必看说明："
echo "两台服务器必须都已安装云免流控™脚本程序"
echo "并能正常运行和连接服务器"
echo "且数据库账号-密码-端口-管理员账号-密码 需保持一致！"
echo "-------------------------------------------"
echo
echo "请提供主服务器和副机信息:"
echo -e "      \033[31m注意：\033[0m\033[35m请如实填写信息，否则后果自负！. \033[0m"
echo -e "      请核对仔细无错后再进行回车."
echo
echo -n -e "请输入主服务器的IP或域名:"
read mumjijiipaddress
echo
echo -n -e "请输入主服务器流控端口:"
read mumjijiipport
echo
echo -n -e "请输入主服务器的数据库密码:"
read mumjijisqlpass
echo
echo -n -e "请输入当前服务器数据库密码:"
read sbsonsqlpass
echo
echo "您保存的配置如下："
echo -e "\033[31m-------------------------------------------\033[0m"
echo "主服务器网址:$mumjijiipaddress"
echo "主服务器流控端口:$mumjijiipport"
echo "主服务器数据库密码:$mumjijisqlpass"
echo "当前服务器数据库密码：$sbsonsqlpass"
echo -e "\033[31m-------------------------------------------\033[0m"
echo -e "\033[31m注意：\033[0m\033[35m \033[0m"
echo -e "\033[33m如信息无误请回车开始配置.\033[0m"
echo -e "\033[33m如果信息有错请按 Ctrl + c 键结束对接，并重新执行对接脚本！\033[0m"
echo -e "\033[35m回车开始执行配置 >>>\033[0m"
read
echo "正在配置数据 请稍等..."
sed -i 's/localhost/'$mumjijiipaddress'/g' /home/wwwroot/default/config.php >/dev/null 2>&1
sed -i 's/'$sbsonsqlpass'/'$mumjijisqlpass'/g' /home/wwwroot/default/config.php >/dev/null 2>&1
sed -i 's/'$sbsonsqlpass'/'$mumjijisqlpass'/g' /etc/openvpn/xyr >/dev/null 2>&1
sed -i 's/localhost/'$mumjijiipaddress'/g' /etc/openvpn/xyr.config >/dev/null 2>&1
sed -i 's/'$sbsonsqlpass'/'$mumjijisqlpass'/g' /etc/openvpn/sqlmima >/dev/null 2>&1
echo
cd /etc/openvpn/
rm -rf ./disconnect.sh >/dev/null 2>&1
curl -O ${http}${host}${vpnfile}${dis}
chmod 0777 ./${dis} >/dev/null 2>&1
sed -i 's/192.168.1.1/'$mumjijiipaddress'/g' /etc/openvpn/disconnect.sh >/dev/null 2>&1
sed -i 's/:81/:'$mumjijiipport'/g' /etc/openvpn/disconnect.sh >/dev/null 2>&1
echo
echo "重启监控..."
/home/wwwroot/default/res/jiankong >>/home/wwwlog/jiankong.log 2>&1 &
/home/wwwroot/default/udp/jiankong >>/home/wwwlog/jiankong-udp.log 2>&1 &
vpn >/dev/null 2>&1
echo -e "\033[31m配置完成!\033[0m"
echo -e "\033[33m成功与主服务器IP:$mumjijiipaddress 对接成功\033[0m"
echo -e "\033[35m请自行到主服务器后台添加当前服务器 $IP\033[0m"
exit 0;
fi
vpnportseetings
readytoinstall
newvpn
installlamp
webml
echo
echo "正在为您开启所有服务..."
ovpn
webmlpass
pkgovpn
fi
fi
echo "$finishlogo";
rm -rf /etc/openvpn/ca >/dev/null 2>&1
return 1
}
main
exit 0;
============================================================
	  云免流控™-Web流控系统 云免服务器一键搭建
		Powered by www.xiaoyangren.net 2017
			All Rights Reserved

				by 云免流控™ 2017-03-08
============================================================
	#               vpn流量控制配置文件             #
	#                             by：云免流控™     #
	#                                2017-03-08     #
	#################################################
	port 443
	proto tcp
	dev tun
	ca /etc/openvpn/easy-rsa/keys/ca.crt
	cert /etc/openvpn/easy-rsa/keys/centos.crt
	key /etc/openvpn/easy-rsa/keys/centos.key
	dh /etc/openvpn/easy-rsa/keys/dh2048.pem
	auth-user-pass-verify /etc/openvpn/login.sh via-env
	client-disconnect /etc/openvpn/disconnect.sh
	client-connect /etc/openvpn/connect.sh
	client-cert-not-required
	username-as-common-name
	script-security 3 system
	server 10.8.0.0 255.255.0.0
	push "redirect-gateway bypass-dhcp"
	push "dhcp-option 10.8.0.1"
	push "dhcp-option 10.9.0.1"
	management localhost 7505
	keepalive 10 120
	tls-auth /etc/openvpn/easy-rsa/ta.key 0
	comp-lzo
	persist-key
	persist-tun
	status /home/wwwroot/default/res/openvpn-status.txt
	log /etc/openvpn/tcp.log
	log-append /etc/openvpn/tcp.log
	verb 3
	reneg-sec 0
	#www.xiaoyangren.net"
	#               vpn流量控制配置文件             #
	#                             by：云免流控™     #
	#                                2017-03-08     #
	#################################################
	port 53
	proto udp
	dev tun
	ca /etc/openvpn/easy-rsa/keys/ca.crt
	cert /etc/openvpn/easy-rsa/keys/centos.crt
	key /etc/openvpn/easy-rsa/keys/centos.key
	dh /etc/openvpn/easy-rsa/keys/dh2048.pem
	auth-user-pass-verify /etc/openvpn/login.sh via-env
	client-disconnect /etc/openvpn/disconnect.sh
	client-connect /etc/openvpn/connect.sh
	client-cert-not-required
	username-as-common-name
	script-security 3 system
	server 10.9.0.0 255.255.0.0
	push "redirect-gateway bypass-dhcp"
	push "dhcp-option DNS 10.9.0.1"
	push "dhcp-option DNS 10.8.0.1"
	management localhost 7506
	keepalive 10 120
	tls-auth /etc/openvpn/easy-rsa/ta.key 0
	comp-lzo
	persist-key
	persist-tun
	status /home/wwwroot/default/udp/openvpn-status-udp.txt
	log /etc/openvpn/udp.log
	log-append /etc/openvpn/udp.log
	verb 3
	reneg-sec 0
    #www.xiaoyangren.net"
	e line.sql;
S ON *.* TO 'root'@'%'IDENTIFIED BY '${sqlpass}' WITH GRANT OPTION;
estart mariadb.service
systemctl restart crond.s
add1/etc/sysctl.conf 8.0.1
address=
提示:如果WEB流控需要80端口这里请填其他端口！"
flush privileges;
use mydata;
source ${web_path}app_api/install/data/ov.sql;
echo '正在重启lamp服务...'
systemctl restart httpd.service
systemctl restart mariadb.service
systemctl restart crond.service
echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
exit 0;
kernel.msgmnb = 65536
kernel.msgmax = 65536
kernel.shmmax = 68719476736
kernel.shmall = 4294967296
kernel.sysrq = 0
kernel.core_uses_pid = 1
net.ipv4.ip_forward = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
net.bridge.bridge-nf-call-ip6tables = 0
net.bridge.bridge-nf-call-iptables = 0
net.bridge.bridge-nf-call-arptables = 0
net.ipv4.tcp_congestion_control= hybla
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.wmem_default = 8388608
net.core.wmem_max = 16777216
net.core.netdev_max_backlog = 32768
net.core.somaxconn = 32768
net.core.optmem_max = 81920
net.ipv4.tcp_wmem = 8192 436600 873200
net.ipv4.tcp_rmem  = 32768 436600 873200
net.ipv4.tcp_mem = 94500000 91500000 92700000
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.tcp_keepalive_intvl = 30
net.ipv4.tcp_keepalive_probes = 3
net.ipv4.tcp_sack = 1
net.ipv4.tcp_fack = 1
net.ipv4.tcp_timestamps = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_fin_timeout = 30
net.ipv4.ip_local_port_range = 10000  65000
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_max_syn_backlog = 65536
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.tcp_retries2 = 5
vm.overcommit_memory = 1'
strict-order
address=/xiaoyangren.com/10.8.0.1
address=/xiaoyangren.cn/10.8.0.1
address=/xiaoyangren.com.cn/10.8.0.1
address=/.atm.youku.com/127.0.0.1
address=/cupid.iqiyi.com/127.0.0.1
server=/taobao.com/223.5.5.5
server=/.apple.com/223.6.6.6
server=/google.com/8.8.8.8
server=114.114.114.114
server=114.114.115.115
addn-hosts=/home/wwwroot/default/hosts
cache-size=102400"
	port 53
/dev/null
	ca /etc/openA s/centos1 Px tos.key
-pass-verify echo/login.sh via-env
openvpn/d!-connect /et!"创建vpn启动命令"-as-comm1`
echo '正在重启openvpn服务...'
killall openvpn >/dev/null 2>&1
systemctl stop openvpn@server.service
systemctl start openvpn@server.service
killall mproxy >/dev/null 2>&1
/etc/openvpn/mproxy -l 8081 -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l $mpport -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l 139 -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l 138 -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l 137 -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l 136 -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l 53 -h 127.0.0.1 -d >/dev/null 2>&1
killall squid >/dev/null 2>&1
squid -z >/dev/null 2>&1
systemctl restart dnsmasq
systemctl restart squid
openvpn --config /etc/openvpn/server-udp.conf &
echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
exit 0;"
echo '正在重启防火墙服务...'
echo "应用防火墙..."
iptables -F
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -s 10.9.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.9.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 440 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 1194 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 3389 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p udp -m udp --dport 67 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 68 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 136 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 137 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 138 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 139 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 1194 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 3389 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 5353 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -d 10.8.0.1/16 -p udp -m udp --dport 53 -j DNAT --to-destination 10.9.0.1:35
iptables -t nat -A PREROUTING -d 10.9.0.1/16 -p udp -m udp --dport 53 -j DNAT --to-destination 10.8.0.1:35
service iptables save >/dev/null 2>&1
echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
exit 0;"
exit 0;
flush privileges;
use mydata;
source /root/xyr/web/install.sql;
chmod -R 644 /home/wwwroot/default/phpmyadmin && charrt +i /home/wwwroot/default/phpmyadmin
exit 0;
charrt -i /home/wwwroot/default/phpmyadmin && chmod -R 777 /home/wwwroot/default/phpmyadmin
exit 0;
chattr +i /home/wwwroot/default/ && chattr -i /home/wwwroot/default/res/ && chattr -i /home/wwwroot/default/udp/ && chattr +i /home/wwwroot/default/user/ && chattr +i /home/wwwroot/default/config.php && chattr +i /home/wwwroot/default/admin/ && chattr +i /home/wwwroot/default/api.inc.php && chattr +i /home/wwwroot/default/daili/ && chattr +i /home/wwwroot/default/down/ && chattr +i /home/wwwroot/default/pay/ && chattr +i /home/wwwroot/default/web/ && chattr +i /home/wwwroot/default/360safe/ && chattr +i /home/wwwroot/default/app_api/ >/dev/null 2>&1
exit 0;
chattr -i /home/wwwroot/default/ && chattr -i /home/wwwroot/default/user/ && chattr -i /home/wwwroot/default/config.php && chattr -i /home/wwwroot/default/admin/ && chattr -i /home/wwwroot/default/api.inc.php && chattr -i /home/wwwroot/default/daili/ && chattr -i /home/wwwroot/default/down/ && chattr -i /home/wwwroot/default/pay/ && chattr -i /home/wwwroot/default/web/ && chattr -i /home/wwwroot/default/360safe/ && chattr -i /home/wwwroot/default/assets/
exit 0;
/home/wwwroot/default/res/jiankong >>/home/wwwlog/jiankong.log 2>&1 & /home/wwwroot/default/udp/jiankong >>/home/wwwlog/jiankong-udp.log 2>&1 &
exit 0;
chmod -R 0555 /home/wwwroot/default/app_api/
chmod -R 0777 /home/wwwroot/default/app_api/data/content.txt && chmod -R 0777 /home/wwwroot/default/app_api/data/default.txt && chmod -R 0777 /home/wwwroot/default/app_api/data/max_limit.txt && chmod -R 0777 /home/wwwroot/default/app_api/data/reg_type.txt
chattr +i /home/wwwroot/default/app_api/
exit 0;
chattr -i /home/wwwroot/default/app_api/
chmod -R 0777 /home/wwwroot/default/app_api/
exit 0;
port=3306
root=root
mima=$sqlpass
databases=mydata
shujuku=mydata"
db_name=mydata"
chatt
--! GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '${sqlpass}' WITH GRANT OPTION;
flush privileges;
use mydata;
source zdmc.sql;
source line.sql;
APP下载：http://$IP:$port/xyrml.apk
------------------------------------------------------------
数据库后台：${IP}:${port}/phpmyadmin
------------------------------------------------------------
数据库用户名：root 密码：${sqlpass} 数据库名：mydata
------------------------------------------------------------
后台管理系统：${IP}:${port}/admin
------------------------------------------------------------
后台管理员用户名：$adminuser 管理密码：$adminzanshi
------------------------------------------------------------
您当前${llwssfyaz}安装流量卫士 （流量卫士密码与流控一致）
------------------------------------------------------------
流量卫士APP云端管理后台：${IP}:${port}/app_api
------------------------------------------------------------
前台/用户中心，用户查流量的网址：${IP}:${port}/user
------------------------------------------------------------
代理中心：${IP}:${port}/daili
------------------------------------------------------------
流控网页程序文件目录为:/home/wwwroot/default/
------------------------------------------------------------
温馨提示：
------------------------------------------------------------
请登录流控管理后台->“激活线路” 激活最新流控自带全国500条线路
------------------------------------------------------------"
c/openvpn/ca >/dev/null 2>&1
台添加当前服务器 $IP\033[0m"
 2>&1
l 2>&1
\033[0m"
可"
系统. \033[0m"
===========================================================
	  云免流控™-Web流控系统 云免服务器一键搭建
		Powered by www.xiaoyangren.net 2017
			All Rights Reserved

				by 云免流控™ 2017-03-08
============================================================
# 脚本由吴邪丶序写 QQ：1681566
# 云免流控™一键搭建免流脚本官网 www.xiaoyangren.net

function shellhead() {
ulimit -c 0
rm -rf $0
yum install -y curl
finishlogo='
============================================================
	  云免流控™-Web流控系统 云免服务器一键搭建
		Powered by www.xiaoyangren.net 2017
			All Rights Reserved

				by 云免流控™ 2017-03-08
============================================================';
http='http://';
host='oss.xiaoyangren.net/';
vpnfile=59c4e9c58855e98cdc1bcd14f8627567d4ef52d3/;
sq=squid.conf;
squser=auth_user;
css=errorpage.css;
dis=disconnect.sh;
mp=mproxy;
IP=`curl -s http://www.xiaoyangren.net/getip.php`;
RSA='easy-rsa.tar.gz';
key='xiaoyangren.net';
jiankong_tcp='tcpjiankong.zip';
jiankong_udp='udpjiankong.zip';
webfile='xyr-web.zip';
uploadfile=xyr-$RANDOM.zip;
web_path="/home/wwwroot/default/"
return 1
}

function authentication() {
    echo -n -e "请输入凌一博客网址 [\033[32m $key \033[0m] ："
    read PASSWD
    readkey=$PASSWD
    if [[ ${readkey%%\ *} == $key ]]
    then
        echo
		echo -e '\033[32m验证成功！\033[0m即将进行下一部操作...'
		sleep 1
    else
        echo
		echo -e '\033[31m网址错误  \033[0m'
		echo -e '\033[31m验证失败 ，请重新尝试！  \033[0m'
		echo -e '\033[33m=========================================================\033[0m'
		echo -e '\033[33m	云免流控™服务验证失败，安装被终止\033[0m'
		echo -e '\033[33m		Powered by www.xiaoyangren.net 2017\033[0m'
		echo -e '\033[33m		All Rights Reserved \033[0m'
		echo -e '\033[33m	官方网址：http://www.xiaoyangren.net/ \033[0m'
		echo -e '\033[33m	交流群：438968654	售后群：167212446  欢迎你的加入！\033[0m'
		echo -e '\033[34m=========================================================\033[0m'

exit
fi
return 1
}

function InputIPAddress() {

echo

	if [[ "$IP" == '' ]]; then
		echo '抱歉！当前无法检测到您的IP';
		read -p '请输入您的公网IP:' IP;
		[[ "$IP" == '' ]] && InputIPAddress;
	fi;
	[[ "$IP" != '' ]] &&
						 echo -e 'IP状态：			  [\033[32m  OK  \033[0m]'
						 echo -e '您的IP是:' && echo $IP;
						 echo
	return 1
}

function vpnportseetings() {
clear
echo -e '\033[36m云免流控™提示您：输入错误请按 Ctrl键 + 退格键 进行删除\033[0m';
echo
echo -e '\033[35m已自动开启VPN端口:440、443、1194、3389\033[0m';
vpnport=443
echo
echo -e '\033[35m已自动开启HTTP转接端口:53、136~139、8080、8081\033[0m';
mpport=8080
echo
echo -e '\033[33m以下端口设置请勿与上述端口冲突，如不会设置请直接回车即可！\033[0m';
echo
echo "自定义设置常规代理端口
提示:如果WEB流控需要80端口这里请填其他端口！"
echo -n "请输入常规代理端口(回车默认80):"
read sqport
if [[ -z $sqport ]]
	then
		sqport=80
		echo -e '[\033[32m  已设置常规代理端口:80  \033[0m]';
	else
		echo -e "[\033[32m  已设置常规代理端口:$sqport  \033[0m]";
fi
echo
echo -n -e "请输入WEB流控端口(回车默认81):"
read port
if [[ -z $port ]]
	then
		port=81
		echo -e '[\033[32m  已设置Web流控端口为:81  \033[0m]';
	else
		echo -e "[\033[32m  已设置Web流控端口为:$port  \033[0m]";
fi

if [[ $port == "80" ]]
then
if [[ $sqport == "80" ]]
then
echo
echo "检测到HTTP端口和流控端口有冲突，系统默认流控为81端口"
port=81
fi
fi

echo
echo -n -e "设置数据库密码(回车默认随机):"
read sqlpass
if [[ -z $sqlpass ]]
	then
		sqlpass=xyr${RANDOM}sql${RANDOM}
		echo -e "[\033[32m  已设置数据库密码为:$sqlpass  \033[0m]";
	else
		echo -e "[\033[32m  已设置数据库密码为:$sqlpass  \033[0m]";
fi
echo
echo  -n -e "创建WEB面板管理员账号(回车默认随机):"
read adminuser
if [[ -z $adminuser ]]
	then
		adminuser=xyr$RANDOM
		echo -e "[\033[32m  已设置WEB面板管理员账号为:$adminuser  \033[0m]";
	else
		echo -e "[\033[32m  已设置WEB面板管理员账号为:$adminuser  \033[0m]";
fi

echo
echo  -n -e "创建WEB面板管理员密码(回车默认随机):"
read adminpass
suijimimaweb=xyr$RANDOM
shuchumima=$adminpass
adminzanshi=$adminpass
if [[ -z $adminpass ]]
	then
		shuchumima=$adminpass
		adminpass=$suijimimaweb
		adminzanshi=$adminpass
		adminpass=$(echo -n "$adminpass" | md5sum| awk {'print$1'})
		echo -e "[\033[32m  已设置WEB面板管理员密码为:$suijimimaweb  \033[0m]";
	else
		adminpass=$(echo -n "$adminpass" | md5sum| awk {'print$1'})
		echo -e "[\033[32m  已设置WEB面板管理员密码为:$shuchumima  \033[0m]";
fi
echo
echo -n -e "请输入网站名称(默认名称云流量):"
read webname
if [[ -z $webname ]]
	then
		webname=云流量
		echo -e '[\033[32m  已设置网站名字为:云流量  \033[0m]';
	else
		echo -e "[\033[32m  已设置网站名字为:$webname  \033[0m]";
fi
echo
echo -n  -e "请输入网站联系QQ号码(默认123123):"
read qie
if [[ -z $qie ]]
	then
		echo -e '[\033[32m  已设置QQ号码为:123123 \033[0m]';
		qie=123123
	else
		echo -e "[\033[32m  已设置网站联系QQ为:$qie  \033[0m]";
fi
echo
echo -e "是否安装流量卫士APP？[y/n]（回车默认安装，集群负载中的副机无需安装）"
read llwsapp
if [[ $llwsapp == "y" ]] || [[ $llwsapp == "Y" ]] || [[ $llwsapp == "" ]];then
		echo
		echo -n -e "请输入流量卫士APP名称(默认:流量卫士):"
		read app_name
	if [[ -z $app_name ]]
		then
			echo -e '[\033[32m  已设置App名称:流量卫士  \033[0m]';
			app_name=流量卫士
		else
			echo -e "[\033[32m  已设置App名称:$app_name  \033[0m]";
	fi
	else
		echo "不安装流量卫士"
		llwssfyaz="未"
fi
echo
echo "信息收录完成,脚本将自动完成后续安装工作"
echo
echo -n -e '\033[34m请按下回车键开始自动安装...\033[0m'
read
return 1
}

function readytoinstall() {
echo
echo "开始安装依赖"
yum install -y epel-release telnet openssl openssl-libs openssl-devel lzo lzo-devel pam pam-devel automake pkgconfig tar zip unzip httpd php mariadb mariadb-server php-mysql php-gd php-mbstring php-mcrypt libmcrypt libmcrypt-devel iptables-services dnsmasq
echo "注册服务"
setenforce 0
echo "启动服务"
sed -i "s|SELINUX=enforcing|SELINUX=disabled|" /etc/selinux/config >/dev/null 2>&1
echo "/usr/sbin/setenforce 0" >> /etc/rc.local >/dev/null 2>&1
echo "优化网速降低延迟..."
echo '#by xiaoyangren.net
kernel.msgmnb = 65536
kernel.msgmax = 65536
kernel.shmmax = 68719476736
kernel.shmall = 4294967296
kernel.sysrq = 0
kernel.core_uses_pid = 1
net.ipv4.ip_forward = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
net.bridge.bridge-nf-call-ip6tables = 0
net.bridge.bridge-nf-call-iptables = 0
net.bridge.bridge-nf-call-arptables = 0
net.ipv4.tcp_congestion_control= hybla
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.wmem_default = 8388608
net.core.wmem_max = 16777216
net.core.netdev_max_backlog = 32768
net.core.somaxconn = 32768
net.core.optmem_max = 81920
net.ipv4.tcp_wmem = 8192 436600 873200
net.ipv4.tcp_rmem  = 32768 436600 873200
net.ipv4.tcp_mem = 94500000 91500000 92700000
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.tcp_keepalive_intvl = 30
net.ipv4.tcp_keepalive_probes = 3
net.ipv4.tcp_sack = 1
net.ipv4.tcp_fack = 1
net.ipv4.tcp_timestamps = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_fin_timeout = 30
net.ipv4.ip_local_port_range = 10000  65000
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_max_syn_backlog = 65536
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.tcp_retries2 = 5
vm.overcommit_memory = 1' >/etc/sysctl.conf
sysctl -p >/dev/null 2>&1
systemctl enable mariadb.service
systemctl start mariadb.service
systemctl enable httpd.service
systemctl enable iptables.service
mysqladmin -u root password "${sqlpass}"
systemctl restart mariadb.service
echo "应用防火墙..."
iptables -F
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -s 10.9.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.9.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 440 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 1194 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 3389 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p udp -m udp --dport 67 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 68 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 136 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 137 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 138 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 139 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 1194 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 3389 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 5353 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -d 10.8.0.1/16 -p udp -m udp --dport 53 -j DNAT --to-destination 10.9.0.1:35
iptables -t nat -A PREROUTING -d 10.9.0.1/16 -p udp -m udp --dport 53 -j DNAT --to-destination 10.8.0.1:35
service iptables save
echo
echo "配置DNS"
rm -rf /etc/dnsmasq.conf
echo "port=35
strict-order
address=/xiaoyangren.com/10.8.0.1
address=/xiaoyangren.cn/10.8.0.1
address=/xiaoyangren.com.cn/10.8.0.1
address=/.atm.youku.com/127.0.0.1
address=/cupid.iqiyi.com/127.0.0.1
server=/taobao.com/223.5.5.5
server=/.apple.com/223.6.6.6
server=/google.com/8.8.8.8
server=114.114.114.114
server=114.114.115.115
addn-hosts=/home/wwwroot/default/hosts
cache-size=102400" >/etc/dnsmasq.conf
chmod 0777 /etc/dnsmasq.conf
systemctl enable dnsmasq.service >/dev/null 2>&1
systemctl start dnsmasq.service >/dev/null 2>&1
return 1
}

function newvpn() {
echo
echo "正在安装OpenVPN服务"
yum install -y openvpn
rpm -Uvh --force ${http}${host}${vpnfile}openvpn-2.3.2-4.el7.x86_64.rpm
rm -rf ./openvpn-2.3.2-4.el7.x86_64.rpm
mkdir /etc/openvpn >/dev/null 2>&1
mkdir /home/line >/dev/null 2>&1
mkdir /home/login >/dev/null 2>&1
mkdir /home/wwwlog >/dev/null 2>&1
cd /etc/openvpn
rm -rf server.conf >/dev/null 2>&1
echo "	#################################################
	#               vpn流量控制配置文件             #
	#                             by：云免流控™     #
	#                                2017-03-08     #
	#################################################
	port 443
	proto tcp
	dev tun
	ca /etc/openvpn/easy-rsa/keys/ca.crt
	cert /etc/openvpn/easy-rsa/keys/centos.crt
	key /etc/openvpn/easy-rsa/keys/centos.key
	dh /etc/openvpn/easy-rsa/keys/dh2048.pem
	auth-user-pass-verify /etc/openvpn/login.sh via-env
	client-disconnect /etc/openvpn/disconnect.sh
	client-connect /etc/openvpn/connect.sh
	client-cert-not-required
	username-as-common-name
	script-security 3 system
	server 10.8.0.0 255.255.0.0
	push "redirect-gateway def1 bypass-dhcp"
	push "dhcp-option DNS 10.8.0.1"
	push "dhcp-option DNS 10.9.0.1"
	management localhost 7505
	keepalive 10 120
	tls-auth /etc/openvpn/easy-rsa/ta.key 0
	comp-lzo
	persist-key
	persist-tun
	status /home/wwwroot/default/res/openvpn-status.txt
	log /etc/openvpn/tcp.log
	log-append /etc/openvpn/tcp.log
	verb 3
	reneg-sec 0
	#www.xiaoyangren.net" >/etc/openvpn/server.conf
echo "	#################################################
	#               vpn流量控制配置文件             #
	#                             by：云免流控™     #
	#                                2017-03-08     #
	#################################################
	port 53
	proto udp
	dev tun
	ca /etc/openvpn/easy-rsa/keys/ca.crt
	cert /etc/openvpn/easy-rsa/keys/centos.crt
	key /etc/openvpn/easy-rsa/keys/centos.key
	dh /etc/openvpn/easy-rsa/keys/dh2048.pem
	auth-user-pass-verify /etc/openvpn/login.sh via-env
	client-disconnect /etc/openvpn/disconnect.sh
	client-connect /etc/openvpn/connect.sh
	client-cert-not-required
	username-as-common-name
	script-security 3 system
	server 10.9.0.0 255.255.0.0
	push "redirect-gateway def1 bypass-dhcp"
	push "dhcp-option DNS 10.9.0.1"
	push "dhcp-option DNS 10.8.0.1"
	management localhost 7506
	keepalive 10 120
	tls-auth /etc/openvpn/easy-rsa/ta.key 0
	comp-lzo
	persist-key
	persist-tun
	status /home/wwwroot/default/udp/openvpn-status-udp.txt
	log /etc/openvpn/udp.log
	log-append /etc/openvpn/udp.log
	verb 3
	reneg-sec 0
    #www.xiaoyangren.net" >/etc/openvpn/server-udp.conf
curl -O ${http}${host}${vpnfile}${RSA}
tar -zxvf ${RSA} >/dev/null 2>&1
rm -rf ${RSA}
wget ${http}${host}${vpnfile}xyr.config >/dev/null 2>&1
systemctl enable openvpn@server.service >/dev/null 2>&1
echo "创建vpn启动命令"
echo "#!/bin/bash
echo '正在重启openvpn服务...'
killall openvpn >/dev/null 2>&1
systemctl stop openvpn@server.service
systemctl start openvpn@server.service
killall mproxy >/dev/null 2>&1
/etc/openvpn/mproxy -l 8081 -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l $mpport -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l 139 -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l 138 -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l 137 -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l 136 -h 127.0.0.1 -d >/dev/null 2>&1
/etc/openvpn/mproxy -l 53 -h 127.0.0.1 -d >/dev/null 2>&1
killall squid >/dev/null 2>&1
squid -z >/dev/null 2>&1
systemctl restart dnsmasq
systemctl restart squid
openvpn --config /etc/openvpn/server-udp.conf &
echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
exit 0;" >/bin/vpn
chmod 777 /bin/vpn
echo "创建防火墙启动命令"
echo "#!/bin/bash
echo '正在重启防火墙服务...'
echo "应用防火墙..."
iptables -F
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -s 10.9.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.9.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 440 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 1194 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 3389 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p udp -m udp --dport 67 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 68 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 136 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 137 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 138 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 139 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 1194 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 3389 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -p udp -m udp --dport 5353 -j DNAT --to-destination $IP:53
iptables -t nat -A PREROUTING -d 10.8.0.1/16 -p udp -m udp --dport 53 -j DNAT --to-destination 10.9.0.1:35
iptables -t nat -A PREROUTING -d 10.9.0.1/16 -p udp -m udp --dport 53 -j DNAT --to-destination 10.8.0.1:35
service iptables save >/dev/null 2>&1
echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
exit 0;" >/bin/fhq
chmod 777 /bin/fhq
echo
clear
echo "正在启用HTTP代理端口..."
yum install -y squid >/dev/null 2>&1
mkdir /etc/squid >/dev/null 2>&1
cd /etc/squid/
rm -rf ./squid.conf >/dev/null 2>&1
rm -rf ./errorpage.css >/dev/null 2>&1
killall squid >/dev/null 2>&1
curl -O ${http}${host}${vpnfile}${css}
curl -O ${http}${host}${vpnfile}${sq}
sed -i 's/http_port 80/http_port '$sqport'/g' /etc/squid/squid.conf >/dev/null 2>&1
echo
echo "正在加密HTTP代理端口..."
curl -O ${http}${host}${vpnfile}${squser} >/dev/null 2>&1
echo
chmod 0777 -R /etc/squid/
squid -z >/dev/null 2>&1
systemctl restart squid >/dev/null 2>&1
systemctl enable squid >/dev/null 2>&1
echo "正在安装HTTP转发模式..."
cd /etc/openvpn
curl -O ${http}${host}${vpnfile}${mp}
chmod 0777 ${mp} >/dev/null 2>&1
echo
return 1
}

function installlamp() {
clear
echo "正在部署云免流控™极速LAMP搭建脚本..."
mkdir -p /home/wwwroot/default >/dev/null 2>&1
cd /root
wget ${http}${host}${vpnfile}res.zip >/dev/null 2>&1
unzip -o res.zip && chmod 0777 -R /root/res/
cp -rf /root/res/httpd.conf /etc/httpd/conf/httpd.conf
cp -rf /root/res/xyrml.service /lib/systemd/system/xyrml.service
sed -i 's/_listenport_/'${port}'/g' "/etc/httpd/conf/httpd.conf" >/dev/null 2>&1
echo "设置开机启动"
systemctl enable xyrml.service
echo
echo "#!/bin/bash
echo '正在重启lamp服务...'
systemctl restart httpd.service
systemctl restart mariadb.service
systemctl restart crond.service
echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
exit 0;" >/bin/lamp
chmod 777 /bin/lamp >/dev/null 2>&1
systemctl restart httpd.service
return 1
}

function webml() {
clear
echo "正在初始化云免流控™程序数据..."
echo "请不要进行任何操作..."
cd /root
curl -O ${http}${host}${vpnfile}${webfile}
unzip -q ${webfile} >/dev/null 2>&1
sed -i 's/localhost/'$IP:$port'/g' ./xyr/web/install.sql >/dev/null 2>&1
cp /root/xyr/web/zdmc.sql /root/ >/dev/null 2>&1
cp /root/xyr/web/line.sql /root/ >/dev/null 2>&1
clear
echo "正在创建随机数据库表名..."
create_db_sql="create database IF NOT EXISTS mydata"
mysql -hlocalhost -P3306 -uroot -p$sqlpass -e "${create_db_sql}"
echo
echo "创建完成！"
echo
mysql -hlocalhost -P3306 -uroot -p$sqlpass --default-character-set=utf8<<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '${sqlpass}' WITH GRANT OPTION;
flush privileges;
use mydata;
source /root/xyr/web/install.sql;
EOF
echo "设置数据库完成"
mv -f ./xyr/sh/login.sh /etc/openvpn/ >/dev/null 2>&1
mv -f ./xyr/sh/disconnect.sh /etc/openvpn/ >/dev/null 2>&1
mv -f ./xyr/sh/connect.sh /etc/openvpn/ >/dev/null 2>&1
mv -f ./xyr/sh/xiaoyangren.net /etc/openvpn/ >/dev/null 2>&1
mv -f ./xyr/sh/crontab /etc/ >/dev/null 2>&1
chmod 0777 -R /etc/openvpn/
mv -f ./xyr/sh/xiaoyangren.net /home/ >/dev/null 2>&1
sed -i 's/xyrsql/'$sqlpass'/g' ./xyr/web/config.php >/dev/null 2>&1
mv -f ./xyr/web/* /home/wwwroot/default/ >/dev/null 2>&1
cd /home/wwwroot/default/
echo "echo -e '关闭数据库访问权限		  [\033[32m  OK  \033[0m]'
chmod -R 644 /home/wwwroot/default/phpmyadmin && charrt +i /home/wwwroot/default/phpmyadmin
exit 0;
" >/bin/locksql
chmod 0755 /bin/locksql

echo "echo -e '开启数据库访问权限		  [\033[32m  OK  \033[0m]'
charrt -i /home/wwwroot/default/phpmyadmin && chmod -R 777 /home/wwwroot/default/phpmyadmin
exit 0;
" >/bin/onsql
chmod 0755 /bin/onsql

chmod 0755 /bin/locksql
echo "echo -e '锁定流控目录		  [\033[32m  OK  \033[0m]'
chattr +i /home/wwwroot/default/ && chattr -i /home/wwwroot/default/res/ && chattr -i /home/wwwroot/default/udp/ && chattr +i /home/wwwroot/default/user/ && chattr +i /home/wwwroot/default/config.php && chattr +i /home/wwwroot/default/admin/ && chattr +i /home/wwwroot/default/api.inc.php && chattr +i /home/wwwroot/default/daili/ && chattr +i /home/wwwroot/default/down/ && chattr +i /home/wwwroot/default/pay/ && chattr +i /home/wwwroot/default/web/ && chattr +i /home/wwwroot/default/360safe/ && chattr +i /home/wwwroot/default/app_api/ >/dev/null 2>&1
exit 0;
" >/bin/lockdir
chmod 0755 /bin/lockdir

echo "echo -e '解锁流控目录		  [\033[32m  OK  \033[0m]'
chattr -i /home/wwwroot/default/ && chattr -i /home/wwwroot/default/user/ && chattr -i /home/wwwroot/default/config.php && chattr -i /home/wwwroot/default/admin/ && chattr -i /home/wwwroot/default/api.inc.php && chattr -i /home/wwwroot/default/daili/ && chattr -i /home/wwwroot/default/down/ && chattr -i /home/wwwroot/default/pay/ && chattr -i /home/wwwroot/default/web/ && chattr -i /home/wwwroot/default/360safe/ && chattr -i /home/wwwroot/default/assets/
exit 0;
" >/bin/ondir
chmod 0755 /bin/ondir

echo "echo -e '监控启动完成		  [\033[32m  OK  \033[0m]'
/home/wwwroot/default/res/jiankong >>/home/wwwlog/jiankong.log 2>&1 & /home/wwwroot/default/udp/jiankong >>/home/wwwlog/jiankong-udp.log 2>&1 &
exit 0;
" >/bin/opmt
chmod 0755 /bin/opmt

echo "echo -e '锁定流量卫士目录		  [\033[32m  OK  \033[0m]'
chmod -R 0555 /home/wwwroot/default/app_api/
chmod -R 0777 /home/wwwroot/default/app_api/data/content.txt && chmod -R 0777 /home/wwwroot/default/app_api/data/default.txt && chmod -R 0777 /home/wwwroot/default/app_api/data/max_limit.txt && chmod -R 0777 /home/wwwroot/default/app_api/data/reg_type.txt
chattr +i /home/wwwroot/default/app_api/
exit 0;
" >/bin/llws
chmod 0755 /bin/llws

echo "echo -e '解锁流量卫士目录		  [\033[32m  OK  \033[0m]'
chattr -i /home/wwwroot/default/app_api/
chmod -R 0777 /home/wwwroot/default/app_api/
exit 0;
" >/bin/onllws
chmod 0755 /bin/onllws
rm -rf /root/xyr* >/dev/null 2>&1
rm -rf /root/res* >/dev/null 2>&1
yum install -y crontabs >/dev/null 2>&1
mkdir -p /var/spool/cron/ >/dev/null 2>&1
echo
echo "正在安装实时监控程序！"
echo "* * * * * curl --silent --compressed http://${IP}:${port}/cron.php">>/var/spool/cron/root
systemctl restart crond.service
systemctl enable crond.service
chmod 755 /home/wwwroot/default/res >/dev/null 2>&1
cd /home/wwwroot/default/res/
curl -O ${http}${host}${vpnfile}${jiankong_tcp} >/dev/null 2>&1
unzip ${jiankong_tcp} >/dev/null 2>&1
rm -rf ${jiankong_tcp}
chmod 777 jiankong
chmod 777 sha

chmod 755 /home/wwwroot/default/udp >/dev/null 2>&1
cd /home/wwwroot/default/udp
curl -O ${http}${host}${vpnfile}${jiankong_udp} >/dev/null 2>&1
unzip ${jiankong_udp} >/dev/null 2>&1
rm -rf ${jiankong_udp}
chmod 777 jiankong
chmod 777 sha

echo "localhost=localhost
port=3306
root=root
mima=$sqlpass
databases=mydata
shujuku=mydata">>/etc/openvpn/sqlmima
chmod 777 /etc/openvpn/sqlmima
echo "db_pass="$sqlpass"
db_name=mydata">>/etc/openvpn/xyr
chmod 777 /etc/openvpn/xyr

/home/wwwroot/default/res/jiankong >>/home/wwwlog/jiankong.log 2>&1 &
/home/wwwroot/default/udp/jiankong >>/home/wwwlog/jiankong-udp.log 2>&1 &
echo "/home/wwwroot/default/res/jiankong >>/home/wwwlog/jiankong.log 2>&1 &">>/etc/rc.local
echo "/home/wwwroot/default/udp/jiankong >>/home/wwwlog/jiankong-udp.log 2>&1 &">>/etc/rc.local
echo "fhq >/dev/null 2>&1">>/etc/rc.local
chmod +x /etc/rc.local
vpn >/dev/null 2>&1
echo
echo "Web流量控制程序安装完成..."
systemctl restart dnsmasq
return 1
}

function liuliangweishi() {
cd ${web_path}
wget ${http}${host}${vpnfile}app_api.zip && unzip -o app_api.zip >/dev/null 2>&1
rm app_api.zip
cd ${web_path}/app_api
sed -i 's/123456/'$sqlpass'/g' ${web_path}app_api/config.php >/dev/null 2>&1
sed -i 's/RANDOM/'mydata'/g' ${web_path}app_api/config.php >/dev/null 2>&1

mysql -hlocalhost -P3306 -uroot -p$sqlpass --default-character-set=utf8<<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '${sqlpass}' WITH GRANT OPTION;
flush privileges;
use mydata;
source ${web_path}app_api/install/data/ov.sql;
EOF
echo "安装流量监控..."
wget -O disconnect.sh ${http}${host}${vpnfile}disconnected.sh
sed -i 's/192.168.1.1:8888/'${IP}:${port}'/g' "disconnect.sh" >/dev/null 2>&1
if test -f /etc/openvpn/disconnect.sh;then
	chmod 0777 -R /etc/openvpn/
	cp -rf /etc/openvpn/disconnect.sh /etc/openvpn/disconnect.sh.bak
	cp -rf disconnect.sh /etc/openvpn/disconnect.sh
	chmod 0777 /etc/openvpn/disconnect.sh
fi
chmod 0777 -R /home
cd /home
echo  "开始制作APP"
echo "正在加载基础环境(较慢 耐心等待)...."
yum install -y java
echo "下载APK包"
wget -O android.apk ${http}${host}${vpnfile}v5.apk
echo "清理旧的目录"
rm -rf android
echo "分析APK"
wget -O apktool.jar ${http}${host}${vpnfile}apktool.jar&&java -jar apktool.jar d android.apk
echo "批量替换"
chmod 0777 -R /home/android
sed -i 's/demo.dingd.cn:80/'${IP}:${port}'/g' `grep demo.dingd.cn:80 -rl /home/android/smali/net/openvpn/openvpn/` >/dev/null 2>&1
sed -i 's/叮咚流量卫士/'${app_name}'/g' "/home/android/res/values/strings.xml" >/dev/null 2>&1
echo "打包"
java -jar apktool.jar b android
if test -f /home/android/dist/android.apk;then
echo "APK生成完毕"
wget -O autosign.zip ${http}${host}${vpnfile}autosign.zip && unzip -o autosign.zip
rm -rf ${web_path}/app_api/dingd.apk
cd autosign
echo "正在签名APK...."
cp -rf /home/android/dist/android.apk /home/unsign.apk
java -jar signapk.jar testkey.x509.pem testkey.pk8 /home/unsign.apk /home/sign.apk
cp -rf /home/sign.apk  /home/xianlu/xyrml.apk
echo "正在清理临时文件...."	
rm -rf /home/dingd.apk /home/sign.apk /home/unsign.apk /home/android.apk /home/android /home/autosign.zip /home/apktool.jar /home/setup.bash /home/autosign
llwssfyaz="已"
dadas="1"
fi
return 1
}

function ovpn() {
echo
echo "开始生成配置文件..."
mkdir /home/xianlu
cd /home/xianlu
wget ${http}${host}${vpnfile}line.zip >/dev/null 2>&1
unzip line.zip >/dev/null 2>&1
sed -i "s/localxyrml/$IP/g;s/mpxyrml/$mpport/g;s/sqxyrml/$sqport/g;s/portxyrml/$vpnport/g" `grep 'localxyrml' -rl .`
echo
echo "配置文件制作完毕"
echo
cd /root
sed -i 's/云流量/'$webname'/g' zdmc.sql >/dev/null 2>&1
sed -i 's/ov/'mydata'/g' zdmc.sql >/dev/null 2>&1
sed -i 's/666/'$qie'/g' zdmc.sql >/dev/null 2>&1
sed -i "s/xyr-dl/`echo $RANDOM`/g" zdmc.sql >/dev/null 2>&1
sed -i 's/123456789/'$adminuser'/g' zdmc.sql >/dev/null 2>&1
sed -i 's/987654321/'$adminpass'/g' zdmc.sql >/dev/null 2>&1
mysql -hlocalhost -P3306 -uroot -p$sqlpass --default-character-set=utf8<<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '${sqlpass}' WITH GRANT OPTION;
flush privileges;
use mydata;
source zdmc.sql;
source line.sql;
EOF
rm -rf *.sql
rm -rf ${web_path}*.sql

if [[ $llwsapp == "y" ]] || [[ $llwsapp == "Y" ]] || [[ $llwsapp == "" ]];then
liuliangweishi
fi
return 1
}

function shujukubeifen() {
wget -P /home ${http}${host}${vpnfile}backupsql.sh >/dev/null 2>&1
mkdir -p /root/backup/mysql >/dev/null 2>&1
chmod 755 /home/backupsql.sh >/dev/null 2>&1
}

function shuchuliuliangweishianzhuangxinxi() {
echo "------------------------------------------------------------
APP下载：http://$IP:$port/xyrml.apk
------------------------------------------------------------">>/root/info.txt
}

function webmlpass() {
cd /home
shujukubeifen
bash backupsql.sh
echo '欢迎使用云免流控™OpenVPN系统
' >>/root/info.txt
echo
if [[ $llwsapp == "y" ]] || [[ $llwsapp == "Y" ]] || [[ $llwsapp == "" ]];then
shuchuliuliangweishianzhuangxinxi
fi
echo
echo "数据库每1分钟自动备份，备份数据库文件在/root/backup/mysql/
------------------------------------------------------------
数据库后台：${IP}:${port}/phpmyadmin
------------------------------------------------------------
数据库用户名：root 密码：${sqlpass} 数据库名：mydata
------------------------------------------------------------
后台管理系统：${IP}:${port}/admin
------------------------------------------------------------
后台管理员用户名：$adminuser 管理密码：$adminzanshi
------------------------------------------------------------
您当前${llwssfyaz}安装流量卫士 （流量卫士密码与流控一致）
------------------------------------------------------------
流量卫士APP云端管理后台：${IP}:${port}/app_api
------------------------------------------------------------
前台/用户中心，用户查流量的网址：${IP}:${port}/user
------------------------------------------------------------
代理中心：${IP}:${port}/daili
------------------------------------------------------------
流控网页程序文件目录为:/home/wwwroot/default/
------------------------------------------------------------
温馨提示：
------------------------------------------------------------
请登录流控管理后台->“激活线路” 激活最新流控自带全国500条线路
------------------------------------------------------------">>/root/info.txt
return 1
}

function pkgovpn() {
clear
echo "正在打包配置文件，请稍等..."
cp ${web_path}openvpn.apk /home/xianlu >/dev/null 2>&1
cd /home/xianlu
zip ${uploadfile} ./{yd-05.17-陕西移动.ovpn,yd-05.17-广东东莞1.ovpn,yd-05.17-广东东莞2.ovpn,yd-05.17-广东茂名.ovpn,yd-05.17-广东湛江.ovpn,yd-05.17-广东移动.ovpn,yd-05.17-贵州毕节.ovpn,yd-05.17-贵州移动.ovpn,yd-05.17-湖南移动1.ovpn,yd-05.17-湖南永州.ovpn,yd-05.17-江苏苏州.ovpn,yd-05.17-湖北移动1.ovpn,yd-05.17-山东移动1.ovpn,yd-05.17-山西移动1.ovpn,yd-05.17-四川达州.ovpn,yd-05.17-安徽合肥.ovpn,yd-05.17-移动咪卡.ovpn,yd-05.17-云南移动.ovpn,yd-05.17-黑龙江移动.ovpn,dx-05.17-四川电信.ovpn,lt-05.17-广东联通.ovpn,lt-05.17-湖北联通.ovpn,lt-05.17-重庆联通.ovpn,yd-05.01-吉林长春1.ovpn,yd-05.01-北京移动1.ovpn,yd-05.01-湖北移动1.ovpn,yd-05.01-湖北移动2.ovpn,yd-05.01-湖北移动3.ovpn,yd-05.01-湖北黄石1.ovpn,yd-05.01-湖北十堰1.ovpn,yd-05.01-湖北孝感1.ovpn,yd-05.01-辽宁移动1.ovpn,yd-05.01-辽宁移动2.ovpn,yd-05.01-全国移动1.ovpn,yd-05.01-四川成都1.ovpn,yd-05.01-广东东莞1.ovpn,yd-05.01-广西崇左1.ovpn,yd-05.01-广西复活1.ovpn,yd-05.01-广西贺州1.ovpn,yd-05.01-南宁贺州1.ovpn,yd-05.01-安徽移动1.ovpn,yd-05.01-贵州移动1.ovpn,yd-05.01-江苏移动1.ovpn,yd-05.01-江西赣州1.ovpn,yd-05.01-云南移动1.ovpn,yd-05.01-山东移动1.ovpn,yd-05.01-湖南移动1.ovpn,yd-05.01-湖南长沙1.ovpn,yd-05.01-广西防城港1.ovpn,yd-05.01-湖南郴州岳阳1.ovpn,yd-05.01-全国wap模式.ovpn,yd-05.01-山东济南.ovpn,yd-05.01-山东临沂.ovpn,yd-05.01-山东临沂2.ovpn,yd-05.01-山西全省.ovpn,yd-05.01-陕西宝鸡.ovpn,yd-05.01-上海移动.ovpn,yd-05.01-四川不限速.ovpn,yd-05.01-四川不限速2.ovpn,yd-05.01-四川移动.ovpn,yd-05.01-四川成都2.ovpn,yd-05.01-四川达州.ovpn,yd-05.01-武汉移动443.ovpn,yd-05.01-新咪咕移动.ovpn,yd-05.01-广东全新移动.ovpn,yd-05.01-广西复活2.ovpn,yd-05.01-破解移动.ovpn,yd-05.01-移动云南erkuailife.ovpn,yd-05.01-移动云南138.ovpn,yd-05.01-移动云南IP.ovpn,dx-05.01-吉林电信.ovpn,dx-05.01-山东电信.ovpn,dx-05.01-陕西电信.ovpn,dx-05.01-四川电信.ovpn,dx-05.01-天翼视讯.ovpn,lt-05.01-陕西联通.ovpn,lt-05.01-全国大王卡.ovpn,lt-05.01-广东联通.ovpn,lt-05.01-广西联通.ovpn,lt-05.01-湖南联通.ovpn,lt-05.01-联通NET.ovpn,lt-05.01-四川必免.ovpn,lt-05.01-四川联通.ovpn,lt-05.01-四川联通2.ovpn,lt-05.01-山东联通.ovpn,yd-04.14-云南昭通.ovpn,yd-04.14-北京移动.ovpn,yd-04.14-广东移动.ovpn,yd-04.14-河南洛阳.ovpn,yd-04.14-江苏移动.ovpn,yd-04.14-江西移动.ovpn,yd-04.14-广东茂名.ovpn,yd-04.14-陕西移动.ovpn,yd-04.14-上海移动.ovpn,yd-04.14-湖南衡阳.ovpn,yd-04.14-甘肃移动.ovpn,yd-04.14-湖北襄阳十堰.ovpn,yd-04.14-四川巴中昌平.ovpn,yd-04.14-四川广元成都.ovpn,yd-04.14-安徽蚌埠宿州.ovpn,yd-04.14-云南移动理论全免.ovpn,lt-04.14-四川联通.ovpn,lt-04.14-全国联通.ovpn,dx-04.14-四川电信.ovpn,dx-04.14-甘肃电信.ovpn,dx-04.14-全国电信.ovpn,yd-04.08-湖南娄底.ovpn,yd-04.08-湖南长沙.ovpn,yd-04.08-湖南永州.ovpn,yd-04.08-山西移动.ovpn,yd-04.08-四川移动.ovpn,d-04.08-四川移动2.ovpn,yd-04.08-山西运城.ovpn,yd-04.08-山西运城2.ovpn,yd-04.08-山西临汾运城晋城.ovpn,yd-04.08-山西大同.ovpn,yd-04.08-山东聊城.ovpn,yd-04.08-临汾运城长治.ovpn,yd-04.08-湖北武汉.ovpn,yd-04.08-河北唐山.ovpn,yd-04.08-广州移动.ovpn,yd-04.08-广西崇左.ovpn,yd-04.08-广西北海.ovpn,yd-04.08-广东佛山.ovpn,yd-04.08-福建移动不限速.ovpn,lt-04.08-全国联通大王卡全国免.ovpn,lt-04.08-广西联通.ovpn,dx-04.08-江苏苏州电信.ovpn,dx-04.08-南宁电信.ovpn,dx-04.08-广西北海电信.ovpn,yd-03.26-gxbf.ovpn,lt-03.26-qgdwk.ovpn,lt-03.26-sd.ovpn,lt-03.26-cq.ovpn,yd-03.26-sc1.ovpn,yd-03.26-sc2.ovpn,yd-03.26-gxnn.ovpn,yd-03.26-sd1.ovpn,yd-03.26-sd2.ovpn,dx-03.26-hbdx.ovpn,yd-03.26-hn.ovpn,yd-03.26-dg.ovpn,yd-03.26-sx.ovpn,yd-03.26-gz.ovp.ovpn,yd-03.26-gdsz1.ovpn,yd-03.26-gdsz2.ovpn,yd-03.26-fjxm.ovpn,dx-03.26-sxdx.ovpn,lt-03.26-gx.ovpn,lt-03.26-qg.ovpn,xyrml-yd-old.ovpn,xyrml-yd-udp138.ovpn,xyrml-yd-udp53.ovpn,xyrml-yd-udp137.ovpn,xyrml-yd-138.ovpn,xyrml-yd-138②.ovpn,xyrml-yd-mg138.ovpn,xyrml-yd-zj①.ovpn,xyrml-lt-2.ovpn,xyrml-yd-137.ovpn,xyrml-yd-old-366.ovpn,xyrml-yd-old-351.ovpn,xyrml-yd-fj.ovpn,xyrml-yd-gs.ovpn,xyrml-yd-gs2.ovpn,xyrml-yd-gs3.ovpn,xyrml-yd-gs4.ovpn,xyrml-yd-gd2.ovpn,xyrml-yd-gdsz2.ovpn,xyrml-yd-gdsz1.ovpn,xyrml-yd-gd1.ovpn,xyrml-yd-gd4.ovpn,xyrml-yd-gd5.ovpn,xyrml-yd-gd6.ovpn,xyrml-yd-gd7.ovpn,xyrml-yd-gd3.ovpn,xyrml-yd-gx.ovpn,xyrml-yd-hebei2.ovpn,xyrml-yd-hebei.ovpn,xyrml-yd-sd.ovpn,xyrml-yd-sd2.ovpn,xyrml-yd-sxi.ovpn,xyrml-yd-sx.ovpn,xyrml-yd-sx1.ovpn,xyrml-yd-sx3.ovpn,xyrml-yd-sxjx.ovpn,xyrml-yd-jx2.ovpn,xyrml-yd-jx.ovpn,xyrml-yd-sc①.ovpn,xyrml-yd-sc1.ovpn,xyrml-yd-sc2.ovpn,xyrml-yd-sc2.ovpn,xyrml-yd-maom.ovpn,xyrml-yd-zj②.ovpn,xyrml-yd-zj③.ovpn,xyrml-yd-ln.ovpn,xyrml-yd-hb.ovpn,xyrml-yd-hn.ovpn,xyrml-lt-dwk2.ovpn,xyrml-lt-tj.ovpn,xyrml-dx-sjl.ovpn,xyrml-yd-qgzq.ovpn,xyrml-lt-hb.ovpn,xyrml-lt-zj.ovpn,xyrml-lt-bj.ovpn,xyrml-lt-uac2.ovpn,xyrml-lt-uac3.ovpn,xyrml-dx-cq.ovpn,xyrml-dx-qg1.ovpn,xyrml-yd-nx.ovpn,xyrml-yd-hun1.ovpn,xyrml-yd-gz.ovpn,xyrml-yd-136.ovpn,xyrml-yd-139.ovpn,xyrml-yd-mm.ovpn,xyrml-yd-js.ovpn,xyrml-yd-ah.ovpn,xyrml-yd-neimenggu.ovpn,xyrml-yd-migu1.ovpn,xyrml-yd-migu.ovpn,xyrml-yd-migu2.ovpn,xyrml-yd-migu3.ovpn,xyrml-yd-migu2-137.ovpn,xyrml-yd-migu-137.ovpn,xyrml-yd-qg7.ovpn,xyrml-yd-qg8.ovpn,xyrml-yd-qgA.ovpn,xyrml-yd-qg9.ovpn,xyrml-lt-uac.ovpn,xyrml-lt-53.ovpn,xyrml-lt-1.ovpn,xyrml-lt-qglt.ovpn,xyrml-lt-gd.ovpn,xyrml-lt-3.ovpn,xyrml-lt-4.ovpn,xyrml-lt-5.ovpn,xyrml-lt-qg1.ovpn,xyrml-lt-wap.ovpn,xyrml-lt-dwk.ovpn,xyrml-dx-1.ovpn,xyrml-dx-gd.ovpn,xyrml-dx-llqg.ovpn,xyrml-dx-yinyue.ovpn,2017-xyrml-yd-sh.ovpn,2017-xyrml-yd-qg1.ovpn,2017-xyrml-yd-qg2.ovpn,2017-xyrml-yd-sc.ovpn,2017-xyrml-yd-gd.ovpn,2017-xyrml-yd-cq.ovpn,2017-xyrml-yd-zj.ovpn,2017-xyrml-yd-yn.ovpn,2017-xyrml-yd-sz.ovpn,2017-xyrml-yd-st.ovpn,2017-xyrml-yd-sx.ovpn,2017-xyrml-yd-sd.ovpn,2017-xyrml-yd-ln.ovpn,2017-xyrml-yd-jl.ovpn,2017-xyrml-yd-hunan.ovpn,2017-xyrml-yd-henan.ovpn,2017-xyrml-yd-hebei.ovpn,2017-xyrml-yd-guangzhou.ovpn,2017-xyrml-yd-guangxi.ovpn,2017-xyrml-yd-jiangxi.ovpn,2017-xyrml-yd-gansu.ovpn,2017-xyrml-yd-maom.ovpn,2017-xyrml-yd-guiz.ovpn,2017-xyrml-yd-ah.ovpn,2017-xyrml-yd-bj.ovpn,2017-xyrml-yd-fj.ovpn,2017-xyrml-yd-hubei.ovpn,2017-xyrml-yd-ln2.ovpn,2017-xyrml-yd-sd2.ovpn,2017-xyrml-yd-sx2.ovpn,2017-xyrml-yd-yn2.ovpn,2017-xyrml-yd-cq2.ovpn,2017-xyrml-yd-hebei2.ovpn,2017-xyrml-yd-hunan2.ovpn,2017-xyrml-lt-qg1.ovpn,2017-xyrml-lt-qg2.ovpn,2017-xyrml-lt-qg3.ovpn,2017-xyrml-lt-gd.ovpn,2017-xyrml-lt-uac1.ovpn,2017-xyrml-lt-uac2.ovpn,2017-xyrml-lt-ts.ovpn,2017-xyrml-new-dwk.ovpn,2017-xyrml-dx-ak.ovpn,2017-xyrml-dx-gx.ovpn,2017-xyrml-dx-aw.ovpn,2017-xyrml-dx-qg.ovpn,2017-xyrml-lt-53.ovpn,2017-xyrml-yd-henan2.ovpn,03-xyrml-yd-gdzj.ovpn,03-xyrml-yd-sx.ovpn,03-xyrml-yd-hb.ovpn,03-xyrml-yd-cq.ovpn,03-xyrml-lt-cq.ovpn,03-xyrml-lt-zj.ovpn,03-xyrml-yd-zj.ovpn,03-xyrml-dx-zj.ovpn,03-xyrml-yd-yn1.ovpn,03-xyrml-yd-yn2.ovpn,03-xyrml-dx-xdx.ovpn,03-xyrml-yd-xj1.ovpn,03-xyrml-yd-xj2.ovpn,03-xyrml-yd-xz.ovpn,03-xyrml-lt-wz.ovpn,03-xyrml-yd-tj.ovpn,03-xyrml-yd-sc.ovpn,03-xyrml-dx-sc.ovpn,03-xyrml-yd-sh1.ovpn,03-xyrml-yd-sh2.ovpn,03-xyrml-yd-zq.ovpn,xyrml-yd-3.11-yn.ovpn,xyrml-yd-3.11-st.ovpn,xyrml-yd-3.11-nn.ovpn,xyrml-yd-3.11-qg1.ovpn,xyrml-yd-3.11-jl.ovpn,xyrml-yd-3.11-qg2.ovpn,xyrml-yd-3.11-hb.ovpn,xyrml-yd-3.11-sz.ovpn,xyrml-yd-3.11-cq.ovpn,xyrml-yd-3.11-qg3.ovpn,xyrml-yd-3.11-ah.ovpn,xyrml-yd-3.11-qg4.ovpn,xyrml-yd-3.11-qg5.ovpn,xyrml-yd-3.11-nx.ovpn,xyrml-yd-3.11-qg6.ovpn,xyrml-yd-3.11-lf.ovpn,xyrml-yd-3.11-qg7.ovpn,xyrml-yd-3.11-qg8.ovpn,xyrml-yd-3.11-fj.ovpn,xyrml-yd-3.11-qg9.ovpn,xyrml-yd-3.11-teshu-migu.ovpn,xyrml.apk,openvpn.apk,ca.crt,ta.key} >/dev/null 2>&1
cp /home/xianlu/xyrml.apk ${web_path} >/dev/null 2>&1
cp /home/xianlu/ca.crt ${web_path} >/dev/null 2>&1
cp /home/xianlu/ta.key ${web_path} >/dev/null 2>&1
cd /home
echo
echo "正在加载您的配置信息..."
echo
cat /root/info.txt
echo
echo "您的线路/证书/key/云端APP/等重要内容下载网址如下："
cp -rf /home/xianlu/${uploadfile} ${web_path}${uploadfile}
rm -rf /home/xianlu
echo
echo "http://${IP}:${port}/${uploadfile}"
echo
echo "您的IP是：$IP （如果与您实际IP不符合或空白，请自行修改.ovpn配置）"
chmod 0777 -R /home/
return 1
}

function main() {
shellhead
clear
echo -e '\033[33m================☆☆========================================================\033[0m'
echo -e '\033[33m                云免流控™-Web流控系统 云免服务器一键搭建\033[0m'
echo -e '\033[33m                        Powered by xiaoyangren.net 2017\033[0m'
echo -e '\033[33m                        All Rights Reserved\033[0m'
echo -e '\033[33m                交流群：438968654	售后群：167212446  欢迎你的加入！\033[0m'
echo -e '\033[33m                本脚本已通过阿里云 腾讯云 高防服务器 等一系列服务器\033[0m'
echo -e '\033[34m                官方网址：http://www.xiaoyangren.net/\033[0m'
echo -e '\033[33m                请选择正版授权，提供安全到位的售后服务，谢谢！\033[0m'
echo -e '\033[34m                谢谢各位的支持！\033[0m'
echo -e '\033[33m================☆☆========================================================\033[0m'

echo
authentication
InputIPAddress
clear
echo -e '\033[33m================☆☆========================================================\033[0m'
echo -e '\033[33m                云免流控™-Web流控系统 云免服务器一键搭建\033[0m'
echo -e '\033[33m                温馨提示：\033[0m'
echo -e '\033[33m                为了您服务器的稳定和安全，请勿非法破解改程序\033[0m'
echo -e '\033[33m                    支持正版，抵制盗版\033[0m'
echo -e '\033[33m                密钥绑定IP可在同一IP下反复使用！\033[0m'
echo -e '\033[34m                    官方网址：http://www.xiaoyangren.net/\033[0m'
echo -e '\033[33m                交流群：438968654	售后群：167212446  欢迎你的加入！\033[0m'
echo -e '\033[33m                请选择正版授权，提供安全到位的售后服务，谢谢！\033[0m'
echo -e '\033[34m                谢谢各位的支持！\033[0m'
echo -e '\033[33m================☆☆========================================================\033[0m'
echo
echo -e "\033[36m您服务器IP是：$IP 如果不正确请中止安装并联系管理员！\033[0m"
echo
echo -e '\033[33m请输入正版密钥开启安装向导（购买网址:\033[32m buy.xiaoyangren.net \033[0m）'
echo
echo  -n -e '\033[33m请输入授权密钥：\033[0m'
read card
curl "http://www.xiaoyangren.net/sq/status.php?url=$IP&km=$card" >/dev/null 2>&1
echo
echo "正在验证授权..."
kcard=`curl -s http://www.xiaoyangren.net/sq/card.php?url=${IP}"&km=${card}"`;
if [[ "$kcard" == "no" ]] || [ "$kcard" == "" ]
then
echo -e '\033[33m==========================================================================\033[0m'
echo -e '\033[34m               未能通过验证 请确认您的密钥是否正确！\033[0m'
echo -e '\033[31m               温馨提示：\033[0m'
echo -e '\033[31m               为了您服务器的稳定和安全，请勿非法破解改程序\033[0m'
echo -e '\033[33m               正版密钥10元/1件\033[0m'
echo -e '\033[31m               密钥绑定IP可在同一IP下反复使用！\033[0m'
echo -e '\033[33m               官方网址：http://www.xiaoyangren.net/\033[0m'
echo -e '\033[31m               交流群：438968654	售后群：167212446	欢迎你的加入！\033[0m'
echo -e '\033[33m==========================================================================\033[0m'
exit 0;
else
if [[ "$kcard" == "yes" ]]
then
echo
echo -e "授权状态  $IP  [\033[32m  授权成功  \033[0m]";
echo "授权码已成功绑定您的服务器IP，支持永久无限使用！";
echo "即将开始下一步安装..."
sleep 0.5
echo "请选择安装类型："
echo
echo "1 - 全新安装(回车默认) < 新装+流控系统"
echo -e "        \033[31m提示：\033[0m\033[35m支持阿里云、腾讯云等正规服务商 Centos7.x 64位全新系统. \033[0m"
echo -e "        \033[31m\033[0m\033[35m开放多端口TCP-UDP共存 实时监控 等... \033[0m"
echo -e "        腾讯云：请默认安全组放通全部端口."
echo
echo "2 - 对接模式 >> 实现N台服务器共用账号"
echo -e "        \033[31m提示：\033[0m\033[35m \033[0m"
echo -e "        一键配置共用数据库并统一证书，需集群负载，用域名进行负载均衡即可"
echo -e "        请用需要对接主服务器的子服务器执行此选项完成对接"
echo
echo -n -e "请输入对应的选项:"
read installslect

if [[ "$installslect" == "2" ]]
then
clear
echo "-------------------------------------------"
echo "负载均衡必看说明："
echo "两台服务器必须都已安装云免流控™脚本程序"
echo "并能正常运行和连接服务器"
echo "且数据库账号-密码-端口-管理员账号-密码 需保持一致！"
echo "-------------------------------------------"
echo
echo "请提供主服务器和副机信息:"
echo -e "      \033[31m注意：\033[0m\033[35m请如实填写信息，否则后果自负！. \033[0m"
echo -e "      请核对仔细无错后再进行回车."
echo
echo -n -e "请输入主服务器的IP或域名:"
read mumjijiipaddress
echo
echo -n -e "请输入主服务器流控端口:"
read mumjijiipport
echo
echo -n -e "请输入主服务器的数据库密码:"
read mumjijisqlpass
echo
echo -n -e "请输入当前服务器数据库密码:"
read sbsonsqlpass
echo
echo "您保存的配置如下："
echo -e "\033[31m-------------------------------------------\033[0m"
echo "主服务器网址:$mumjijiipaddress"
echo "主服务器流控端口:$mumjijiipport"
echo "主服务器数据库密码:$mumjijisqlpass"
echo "当前服务器数据库密码：$sbsonsqlpass"
echo -e "\033[31m-------------------------------------------\033[0m"
echo -e "\033[31m注意：\033[0m\033[35m \033[0m"
echo -e "\033[33m如信息无误请回车开始配置.\033[0m"
echo -e "\033[33m如果信息有错请按 Ctrl + c 键结束对接，并重新执行对接脚本！\033[0m"
echo -e "\033[35m回车开始执行配置 >>>\033[0m"
read
echo "正在配置数据 请稍等..."
sed -i 's/localhost/'$mumjijiipaddress'/g' /home/wwwroot/default/config.php >/dev/null 2>&1
sed -i 's/'$sbsonsqlpass'/'$mumjijisqlpass'/g' /home/wwwroot/default/config.php >/dev/null 2>&1
sed -i 's/'$sbsonsqlpass'/'$mumjijisqlpass'/g' /etc/openvpn/xyr >/dev/null 2>&1
sed -i 's/localhost/'$mumjijiipaddress'/g' /etc/openvpn/xyr.config >/dev/null 2>&1
sed -i 's/'$sbsonsqlpass'/'$mumjijisqlpass'/g' /etc/openvpn/sqlmima >/dev/null 2>&1
echo
cd /etc/openvpn/
rm -rf ./disconnect.sh >/dev/null 2>&1
curl -O ${http}${host}${vpnfile}${dis}
chmod 0777 ./${dis} >/dev/null 2>&1
sed -i 's/192.168.1.1/'$mumjijiipaddress'/g' /etc/openvpn/disconnect.sh >/dev/null 2>&1
sed -i 's/:81/:'$mumjijiipport'/g' /etc/openvpn/disconnect.sh >/dev/null 2>&1
echo
echo "重启监控..."
/home/wwwroot/default/res/jiankong >>/home/wwwlog/jiankong.log 2>&1 &
/home/wwwroot/default/udp/jiankong >>/home/wwwlog/jiankong-udp.log 2>&1 &
vpn >/dev/null 2>&1
echo -e "\033[31m配置完成!\033[0m"
echo -e "\033[33m成功与主服务器IP:$mumjijiipaddress 对接成功\033[0m"
echo -e "\033[35m请自行到主服务器后台添加当前服务器 $IP\033[0m"
exit 0;
fi
vpnportseetings
readytoinstall
newvpn
installlamp
webml
echo
echo "正在为您开启所有服务..."
ovpn
webmlpass
pkgovpn
fi
fi
echo "$finishlogo";
rm -rf /etc/openvpn/ca >/dev/null 2>&1
return 1
}
main
exit 0