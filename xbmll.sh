#!/bin/bash
# 本脚本由小白免流制作
# 作者 心欣&掌握节流核心技术

###                                                 ###
###   sed s/$/"\\\n"/ xbml-yd-137.ovpn|tr -d '\n'   ###
###                                                 ###
#iptables -A INPUT -p TCP --dport 端口 -j ACCEPT
#service iptables save >/dev/null 2>&1
#systemctl restart iptables >/dev/null 2>&1
#systemctl enable iptables >/dev/null 2>&1
#./mproxy-xb -l 8081 -d >/dev/null 2>&1


rm -rf xxx
function shellhead() {
ulimit -c 0
rm -rf $0 
DmgLogo='
==========================================================================
                                     
									 
                        小白免流™全新一代的流控                      
                  Powered by www.xbmll.cn 2016                         
                        All Rights Reserved                                
											  QQ群：201320977                                  
                                                        by 心欣                      
==========================================================================';
	errorlogo='
==========================================================================
                     服务验证失败，安装被终止                                           
                        小白免流™全新一代的流控                      
                  Powered by www.xbmll.cn 2016   QQ群：201320977                      
                        All Rights Reserved                                
                                                                         
                                                        by 心欣                        
==========================================================================';
	finishlogo='
==========================================================================
                                                                         
                         最好看好用的流控之一																		 
                        小白免流™全新一代的流控                      
                  Powered by www.xbmll.cn 2016   QQ群：201320977                      
                        All Rights Reserved                                
                                                                         
                                                        by 心欣                      
==========================================================================';
	keyerrorlogo='
==========================================================================
                      验证码输入错误，请重新运行                                            
                           小白免流™-流控系统                       
                        小白免流™全新一代的流控                      
                  Powered by www.xbmll.cn 2016   QQ群：201320977                      
                        All Rights Reserved                                
                                                                         
                                                        by 心欣                     
==========================================================================';
	http="http://"; 
	update="web-update.zip";
	sq=squid.conf;
	mp=mproxy-xb;
	RSA=EasyRSA-2.2.2.tar.gz;
	Host='i.fbdo.pw';
	xbml='shell/xbmll';
	IP=`curl -s http://members.3322.org/dyndns/getip`;
	squser=auth_user;
	mysqlip='null';
	KRSA=easy-rsa.zip;
	webupdatefile='xb-web-update.zip';
	webfile32='ioncube-32.tar.gz';
	webfile64='ioncube_loaders-64.tar.gz';
	phpmyadminfile='phpMyAdmin-4.0.10.15-all-languages.tar.gz';
	key='xbmll.cn'
	upload=transfer.sh;
	jiankongfile=jiankong.zip
	lnmpfile='xb-lnmp.tar.gz';
	webfile='xb-web5.zip';
	uploadfile=xb-openvpn.tar.gz;export uploadfile=$uploadfile
	return 1
}
    function authentication() {
    echo -n -e "请输入验证码 [\033[32m $key \033[0m] ："
    read PASSWD
    readkey=$PASSWD
    if [[ ${readkey%%\ *} == $key ]]
    then
        echo 
		echo -e '\033[32m验证成功！\033[0m即将开始搭建...'
		echo -e "本机IP：\033[34m $IP \033[0m"
		yum install curl -y >/dev/null 2>&1
    else
        echo
		echo -e '\033[31m验证失败 ，请重新尝试！  \033[0m'
		sleep 3
echo "$keyerrorlogo";
exit
fi
return 1
}
function InputIPAddress() {

echo 
echo "正在检测您的IP是否正确加载..."

	if [[ "$IP" == '' ]]; then
		echo '无法检测您的IP,可能会影响到您接下来的搭建工作';
		read -p '请输入您的公网IP:' IP;
		[[ "$IP" == '' ]] && InputIPAddress;
	fi;
	[[ "$IP" != '' ]] && 
						 echo -e 'IP状态：			  [\033[32m  OK  \033[0m]'
	sleep 2
	echo -n "正在检测网卡..."
	if [ ! -e "/dev/net/tun" ];
    then
	    echo
        echo "检查到你是网易蜂巢 正在为你开启网卡"
		sleep 2
		echo -e "                                [\033[32m OK \033[0m]"
		mkdir /dev/net; mknod /dev/net/tun c 10 200
		echo "更新系统 接下来的所有提示都输入Y回车"
		sleep 2
		yum install wget
		yum update -y
		yum install gcc gcc-c++ make 
	else
	    echo -e "                 [\033[32m OK \033[0m]" 
	fi
	return 1
}
function readytoinstall() {
	echo 
	echo -e "\033[35m开始整理安装环境...\033[0m"
	echo -e "\033[35m可能需要1分钟左右...\033[0m"
	sleep 2
	echo -e "\033[35m开始整理残留环境...\033[0m"
	systemctl stop openvpn@server.service >/dev/null 2>&1
	yum -y remove openvpn >/dev/null 2>&1
	yum -y remove java-1.7.0-openjdk* >/dev/null 2>&1
	yum -y remove java >/dev/null 2>&1
	systemctl stop squid.service >/dev/null 2>&1
	yum -y remove squid >/dev/null 2>&1
	killall mproxy-xb >/dev/null 2>&1
	rm -rf /etc/openvpn/*
	rm -rf /root/*
	rm -rf /home/*
	sleep 2 
	systemctl stop httpd.service >/dev/null 2>&1
	systemctl stop mariadb.service >/dev/null 2>&1
	systemctl stop mysqld.service >/dev/null 2>&1
	/etc/init.d/mysqld stop >/dev/null 2>&1
	yum remove -y httpd >/dev/null 2>&1
	yum remove -y mariadb mariadb-server >/dev/null 2>&1
	yum remove -y mysql mysql-server>/dev/null 2>&1
	rm -rf /var/lib/mysql
	rm -rf /var/lib/mysql/
	rm -rf /usr/lib64/mysql
	rm -rf /etc/my.cnf
	rm -rf /var/log/mysql/
	rm -rf 
	yum remove -y nginx php-fpm >/dev/null 2>&1
	yum remove -y nginx php-fpm >/dev/null 2>&1
	yum remove -y php php-mysql php-gd libjpeg* php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-bcmath php-mhash php-fpm >/dev/null 2>&1
	sleep 2
	echo -e "\033[35m正在安装主程序...\033[0m"
	yum install -y openvpn telnet >/dev/null 2>&1
	sleep 1
	yum install -y openssl openssl-devel lzo lzo-devel pam pam-devel automake pkgconfig expect >/dev/null 2>&1
	cd /etc/openvpn/ >/dev/null 2>&1
	rm -rf /etc/openvpn/server.conf >/dev/null 2>&1
	service sendmail stop >/dev/null 2>&1 
	rm -rf /etc/openvpn/xbmll.sh >/dev/null 2>&1
	echo -e "\033[35m正在检查并更新源...\033[0m"
	# 安装mysql
	yum install -y mariadb mariadb-server
	systemctl restart mariadb.service
	systemctl enable mariadb.service
	sleep 3
	# 配置epel源
	#rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm --force
	rpm -ivh http://bo.mirror.garr.it/1/slc/centos/7.1.1503/extras/x86_64/Packages/epel-release-7-5.noarch.rpm --force
	rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7

	# 配置remi源
	rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm --force
	rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi

	# 安装php
	yum -y --enablerepo=epel,remi,remi-php55 install php-fpm php-cli php-gd php-mbstring php-mcrypt php-mysqlnd php-opcache php-pdo php-devel php-xml
	#mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
	#wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
	#yum clean all
	#yum makecache
	#yum update -y
	yum install unzip curl tar expect -y
	sleep 3
	#yum update -y
	echo
	echo -e "\033[35m正在配置网络环境...\033[0m"
	sleep 3
	systemctl stop firewalld.service >/dev/null 2>&1
	systemctl disable firewalld.service >/dev/null 2>&1
	systemctl mask firewalld.service >/dev/null 2>&1
	yum install -y iptables >/dev/null 2>&1
	yum update iptables >/dev/null 2>&1
	yum install iptables-services -y >/dev/null 2>&1
	yum -y install vim vim-runtime ctags >/dev/null 2>&1
	setenforce 0 >/dev/null 2>&1 
	service sendmail stop >/dev/null 2>&1 
	echo "/usr/sbin/setenforce 0" >> /etc/rc.local >/dev/null 2>&1
	sleep 1

	echo
	echo -e "\033[35m正在配置网速优化...\033[0m"
	echo '# Kernel sysctl configuration file for Red Hat Linux
	# by dmkuai.com
	# For binary values, 0 is disabled, 1 is enabled.  See sysctl(8) and
	# sysctl.conf(5) for more details.

	# Controls IP packet forwarding
	net.ipv4.ip_forward = 1

	# Controls source route verification
	net.ipv4.conf.default.rp_filter = 1

	# Do not accept source routing
	net.ipv4.conf.default.accept_source_route = 0

	# Controls the System Request debugging functionality of the kernel
	kernel.sysrq = 0

	# Controls whether core dumps will append the PID to the core filename.
	# Useful for debugging multi-threaded applications.
	kernel.core_uses_pid = 1

	# Controls the use of TCP syncookies
	net.ipv4.tcp_syncookies = 1

	# Disable netfilter on bridges.
	net.bridge.bridge-nf-call-ip6tables = 0
	net.bridge.bridge-nf-call-iptables = 0
	net.bridge.bridge-nf-call-arptables = 0

	# Controls the default maxmimum size of a mesage queue
	kernel.msgmport = 65536

	# Controls the maximum size of a message, in bytes
	kernel.msgmax = 65536

	# Controls the maximum shared segment size, in bytes
	kernel.shmmax = 68719476736

	# Controls the maximum number of shared memory segments, in pages
	kernel.shmall = 4294967296' >/etc/sysctl.conf
	sysctl -p >/dev/null 2>&1
	echo
	echo -e "\033[35m正在配置防火墙...\033[0m"
	systemctl start iptables >/dev/null 2>&1
	iptables -F >/dev/null 2>&1
	sleep 3
	iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -o eth0 -j MASQUERADE
	iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -j SNAT --to-source $IP
	iptables -t nat -A POSTROUTING -s 10.9.0.0/16 -o eth0 -j MASQUERADE
    iptables -t nat -A POSTROUTING -s 10.9.0.0/16 -j SNAT --to-source $IP
	iptables -t nat -A POSTROUTING -s 10.10.0.0/16 -o eth0 -j MASQUERADE
    iptables -t nat -A POSTROUTING -s 10.10.0.0/16 -j SNAT --to-source $IP
	iptables -t nat -A POSTROUTING -j MASQUERADE
	iptables -A INPUT -p TCP --dport $mpport -j ACCEPT
	iptables -A INPUT -p TCP --dport 137 -j ACCEPT
	iptables -A INPUT -p TCP --dport 138 -j ACCEPT
	iptables -A INPUT -p TCP --dport 139 -j ACCEPT
	iptables -A INPUT -p TCP --dport 351 -j ACCEPT
	iptables -A INPUT -p TCP --dport 366 -j ACCEPT
	iptables -A INPUT -p TCP --dport 1026 -j ACCEPT
	iptables -A INPUT -p UDP --dport 137 -j ACCEPT
	iptables -A INPUT -p UDP --dport 138 -j ACCEPT
	iptables -A INPUT -p TCP --dport 443 -j ACCEPT
	iptables -A INPUT -p TCP --dport 3389 -j ACCEPT
	iptables -A INPUT -p TCP --dport 53 -j ACCEPT
	iptables -A INPUT -p TCP --dport 9101 -j ACCEPT
	iptables -A INPUT -p TCP --dport 80 -j ACCEPT
	iptables -A INPUT -p TCP --dport 28080 -j ACCEPT
	iptables -A INPUT -p TCP --dport $sqport -j ACCEPT
	iptables -A INPUT -p TCP --dport $vpnport -j ACCEPT
	iptables -A INPUT -p TCP --dport 22 -j ACCEPT
	iptables -A INPUT -p TCP --dport 25 -j DROP
	iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
	/etc/rc.d/init.d/iptables save >/dev/null 2>&1
	service iptables save >/dev/null 2>&1
	systemctl restart iptables >/dev/null 2>&1
	systemctl enable iptables >/dev/null 2>&1
	echo 
	sleep 1

	return 1
}
function vpnportseetings() {
echo -ne "\033[31m##-------------------小白请使用默认--------------------## \033[0m"
echo
echo -ne "\033[31m##-------------------小白请使用默认--------------------## \033[0m"
echo 
echo -ne "\033[31m##-------------------小白请使用默认--------------------## \033[0m"
echo 
echo -ne "\033[34m 输入本地代理端口\033[0m"
echo 
echo -n -e " 回车默认 [\033[31m 440 \033[0m] ：" 
read vpnport 
[ -z "$vpnport" ] && vpnport="440"
	echo
    echo " ================="
    echo " |端口 = $vpnport"
    echo " ================="
    echo
#小白免流
echo -ne "\033[36m 请输入转接端口\033[0m"
echo 
echo -n -e " 回车默认 [\033[31m 8080 \033[0m] ：" 
read mpport
[ -z "$mpport" ] && mpport="8080"
	echo
	echo " ================="
    echo " |端口 = $mpport"
    echo " ================="
    echo
#小白免流
echo -ne "\033[34m 输入常规代理端口\033[0m"
echo 
echo -n -e " 回车默认 [\033[31m 80 \033[0m] ：" 
read sqport 
[ -z "$sqport" ] && sqport="80"
	echo
    echo " ================="
    echo " |端口 = $sqport"
    echo " ================="
    echo
#xbmll.cn
echo -ne "\033[35m 请输入实时监控频率（秒）\033[0m"
echo 
echo -n -e " 回车默认 [\033[31m 20 \033[0m] ：" 
read jiankongs
[ -z "$jiankongs" ] && jiankongs="20"
	echo
	echo " ============="
    echo " |秒数 = $jiankongs"
    echo " ============="
    echo
#小白免流
clear
echo -ne "\033[35m 请输入云端后台密码\033[0m"
echo 
echo -n -e " 回车默认 [\033[31m 随机六位数 \033[0m] ：" 
read pas
[ -z "$pas" ] && pas=`cat /dev/urandom | head -n 6 | md5sum | head -c 6`
	echo
	echo " =================="
    echo " |密码 = $pas     |"
    echo " =================="
    echo
#小白免流
echo -ne "\033[34m 请输入你的APPkey \033[0m"
echo 
echo -n -e " 回车默认 [\033[31m 随机六位数 \033[0m] ：" 
read ykey
[ -z "$ykey" ] && ykey=`cat /dev/urandom | head -n 6 | md5sum | head -c 6`
	echo
    echo " ================="
    echo " |密码 = $ykey|"
    echo " ================="
    echo
#dnsml.top
echo -ne "\033[35m 请输入云端访问路径\033[0m"
echo 
echo -n -e " 回车默认 [\033[31m 随机六位数 \033[0m] ：" 
read appapi
[ -z "$appapi" ] && appapi=`cat /dev/urandom | head -n 6 | md5sum | head -c 6`
	echo
	echo " ============="
    echo " |路径 = $appapi"
    echo " ============="
    echo
#小白免流
echo -ne "\033[35m 请输入后台访问路径\033[0m"
echo 
echo -n -e " 回车默认 [\033[31m 随机六位数 \033[0m] ：" 
read fh1
[ -z "$fh1" ] && fh1=`cat /dev/urandom | head -n 6 | md5sum | head -c 6`
	echo
	echo " ============="
    echo " |路径 = $fh1"
    echo " ============="
    echo
#小白免流
echo -ne "\033[35m 请输入数据库访问路径\033[0m"
echo 
echo -n -e " 回车默认 [\033[31m 随机六位数 \033[0m] ：" 
read sqlfh
[ -z "$sqlfh" ] && sqlfh=`cat /dev/urandom | head -n 6 | md5sum | head -c 6`
	echo
	echo " ============="
    echo " |路径 = $sqlfh"
    echo " ============="
    echo
if [[ $fh1 == $appapi ]]
then
fh1=`cat /dev/urandom | head -n 6 | md5sum | head -c 6`
echo "检查到后台访问路径相同 随机产生路径"
echo "$fh1"
fi
if [[ $fh1 == $sqlfh ]]
then
fh1=`cat /dev/urandom | head -n 6 | md5sum | head -c 6`
echo "检查到后台访问路径相同 随机产生路径"
echo "$fh1"
fi
if [[ $appapi == $sqlfh ]]
then
appapi=`cat /dev/urandom | head -n 6 | md5sum | head -c 6`
echo "检查到后台访问路径相同 随机产生路径"
echo "$appapi"
fi
if [[ $sqlfh == $appapi ]]
then
sqlfh=`cat /dev/urandom | head -n 6 | md5sum | head -c 6`
echo "检查到后台访问路径相同 随机产生路径"
echo "$sqlfh"
fi
cd /bin/
echo $fh1 >by.txt
#小白免流
#echo 
#echo -ne "\033[31m##-------------------请务必别使用默认--------------------## \033[0m"
#echo
#echo -ne "\033[31m##-------------------请务必别使用默认--------------------## \033[0m"
#echo 
#echo -ne "\033[31m##-------------------请务必别使用默认--------------------## \033[0m"
clear
echo -ne "\033[33m 请输入数据库密码 \033[0m"
echo 
echo -ne "\033[33m 切勿有符号或者上下左右键 \033[0m"
echo 
echo -n -e " 回车默认 [\033[31m 随机八位数 \033[0m] ：" 
read sqlpass
[ -z "$sqlpass" ] && sqlpass=`cat /dev/urandom | head -n 8 | md5sum | head -c 8`
	echo
    echo " =============="
    echo " |密码 = $sqlpass"
    echo " =============="
    echo
#小白免流
#echo -e "\033[34m设置数据库完成\033[0m"
echo -ne "\033[36m 请设置0-65535之间的数值 \033[0m"
echo 
echo -ne "\033[36m 请输入流控端口\033[0m"
echo 
echo -n -e " 回车默认 [\033[31m 1234 \033[0m] ：" 
read port
[ -z "$port" ] && port="1234"
	echo
	echo " ============="
    echo " |端口 = $port"
    echo " ============="
    echo
#小白免流
iptables -A INPUT -p TCP --dport $port -j ACCEPT 
service iptables save >/dev/null 2>&1
systemctl restart iptables >/dev/null 2>&1
if [[ $port == "80" ]]
then
if [[ $sqport == "80" ]]
then
echo
echo "检测到HTTP端口和流控端口有冲突，系统默认将流控端口默认为1234端口"
port=1234
fi
fi
echo -ne "\033[34m 请输入后台管理员账号\033[0m"
echo 
echo -n -e " 回车默认 [\033[31m 随机六位数 \033[0m] ：" 
read adminuser
[ -z "$adminuser" ] && adminuser=`cat /dev/urandom | head -n 8 | md5sum | head -c 8`
	echo
    echo " ================="
    echo " |账号 = $adminuser"
    echo " ================="
    echo
#小白免流
echo -ne "\033[34m 请输入后台管理员密码 \033[0m"
echo 
echo -n -e " 回车默认 [\033[31m 随机六位数 \033[0m] ：" 
read adminpass
[ -z "$adminpass" ] && adminpass=`cat /dev/urandom | head -n 6 | md5sum | head -c 6`
	echo
    echo " ================="
    echo " |密码 = $adminpass"
    echo " ================="
    echo
#小白免流
clear
echo -ne "\033[36m 请输入App名称\033[0m"
echo 
echo -n -e " 回车默认 [\033[31m 小白云流量 \033[0m] ：" 
 read appname 
[ -z "$appname" ] && appname="小白云流量"
	echo
	echo " ======================"
    echo " |名称 = $appname"
    echo " ======================"
    echo
#小白免流
echo -ne "\033[36m 请输入客服QQ\033[0m"
echo 
echo -n -e " 回车默认 [\033[31m 100000 \033[0m] ：" 
 read appname1 
[ -z "$appname1" ] && appname1="100000"
	echo
	echo " ======================"
    echo " |QQ = $appname1"
    echo " ======================"
    echo
#小白免流
echo -e "\033[35m设置完成  接下来的时间
可以打把撸 啪啪啪  看看小黄片 群主献上www.papapa88.com...\033[0m"
return 1
}
function newvpn() {
clear
echo
	echo -e "\033[35m正在安装主程序...\033[0m"
	yum install -y openvpn telnet >/dev/null 2>&1
	sleep 1
	yum install -y openssl openssl-devel lzo lzo-devel pam pam-devel automake pkgconfig expect >/dev/null 2>&1
	cd /etc/openvpn/ >/dev/null 2>&1
	rm -rf /etc/openvpn/server.conf >/dev/null 2>&1
	service sendmail stop >/dev/null 2>&1 
	rm -rf /etc/openvpn/xbmll.sh >/dev/null 2>&1
#echo "> 选择安装模式"
#echo
#echo " 1 - 标准(回车默认) < 新装+流控系统"
#echo -e "     \033[31m注意：\033[0m\033[35m支持阿里云、腾讯云等正规服务商 Centos7 全新系统. \033[0m"
#echo -e "     腾讯云：请默认安全组放通全部端口."
#echo 
#echo " 2 - 修复模式 >> 证书问题"
#echo 
#echo " 3 - 对接模式 >> 实现N台服务器共用账号"
#echo
#echo -n -e "请输入对应数字:"
#read installxuanze
if [[ $installslect == "1" ]]
then
echo "#################################################
	#               vpn流量控制配置文件             #
	#                               by：小白免流™   #
	#                                  2016-10-09   #
	#################################################
	port 137
	#your port by:xbmll.cn

	proto udp
	dev tun
	ca /etc/openvpn/easy-rsa/keys/ca.crt
	cert /etc/openvpn/easy-rsa/keys/centos.crt
	key /etc/openvpn/easy-rsa/keys/centos.key
	dh /etc/openvpn/easy-rsa/keys/dh2048.pem
	auth-user-pass-verify /etc/openvpn/loginudp.sh via-env
	client-disconnect /etc/openvpn/disconnectudp.sh
	client-connect /etc/openvpn/connect.sh
	client-cert-not-required
	username-as-common-name
	script-security 3 system
	server 10.9.0.0 255.255.0.0
	push redirect-gateway def1 bypass-dhcp
	push dhcp-option DNS 114.114.114.114
	push dhcp-option DNS 114.114.115.115
	management localhost 7506
	keepalive 10 120
	tls-auth /etc/openvpn/easy-rsa/ta.key 0  
	comp-lzo
	persist-key
	persist-tun
	status /home/wwwroot/default/udp1/openvpn-status2.txt
	log /etc/openvpn/openvpn2.log
	log-append  /etc/openvpn/openvpn2.log
	verb 3
	#xbmll.cn" >/etc/openvpn/server-udp.conf
	
echo "#################################################
	#               vpn流量控制配置文件             #
	#                               by：小白免流™   #
	#                                  2016-10-09   #
	#################################################
	port 138
	#your port by:xbmll.cn

	proto udp
	dev tun
	ca /etc/openvpn/easy-rsa/keys/ca.crt
	cert /etc/openvpn/easy-rsa/keys/centos.crt
	key /etc/openvpn/easy-rsa/keys/centos.key
	dh /etc/openvpn/easy-rsa/keys/dh2048.pem
	auth-user-pass-verify /etc/openvpn/loginudp.sh via-env
	client-disconnect /etc/openvpn/disconnectudp.sh
	client-connect /etc/openvpn/connect.sh
	client-cert-not-required
	username-as-common-name
	script-security 3 system
	server 10.10.0.0 255.255.0.0
	push redirect-gateway def1 bypass-dhcp
	push dhcp-option DNS 114.114.114.114
	push dhcp-option DNS 114.114.115.115
	management localhost 7507
	keepalive 10 120
	tls-auth /etc/openvpn/easy-rsa/ta.key 0  
	comp-lzo
	persist-key
	persist-tun
	status /home/wwwroot/default/udp2/openvpn-status3.txt
	log /etc/openvpn/openvpn3.log
	log-append  /etc/openvpn/openvpn3.log
	verb 3
	#xbmll.cn" >/etc/openvpn/server-udp2.conf


	echo "#################################################
	#               vpn流量控制配置文件             #
	#                               by：小白免流™   #
	#                                  2016-09-22   #
	#################################################
	port $vpnport
	#your port by:xbmll

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
	push "dhcp-option DNS 114.114.114.114"
	push "dhcp-option DNS 114.114.115.115"
	management localhost 7505
	keepalive 10 120
	tls-auth /etc/openvpn/easy-rsa/ta.key 0  
	comp-lzo
	persist-key
	persist-tun
	status /home/wwwroot/default/res/openvpn-status.txt
	log         openvpn.log
	log-append  openvpn.log
	verb 3
	#xbmll.cn" >/etc/openvpn/server.conf
	cd /etc/openvpn/
	rm -rf /easy-rsa/
	curl -O ${http}${Host}/${xbml}/${KRSA}
	unzip ${KRSA} >/dev/null 2>&1
	rm -rf ${KRSA}
	
else
	
	echo "#################################################
	#               vpn流量控制配置文件             #
	#                               by：小白免流™   #
	#                                  2016-10-09   #
	#################################################
	port 137
	#your port by:xbmll.cn

	proto udp
	dev tun
	ca /etc/openvpn/easy-rsa/keys/ca.crt
	cert /etc/openvpn/easy-rsa/keys/centos.crt
	key /etc/openvpn/easy-rsa/keys/centos.key
	dh /etc/openvpn/easy-rsa/keys/dh2048.pem
	auth-user-pass-verify /etc/openvpn/loginudp.sh via-env
	client-disconnect /etc/openvpn/disconnectudp.sh
	client-connect /etc/openvpn/connect.sh
	client-cert-not-required
	username-as-common-name
	script-security 3 system
	server 10.9.0.0 255.255.0.0
	push redirect-gateway def1 bypass-dhcp
	push dhcp-option DNS 114.114.114.114
	push dhcp-option DNS 114.114.115.115
	management localhost 7506
	keepalive 10 120
	tls-auth /etc/openvpn/easy-rsa/ta.key 0  
	comp-lzo
	persist-key
	persist-tun
	status /home/wwwroot/default/udp1/openvpn-status2.txt
	log /etc/openvpn/openvpn2.log
	log-append  /etc/openvpn/openvpn2.log
	verb 3
	#xbmll.cn" >/etc/openvpn/server-udp.conf
	
	echo "#################################################
	#               vpn流量控制配置文件             #
	#                               by：小白免流™   #
	#                                  2016-10-09   #
	#################################################
	port 138
	#your port by:xbmll.cn

	proto udp
	dev tun
	ca /etc/openvpn/easy-rsa/keys/ca.crt
	cert /etc/openvpn/easy-rsa/keys/centos.crt
	key /etc/openvpn/easy-rsa/keys/centos.key
	dh /etc/openvpn/easy-rsa/keys/dh2048.pem
	auth-user-pass-verify /etc/openvpn/loginudp.sh via-env
	client-disconnect /etc/openvpn/disconnectudp.sh
	client-connect /etc/openvpn/connect.sh
	client-cert-not-required
	username-as-common-name
	script-security 3 system
	server 10.10.0.0 255.255.0.0
	push redirect-gateway def1 bypass-dhcp
	push dhcp-option DNS 114.114.114.114
	push dhcp-option DNS 114.114.115.115
	management localhost 7507
	keepalive 10 120
	tls-auth /etc/openvpn/easy-rsa/ta.key 0  
	comp-lzo
	persist-key
	persist-tun
	status /home/wwwroot/default/udp2/openvpn-status3.txt
	log /etc/openvpn/openvpn3.log
	log-append  /etc/openvpn/openvpn3.log
	verb 3
	#xbmll.cn" >/etc/openvpn/server-udp2.conf
	
    echo "#################################################
   #               vpn流量控制配置文件             #
   #                               by：小白免流™   #
   #                                  2016-09-22   #
   #################################################
   port $vpnport
   #your port by:xbmll

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
   push "dhcp-option DNS 114.114.114.114"
   push "dhcp-option DNS 114.114.115.115"
   management localhost 7505
   keepalive 10 120
   tls-auth /etc/openvpn/easy-rsa/ta.key 0  
   comp-lzo
   persist-key
   persist-tun
   status /home/wwwroot/default/res/openvpn-status.txt
   log         openvpn.log
   log-append  openvpn.log
   verb 3
   #xbmll.cn" >/etc/openvpn/server.conf
   curl -O ${http}${Host}/${xbml}/${RSA}
   tar -zxvf ${RSA} >/dev/null 2>&1
   rm -rf /etc/openvpn/${RSA}
   cd /etc/openvpn/easy-rsa/
   sleep 1
   source vars >/dev/null 2>&1
   ./clean-all
   clear
   echo "正在生成CA/服务端证书..."
   echo 
   sleep 2
   ./ca >/dev/null 2>&1 && ./centos centos >/dev/null 2>&1
   sleep 2
   echo "正在生成TLS密钥..."
   openvpn --genkey --secret ta.key
   echo
   sleep 1
   clear
    echo
	echo "正在生成加密证书..."
	./build-dh

   echo
   echo "生成完毕！"
fi



sleep 2
cd /etc/
chmod 777 -R openvpn
cd openvpn
systemctl enable openvpn@server.service >/dev/null 2>&1
sleep 1
cp /etc/openvpn/easy-rsa/keys/ca.crt /home/ >/dev/null 2>&1
cp /etc/openvpn/easy-rsa/ta.key /home/ >/dev/null 2>&1
echo "创建vpn启动命令..."
echo "正在重启openvpn服务...
	mkdir -p /dev/net; mknod /dev/net/tun c 10 200 >/dev/null 2>&1
	killall openvpn >/dev/null 2>&1
	systemctl disable firewalld.service
	systemctl stop openvpn@server.service
	systemctl start openvpn@server.service
	killall mproxy-xb >/dev/null 2>&1
	cd /root/
	./mproxy-xb -l $mpport -d >/dev/null 2>&1
	./mproxy-xb -l 137 -d >/dev/null 2>&1
	./mproxy-xb -l 139 -d >/dev/null 2>&1
	./mproxy-xb -l 138 -d >/dev/null 2>&1
	./mproxy-xb -l 3389 -d >/dev/null 2>&1
	./mproxy-xb -l 53 -d >/dev/null 2>&1
	./mproxy-xb -l 28080 -d >/dev/null 2>&1
	./mproxy-xb -l 351 -d >/dev/null 2>&1
	./mproxy-xb -l 366 -d >/dev/null 2>&1
	./mproxy-xb -l 9101 -d >/dev/null 2>&1
	killall squid >/dev/null 2>&1
	squid -z >/dev/null 2>&1
	systemctl restart squid
	lnmp
	openvpn --config /etc/openvpn/server-udp.conf &
	openvpn --config /etc/openvpn/server-udp2.conf &
	killall jiankong >/dev/null 2>&1
	rm -rf /home/jiankong.log >/dev/null 2>&1
	/home/wwwroot/default/res/jiankong >>/home/jiankong.log >&1 &
	/home/wwwroot/default/udp1/udpjiankong >>/home/jiankong.log >&1 &
	/home/wwwroot/default/udp2/udpjiankong2 >>/home/jiankong.log >&1 &
	echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
	exit 0" >/bin/vpn
chmod 777 /bin/vpn

cd /bin
curl -O ${http}${Host}/${xbml}/onsql >/dev/null 2>&1
curl -O ${http}${Host}/${xbml}/onyd >/dev/null 2>&1
curl -O ${http}${Host}/${xbml}/offsql >/dev/null 2>&1
curl -O ${http}${Host}/${xbml}/offyd >/dev/null 2>&1
sed -i '5s/phpmyadmin/'$sqlfh'/' /bin/offsql >/dev/null 2>&1
sed -i '3s/phpmyadmin/'$sqlfh'/' /bin/onsql >/dev/null 2>&1

sed -i '5s/dnsml/'$appapi'/' /bin/offyd >/dev/null 2>&1
sed -i '6s/dnsml/'$appapi'/' /bin/offyd >/dev/null 2>&1

sed -i '3s/dnsml/'$appapi'/' /bin/onyd >/dev/null 2>&1
sed -i '4s/dnsml/'$appapi'/' /bin/onyd >/dev/null 2>&1


chmod 777 /bin/onsql
chmod 777 /bin/onyd
chmod 777 /bin/offsql
chmod 777 /bin/offyd
echo 
sleep 1
killall squid >/dev/null 2>&1
clear
echo -e "\033[35m正在安装设置HTTP代理端口...\033[0m"
sleep 2
yum -y install squid >/dev/null 2>&1
chkconfig squid on
cd /etc/squid
rm -rf ./squid.conf >/dev/null 2>&1
sleep 1
curl -O ${http}${Host}/${xbml}/${sq}
sed -i 's/http_port 80/http_port '$sqport'/g' /etc/squid/squid.conf >/dev/null 2>&1
sleep 1
chmod 0755 ./${sq} >/dev/null 2>&1
echo 
echo
sleep 2

curl -O ${http}${Host}/${xbml}/${squser} >/dev/null 2>&1
chmod 0755 ./${squser} >/dev/null 2>&1
sleep 1
echo 
echo
cd /etc/
chmod 777 -R squid
cd squid
squid -z >/dev/null 2>&1
systemctl restart squid >/dev/null 2>&1
systemctl enable squid >/dev/null 2>&1
#禁ping代码
#echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all >/dev/null 2>&1
sleep 2
echo 
sleep 3
clear
echo
sleep 3
cd /root/
curl -O ${http}${Host}/${xbml}/${mp} >/dev/null 2>&1
chmod 0777 ./${mp} >/dev/null 2>&1
echo 
return 1
}
function installlnmp(){
#rm -rf /etc/yum.repos.d/CentOS-Base.repo >/dev/null 2>&1
#mv /etc/yum.repos.d/CentOS-Base.repo.backup /etc/yum.repos.d/CentOS-Base.repo >/dev/null 2>&1
rm -rf /etc/yum.repos.d/epel.repo >/dev/null 2>&1
rm -rf /etc/yum.repos.d/epel-testing.repo >/dev/null 2>&1
clear
echo -e "\033[35m正在安装小白免流™ LNMP系统\033[0m"
echo
echo -e "\033[33m注意：安装过程中如果有卡住或者停住请耐心等待\033[0m"
 
mkdir -p /home/wwwroot/default >/dev/null 2>&1
wget ${http}${Host}/${xbml}/${lnmpfile} >/dev/null 2>&1
tar -zxf ./${lnmpfile} >/dev/null 2>&1
rm -rf ${lnmpfile} >/dev/null 2>&1
#yum -y install httpd
#rm -rf /etc/httpd/conf/httpd.conf
#cd /etc/httpd/conf/
#curl -O ${http}${Host}/${xbml}/httpd.conf
#systemctl restart httpd.service
#systemctl enable httpd.service
#sleep 1
cd lnmp
chmod +x ./install_php.sh
./install_php.sh

# 安装mysql
yum -y install nginx
mv /usr/share/nginx /home/wwwroot
rm -rf /etc/nginx/conf.d/default.conf
cp -r /root/lnmp/conf/default.conf /etc/nginx/conf.d/default.conf
systemctl enable nginx.service
systemctl start nginx.service
#yum --enablerepo=remi install -y mariadb-server mariadb
#sleep 1
#systemctl restart mariadb
#systemctl enable mariadb
#sleep 1

#yum -y --enablerepo=epel,remi,remi-php54 install php php-cli php-gd php-mbstring php-mcrypt php-mysqlnd php-opcache php-pdo php-devel php-xml
##3 yum --enablerepo=remi install -y php php-mysql php-gd libjpeg* php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-bcmath php-mhash
#systemctl restart httpd.service
#sleep 1
echo

echo
 cd /usr/local/
echo 
curl -O ${http}${Host}/${xbml}/${webfile64}
tar zxf ${webfile64}
rm -rf ${webfile64}

CDIR='/usr/local/ioncube'
phpversion=`php -v | grep ^PHP | cut -f2 -d " "| awk -F "." '{print "zend_extension=\"/usr/local/ioncube/ioncube_loader_lin_"$1"."$2".so\""}'`
phplocation=`php -i | grep php.ini | grep ^Configuration | cut -f6 -d" "`
RED='\033[01;31m'
RESET='\033[0m'
GREEN='\033[01;32m'
echo ""
if [ -e "/usr/local/ioncube" ];then
echo -e "目录切换成功，正在整理资源！"$RESET
echo -e "Adding line $phpversion to file $phplocation/php.ini" >/dev/null 2>&1 $RESET 
echo -e "$phpversion" >> $phplocation/php.ini
echo -e "安装成功"$RESET
else
echo -e "安装失败！请确认当前系统为Centos7.x 64位！"$RESET
echo -e "请不要用旧版本进行搭建！"$RESET
exit
fi
echo "#!/bin/bash
echo '正在重启lnmp...'
systemctl restart mariadb
systemctl restart nginx.service
systemctl restart php-fpm.service
systemctl restart crond.service
service sendmail stop >/dev/null 2>&1 
echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
exit 0;
" >/bin/lnmp
chmod 777 /bin/lnmp >/dev/null 2>&1
lnmp
 echo 
echo -e "\033[31m安装完成！\033[0m"
echo -e "\033[31m感谢使用小白免流™ LNMP系统 - Centos7版\033[0m"
 return 1
}
function webml(){
clear
echo -e "\033[36m开始搭建小白免流™流量控制程序\033[0m"
echo -e "\033[33m请不要进行任何操作 程序自动完成...\033[0m"
cd /root/
curl -O ${http}${Host}/${xbml}/${webfile}
unzip -q ${webfile} >/dev/null 2>&1
mysqladmin -u root password "${sqlpass}"
sed -i "289s/ip/$IP/" /root/xb/web/install.sql >/dev/null 2>&1 
sed -i "289s/port/$port/" /root/xb/web/install.sql >/dev/null 2>&1 

#sed -i "290s/ip/$IP/" /root/xb/web/install.sql >/dev/null 2>&1 
#sed -i "290s/port/$port/" /root/xb/web/in`st.all.sql >/dev/null 2>&1 

sed -i "292s/ip/$IP/" /root/xb/web/install.sql >/dev/null 2>&1 
sed -i "292s/port/$port/" /root/xb/web/install.sql >/dev/null 2>&1 

#sed -i "308s/bdw/$IP/" install.sql
#sed -i "308s/yuan/$port/" install.sql
sed -i "338s/1549492819/$ykey/" /root/xb/web/install.sql >/dev/null 2>&1 
sed -i "364s/admin/root/" /root/xb/web/install.sql >/dev/null 2>&1 
a=`printf $pas|md5sum|tr -d "-"`;
sed -i "364s/21232f297a57a5a743894a0e4a801fc3/$a/" /root/xb/web/install.sql >/dev/null 2>&1 
#echo -e "\033[34m修改数据库密码完成！\033[0m"
sed -i 's/127.0.0.1:808/'$IP:$port'/g' /root/xb/web/install.sql >/dev/null 2>&1 
sed -i "460s/admin/root/" /root/xb/web/install.sql >/dev/null 2>&1 
sed -i "460s/admin1/$pas/" /root/xb/web/install.sql >/dev/null 2>&1 
#echo -e "正在自动加入流控数据库表：\033[31m ov \033[0m"
create_db_sql="create database IF NOT EXISTS ov"
mysql -hlocalhost -uroot -p$sqlpass -e "${create_db_sql}"
mysql -hlocalhost -uroot -p$sqlpass --default-character-set=utf8<<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '${sqlpass}' WITH GRANT OPTION;
flush privileges;
use ov;set names utf8;
source /root/xb/web/install.sql;
EOF
sed -i 's/123456/'$sqlpass'/g' ./xb/sh/login.sh >/dev/null 2>&1
sed -i 's/123456/'$sqlpass'/g' ./xb/sh/loginudp.sh >/dev/null 2>&1
sed -i 's/123456/'$sqlpass'/g' ./xb/sh/disconnect.sh >/dev/null 2>&1
sed -i 's/123456/'$sqlpass'/g' ./xb/sh/disconnectudp.sh >/dev/null 2>&1

top=`cat /dev/urandom | head -n 6 | md5sum | head -c 6`
sed -i 's/top_api.php/'$top.php'/g' ./xb/sh/disconnect.sh >/dev/null 2>&1
sed -i 's/top_api.php/'$top.php'/g' ./xb/sh/disconnectudp.sh >/dev/null 2>&1
sleep 1
sed -i 's/80/'$port'/g' /usr/local/nginx/conf/nginx.conf >/dev/null 2>&1
sed -i 's/80/'$port'/g' /etc/nginx/conf.d/default.conf >/dev/null 2>&1
#sed -i 's/ServerName www.example.com:1234/ServerName www.example.com:'$port'/g' /etc/httpd/conf/httpd.conf >/dev/null 2>&1
#sed -i 's/Listen 1234/Listen '$port'/g' /etc/httpd/conf/httpd.conf >/dev/null 2>&1
sleep 1
mv -f ./xb/sh/login.sh /etc/openvpn/ >/dev/null 2>&1
mv -f ./xb/sh/loginudp.sh /etc/openvpn/ >/dev/null 2>&1
mv -f ./xb/sh/disconnect.sh /etc/openvpn/ >/dev/null 2>&1
mv -f ./xb/sh/disconnectudp.sh /etc/openvpn/ >/dev/null 2>&1
mv -f ./xb/sh/connect.sh /etc/openvpn/ >/dev/null 2>&1
chmod +x /etc/openvpn/*.sh >/dev/null 2>&1
chmod 755 -R ./xb/web/* >/dev/null 2>&1

sed -i '30s/127.0.0.1/'$IP:$port'/' /etc/openvpn/disconnect.sh >/dev/null 2>&1
sed -i '30s/127.0.0.1/'$IP:$port'/' /etc/openvpn/disconnectudp.sh >/dev/null 2>&1

service sendmail stop >/dev/null 2>&1 
sleep 1
sed -i 's/123456/'$sqlpass'/g' ./xb/web/config.php >/dev/null 2>&1
#sed -i 's/123456/'$sqlpass'/g' ./xb/web/7kyun/config.php >/dev/null 2>&1
#sed -i 's/127.0.0.1/'${IP}:${port}'/g' ./xb/web/7kyun/config.php >/dev/null 2>&1
rm -rf /home/wwwroot/default/html/index* >/dev/null 2>&1
mv -f ./xb/web/* /home/wwwroot/default/ >/dev/null 2>&1
sleep 1
sed -i '8s/root/'$adminuser'/' /home/wwwroot/default/config.php >/dev/null 2>&1
sed -i '9s/root/'$adminpass'/' /home/wwwroot/default/config.php >/dev/null 2>&1
cd /home/wwwroot/default/
sed -i '48s/adminuser/'$fh1'/' /home/wwwroot/default/admin/nav.php >/dev/null 2>&1
mv admin $fh1
#curl -O ${http}${Host}/${phpmyadminfile}
#tar -zxf ${phpmyadminfile}
mv phpMyAdmin-4.6.2-all-languages $sqlfh >/dev/null 2>&1
rm -rf /root/xb/ >/dev/null 2>&1
rm -rf /root/lnmp
rm -rf /root/${webfile} >/dev/null 2>&1
sleep 1
cd /home/
s=`cat /dev/urandom | head -n 29 | md5sum | head -c 29 >sjs.txt`
sjs=`cat sjs.txt`
mv /home/wwwroot/default/config.php /home/wwwroot/default/$sjs.php >/dev/null 2>&1
sed -i '126s/config.php/'$sjs.php'/' /home/wwwroot/default/api.inc.php >/dev/null 2>&1

yum install -y crontabs >/dev/null 2>&1
mkdir -p /var/spool/cron/ >/dev/null 2>&1
chmod 777 /home/wwwroot/default/cron.php >/dev/null 2>&1
clear
echo
echo -e "\033[35m正在设置全新实时流量自动监控程序...\033[0m"
echo "* * * * * curl --silent --compressed http://${IP}:${port}/cron.php">>/var/spool/cron/root
cd /home
#建备份文件夹
mkdir mysql
mkdir -p /home/mysql
cd /home/mysql/
#建脚本文件
echo '#!/bin/sh
date=`date +%Y%m%d-%H:%M:%S`
/usr/bin/mysqldump -uroot -proot1 ov >>/home/mysql/$date.sql'>/home/mysql/beifen.sh
sed -i '3s/root1/'$sqlpass'/' /home/mysql/beifen.sh >/dev/null 2>&1
chmod +x /home/mysql/beifen.sh

#一个小时备份一次
sed -i '$a\* */1 * * * source /home/mysql/beifen.sh' /var/spool/cron/root
systemctl restart crond.service  >/dev/null 2>&1
systemctl enable crond.service >/dev/null 2>&1

cd /home/wwwroot/default/
mkdir udp1 >/dev/null 2>&1
mkdir udp2 >/dev/null 2>&1
cd /home/wwwroot/default/res/
curl -O ${http}${Host}/${xbml}/${jiankongfile} >/dev/null 2>&1
unzip ${jiankongfile} >/dev/null 2>&1
rm -rf ${jiankongfile}
chmod 777 jiankong >/dev/null 2>&1
chmod 777 sha >/dev/null 2>&1
mv -f ./udp137 /home/wwwroot/default/udp1
mv -f ./udpjiankong /home/wwwroot/default/udp1
mv -f ./udp138 /home/wwwroot/default/udp2
mv -f ./udpjiankong2 /home/wwwroot/default/udp2
chmod 777 /home/wwwroot/default/udp1/udp137
chmod 777 /home/wwwroot/default/udp2/udp138
chmod 777 /home/wwwroot/default/udp1/udpjiankong
chmod 777 /home/wwwroot/default/udp2/udpjiankong2
chmod 777 /home/wwwroot/default/udp1 >/dev/null 2>&1
chmod 777 /home/wwwroot/default/udp2 >/dev/null 2>&1
cd /etc/openvpn/
curl -O ${http}${Host}/${xbml}/peizhi.zip >/dev/null 2>&1
unzip peizhi.zip >/dev/null 2>&1
rm -rf peizhi.zip
sed -i 's/mima=123456/'mima=$sqlpass'/g' /etc/openvpn/peizhi.cfg >/dev/null 2>&1
sed -i 's/shijian=30/'shijian=$jiankongs'/g' /etc/openvpn/peizhi.cfg >/dev/null 2>&1
chmod 777 /etc/openvpn/peizhi.cfg >/dev/null 2>&1
echo "/home/wwwroot/default/res/jiankong >>/home/jiankong.log >&1 &">>/etc/rc.local >/dev/null 2>&1
echo "/home/wwwroot/default/udp1/udpjiankong >>/home/jiankong.log >&1 &">>/etc/rc.local >/dev/null 2>&1
echo "/home/wwwroot/default/udp2/udpjiankong2 >>/home/jiankong.log >&1 &">>/etc/rc.local >/dev/null 2>&1
sleep 2
vpn >/dev/null 2>&1
chmod 777 /home/wwwroot/default/res/openvpn-status.txt >/dev/null 2>&1
chmod 777 /home/wwwroot/default/udp1/openvpn-status2.txt >/dev/null 2>&1
chmod 777 /home/wwwroot/default/udp2/openvpn-status3.txt >/dev/null 2>&1
#curl -O ${http}${Host}/${xbml}/${jiankongfile} >/dev/null 2>&1
#rm -f /var/spool/mail/* >/dev/null 2>&1 
#unzip ${jiankongfile} >/dev/null 2>&1
#rm -rf ${jiankongfile}
#chmod 777 jiankong
#chmod 777 sha
#sed -i 's/shijian=1/'shijian=$jiankongs'/g' /home/wwwroot/default/res/ >/dev/null 2>&1
#echo "mima=$sqlpass">>/etc/openvpn/sqlmima
#chmod 777 /etc/openvpn/sqlmima
#/home/wwwroot/default/res/jiankong >>/home/jiankong.log 2>&1 &
#echo "/home/wwwroot/default/res/jiankong >>/home/jiankong.log 2>&1 &">>/etc/rc.local
#rm -f /var/spool/mail/* >/dev/null 2>&1 
sleep 2
lnmp
echo -e "\033[35m正在设置为开机启动...\033[0m"
systemctl enable openvpn@server.service >/dev/null 2>&1
echo 
# echo "正在进行流控网速优化..."
# echo 0 > /proc/sys/net/ipv4/tcp_window_scaling
echo 
echo -e "\033[35mWeb流量控制程序安装完成...\033[0m"
return 1
}
function ovpn(){
echo 
echo "开始生成配置文件..."
sleep 3
cd /home/
echo "# 小白云免配置 移动常规类型
# 本文件由系统自动生成
# 类型：常规
client
dev tun
proto tcp
remote $IP $vpnport
########免流代码########
http-proxy $IP $sqport">yd-quanguo1.ovpn
echo 'http-proxy-option EXT1 "POST http://rd.go.10086.cn"
http-proxy-option EXT1 "GET http://rd.go.10086.cn"
http-proxy-option EXT1 "X-Online-Host: rd.go.10086.cn"
http-proxy-option EXT1 "POST http://rd.go.10086.cn"
http-proxy-option EXT1 "X-Online-Host: rd.go.10086.cn"
http-proxy-option EXT1 "POST http://rd.go.10086.cn"
http-proxy-option EXT1 "Host: rd.go.10086.cn"
http-proxy-option EXT1 "GET http://rd.go.10086.cn"
http-proxy-option EXT1 "Host: rd.go.10086.cn" 
########免流代码########
<http-proxy-user-pass>
xbmlll
xbmll.cn
</http-proxy-user-pass>
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>yd-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">yd-quanguo3.ovpn
cat yd-quanguo1.ovpn yd-quanguo2.ovpn yd-quanguo3.ovpn>xbml-yd-old.ovpn
rm -rf ./{yd-quanguo1.ovpn,yd-quanguo2.ovpn,yd-quanguo3.ovpn}

echo "# 小白云免配置 移动全国137UDP
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto udp
remote $IP 137">http-yd2-quanguo-1.ovpn
echo 'resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd2-quanguo-2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd2-quanguo-3.ovpn
cat http-yd2-quanguo-1.ovpn http-yd2-quanguo-2.ovpn http-yd2-quanguo-3.ovpn>xbml-yd-udp137.ovpn
rm -rf ./{http-yd2-quanguo1.ovpn,http-yd2-quanguo2.ovpn,http-yd2-quanguo3.ovpn}

echo "# 小白云免配置 移动全国138UDP
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto udp
remote $IP 138">http-yd2-quanguo-1.ovpn
echo 'resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd2-quanguo-2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd2-quanguo-3.ovpn
cat http-yd2-quanguo-1.ovpn http-yd2-quanguo-2.ovpn http-yd2-quanguo-3.ovpn>xbml-yd-udp138.ovpn
rm -rf ./{http-yd2-quanguo1.ovpn,http-yd2-quanguo2.ovpn,http-yd2-quanguo3.ovpn}

echo "# 小白云免配置 移动全国137
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote wap.10086.cn 80
########免流代码########
http-proxy $IP 137
http-proxy-option EXT1 POST http://wap.10086.cn
http-proxy-option EXT1 xbmlll 127.0.0.1:$vpnport">http-yd-zj1.ovpn
echo 'http-proxy-option EXT1 Host wap.10086.cn
http-proxy-option EXT1 Host: wap.10086.cn / HTTP/1.1
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-zj2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-zj3.ovpn
cat http-yd-zj1.ovpn http-yd-zj2.ovpn http-yd-zj3.ovpn>xbml-yd-137.ovpn
rm -rf ./{http-yd-zj1.ovpn,http-yd-zj2.ovpn,http-yd-zj3.ovpn}

echo "# 小白云免配置 移动全国138
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote wap.10086.cn 80
########免流代码########
http-proxy $IP 138
http-proxy-option EXT1 POST http://wap.10086.cn
http-proxy-option EXT1 xbmlll 127.0.0.1:$vpnport">http-yd-zj1.ovpn
echo 'http-proxy-option EXT1 Host wap.10086.cn
http-proxy-option EXT1 Host: wap.10086.cn / HTTP/1.1
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-zj2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-zj3.ovpn
cat http-yd-zj1.ovpn http-yd-zj2.ovpn http-yd-zj3.ovpn>xbml-yd-138.ovpn
rm -rf ./{http-yd-zj1.ovpn,http-yd-zj2.ovpn,http-yd-zj3.ovpn}

echo "# 小白云免配置 移动百度138
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote www.baidu.com 80
########免流代码########
http-proxy-option EXT1 xbmlll 127.0.0.1:$vpnport
http-proxy-option EXT1 X-Online-Host: www.baidu.com
http-proxy-option EXT1 Host: www.baidu.com
http-proxy $IP 138">http-yd-zj1.ovpn
echo '########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-zj2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-zj3.ovpn
cat http-yd-zj1.ovpn http-yd-zj2.ovpn http-yd-zj3.ovpn>xbml-yd-138baidu.ovpn
rm -rf ./{http-yd-zj1.ovpn,http-yd-zj2.ovpn,http-yd-zj3.ovpn}


echo "# 小白云免配置 联通空中卡53
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote k.10010.com 80
########免流代码########
http-proxy $IP 53
http-proxy-option EXT1 POST http://k.10010.com
http-proxy-option EXT1 xbmlll 127.0.0.1:$vpnport">http-yd-zj1.ovpn
echo 'http-proxy-option EXT1 Host k.10010.com
http-proxy-option EXT1 Host: k.10010.com / HTTP/1.1
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-zj2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-zj3.ovpn
cat http-yd-zj1.ovpn http-yd-zj2.ovpn http-yd-zj3.ovpn>xbml-lt-53.ovpn
rm -rf ./{http-yd-zj1.ovpn,http-yd-zj2.ovpn,http-yd-zj3.ovpn}

echo "# 小白云免配置 联通全国UAC
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote uac.10010.com/index.asp&from=http://$IP:$vpnport?uac.10010.com/index.asp&from=uac.10155.com/index.asp&& $vpnport
########免流代码########">http-lt-quanguo1.ovpn
echo 'http-proxy-option EXT1 "POST http://m.client.10010.com"
http-proxy-option EXT1 "GET http://m.client.10010.com"
http-proxy-option EXT1 ": http://uac.10010.com/"
http-proxy-option EXT1 "Referer: http://uac.10010.com/oauth2/new_auth?display=wap&page_type=05&app_code=ECS-YH-WAP&redirect_uri=http://wap.10010.com/t/loginCallBack.htm&state=http://wap.10010.com/t/home.htm&channel_code=113000001&real_ip=113.57.255.1"
http-proxy 10.0.0.172 80
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-quanguo3.ovpn
cat http-lt-quanguo1.ovpn http-lt-quanguo2.ovpn http-lt-quanguo3.ovpn>xbml-lt-uac.ovpn
rm -rf ./{http-lt-quanguo1.ovpn,http-lt-quanguo2.ovpn,http-lt-quanguo3.ovpn}

echo "# 小白云免配置 广东联通
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote u.3gtv.net 80
########免流代码########
http-proxy $IP $mpport
http-proxy-option EXT1 xbmlll 127.0.0.1:$vpnport">http-lt-quanguo1.ovpn
echo '########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-quanguo3.ovpn
cat http-lt-quanguo1.ovpn http-lt-quanguo2.ovpn http-lt-quanguo3.ovpn>xbml-lt-gd.ovpn
rm -rf ./{http-lt-quanguo1.ovpn,http-lt-quanguo2.ovpn,http-lt-quanguo3.ovpn}

echo "# 小白云免配置 广东联通2
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote 58.248.254.7 80
########免流代码########
http-proxy $IP $mpport
http-proxy-option EXT1 xbmlll 127.0.0.1:$vpnport">http-lt-quanguo1.ovpn
echo '########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-quanguo3.ovpn
cat http-lt-quanguo1.ovpn http-lt-quanguo2.ovpn http-lt-quanguo3.ovpn>xbml-lt-gd2.ovpn
rm -rf ./{http-lt-quanguo1.ovpn,http-lt-quanguo2.ovpn,http-lt-quanguo3.ovpn}

echo "# 小白云免配置 移动咪咕
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote dlsdown.mll.migu.cn 80
########免流代码########
http-proxy-option EXT1 POST http://dlsdown.mll.migu.cn" >http-yd-quanguo1.ovpn
echo 'http-proxy-option EXT1 "GET /wlansst?pars=CI=6005660A0KZ2600902000009442296/F=020007/T=30142258647901/S=47be953c93/FN=filename.mp3 HTTP/1.1"'>ip.ovpn
echo "http-proxy-option EXT1 xbmlll 127.0.0.1:$vpnport 
http-proxy $IP 137 " >http-yd-s.ovpn
echo '########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-quanguo3.ovpn
cat http-yd-quanguo1.ovpn ip.ovpn http-yd-s.ovpn http-yd-quanguo2.ovpn http-yd-quanguo3.ovpn>xbml-yd-migu.ovpn
rm -rf ./{http-yd-quanguo1.ovpn,http-yd-quanguo2.ovpn,http-yd-quanguo3.ovpn}

echo "# 小白云免配置 腾讯大王卡
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
########免流代码########
##-------------------代理部分--------------------## ">http-yd-quanguo1.ovpn
echo 'http-proxy-option EXT1 "POST uni3g.qq.com" '>ip.ovpn
echo "http-proxy-option EXT1 xbmlll 127.0.0.1:$vpnport">ip2.ovpn
echo 'http-proxy-option EXT1 "Host: uni3g.qq.com / HTTP/1.1"'>ip3.ovpn
echo "http-proxy $IP $mpport
##-------------------指向链接--------------------##
remote uni3g.qq.com 3389 tcp-client ">http-yd-quanguo2.ovpn
echo '########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-quanguo3.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-quanguo4.ovpn
cat http-yd-quanguo1.ovpn ip.ovpn ip2.ovpn ip3.ovpn http-yd-quanguo2.ovpn http-yd-quanguo3.ovpn http-yd-quanguo4.ovpn>xbml-lt-tencent.ovpn
rm -rf ./{http-yd-quanguo1.ovpn,http-yd-quanguo2.ovpn,http-yd-quanguo3.ovpn}

echo "# 小白云免配置 全国电信爱玩
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
http-proxy $IP $mpport
########免流代码######## 
remote 4galbum.musicway.cn 80
http-proxy-option EXT1 xbmlll 127.0.0.1:$vpnport ">http-yd-quanguo1.ovpn
echo 'http-proxy-option EXT1 "Host: 4galbum.musicway.cn"
http-proxy-option EXT1 "X-Online-Host: 4galbum.musicway.cn"
http-proxy-option EXT1 "GET http://4galbum.musicway.cn/ HTTP/1.1"
http-proxy-option EXT1 "CONNECT 4galbum.musicway.cn"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-quanguo3.ovpn
cat http-yd-quanguo1.ovpn http-yd-quanguo2.ovpn http-yd-quanguo3.ovpn>xbml-dx-aiwan.ovpn
rm -rf ./{http-yd-quanguo1.ovpn,http-yd-quanguo2.ovpn,http-yd-quanguo3.ovpn}

echo "# 小白云免配置 全国电信爱玩
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
########免流代码######## 
remote cdn.4g.play.cn 80 ">http-yd-quanguo1.ovpn
echo 'http-proxy-option EXT1 "GET http://dl.music.189.cn:9495/res/V/1388/mp3/33/58/94/1388335894003000.mp3?mb=15380197563&fs=10104163&s=800&n=&id=63696337&M=online&sid=240387514 HTTP/1.1"
http-proxy-option EXT1 "Host dl.music.189.cn:9495"
http-proxy-option EXT1 "POST http://iting.music.189.cn:9101/iting2/imusic/V2 HTTP/1.1"'>ip.ovpn
echo "http-proxy-option EXT1 xbmlll 127.0.0.1:$vpnport 
http-proxy $IP $mpport">ip1.ovpn
echo '########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-quanguo3.ovpn
cat http-yd-quanguo1.ovpn ip.ovpn ip1.ovpn http-yd-quanguo2.ovpn http-yd-quanguo3.ovpn>xbml-dx-teshu.ovpn
rm -rf ./{http-yd-quanguo1.ovpn,http-yd-quanguo2.ovpn,http-yd-quanguo3.ovpn}

echo "# 小白云免配置 广东电信
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote 4galbum.musicway.cn 80 
########免流代码######## 
http-proxy-option EXT1 xbmlll 127.0.0.1:$vpnport ">http-yd-quanguo1.ovpn
echo 'http-proxy-option EXT1 "POST http://4galbum.musicway.cn/ HTTP/1.1"
http-proxy-option EXT1 "GET http://4galbum.musicway.cn/ HTTP/1.1"
http-proxy-option EXT1 "Host: 4galbum.musicway.cn"'>ip.ovpn
echo "http-proxy $IP $mpport">ip1.ovpn
echo '########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-quanguo3.ovpn
cat http-yd-quanguo1.ovpn ip.ovpn ip1.ovpn http-yd-quanguo2.ovpn http-yd-quanguo3.ovpn>xbml-dx-gd.ovpn
rm -rf ./{http-yd-quanguo1.ovpn,http-yd-quanguo2.ovpn,http-yd-quanguo3.ovpn}

echo '# 小白云免配置 全国电信爱听
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote 101.95.47.77 9101
########免流代码######## 
http-proxy-option EXT1 "xbmlll 127.0.0.1:vpnport"
http-proxy IP mpport '>http-yd-quanguo1.ovpn
echo '########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-quanguo3.ovpn
cat http-yd-quanguo1.ovpn http-yd-quanguo2.ovpn http-yd-quanguo3.ovpn>xbml-dx-aiting.ovpn
sed -i "10s/IP/$IP/" /home/xbml-dx-aiting.ovpn
sed -i "10s/mpport/$mpport/" /home/xbml-dx-aiting.ovpn
sed -i "9s/vpnport/$vpnport/" /home/xbml-dx-aiting.ovpn
rm -rf ./{http-yd-quanguo1.ovpn,http-yd-quanguo2.ovpn,http-yd-quanguo3.ovpn}

echo "# 小白云免配置 广东移动复活
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote wap.gd.chinamobile.com 80
########免流代码########
http-proxy $IP $mpport
http-proxy-option EXT1 CONNECT http://wap.gd.chinamobile.com / HTTP/1.1
http-proxy-option EXT1 POST http://wap.gd.chinamobile.com
http-proxy-option EXT1 xbmlll 127.0.0.1:$vpnport ">http-yd-quanguo1.ovpn
echo 'http-proxy-option EXT1 Host: 642749159wap.gd.chinamobile.com
http-proxy-option EXT1 Host: /33/58/94/1388335894003000.mp3?mb=15380197563&fs=10104163&s=800&n=&iwap.gd.chinamobile.com / HTTP/1.1 '>ip.ovpn
echo '########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-quanguo3.ovpn
cat http-yd-quanguo1.ovpn ip.ovpn http-yd-quanguo2.ovpn http-yd-quanguo3.ovpn>xbml-yd-gdfh.ovpn
rm -rf ./{http-yd-quanguo1.ovpn,http-yd-quanguo2.ovpn,http-yd-quanguo3.ovpn}

echo "# 小白云免配置 广东移动复活
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote wap.gd.10086.cn 3389 tcp-client
########免流代码########">http-yd-quanguo1.ovpn
echo 'http.-proxy-option EXT1 "GET http:// wap.gd.10086.cn"
http.-proxy-option EXT1 "X-Online-Host:wap.gd.10086.cn"
http-proty-option "Host:wap.gd.10086.cn" '>ip.ovpn
echo "http-proxy-option EXT1 xbmlll 127.0.0.1:$vpnport 
http-proxy $IP $mpport">ip2.ovpn
echo 'http-proxy-option EXT1 "VPN"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-quanguo3.ovpn
cat http-yd-quanguo1.ovpn ip.ovpn ip2.ovpn http-yd-quanguo2.ovpn http-yd-quanguo3.ovpn>xbml-yd-gdfh2.ovpn
rm -rf ./{http-yd-quanguo1.ovpn,http-yd-quanguo2.ovpn,http-yd-quanguo3.ovpn,ip.ovpn,ip2.ovpn}

echo "# 小白云免配置 全国移动
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote $IP:$vpnport/Host:strms.free.migudm.cn
########免流代码########">http-yd-quanguo1.ovpn
echo 'http-proxy-option EXT1 "CONNECT strms.free.migudm.cn"
http-proxy-option EXT1 "X-Online-Host: strms.free.migudm.cn"
http-proxy 10.0.0.172 80
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-quanguo3.ovpn
cat http-yd-quanguo1.ovpn http-yd-quanguo2.ovpn http-yd-quanguo3.ovpn>xbml-yd-quanguo.ovpn
rm -rf ./{http-yd-quanguo1.ovpn,http-yd-quanguo2.ovpn,http-yd-quanguo3.ovpn,1.ovpn,2.ovpn}

echo '# 小白云免配置 全国移动2
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote freetyst.mll.migu.cn 8080
########免流代码########
http-proxy-option EXT1 VPN
http-proxy-option GET /public/ringmaker01/n16/2016/10/2016%E5%B9%B410%E6%9C%8814%E6%97%A515%E7%82%B952%E5%88%86%E7%B4%A7%E6%80%A5%E5%86%85%E5%AE%B9%E5%87%86%E5%85%A5%E7%AE%80%E5%8D%95%E5%BF%AB%E4%B9%905%E9%A6%96/%E5%85%A8%E6%9B%B2%E8%AF%95%E5%90%AC/Mp3_128_44_16/%E5%82%BB%E5%82%BB%E7%AD%89-%E5%AD%99%E5%AD%90%E6%B6%B5.mp3?channelid=03&k=7f0e5a1cf01522c1&t=1476991262 HTTP/1.1
http-proxy-option "Accept: */*"
http-proxy-option "User-Agent: migumusic"
http-proxy-option "Range: bytes=0-"
http-proxy-option "Connection: Close"
http-proxy-option "imei:971ab76ef00772371c4f3dc0dbd16bd0"
http-proxy-option "imsi:b7cf876ebab6f01f588a7c6477b04bce"'>http-yd-quanguo1.ovpn
echo "http-proxy $IP $mpport
http-proxy-option EXT1 xbmlll 127.0.0.1:$vpnport">ip.ovpn
echo '########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-quanguo3.ovpn
cat http-yd-quanguo1.ovpn ip.ovpn http-yd-quanguo2.ovpn http-yd-quanguo3.ovpn>xbml-yd-quanguo2.ovpn
rm -rf ./{http-yd-quanguo1.ovpn,ip.ovpn,http-yd-quanguo2.ovpn,http-yd-quanguo3.ovpn,1.ovpn,2.ovpn}

echo '# 小白云免配置 四川
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote / 80
########免流代码########
;http-proxy-retry
;http-proxy [proxy server] [proxy port]
http-proxy 10.0.0.172 80
http-proxy-option EXT1 "          "Host:IP:vpnport
http-proxy-option EXT1 Host:wap.sc.10086.cn'>http-yd-quanguo1.ovpn
echo '########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-quanguo3.ovpn
cat http-yd-quanguo1.ovpn http-yd-quanguo2.ovpn http-yd-quanguo3.ovpn>xbml-yd-sc.ovpn
sed -i "12s/IP/$IP/" /home/xbml-yd-sc.ovpn
sed -i "12s/vpnport/$vpnport/" /home/xbml-yd-sc.ovpn
rm -rf ./{http-yd-quanguo1.ovpn,http-yd-quanguo2.ovpn,http-yd-quanguo3.ovpn,1.ovpn,2.ovpn}

echo '# 小白云免配置 四川
# 本文件由系统自动生成
# 类型：HTTP转接
client
dev tun
proto tcp
remote / 80
########免流代码########
;http-proxy-retry
;http-proxy [proxy server] [proxy port]
http-proxy 10.0.0.172 80
http-proxy-option EXT1 "          "Host:IP:vpnport
http-proxy-option EXT1 Host:wap.sn.10086.cn'>http-yd-quanguo1.ovpn
echo '########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.114 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-quanguo3.ovpn
cat http-yd-quanguo1.ovpn http-yd-quanguo2.ovpn http-yd-quanguo3.ovpn>xbml-yd-sn.ovpn
sed -i "12s/IP/$IP/" /home/xbml-yd-sc.ovpn
sed -i "12s/vpnport/$vpnport/" /home/xbml-yd-sc.ovpn
rm -rf ./{http-yd-quanguo1.ovpn,http-yd-quanguo2.ovpn,http-yd-quanguo3.ovpn,1.ovpn,2.ovpn}

wget http://xbmll1-1252085159.costj.myqcloud.com/xbmll/update-12-27.zip >/dev/null 2>&1
unzip update-12-27.zip >/dev/null 2>&1
#湖南
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-hn.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-hn.ovpn >/dev/null 2>&1
#重庆wap
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-cq-wap.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-cq-wap.ovpn >/dev/null 2>&1
#河北
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-he.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-he.ovpn >/dev/null 2>&1

#山东
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-sd.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-sd.ovpn >/dev/null 2>&1
#云南
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-yn.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-yn.ovpn >/dev/null 2>&1
#山西
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-sx.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-sx.ovpn >/dev/null 2>&1

#河北2
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-he2.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-he2.ovpn >/dev/null 2>&1
#甘肃
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-gs.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-gs.ovpn >/dev/null 2>&1
#安徽
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-ah.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-ah.ovpn >/dev/null 2>&1

#江西
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-jx.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-jx.ovpn >/dev/null 2>&1
#浙江
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-zj.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-zj.ovpn >/dev/null 2>&1
#广西
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-gx.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-gx.ovpn >/dev/null 2>&1

#江西2
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-jx2.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-jx2.ovpn >/dev/null 2>&1
#东莞
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-gd-dg.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-gd-dg.ovpn >/dev/null 2>&1
#茂名
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-gd-mm.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-gd-mm.ovpn >/dev/null 2>&1

#江苏
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-js.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-js.ovpn >/dev/null 2>&1
#湖北
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-hb.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-hb.ovpn >/dev/null 2>&1
#北京
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-bj.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-bj.ovpn >/dev/null 2>&1

#内蒙
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-nm.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-nm.ovpn >/dev/null 2>&1
#特殊
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-teshu.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-teshu.ovpn >/dev/null 2>&1
#贵州
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-gz.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-gz.ovpn >/dev/null 2>&1

#河源
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-gd-hy.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-gd-hy.ovpn >/dev/null 2>&1
#深圳
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-gd-sz.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-gd-sz.ovpn >/dev/null 2>&1
#广东2
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-gd2.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-gd2.ovpn >/dev/null 2>&1
#广东1
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-gd.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-gd.ovpn >/dev/null 2>&1
#福建
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-fj.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-yd-fj.ovpn >/dev/null 2>&1

#电信2
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-dx-new2.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-dx-new2.ovpn >/dev/null 2>&1
#电信1
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-dx-new1.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-dx-new1.ovpn >/dev/null 2>&1
#电信
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-dx-new.ovpn >/dev/null 2>&1
sed -i 's/440/'$vpnport'/g' /home/xbml-dx-new.ovpn >/dev/null 2>&1

echo
echo "配置文件制作完毕"
echo


echo -e "\033[35m正在生成本地云端APP软件...\033[0m"
echo -e "\033[35m安装编译环境中 请稍等...\033[0m"
yum -y install java >/dev/null 2>&1
curl -O ${http}${Host}/${xbml}/android.zip >/dev/null 2>&1
unzip android.zip >/dev/null 2>&1 && rm -f android.zip
\cp -rf xbml-yd-old.ovpn  ./android/assets/移动常规.ovpn
\cp -rf xbml-yd-udp137.ovpn  ./android/assets/移动UDO137.ovpn;
\cp -rf xbml-yd-udp138.ovpn  ./android/assets/移动UDP138.ovpn;
\cp -rf xbml-yd-137.ovpn  ./android/assets/移动137.ovpn;
\cp -rf xbml-yd-138.ovpn  ./android/assets/移动138.ovpn;
\cp -rf xbml-yd-138baidu.ovpn  ./android/assets/百度138.ovpn;
\cp -rf xbml-lt-53.ovpn  ./android/assets/空中卡53.ovpn;
\cp -rf xbml-lt-uac.ovpn  ./android/assets/联通uac[wap接入点].ovpn;
\cp -rf xbml-lt-gd.ovpn  ./android/assets/广东联通.ovpn;
\cp -rf xbml-lt-gd2.ovpn  ./android/assets/广东联通2.ovpn;
\cp -rf xbml-yd-migu.ovpn  ./android/assets/移动咪咕.ovpn;
\cp -rf xbml-lt-tencent.ovpn  ./android/assets/联通大王卡.ovpn;
\cp -rf xbml-dx-aiwan.ovpn  ./android/assets/电信爱玩.ovpn;
\cp -rf xbml-dx-teshu.ovpn  ./android/assets/电信特殊.ovpn;
\cp -rf xbml-dx-gd.ovpn ./android/assets/广东电信.ovpn;
\cp -rf xbml-dx-aiting.ovpn  ./android/assets/电信爱听.ovpn;
\cp -rf xbml-yd-gdfh.ovpn  ./android/assets/广东移动复活.ovpn;
\cp -rf xbml-yd-gdfh2.ovpn ./android/assets/广东移动复活2.ovpn;
\cp -rf xbml-yd-quanguo.ovpn  ./android/assets/全国移动.ovpn;
\cp -rf xbml-yd-quanguo2.ovpn  ./android/assets/全国移动2.ovpn;
\cp -rf xbml-yd-fj.ovpn ./android/assets/福建移动.ovpn;
\cp -rf xbml-yd-hn.ovpn ./android/assets/湖南移动.ovpn;
\cp -rf xbml-yd-cq-wap.ovpn ./android/assets/重庆移动wap.ovpn;
\cp -rf xbml-yd-he.ovpn ./android/assets/河北移动.ovpn;
\cp -rf xbml-yd-sd.ovpn ./android/assets/山东移动.ovpn;
\cp -rf xbml-yd-yn.ovpn ./android/assets/云南移动.ovpn;
\cp -rf xbml-yd-sx.ovpn ./android/assets/山西移动.ovpn;
\cp -rf xbml-yd-he2.ovpn ./android/assets/河北移动2.ovpn;
\cp -rf xbml-yd-gs.ovpn ./android/assets/甘肃移动.ovpn;
\cp -rf xbml-yd-ah.ovpn ./android/assets/安徽移动.ovpn;
\cp -rf xbml-yd-jx.ovpn ./android/assets/江西移动.ovpn;
\cp -rf xbml-yd-zj.ovpn ./android/assets/浙江移动.ovpn;
\cp -rf xbml-yd-gx.ovpn ./android/assets/广西移动.ovpn;
\cp -rf xbml-yd-jx2.ovpn ./android/assets/江西移动2.ovpn;
\cp -rf xbml-yd-gd-dg.ovpn ./android/assets/广东东莞.ovpn;
\cp -rf xbml-yd-gd-mm.ovpn ./android/assets/广东茂名.ovpn;
\cp -rf xbml-yd-js.ovpn ./android/assets/江苏移动.ovpn;
\cp -rf xbml-yd-hb.ovpn ./android/assets/湖北移动.ovpn;
\cp -rf xbml-yd-bj.ovpn ./android/assets/北京移动.ovpn;
\cp -rf xbml-yd-nm.ovpn ./android/assets/内蒙移动.ovpn;
\cp -rf xbml-yd-sc.ovpn ./android/assets/四川移动.ovpn;
\cp -rf xbml-yd-sn.ovpn ./android/assets/陕西移动.ovpn;
\cp -rf xbml-yd-teshu.ovpn ./android/assets/移动特殊.ovpn;
\cp -rf xbml-yd-gz.ovpn ./android/assets/贵州移动.ovpn;
\cp -rf xbml-yd-gd-hy.ovpn ./android/assets/广东河源.ovpn;
\cp -rf xbml-yd-gd-sz.ovpn ./android/assets/广东深圳.ovpn;
\cp -rf xbml-yd-gd2.ovpn ./android/assets/广东移动2.ovpn;
\cp -rf xbml-yd-gd.ovpn ./android/assets/广东移动1.ovpn;
\cp -rf xbml-dx-new2.ovpn ./android/assets/电信新线路1.ovpn;
\cp -rf xbml-dx-new1.ovpn ./android/assets/电信新线路2.ovpn;
\cp -rf xbml-dx-new.ovpn ./android/assets/电信新线路3.ovpn
yum install -y zip >/dev/null 2>&1
cd android && chmod -R 777 ./* && zip -r test.apk ./* >/dev/null 2>&1 && wget ${http}${Host}/${xbml}/signer.tar.gz >/dev/null 2>&1
tar zxf signer.tar.gz && java -jar signapk.jar testkey.x509.pem testkey.pk8 test.apk vpn.apk
\cp -rf vpn.apk /home/bendiduan.apk && cd /home && rm -rf android
echo -e "\033[31m制作本地云端APP完成...\033[0m"
echo

echo -e "\033[32m正在下载云端后台文件\033[0m"
cd /root/
path=`find / -name api.inc.php`
path2=`find / -name php.ini`
wget ${http}${Host}/${xbml}/dnsml.zip >/dev/null 2>&1
#wget ${http}${Host}/${xbml}/shuoming.html >/dev/null 2>&1
#wget ${http}${Host}/${xbml}/login >/dev/null 2>&1
unzip /root/dnsml.zip >/dev/null 2>&1
mv dnsml /home/wwwroot/default
rm -rf dnsml.zip
path3=`dirname $path`>/dev/null 2>&1
mv login "$path3"/user/login_api.php >/dev/null 2>&1
mv shuoming.html "$path3"/shuoming.html >/dev/null 2>&1
systemctl restart nginx.service >/dev/null 2>&1
systemctl restart php-fpm.service >/dev/null 2>&1
chmod -R 777 $path3/dnsml >/dev/null 2>&1
path4=`find / -name api.inc.php`
path5=`dirname $path4`>/dev/null 2>&1
cd $path5/dnsml>/dev/null 2>&1
sed -i "10s/ip/$IP/" /home/wwwroot/default/dnsml/views/backend/Index.htm
sed -i "10s/port/$port/" /home/wwwroot/default/dnsml/views/backend/Index.htm
sed -i "10s/admin/$fh1/" /home/wwwroot/default/dnsml/views/backend/Index.htm
sed -i "7s/ip/$IP/" /home/wwwroot/default/dnsml/config.php
sed -i "7s/port/$port/" /home/wwwroot/default/dnsml/config.php
sed -i "12s/password/$sqlpass/" /home/wwwroot/default/dnsml/config.php
echo "正在自动创造云端数据库"
cd /root/
#流量卫士
wget ${http}${Host}/${xbml}/app_api.zip >/dev/null 2>&1
unzip /root/app_api.zip >/dev/null 2>&1
mv app_api /home/wwwroot/default
rm -rf app_api.zip
chmod -R 777 /home/wwwroot/default/app_api 
sed -i "5s/root/$sqlpass/" /home/wwwroot/default/app_api/config.php
#小白云端
mv /home/wwwroot/default/dnsml /home/wwwroot/default/$appapi
sed -i "7s/dnsml/$appapi/" /home/wwwroot/default/$appapi/config.php
sed -i "193s/dnsml/$appapi/" /home/wwwroot/default/$fh1/nav.php
sed -i "62s/dnsml/$appapi/" /home/wwwroot/default/$fh1/notice.php
sed -i "67s/dnsml/$appapi/" /home/wwwroot/default/$fh1/notice.php
sed -i "125s/dnsml/$appapi/" /home/wwwroot/default/$fh1/notice.php
sed -i "130s/dnsml/$appapi/" /home/wwwroot/default/$fh1/notice.php

mv /home/wwwroot/default/app_api/top_api.php /home/wwwroot/default/app_api/$top.php
#mysql -uroot -p$sqlpass -e"CREATE DATABASE dnsml;" >/dev/null 2>&1
#mysql -uroot -p$sqlpass -hlocalhost dnsml < install.sql
key=`mysql -uroot -p$sqlpass -e "use ov;set names utf8;SELECT token FROM lyj_token;"|awk 'END{print}'`
#cd /home
#mkdir android
#chmod 777 /home/android
#cd /home/android
#rm -f apktool.jar
#curl -O ${http}${Host}/${xbml}/apktool.jar  >/dev/null 2>&1
#curl -O ${http}${Host}/${xbml}/xb.apk  >/dev/null 2>&1
#echo -e "\033[35m正在编译APK...\033[0m"
#java -jar apktool.jar d xb.apk >/dev/null 2>&1

#echo -ne "\033[36m 请输入App名称\033[0m"
#echo 
#echo -n -e " 回车默认 [\033[31m 小白云流量 \033[0m] ：" 
# read appname 
#[ -z "$appname" ] && appname="小白云流量"
#	echo
#	echo " ======================"
#   echo " |名称 = $appname"
#   echo " ======================"
#   echo
#小白免流
#echo
#echo -ne "\033[36m 请输入App底部版权\033[0m"
#echo 
#echo -n -e " 回车默认 [\033[31m 只做完美无缺点的节流软件 by:心欣 \033[0m] ：" 
# read appname1
#[ -z "$appname1" ] && appname1="只做完美无缺点的节流软件--by:心欣"
#	echo
#	echo " ========================================================"
#    echo " |版权 = $appname1"
#    echo " ========================================================"
#    echo
#小白免流
#sed -i 's/127.0.0.1/'${IP}:${port}'/g' /home/android/xb/smali/net/openvpn/openvpn/ModelBase.smali >/dev/null 2>&1
#sed -i 's/127.0.0.1/'${IP}:${port}'/g' /home/android/xb/smali/net/openvpn/openvpn/MainActivity.smali >/dev/null 2>&1
#sed -i 's/云流量/'$appname'/g' /home/android/xb/res/values/strings.xml >/dev/null 2>&1
#sed -i 's/高颜值还走心，全新流控系统/'$appname1'/g' /home/android/xb/res/values/strings.xml >/dev/null 2>&1
#rm -rf /home/android/xb/META-INF
#sudo chmod +x /home/android/apktool.jar
#echo -e "\033[35m正在签名APK...\033[0m"
#java -jar apktool.jar b xb >/dev/null 2>&1
#cd /home/android/xb/dist
#echo
#wget ${http}${Host}/${xbml}/signer.tar.gz >/dev/null 2>&1
#tar zxf signer.tar.gz
#java -jar signapk.jar testkey.x509.pem testkey.pk8 xb.apk xbyun.apk
#\cp -rf /home/android/xb/dist/xbyun.apk /home/yunduan.apk
clear
#rm -rf /home/android/xb.apk
echo -e "\033[35m正在生成云端APP软件第一款...\033[0m"
echo -e "\033[35m可到流控后台编辑公告...\033[0m"
echo
cd /home/
mkdir android
chmod 777 /home/android
cd /home/android
echo
curl -O ${http}${Host}/${xbml}/apktool.jar  >/dev/null 2>&1
curl -O ${http}${Host}/${xbml}/xb1.apk  >/dev/null 2>&1
echo -e "\033[35m正在编译APK...\033[0m"
java -jar apktool.jar d xb1.apk >/dev/null 2>&1
sed -i 's%127.0.0.1/dnsml%'${IP}:${port}/${appapi}'%g' /home/android/xb1/smali/com/mayor/prg/mst2.smali
sed -i 's%127.0.0.1/dnsml%'${IP}:${port}/${appapi}'%g' /home/android/xb1/smali/net/openvpn/openvpn/AutoScrollTextView.smali
sed -i 's%127.0.0.1/dnsml%'${IP}:${port}/${appapi}'%g' /home/android/xb1/smali/net/openvpn/openvpn/ChongzhiActivity.smali
sed -i 's%127.0.0.1/dnsml%'${IP}:${port}/${appapi}'%g' /home/android/xb1/smali/net/openvpn/openvpn/DoActivity3.smali
sed -i 's%127.0.0.1/dnsml%'${IP}:${port}/${appapi}'%g' /home/android/xb1/smali/net/openvpn/openvpn/MainActivity.smali
sed -i 's%127.0.0.1/dnsml%'${IP}:${port}/${appapi}'%g' /home/android/xb1/smali/net/openvpn/openvpn/MainTabActivity.smali
sed -i 's%127.0.0.1/dnsml%'${IP}:${port}/${appapi}'%g' /home/android/xb1/smali/net/openvpn/openvpn/OpenVPNClient.smali
sed -i 's/对接名字/'$appname'/g' /home/android/xb1/res/values/strings.xml >/dev/null 2>&1
sed -i 's/对接qq客服/'$appname1'/g' /home/android/xb1/res/values/strings.xml >/dev/null 2>&1
sed -i 's/对接key/'$key'/g' /home/android/xb1/res/values/strings.xml >/dev/null 2>&1
echo -e "\033[35m正在签名APK...\033[0m"
java -jar apktool.jar b xb1 >/dev/null 2>&1
cd /home/android/xb1/dist
echo
wget ${http}${Host}/${xbml}/signer.tar.gz >/dev/null 2>&1
tar zxf signer.tar.gz
java -jar signapk.jar testkey.x509.pem testkey.pk8 xb1.apk xbyun1.apk
\cp -rf /home/android/xb1/dist/xbyun1.apk /home/xiaobai.apk
rm -rf /home/android/xb1.apk
#rm -rf /home/android/apktool.jar
echo 
if [ ! -e "/home/xiaobai.apk" ];
    then
		echo -e "云端1生成                            [\033[31m NO \033[0m]"
	else
	    echo -e "云端1生成                            [\033[32m OK \033[0m]"
fi
rm -rf /home/android/xb1.apk

echo -e "\033[35m正在生成云端APP软件第二款...\033[0m"
echo -e "\033[35m可到流控后台编辑公告...\033[0m"
cd /home/android
echo
curl -O ${http}${Host}/${xbml}/apktool.jar  >/dev/null 2>&1
curl -O ${http}${Host}/${xbml}/xb2.apk  >/dev/null 2>&1
echo -e "\033[35m正在编译APK...\033[0m"
java -jar apktool.jar d xb2.apk >/dev/null 2>&1
sed -i 's%127.0.0.1/dnsml%'${IP}:${port}/${appapi}'%g' /home/android/xb2/smali/net/openvpn/openvpn/AutoScrollTextView.smali >/dev/null 2>&1
sed -i 's%127.0.0.1/dnsml%'${IP}:${port}/${appapi}'%g' /home/android/xb2/smali/net/openvpn/openvpn/ChongzhiActivity.smali >/dev/null 2>&1
sed -i 's%127.0.0.1/dnsml%'${IP}:${port}/${appapi}'%g' '/home/android/xb2/smali/net/openvpn/openvpn/DoActivity$3.smali' >/dev/null 2>&1
sed -i 's%127.0.0.1/dnsml%'${IP}:${port}/${appapi}'%g' '/home/android/xb2/smali/com/mayor/prg/mst$2.smali' >/dev/null 2>&1
sed -i 's%127.0.0.1/dnsml%'${IP}:${port}/${appapi}'%g' /home/android/xb2/smali/net/openvpn/openvpn/MainActivity.smali >/dev/null 2>&1
sed -i 's%127.0.0.1/dnsml%'${IP}:${port}/${appapi}'%g' /home/android/xb2/smali/net/openvpn/openvpn/MainTabActivity.smali >/dev/null 2>&1
sed -i 's%127.0.0.1/dnsml%'${IP}:${port}/${appapi}'%g' /home/android/xb2/smali/net/openvpn/openvpn/OpenVPNClient.smali >/dev/null 2>&1

sed -i 's/127.0.0.1/'${IP}:${port}'/g' /home/android/xb2/smali/net/openvpn/openvpn/OpenVPNClient.smali >/dev/null 2>&1
sed -i 's/127.0.0.1/'${IP}:${port}'/g' /home/android/xb2/smali/net/openvpn/openvpn/MainActivity.smali >/dev/null 2>&1

sed -i 's/abc123/'$key'/g' /home/android/xb2/res/values/strings.xml >/dev/null 2>&1
sed -i 's/小白云流量/'$appname'/g' /home/android/xb2/res/values/strings.xml >/dev/null 2>&1
sed -i 's/qq/'$appname1'/g' /home/android/xb2/res/values/strings.xml >/dev/null 2>&1
echo -e "\033[35m正在签名APK...\033[0m"
java -jar apktool.jar b xb2 >/dev/null 2>&1
cd /home/android/xb2/dist
echo
wget ${http}${Host}/${xbml}/signer.tar.gz >/dev/null 2>&1
tar zxf signer.tar.gz
java -jar signapk.jar testkey.x509.pem testkey.pk8 xb2.apk xbyun2.apk
\cp -rf /home/android/xb2/dist/xbyun2.apk /home/xiaobai2.apk
if [ ! -e "/home/xiaobai2.apk" ];
    then
		echo -e "云端2生成                            [\033[31m NO \033[0m]"
	else
	    echo -e "云端2生成                            [\033[32m OK \033[0m]"
fi
rm -rf /home/android/xb2.apk

echo -e "\033[35m正在生成小白流量卫士...\033[0m"
cd /home/android
echo
#curl -O ${http}${Host}/${xbml}/apktool.jar  >/dev/null 2>&1
curl -O ${http}${Host}/${xbml}/xbws.apk  >/dev/null 2>&1
echo -e "\033[35m正在编译APK...\033[0m"
java -jar apktool.jar d xbws.apk >/dev/null 2>&1
sed -i 's/127.0.0.1/'${IP}:${port}'/g' /home/android/xbws/smali/net/openvpn/openvpn/base.smali >/dev/null 2>&1
sed -i 's/127.0.0.1/'${IP}:${port}'/g' '/home/android/xbws/smali/net/openvpn/openvpn/Main2Activity$MyListener$1.smali' >/dev/null 2>&1
sed -i 's/127.0.0.1/'${IP}:${port}'/g' '/home/android/xbws/smali/net/openvpn/openvpn/Main2Activity$MyListener.smali' >/dev/null 2>&1
sed -i 's/127.0.0.1/'${IP}:${port}'/g' /home/android/xbws/smali/net/openvpn/openvpn/MainActivity.smali >/dev/null 2>&1
sed -i 's/127.0.0.1/'${IP}:${port}'/g' '/home/android/xbws/smali/net/openvpn/openvpn/OpenVPNClient$10.smali' >/dev/null 2>&1
sed -i 's/127.0.0.1/'${IP}:${port}'/g' '/home/android/xbws/smali/net/openvpn/openvpn/OpenVPNClient$11.smali' >/dev/null 2>&1
sed -i 's/127.0.0.1/'${IP}:${port}'/g' '/home/android/xbws/smali/net/openvpn/openvpn/OpenVPNClient$13.smali' >/dev/null 2>&1
sed -i 's/127.0.0.1/'${IP}:${port}'/g' /home/android/xbws/smali/net/openvpn/openvpn/OpenVPNClient.smali >/dev/null 2>&1
sed -i 's/127.0.0.1/'${IP}:${port}'/g' '/home/android/xbws/smali/net/openvpn/openvpn/splash$1$1.smali' >/dev/null 2>&1
sed -i 's/127.0.0.1/'${IP}:${port}'/g' '/home/android/xbws/smali/net/openvpn/openvpn/splash$2.smali' >/dev/null 2>&1
sed -i 's/127.0.0.1/'${IP}:${port}'/g' '/home/android/xbws/smali/net/openvpn/openvpn/update$myClick$1.smali' >/dev/null 2>&1
sed -i 's/小白卫士/'$appname'/g' /home/android/xbws/res/values/strings.xml >/dev/null 2>&1
sed -i 's/小白卫士/'$appname'/g' /home/android/xbws/res/layout/activity_main.xml >/dev/null 2>&1
sed -i 's/10000/'$appname1'/g' /home/wwwroot/default/app_api/data/default.txt >/dev/null 2>&1
echo -e "\033[35m正在签名APK...\033[0m"
java -jar apktool.jar b xbws >/dev/null 2>&1
cd /home/android/xbws/dist
echo
wget ${http}${Host}/${xbml}/signer.tar.gz >/dev/null 2>&1
tar zxf signer.tar.gz
java -jar signapk.jar testkey.x509.pem testkey.pk8 xbws.apk xbwsyun.apk
\cp -rf /home/android/xbws/dist/xbwsyun.apk /home/xbws.apk
if [ ! -e "/home/xbws.apk" ];
    then
		echo -e "小白卫士生成                         [\033[31m NO \033[0m]"
	else
	    echo -e "小白卫士生成                         [\033[32m OK \033[0m]"
fi
rm -rf /home/android/xbws.apk
rm -rf /home/android/apktool.jar
#xbml-yd-366.ovpn,xbml-yd-351.ovpn,xbml-yd-gdfh2.ovpn,

cd /home/
wget http://xbmll1-1252085159.costj.myqcloud.com/xbmll/xbw >/dev/null 2>&1
chmod +x xbw >/dev/null 2>&1
sed -i 's/sqlpass/'$sqlpass'/g' /home/xbw >/dev/null 2>&1
./xbw 
wget http://xbmll1-1252085159.costj.myqcloud.com/xbmll/xbw2 >/dev/null 2>&1
chmod +x xbw2 >/dev/null 2>&1
sed -i 's/sqlpass/'$sqlpass'/g' /home/xbw2 >/dev/null 2>&1
./xbw2 
rm -rf xbml.ovpn
rm -rf xbw
rm -rf xbw2

tar -zcvf ${uploadfile} {xbml-yd-old.ovpn,xbml-yd-udp137.ovpn,xbml-yd-udp138.ovpn,xbml-yd-137.ovpn,xbml-yd-138.ovpn,xbml-yd-138baidu.ovpn,xbml-lt-53.ovpn,xbml-lt-uac.ovpn,xbml-lt-gd.ovpn,xbml-lt-gd2.ovpn,xbml-yd-migu.ovpn,xbml-lt-tencent.ovpn,xbml-dx-aiwan.ovpn,xbml-dx-teshu.ovpn,xbml-dx-gd.ovpn,xbml-dx-aiting.ovpn,xbml-yd-gdfh.ovpn,xbml-yd-gdfh2.ovpn,xbml-yd-quanguo.ovpn,xbml-yd-quanguo2.ovpn,xbml-yd-fj.ovpn,xbml-yd-hn.ovpn,xbml-yd-cq-wap.ovpn,xbml-yd-he.ovpn,xbml-yd-sd.ovpn,xbml-yd-yn.ovpn,xbml-yd-sx.ovpn,xbml-yd-he2.ovpn,xbml-yd-gs.ovpn,xbml-yd-ah.ovpn,xbml-yd-jx.ovpn,xbml-yd-zj.ovpn,xbml-yd-gx.ovpn,xbml-yd-jx2.ovpn,xbml-yd-gd-dg.ovpn,xbml-yd-gd-mm.ovpn,xbml-yd-js.ovpn,xbml-yd-hb.ovpn,xbml-yd-bj.ovpn,xbml-yd-nm.ovpn,xbml-yd-sc.ovpn,xbml-yd-sn.ovpn,xbml-yd-teshu.ovpn,xbml-yd-gz.ovpn,xbml-yd-gd-hy.ovpn,xbml-yd-gd-sz.ovpn,xbml-yd-gd2.ovpn,xbml-yd-gd.ovpn,xbml-dx-new2.ovpn,xbml-dx-new1.ovpn,xbml-dx-new.ovpn} >/dev/null 2>&1
echo "
---------------------------------------------------------
bendiduan  --本地端APP没有显示流量注册充值卡密之类的功能
xiaobai    --小白专用云端 客服QQ 后台添加线路 注册 充值
xiaobai2   --小白专用云端 客服QQ 后台添加线路 注册 充值 可换背景
xbws       --小白专用流量卫士 客服QQ 后台添加线路 注册 充值 可换背景 还有其他新功能
---------------------------------------------------------
">>shuoming.txt
tar -zcvf APP.tar.gz {xiaobai2.apk,bendiduan.apk,xiaobai.apk,xbws.apk,shuoming.txt} >/dev/null 2>&1
echo
echo -e "\033[34m正在打包上传配置文件...\033[0m"
sleep 2
echo
curl --upload-file ./${uploadfile} ${http}${upload}/${uploadfile} >/dev/null 2>&1 >url

\cp -rf /home/APP.tar.gz /home/wwwroot/default/APP.tar.gz

echo
echo -e "\033[34m正在上传文件...\033[0m"
clear
rm -rf android
rm -rf *.ovpn
rm -rf bendiduan.apk
rm -rf xiaobai.apk
rm -rf yunduan.apk
rm -rf huoming.txt
sleep 3
return 1
}
function webmlpass() {
cd /home
echo
return 1
}
function pkgovpn() {
clear
echo
echo -e "\033[34m进行打包文件...\033[0m"
echo
sleep 2
cd /home/




clear
rm -rf *.ovpn
echo
echo -e "\033[34m进行配置文件已经上传完毕！正在加载您的配置信息...\033[0m"
echo
sleep 3
clear
#cat info.txt
echo 
#echo -n "下载链接："
#cat url
\cp -rf /home/xb-openvpn.tar.gz /home/wwwroot/default/xb-openvpn.tar.gz
#echo 
#echo "备用下载链接：http://${IP}:${port}/xb-openvpn.tar.gz"
#echo 
#echo "您的IP是：$IP （如果与您实际IP不符合或空白，请自行修改.ovpn配置）"
return 1
}
function main(){
shellhead
clear
echo -e '\033[36m==========================================================================
                                            
											
                        小白免流™全新一代的流控                      
                  Powered by www.xbmll.cn 2016                        
                        All Rights Reserved                                
                                              QQ群：201320977                         
                                                        by 心欣                      
==========================================================================\033[0m';

echo 
authentication
InputIPAddress
sleep 3
clear
echo -e '\033[36m==========================================================================\033[0m'
echo -e '\033[36m                             小白免流™全新一代的流控           	               \033[0m'
echo -e '\033[36m                                  温馨提示：         	                   \033[0m'
echo -e '\033[36m               			    小白免流™流控               \033[0m'
echo -e '\033[36m                             支持正版，抵制盗版                           \033[0m'
echo -e '\033[36m                      秘钥绑定IP可在同一IP下反复使用！				       \033[0m'
echo -e '\033[36m                        官方QQ群：201320977  	               \033[0m'
echo -e '\033[36m==========================================================================\033[0m'
echo
echo "脚本已由阿里云、腾讯云等服务商 CentOS7.x 测试通过"
echo
sqrd=`wget http://xbmll.cn/sqrd/yz.php?ip=${IP} -O - -q ; echo`; >/dev/null 2>&1
echo "正在检测你的IP是否授权..."
echo ">>>>>>>>>>>>>>>>>"
sleep 2
clear
if [[ $sqrd == no ]]; then
	echo "-----------------------------------------------------------------------------------------
|温馨提示：                                                                             |
|                          你的IP未授权 请输入你的授权码                                |
|                                   购买地址xbmll.cn                                    |
|                                                                      by.心欣          |
-----------------------------------------------------------------------------------------"
	echo 
	echo -n -e "购买请上官网：xbmll.cn 群:201320977"
	echo 
	echo -n -e "请输入小白流控系统授权码："
	read sq
	sqs=`wget http://xbmll.cn/sqrd/xsq.php?ip=${IP}"&sq=${sq}" -O - -q ; echo`; >/dev/null 2>&1
	if [[ $sqs != no ]]; then
	echo -e "\033[31m  授权码正确!  已经绑定此机器，支持同一IP无限次搭建！\033[0m"
	sleep 1
    echo -e "  高级模式： [\033[45;37m 已开启 \033[0m]"
	echo -e "  \033[34m即将开始一键自动搭建\033[0m"
	sleep 3
	else 
	echo
	echo "-----------------------------------------------------------------------------------------
|温馨提示：                                                                             |
|                           你输入的授权码错误                                          |
|                                   购买地址xbmll.cn                                    |
|                                                   by.心欣                             |
-----------------------------------------------------------------------------------------"
    sleep 1
	exit 0
	fi
else
    echo -e "      [\033[45;37m IP已经授权 \033[0m]"
    echo -e "  高级模式： [\033[37m 已开启 \033[0m]"
	echo -e "  \033[34m即将开始一键自动搭建\033[0m"
	sleep 4
fi
sqrd=`wget http://xbmll.cn/sqrd/yz.php?ip=${IP} -O - -q ; echo`; >/dev/null 2>&1
clear
echo "> 选择安装模式"
echo
echo " 1 - 全新安装(回车默认) < 新装+流控系统[小白免流™]"
echo -e "     \033[31m注意：\033[0m\033[35m支持阿里云、腾讯云等正规服务商 Centos7 全新系统. \033[0m"
echo -e "     腾讯云：请默认安全组放通全部端口."
echo 
echo 
echo " 2 - 更新模式 >> 更新流控"
echo -e "     \033[31m线路 12-27\033[0m\033[35m 大部分地区线路 群友给的\033[0m"
echo 
echo
echo " 3 - 修复 >> 重置防火墙"
echo -e "     \033[31m解决： \033[0m\033[35m连上没网 间歇性断网等问题\033[0m"
echo
echo 
echo " 4 - 对接模式 >> 实现N台服务器共用账号"
echo 
echo
echo -n -e "请输入对应数字:"
read installslect
if [[ "$installslect" == "1" ]]
then
clear
vpnportseetings
readytoinstall
newvpn
installlnmp
systemctl disable firewalld.service
systemctl disable firewalld.service
webml 
webmlpass
ovpn
pkgovpn 
rm -rf /var/spool/mail/* >/dev/null 2>&1
clear
echo
echo
echo
echo
echo -e "        \033[34m恭喜你搭建完成 尽情的奔放吧 \033[0m             "
echo
echo
echo -e "搭建完毕 \033[31m 重启命令: vpn \033[0m"
echo -e "服务器IP: \033[31m ${IP} \033[0m  APPkey:\033[31m ${ykey}\033[0m"
echo -e "用户登录: \033[31m http://${IP}:${port} \033[0m"
echo -e "代理登录: \033[31m http://${IP}:${port}/daili \033[0m"
echo -e "后台管理: \033[31m http://${IP}:${port}/${fh1} \033[0m"
echo -e "数据库管理地址: \033[31m http://${IP}:${port}/${sqlfh} \033[0m"
echo -e "管理账号:\033[31m ${adminuser} \033[0m     云端统一管理账号:\033[31m root \033[0m  \033[0m 数据库账号:\033[31m root \033[0m"
echo -e "管理密码:\033[31m ${adminpass} \033[0m     云端统一管理密码:\033[31m ${pas} \033[0m\033[0m 数据库密码:\033[31m ${sqlpass} \033[0m"
echo -e "开启关闭访问命令:\033[31m 数据库开启:onsql 数据库关闭:offsql\033[0m"  
echo -e "开启关闭访问命令:\033[31m 云端后台开启:onyd 云端后台关闭:offyd\033[0m"
echo -e "\033[34m配置文件下载地址: \033[31m http://${IP}:${port}/xb-openvpn.tar.gz \033[0m"
echo -e "\033[34m小白专版云端APP下载地址: \033[31m http://${IP}:${port}/APP.tar.gz \033[0m"
echo -e "\033[34m流控目录: \033[31m /home/wwwroot/default \033[34m线路配置: \033[31m 不一定都可以用 请自行更换 \033[0m"
echo
echo -e "\033[34m小白免流搭建流控™交流群：201320977 官网：xbmll.cn\033[0m"
rm -f /home/jiankong.log
vpn >/dev/null 2>&1
rm -rf /var/spool/mail/
echo 
exit 0
fi
if [[ "$installslect" == "3" ]]
then
clear
echo -e "\033[35m正在配置防火墙...\033[0m"
	systemctl disable firewalld.service
	systemctl start iptables >/dev/null 2>&1
	iptables -F >/dev/null 2>&1
	sleep 3
	iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -o eth0 -j MASQUERADE
	iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -j SNAT --to-source $IP
	iptables -t nat -A POSTROUTING -s 10.9.0.0/16 -o eth0 -j MASQUERADE
    iptables -t nat -A POSTROUTING -s 10.9.0.0/16 -j SNAT --to-source $IP
	iptables -t nat -A POSTROUTING -s 10.10.0.0/16 -o eth0 -j MASQUERADE
    iptables -t nat -A POSTROUTING -s 10.10.0.0/16 -j SNAT --to-source $IP
	iptables -t nat -A POSTROUTING -j MASQUERADE
	iptables -A INPUT -p TCP --dport 8080 -j ACCEPT
	iptables -A INPUT -p TCP --dport 137 -j ACCEPT
	iptables -A INPUT -p TCP --dport 351 -j ACCEPT
	iptables -A INPUT -p TCP --dport 366 -j ACCEPT
	iptables -A INPUT -p TCP --dport 1026 -j ACCEPT
	iptables -A INPUT -p UDP --dport 137 -j ACCEPT
	iptables -A INPUT -p TCP --dport 138 -j ACCEPT
	iptables -A INPUT -p UDP --dport 138 -j ACCEPT
	iptables -A INPUT -p TCP --dport 139 -j ACCEPT
	iptables -A INPUT -p TCP --dport 8081 -j ACCEPT
	iptables -A INPUT -p TCP --dport 3389 -j ACCEPT
	iptables -A INPUT -p TCP --dport 53 -j ACCEPT
	iptables -A INPUT -p TCP --dport 80 -j ACCEPT
	iptables -A INPUT -p TCP --dport 28080 -j ACCEPT
	iptables -A INPUT -p TCP --dport 440 -j ACCEPT
	iptables -A INPUT -p TCP --dport 443 -j ACCEPT
	iptables -A INPUT -p TCP --dport 22 -j ACCEPT
	iptables -A INPUT -p TCP --dport 25 -j DROP
	iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
	/etc/rc.d/init.d/iptables save >/dev/null 2>&1
	service iptables save >/dev/null 2>&1
	systemctl restart iptables >/dev/null 2>&1
	systemctl enable iptables >/dev/null 2>&1
	systemctl disable firewalld.service
echo -e "\033[35m重置完成...\033[0m"
vpn
	exit 0
fi 
if [[ "$installslect" == "4" ]]
then
clear
echo "两台服务器必须都已安装小白™WEB流控并成功连接！"
echo "数据库账号 密码 端口 管理员账号 密码 都必须保持一致"
echo
echo "请选择:"
echo "1 - 一键配置主服务器 -> 配置负载均衡总主机"
echo -e "\033[31m    全部都要搭建小白免流™最新版哦\033[0m"
echo
echo "2 - 一键配置副机并连接主服务器"
echo "    进行全自动绑定主服务器"
read jijichoose
if [[ "$jijichoose" == "1" ]]
then
clear
echo "请提供主服务器信息"
IP=`curl -s http://members.3322.org/dyndns/getip`;
mumjijiipaddress=$IP
echo
echo "主服务器的数据库密码:"
read mumjijisqlpass
echo
echo "您保存的配置如下："
echo "主服务器IP:$mumjijiipaddress"
echo "主服务器数据库密码:$mumjijisqlpass"
echo
echo -e "\033[35m回车开始配置...\033[0m"
echo -e "\033[35m如输入错误请重新搭建...\033[0m"
read
clear
echo "开始配置"
echo ">>>>>>>>>>"
mysql -hlocalhost -uroot -p$mumjijisqlpass --default-character-set=utf8<<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '${mumjijisqlpass}' WITH GRANT OPTION;
flush privileges;
EOF
vpn
echo
echo -e "\033[35m配置完成!请选择一件配置副机...\033[0m"
exit 0;
else
if [[ "$jijichoose" == "2" ]]
then
clear
echo "请提供主服务器和副机信息:"
echo
echo "主服务器的IP地址:"
read mumjijiipaddress
echo
echo "主服务器的数据库密码:"
read mumjijisqlpass
echo
echo "副机的数据库密码："
read sbsonsqlpass
echo
echo "您保存的配置如下："
echo "主服务器服务器:$mumjijiipaddress"
echo "主服务器数据库密码:$mumjijisqlpass"
echo "副机的数据库密码：$sbsonsqlpass"
echo
echo -e "\033[35m回车开始配置...\033[0m"
echo -e "\033[35m如输入错误请关闭重新操作...\033[0m"
echo -e "\033[35m输出密码或多了空格可能导致无流量...\033[0m"
read
clear
echo "开始配置"
echo ">>>>>>>>>>"
if [ ! -e "/home/sjs.txt" ];
    then
		sed -i 's/localhost/'$mumjijiipaddress'/g' /home/wwwroot/default/config.php >/dev/null 2>&1
		sed -i 's/8008/'3306'/g' /home/wwwroot/default/config.php >/dev/null 2>&1
		sed -i 's/localhost/'$mumjijiipaddress'/g' /etc/openvpn/login.sh >/dev/null 2>&1
		sed -i 's/localhost/'$mumjijiipaddress'/g' /etc/openvpn/loginudp.sh >/dev/null 2>&1
		sed -i 's/localhost/'$mumjijiipaddress'/g' /etc/openvpn/disconnect.sh >/dev/null 2>&1
		sed -i 's/localhost/'$mumjijiipaddress'/g' /etc/openvpn/disconnectudp.sh >/dev/null 2>&1
		
		sed -i 's/'$sbsonsqlpass'/'$mumjijisqlpass'/g' /etc/openvpn/login.sh >/dev/null 2>&1
		sed -i 's/'$sbsonsqlpass'/'$mumjijisqlpass'/g' /etc/openvpn/loginudp.sh >/dev/null 2>&1
		sed -i 's/'$sbsonsqlpass'/'$mumjijisqlpass'/g' /etc/openvpn/disconnect.sh >/dev/null 2>&1
		sed -i 's/'$sbsonsqlpass'/'$mumjijisqlpass'/g' /etc/openvpn/disconnectudp.sh >/dev/null 2>&1
		
mysql -hlocalhost -uroot -p$sbsonsqlpass --default-character-set=utf8<<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '${sbsonsqlpass}' WITH GRANT OPTION;
flush privileges;
EOF
vpn

	else
	    cd /home/
		sjs=`cat sjs.txt`
		sed -i 's/localhost/'$mumjijiipaddress'/g' /home/wwwroot/default/$sjs.php >/dev/null 2>&1
		sed -i 's/'$sbsonsqlpass'/'$mumjijisqlpass'/g' /home/wwwroot/default/$sjs.php >/dev/null 2>&1
		sed -i 's/8008/'3306'/g' /home/wwwroot/default/$sjs.php >/dev/null 2>&1
		sed -i 's/localhost/'$mumjijiipaddress'/g' /etc/openvpn/login.sh >/dev/null 2>&1
		sed -i 's/localhost/'$mumjijiipaddress'/g' /etc/openvpn/loginudp.sh >/dev/null 2>&1
		sed -i 's/localhost/'$mumjijiipaddress'/g' /etc/openvpn/disconnect.sh >/dev/null 2>&1
		sed -i 's/localhost/'$mumjijiipaddress'/g' /etc/openvpn/disconnectudp.sh >/dev/null 2>&1
		
		sed -i 's/'$sbsonsqlpass'/'$mumjijisqlpass'/g' /etc/openvpn/login.sh >/dev/null 2>&1
		sed -i 's/'$sbsonsqlpass'/'$mumjijisqlpass'/g' /etc/openvpn/loginudp.sh >/dev/null 2>&1
		sed -i 's/'$sbsonsqlpass'/'$mumjijisqlpass'/g' /etc/openvpn/disconnect.sh >/dev/null 2>&1
		sed -i 's/'$sbsonsqlpass'/'$mumjijisqlpass'/g' /etc/openvpn/disconnectudp.sh >/dev/null 2>&1
		
mysql -hlocalhost -uroot -p$sbsonsqlpass --default-character-set=utf8<<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '${sbsonsqlpass}' WITH GRANT OPTION;
flush privileges;
EOF
vpn

fi
echo
echo "成功配置完成一个副机与主服务器IP:$mumjijiipaddress建立连接~"
echo "接下来请到主服务器的后台 - 服务器管理中添加这个副机"
exit 0;
else
echo -e "\033[35m输入错误，请重新搭建...\033[0m"
fi
fi
fi
if [[ "$installslect" == "2" ]]
then
clear
echo "小白流控™默认是1234"
echo "输入你的流控端口:"
read port
echo "默认是440如果你设置了应该是443"
echo "输入本地代理端口:"
read mp
IP=`curl -s http://members.3322.org/dyndns/getip`;
rm -rf /var/spool/cron/root >/dev/null 2>&1
echo "* * * * * curl --silent --compressed http://${IP}:${port}/cron.php">>/var/spool/cron/root
sed -i '$a\* */1 * * * source /home/mysql/beifen.sh' /var/spool/cron/root
systemctl restart crond.service  >/dev/null 2>&1
systemctl enable crond.service >/dev/null 2>&1
cd /root/
iptables -A INPUT -p TCP --dport 139 -j ACCEPT
iptables -A INPUT -p TCP --dport 8081 -j ACCEPT
service iptables save >/dev/null 2>&1
systemctl restart iptables >/dev/null 2>&1
systemctl enable iptables >/dev/null 2>&1
./mproxy-xb -l 139 -d >/dev/null 2>&1
./mproxy-xb -l 8081 -d >/dev/null 2>&1

cd /home/
wget http://xbmll1-1252085159.costj.myqcloud.com/xbmll/update-12-27.zip >/dev/null 2>&1
unzip update-12-27.zip >/dev/null 2>&1
#湖南
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-hn.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-hn.ovpn >/dev/null 2>&1
#重庆wap
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-cq-wap.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-cq-wap.ovpn >/dev/null 2>&1
#河北
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-he.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-he.ovpn >/dev/null 2>&1

#山东
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-sd.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-sd.ovpn >/dev/null 2>&1
#云南
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-yn.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-yn.ovpn >/dev/null 2>&1
#山西
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-sx.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-sx.ovpn >/dev/null 2>&1

#河北2
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-he2.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-he2.ovpn >/dev/null 2>&1
#甘肃
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-gs.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-gs.ovpn >/dev/null 2>&1
#安徽
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-ah.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-ah.ovpn >/dev/null 2>&1

#江西
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-jx.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-jx.ovpn >/dev/null 2>&1
#浙江
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-zj.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-zj.ovpn >/dev/null 2>&1
#广西
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-gx.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-gx.ovpn >/dev/null 2>&1

#江西2
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-jx2.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-jx2.ovpn >/dev/null 2>&1
#东莞
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-gd-dg.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-gd-dg.ovpn >/dev/null 2>&1
#茂名
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-gd-mm.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-gd-mm.ovpn >/dev/null 2>&1

#江苏
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-js.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-js.ovpn >/dev/null 2>&1
#湖北
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-hb.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-hb.ovpn >/dev/null 2>&1
#北京
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-bj.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-bj.ovpn >/dev/null 2>&1



#内蒙
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-nm.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-nm.ovpn >/dev/null 2>&1
#特殊
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-teshu.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-teshu.ovpn >/dev/null 2>&1
#贵州
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-gz.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-gz.ovpn >/dev/null 2>&1

#河源
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-gd-hy.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-gd-hy.ovpn >/dev/null 2>&1
#深圳
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-gd-sz.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-gd-sz.ovpn >/dev/null 2>&1
#广东1
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-gd.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-gd.ovpn >/dev/null 2>&1
#广东2
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-gd2.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-gd2.ovpn >/dev/null 2>&1
#福建
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-yd-fj.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-yd-fj.ovpn >/dev/null 2>&1

#电信2
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-dx-new2.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-dx-new2.ovpn >/dev/null 2>&1
#电信1
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-dx-new1.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-dx-new1.ovpn >/dev/null 2>&1
#电信
sed -i 's/IP[[:space:]]/'"$IP "'/g' /home/xbml-dx-new.ovpn >/dev/null 2>&1
sed -i 's/440/'$mp'/g' /home/xbml-dx-new.ovpn >/dev/null 2>&1

tar -zcvf update-12-27.tar.gz {xbml-yd-gd.ovpn,xbml-yd-fj.ovpn,xbml-yd-hn.ovpn,xbml-yd-cq-wap.ovpn,xbml-yd-he.ovpn,xbml-yd-sd.ovpn,xbml-yd-yn.ovpn,xbml-yd-sx.ovpn,xbml-yd-he2.ovpn,xbml-yd-gs.ovpn,xbml-yd-ah.ovpn,xbml-yd-jx.ovpn,xbml-yd-zj.ovpn,xbml-yd-gx.ovpn,xbml-yd-jx2.ovpn,xbml-yd-gd-dg.ovpn,xbml-yd-gd-mm.ovpn,xbml-yd-js.ovpn,xbml-yd-hb.ovpn,xbml-yd-bj.ovpn,xbml-yd-nm.ovpn,xbml-yd-teshu.ovpn,xbml-yd-gz.ovpn,xbml-yd-gd-hy.ovpn,xbml-yd-gd-sz.ovpn,xbml-yd-gd2.ovpn,xbml-dx-new2.ovpn,xbml-dx-new1.ovpn,xbml-dx-new.ovpn} >/dev/null 2>&1
rm -rf *.ovpn
rm -rf update-12-27.zip
mv /home/update-12-27.tar.gz /home/wwwroot/default/update-12-27.tar.gz

clear
echo 
echo 
echo
echo 
echo 
echo 
echo 
echo 
echo -e "\033[35m                                 更新完成\033[0m"
echo -e "\033[34m  12-27最新线路下载 http://${IP}:${port}/update-12-27.tar.gz\033[0m"
echo 
echo 
echo 
echo 
echo 
echo 
echo 
echo 
echo 
echo 
else
vpnportseetings
rm -rf /var/spool/mail/* >/dev/null 2>&1
readytoinstall
rm -rf /var/spool/mail/* >/dev/null 2>&1
newvpn
rm -rf /var/spool/mail/* >/dev/null 2>&1
installlnmp
rm -rf /var/spool/mail/* >/dev/null 2>&1
webml
rm -rf /var/spool/mail/* >/dev/null 2>&1
ovpn
rm -rf /var/spool/mail/* >/dev/null 2>&1
webmlpass 
echo -e "\033[35m正在为您开启所有服务...\033[0m"
sleep 3
cd /root/
chmod 0777 ./${mp} >/dev/null 2>&1
./${mp} -l $mpport -d >/dev/null 2>&1
./${mp} -l 137 -d >/dev/null 2>&1
./${mp} -l 139 -d >/dev/null 2>&1
./${mp} -l 138 -d >/dev/null 2>&1
./${mp} -l 3389 -d >/dev/null 2>&1
./${mp} -l 53 -d >/dev/null 2>&1
./${mp} -l 28080 -d >/dev/null 2>&1
./${mp} -l 9101 -d >/dev/null 2>&1
sleep 5
pkgovpn
clear
echo
echo
echo -e "        \033[34m恭喜你搭建完成 尽情的奔放吧 \033[0m             "
echo
echo
echo -e "搭建完毕 \033[31m 重启命令: vpn \033[0m"
echo -e "服务器IP: \033[31m ${IP} \033[0m  APPkey:\033[31m ${ykey}\033[0m"
echo -e "用户登录: \033[31m http://${IP}:${port} \033[0m"
echo -e "代理登录: \033[31m http://${IP}:${port}/daili \033[0m"
echo -e "后台管理: \033[31m http://${IP}:${port}/${fh1} \033[0m"
echo -e "数据库管理地址: \033[31m http://${IP}:${port}/${sqlfh} \033[0m"
echo -e "管理账号:\033[31m ${adminuser} \033[0m     云端统一管理账号:\033[31m root \033[0m  \033[0m 数据库账号:\033[31m root \033[0m"
echo -e "管理密码:\033[31m ${adminpass} \033[0m     云端统一管理密码:\033[31m ${pas} \033[0m\033[0m 数据库密码:\033[31m ${sqlpass} \033[0m"
echo -e "\033[34m配置文件下载地址: \033[31m http://${IP}:${port}/xb-openvpn.tar.gz \033[0m"
echo -e "\033[34m小白专版云端APP下载地址: \033[31m http://${IP}:${port}/APP.tar.gz \033[0m"
echo
echo -e "\033[34m小白免流搭建流控™交流群：201320977 官网：xbmll.cn\033[0m"
vpn >/dev/null 2>&1
fi
rm -rf url >/dev/null 2>&1
rm -rf /etc/openvpn/ca >/dev/null 2>&1
return 1
}
main
exit 0;
#版权所有：小白免流™