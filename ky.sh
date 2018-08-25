#!/bin/bash

function Kyunhead() {
# 环境变量 *******
clear 
ulimit -c 0
echo && echo 'Loading...'
trap exit SIGTSTP
rm -rf $0
yum install curl net-tools procps-ng -y >/dev/null 2>&1
KyLogo='
=====================================================    
                                     
☆-欢迎使用快云免流第六期流控搭建脚本。
                                                        
☆-Powered by kuaiyum.com 2017 All Rights Reserved                
=====================================================';
YzError='
=====================================================  

☆-你输入的官网验证失败，安装服务被终止          
	           
☆-Powered by kuaiyum.com 2017 All Rights Reserved     
                                         
=====================================================';
HmdLogo='
=====================================================  

☆-由于你的IP在黑名单中，安装服务被终止          
	           
☆-Powered by kuaiyum.com 2017 All Rights Reserved     
                                      
=====================================================';
BuyLogo='
=====================================================                                                                      
             快云免流-全新一代流控系统            
                     温馨提示：                   
    为了您服务器的稳定和安全，请勿非法更新改程序                           
               支持正版，抵制盗版                 
         购买地址：http://kuaiyum.com/buy/        
====================================================='; 
porxy='udp.c';export porxy=$porxy
web='https://';export web=$web
EasyRSA=easy-rsa.zip;export EasyRSA=$EasyRSA
webs='https://';export webs=$webs
O=openvpn-2.3.12-1.el7.x86_64.rpm;export O=$O
KyWEB="WEB_N17-6.0.zip";export KyWEB=$KyWEB
sql=mysql_$RANDOM;export sql=$sql
peizhi='peizhi.zip';export peizhi=$peizhi
phpmyadmin=phpmyadmin.tar.gz;export phpmyadmin=$phpmyadmin
IP=`wget http://members.3322.org/dyndns/getip -O - -q ; echo`;
Host='raw.githubusercontent.com/QHDS/xyr/master/kuaiyun/';export Host=$Host
# Ksq1=`curl -s http://kyun.kuaiyum.com:8888/Check/api.php?act=cx\&ip=$IP`;
# Ksq2=`curl -s http://kyun.kuaiyum.com:8888/Check/api.php?act=hmd\&ip=$IP`;
localserver=`curl -s ip.cn`;fwq=`echo $localserver|awk '{print $4}'`;export fwq=$fwq
wa=`ifconfig`;wb=`echo $wa|awk '{print $1}'`;wangka=${wb/:/};export wangka=$wangka
if test -f /etc/os-release ;then
	OS_VERSION=`cat /etc/os-release |awk -F'[="]+' '/^VERSION_ID=/ {print $2}'`
	if test $OS_VERSION != "7" ;then
		echo -e "\n当前系统版本为：\033[31mCentOS $OS_VERSION\033[0m\n"
		echo "暂不支持该系统安装"
		echo "请更换 CentOS 7.0-7.2 系统进行安装"
		exit 1
	fi
elif [ -f /etc/redhat-release ];then
	OS_VERSION=`cat /etc/redhat-release |grep -Eos '\b[0-9]+\S*\b' |cut -d'.' -f1`
	if test $OS_VERSION != "7" ;then
		echo -e "\n当前系统版本为：\033[31mCentOS $OS_VERSION\033[0m\n"
		echo "暂不支持该系统安装"
		echo "请更换 CentOS 7.0-7.2 系统进行安装"
		exit 1
	fi
else
	echo -e "当前系统版本为：\033[31m未知\033[0m\n"
	echo "暂不支持该系统安装"
	echo "请更换 CentOS 7.0-7.2 系统进行安装"
	exit
	fi
return 1
}

function KyunApp() {
echo && echo "正在准备Java环境..."
if [ ! -e "/usr/bin/java" ];then
  yum install -y java >/dev/null 2>&1
fi
mkdir /home/android 
chmod 0777 -R /home/android 
cd /home/android
# 反编译
echo && echo -e "正在反编译APP..."
wget -q ${web}$Host/apktool.jar 
wget -q ${web}$Host/Kyun.apk 
java -jar apktool.jar d Kyun.apk >/dev/null 2>&1

sed -i 's/'wap.kuaiyum.com:8888'/'${IP}:${webdk}'/g' "/home/android/Kyun/smali/net/openvpn/openvpn/base.smali"
sed -i 's/'wap.kuaiyum.com:8888'/'${IP}:${webdk}'/g' "/home/android/Kyun/smali/net/openvpn/openvpn/OpenVPNClient.smali" 
sed -i 's/'wap.kuaiyum.com:8888'/'${IP}:${webdk}'/g' "/home/android/Kyun/smali/net/openvpn/openvpn/OpenVPNClient\$10.smali" 
sed -i 's/'wap.kuaiyum.com:8888'/'${IP}:${webdk}'/g' "/home/android/Kyun/smali/net/openvpn/openvpn/OpenVPNClient\$11.smali" 
sed -i 's/'wap.kuaiyum.com:8888'/'${IP}:${webdk}'/g' "/home/android/Kyun/smali/net/openvpn/openvpn/OpenVPNClient\$13.smali" 
sed -i 's/'wap.kuaiyum.com:8888'/'${IP}:${webdk}'/g' "/home/android/Kyun/smali/net/openvpn/openvpn/Main2Activity\$MyListener\$1.smali" 
sed -i 's/'wap.kuaiyum.com:8888'/'${IP}:${webdk}'/g' '/home/android/Kyun/smali/net/openvpn/openvpn/Main2Activity$MyListener.smali' 
sed -i 's/'wap.kuaiyum.com:8888'/'${IP}:${webdk}'/g' '/home/android/Kyun/smali/net/openvpn/openvpn/MainActivity.smali' 
sed -i 's/'wap.kuaiyum.com:8888'/'${IP}:${webdk}'/g' '/home/android/Kyun/smali/net/openvpn/openvpn/update$myClick$1.smali'
sed -i 's/'wap.kuaiyum.com:8888'/'${IP}:${webdk}'/g' '/home/android/Kyun/smali/net/openvpn/openvpn/AutoScrollTextView.smali' 
sed -i 's/快云流量/'$appname'/g' "/home/android/Kyun/res/values/strings.xml"
if [[ $img == 'yes' ]];then
  # 图标
  rm -rf /home/android/Kyun/res/drawable-hdpi-v4/icon.png
  rm -rf /home/android/Kyun/res/drawable-mdpi-v4/icon.png
  rm -rf /home/android/Kyun/res/drawable-xhdpi-v4/icon.png
  wget -q -O /home/android/Kyun/res/drawable-xhdpi-v4/icon.png $urlA
  cp /home/android/Kyun/res/drawable-xhdpi-v4/icon.png /home/android/Kyun/res/drawable-mdpi-v4/icon.png
  cp /home/android/Kyun/res/drawable-xhdpi-v4/icon.png /home/android/Kyun/res/drawable-hdpi-v4/icon.png

  # 启动图
  rm -rf /home/android/Kyun/res/drawable/splash.png
  wget -q -O /home/android/Kyun/res/drawable/splash.png $urlB
fi

# 打包
echo && echo -e "正在签名打包APP..."
chmod +x /home/android/apktool.jar
java -jar apktool.jar b Kyun >/dev/null 2>&1
cd /home/android/Kyun/dist
wget -q ${web}$Host/signer.tar.gz 
tar zxf signer.tar.gz
java -jar signapk.jar testkey.x509.pem testkey.pk8 Kyun.apk Kyunws.apk >/dev/null 2>&1
cp -rf /home/android/Kyun/dist/Kyunws.apk /Data/wwwroot/Kyun/user/app/app.apk
rm -rf /home/*
return 1
}

function KyunClear() {
clear
echo -e "你需要自定义一些信息 [密码请尽量复杂]"
# 管理员账号
echo
echo -n -e "请输入管理员账号 [默认：admin ]"
read adminuser
if [ -z $adminuser ]
then
	adminuser=admin
	echo -e "\033[1;34m管理员账号已设置为：\033[32m $adminuser \033[0m" ;
else
	echo -e "\033[1;34m管理员账号已设置为：\033[32m $adminuser \033[0m"
fi

# 管理员密码
echo
echo -n -e "请输入管理员密码 [默认：admin ]"
read adminpass
if [ -z $adminpass ]
then
	adminpass=admin
	echo -e "\033[1;34m管理员密码已设置为：\033[32m $adminpass \033[0m" ;
else
	echo -e "\033[1;34m管理员密码已设置为：\033[32m $adminpass \033[0m"
fi

# 本地二级密码
echo
echo -n -e "请输入本地二级密码 [默认：admin ]"
read admintwopass
if [ -z $admintwopass ]
then
	admintwopass=admin
	echo -e "\033[1;34m本地二级密码已设置为：\033[32m $admintwopass \033[0m" ;
else
	echo -e "\033[1;34m本地二级密码已设置为：\033[32m $admintwopass \033[0m"
fi

# 数据库密码
echo
echo -n -e "请输入数据库密码 [默认：kuaiyum ]"
read sqlpass
if [ -z $sqlpass ]
then
	sqlpass=kuaiyum
	echo -e "\033[1;34m数据库密码已设置为：\033[32m $sqlpass \033[0m" ;
else
	echo -e "\033[1;34m数据库密码已设置为：\033[32m $sqlpass \033[0m"
fi

# WEB端口
echo
echo -n -e "请输入后台端口 [默认：8888 ]"
read webdk
if [ -z $webdk ]
then
	webdk=8888
	echo -e "\033[1;34m后台WEB端口已设置为：\033[32m $webdk \033[0m" ;
else
	echo -e "\033[1;34m后台WEB端口已设置为：\033[32m $webdk \033[0m"
fi

# 管理后台名称
echo
echo -n -e "请输入流量平台名称 [默认:快云免流 ]"
read adminname
if [ -z $adminname ]
then
	adminname=快云免流
	echo -e "\033[1;34m流量平台名称已设置为：\033[32m $adminname \033[0m" ;
else
	echo -e "\033[1;34m流量平台名称已设置为：\033[32m $adminname \033[0m"
fi

# APP软件名称
echo
echo -n -e "请输入云端软件名称 [默认:快云流量 ]"
read appname
if [ -z $appname ]
then
	appname=快云流量
	echo -e "\033[1;34m云端软件名称已设置为：\033[32m $appname \033[0m" ;
else
	echo -e "\033[1;34m云端软件名称已设置为：\033[32m $appname \033[0m"
fi

# APP软件客服
echo
echo -n -e "请输入APP客服QQ [默认:Fyue/飞跃QQ ]"
read adminqq
if [ -z $adminqq ]
then
	adminqq=1797106720
	echo -e "\033[1;34mAPP客服QQ已设置为：\033[32m $adminqq \033[0m" ;
else
	echo -e "\033[1;34mAPP客服QQ已设置为：\033[32m $adminqq \033[0m"
fi
echo
echo -n -e "你想自定义APP图标和启动图吗？(y/n)："
read userimg
if [[ $userimg == 'y' || $userimg == 'Y' ]];then
img=yes
# APP软件图标
echo
echo -n -e "请输入APP图标地址 [默认:快云Logo图标 ]"
read urlA
if [ -z $urlA ]
then 
    img=no
	echo -e "\033[1;34mAPP图标地址已设置为：\033[32m 快云Logo图标 \033[0m" ;
else
	echo -e "\033[1;34mAPP图标地址已设置为：\033[32m $urlA \033[0m"
fi

# APP启动图
echo
echo -n -e "请输入APP启动图地址 [默认:快云启动图 ]"
read urlB
if [ -z $urlB ]
then 
    img=no
	echo -e "\033[1;34mAPP启动图地址已设置为：\033[32m 快云启动图 \033[0m" ;
else
	echo -e "\033[1;34mAPP启动图地址已设置为：\033[32m $urlB \033[0m"
fi
else
img=no
fi
sleep 0.5
clear
echo -e "\033[1;34m好啦！自定义信息已全部收集完毕，脚本将全自动完成下面步骤
给你两分钟时间去群里装个逼,或者狠狠撸一发( www.52avav.com )\033[0m"
echo
echo -n -e "\033[1;34m回车开始快云免流独家两分钟极速安装 \033[0m"
read
clear 
NowV=`uname -r`
if [ $NowV != '4.13.7-1.el7.elrepo.x86_64' ];then
  if [ ! -e "/opt/BBR_elrepo_install" ];then
     echo -e "系统检测到你的服务器不是最新版内核4.13.7-1.el7.elrepo.x86_64\n开始为你升级服务器内核(大概需要1~2分钟时间,根据服务器性能决定快慢)"
     rpm --import https://elrepo.org/RPM-GPG-KEY-elrepo.org
     rpm -Uvh https://elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
     yum --enablerepo=elrepo-kernel -y install kernel-ml kernel-ml-devel
     grub2-set-default 0
     echo 'kuaiyum.com'>>/opt/BBR_elrepo_install
     echo '恭喜你升级内核完成，骚后我们将帮你开启BBR加速，手动重启服务器即可生效'
  else
	 echo -e "\033[34m---------------------------------------------\n\n你已经升级过内核啦，请手动重启服务器即可生效\n\n---------------------------------------------\033[0m"
  fi
  sleep 2
fi
clear
echo -e "开始整理安装环境..."
CURTIME=`date +"%Y-%m-%d %H:%M:%S"`; #获取开始时间
yum install psmisc -y >/dev/null 2>&1
rm -rf /Data 
rm -rf /etc/Kyun
rm -rf /home/*
rm -rf /etc/openvpn 
rm -rf /root/*
rm -rf /bin/Ky 
rm -rf /bin/Kps
rm -rf /etc/rc.local
rm -rf /var/lib/mysql
rm -rf /bin/K666
rm -rf /etc/yum.repos.d/CentOS-Base.repo.bak
killall K666 >/dev/null 2>&1  
killall Ky >/dev/null 2>&1  
killall Kps >/dev/null 2>&1   
systemctl stop httpd.service >/dev/null 2>&1   
systemctl stop mariadb.service >/dev/null 2>&1  
systemctl stop openvpn@server-*.service >/dev/null 2>&1  
yum remove -y openvpn httpd mariadb-server mariadb >/dev/null 2>&1 
yum remove -y php php-mysql php-gd libjpeg* php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-bcmath php-mhash php-fpm >/dev/null 2>&1
echo && echo -e "正在更换安装源..."
if [[ $fwq != '阿里云'  ||  $fwq != '腾讯云'  ||  $fwq != '小鸟云' ]];then
  mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
  wget -q -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
  yum clean all >/dev/null 2>&1
  yum makecache >/dev/null 2>&1  
fi
yum -y install unzip tar expect epel-release >/dev/null 2>&1
rm -rf /etc/sysctl.conf
echo "# 解决微信QQ卡顿问题
net.ipv4.ip_forward = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
kernel.sysrq = 0
kernel.core_uses_pid = 1
net.ipv4.tcp_syncookies = 1
net.bridge.bridge-nf-call-ip6tables = 0
net.bridge.bridge-nf-call-iptables = 0
net.bridge.bridge-nf-call-arptables = 0
kernel.msgmnb = 65536
kernel.msgmax = 65536
kernel.shmmax = 68719476736
kernel.shmall = 4294967296
fs.file-max = 789972
# 提高系统限制和BBR加速
net.core.rmem_max = 67108864
net.core.wmem_max = 67108864
net.core.netdev_max_backlog = 250000
net.core.somaxconn = 32768
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr">>/etc/sysctl.conf 
# 加载bridge模块
modprobe bridge
sysctl -p >/dev/null 2>&1 
echo && echo -e "正在配置防火墙..."
setenforce 0 >/dev/null 2>&1
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
systemctl stop firewalld.service >/dev/null 2>&1
systemctl disable firewalld.service >/dev/null 2>&1
yum install iptables iptables-services -y >/dev/null 2>&1
systemctl restart iptables.service >/dev/null 2>&1
# 清空所有防火墙规则
iptables -F
iptables -F -t nat
service iptables save >/dev/null 2>&1
iptables -A INPUT -s 127.0.0.1/32  -j ACCEPT
iptables -A INPUT -d 127.0.0.1/32  -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 440 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport $webdk -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 666 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 1194 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 138 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 137 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 3389 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 3306 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 137 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 138 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 53 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 68 -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -P INPUT DROP 
iptables -t nat  -A POSTROUTING -s 10.9.0.0/24 -o $wangka -j MASQUERADE
iptables -t nat  -A POSTROUTING -s 10.8.0.0/24 -o $wangka -j MASQUERADE
iptables -t nat  -A POSTROUTING -s 10.7.0.0/24 -o $wangka -j MASQUERADE
iptables -t nat  -A POSTROUTING -s 10.6.0.0/24 -o $wangka -j MASQUERADE
iptables -t nat  -A POSTROUTING -s 10.5.0.0/24 -o $wangka -j MASQUERADE
iptables -t nat  -A POSTROUTING -s 10.4.0.0/24 -o $wangka -j MASQUERADE
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 440 -j DNAT --to-destination $IP:443
service iptables save >/dev/null 2>&1
systemctl restart iptables.service >/dev/null 2>&1
return 1
}

function KyunWeb() {
echo && echo -e "正在部署LAMP环境..."
yum -y install httpd >/dev/null 2>&1
rm -rf /etc/httpd/conf/httpd.conf
mv -f /root/K/httpd.conf /etc/httpd/conf/httpd.conf
chmod 0755 -R /etc/httpd/conf/httpd.conf
sed -i 's/8888/'$webdk'/g' /etc/httpd/conf/httpd.conf
yum -y install mariadb-server mariadb >/dev/null 2>&1
rm -rf /etc/my.cnf && mv -f /root/K/my.cnf /etc/my.cnf && chmod 0755 -R /etc/my.cnf
systemctl start mariadb.service
systemctl restart mariadb.service
yum install -y php php-mysql php-gd libjpeg* php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-bcmath php-mhash php-fpmecho >/dev/null 2>&1
echo && echo -e "开始配置快云后台..."
rm -rf /Data && mkdir -p /Data/wwwroot/Kyun
cd /mnt && wget -q $KyWEB ${web}$Host/$KyWEB
unzip -q $KyWEB && rm -rf $KyWEB
adminuserA=$(echo -n "$adminuser" | md5sum| awk {'print$1'})
adminuserB=u$(echo -n "$adminuserA" | md5sum| awk {'print$1'})
adminpassA=$(echo -n "$adminpass" | md5sum| awk {'print$1'})
adminpassB=p$(echo -n "$adminpassA" | md5sum| awk {'print$1'})
admintwopassA=k$(echo -n "$admintwopass" | md5sum| awk {'print$1'})
sed -i 's/MD5账号/'$adminuserB'/g' /mnt/install.sql
sed -i 's/MD5密码/'$adminpassB'/g' /mnt/install.sql
sed -i 's/网站名称/'$adminname'/g' /mnt/install.sql
sed -i 's/QQ客服/'$adminqq'/g' /mnt/install.sql
sed -i 's/hunan.kuaiyum.com:8888/'$IP:$webdk'/g' /mnt/install.sql
sed -i 's/hunan.kuaiyum.com/'$IP'/g' /mnt/install.sql
sed -i 's/kywlpass/'$sqlpass'/g' /mnt/Kyws/config.php
sed -i 's/kywlpass/'$sqlpass'/g' /mnt/Data/config.php
sed -i 's/kywltwopass/'$admintwopassA'/g' /mnt/Data/config.php
mysqladmin -u root password "${sqlpass}"
mysql -hlocalhost -uroot -p${sqlpass} -e "create database IF NOT EXISTS Kyml"
mysql -hlocalhost -uroot -p${sqlpass} --default-character-set=utf8<<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '${sqlpass}' WITH GRANT OPTION;
flush privileges;
use Kyml;
source /mnt/install.sql;
source /mnt/line.sql;
EOF
	mv -f /root/K/sha /bin/sha
	mv -f /root/K/Ky /bin/Ky
	mv -f /root/K/Kps /bin/Kps
	mv -f /root/K/*.sh /etc/Kyun/
	mv -f /root/K/bwlimitplugin.* /etc/Kyun/
	mv -f /root/K/kyun.conf /etc/Kyun/kyun.conf
	rm -rf /root/K
	chmod 0777 -R /bin/Kps
	chmod 0777 -R /bin/Ky
	chmod 0777 -R /bin/sha
	sed -i 's/SETPASS/'$sqlpass'/g' /etc/Kyun/kyun.conf
	sed -i 's/SETWEB/'$webdk'/g' /etc/Kyun/kyun.conf
	sed -i 's/SETIP/'$IP'/g' /etc/Kyun/kyun.conf
	sed -i 's/SETWANG/'$wangka'/g' /etc/Kyun/kyun.conf
	chmod 0777 -R /etc/Kyun/*
	chmod 0777 -R /mnt/*
	mv -f /mnt/* /Data/wwwroot/Kyun/
	yum install -y crontabs >/dev/null 2>&1
	mkdir -p /var/spool/cron
	mkdir -p /Data/Backups
	echo -e 'source /etc/Kyun/kyun.conf\nmysqldump -u$Kyun_USER -p$Kyun_PASS $Kyun_NAME > /Data/Backups/`date +%F`.sql' >> /Data/Backups/Backups.sh
	rm -rf /etc/localtime
	ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	echo "00 05 *   * * /bin/bash /Data/Backups/Bckups.sh" >> /var/spool/cron/root
	echo "*/10 * * * * ntpdate time.windows.com" >> /var/spool/cron/root
	systemctl restart crond.service
    systemctl start httpd.service
    vpn >/dev/null 2>&1
	chmod 0777 -R /Data/wwwroot/Kyun/Online/*
	cd /Data/wwwroot/Kyun
	wget -q ${web}$Host/$phpmyadmin
	tar zxf $phpmyadmin && rm -f $phpmyadmin 
	mv phpMyAdmin-4.4.15.5-all-languages $sql
	echo && echo "正在检测vpn状态..."
    op=`ps -ef |grep openvpn|grep -v grep |wc -l`
    if [[ $op -ge '6' ]];then
        echo && echo -e "VPN运行状态     [\033[32m OK \033[0m]"
	elif [[ $op -ge '5' ]];then
	    echo && echo -e "\033[31m错误，有一个VPN程序启动失败\033[0m\n"
	    echo -e "\033[31m请检查你的服务器是否已占用udp68、udp53、tcp666、tcp1194、tcp443、tcp3389端口\033[0m"
	    echo -e "\033[34m解决方法：搭建完成后重启一下服务器，如不行请重装系统再搭建\033[0m"
		sleep 8
	else 
	    echo && echo -e "\033[31m错误，有一些VPN程序启动失败\033[0m\n"
	    echo -e "\033[31m请检查你的服务器是否已占用udp68、udp53、tcp666、tcp1194、tcp443、tcp3389端口\033[0m"
		echo -e "\033[34m解决方法：搭建完成后重启一下服务器，如不行请重装系统再搭建\033[0m"
	    sleep 8
    fi
return 1
}

function KyunVPN() {
echo && echo "开始安装VPN程序..."
yum install -y openvpn telnet >/dev/null 2>&1
yum install -y gcc openssl openssl-devel lzo lzo-devel pam pam-devel automake pkgconfig >/dev/null 2>&1
wget -q ${web}$Host/$O
rpm -Uvh --oldpackage --force $O >/dev/null 2>&1
rm -rf $O && mkdir -p /etc/openvpn
cd /root && wget -q ${web}$Host/$peizhi
unzip -q $peizhi && rm -rf $peizhi
mv -f /root/K/server-*.conf /etc/openvpn/
chmod 0777 -R /etc/openvpn/*
mkdir -p /etc/Kyun
cd /etc/openvpn && wget -q ${web}$Host/$EasyRSA
unzip -q $EasyRSA && rm -rf $EasyRSA
chmod 0777 -R /etc/openvpn/easy-rsa/*
rm -rf /bin/vpn
mv -f /root/K/vpn /bin/vpn
chmod 0777 -R /bin/vpn
wget -q -O /bin/K666 ${web}$Host/K666
chmod 0777 /bin/K666
return 1
}

function Kyun() {
Kyunhead
clear
if [[ $Ksq2 == *黑名单* ]];then
  echo -e "\033[31m$HmdLogo\033[0m"
  exit 1
fi
echo -e "\033[36m$KyLogo\033[0m"
echo
echo -n -e "请输入验证：[\033[32m yes\033[0m ]："
read key
if [[ $key == 'yes' ]]
then
	echo
	dizhi=`echo $localserver|awk '{print $3}'`
	echo -e "验证成功，本机IP：\033[34m$IP $dizhi$fwq\033[0m"
	sleep 1
	echo
else
    clear
    echo -e "\033[31m$YzError\033[0m"
	exit 1
fi
sqlcnm='已授权'
if [[ $sqlcnm == *已授权* ]];then
	echo -e '\033[1;34m本机器已永久授权   高级模式：\033[32m[ 已开启 ]\033[0m'
	sleep 1
else
	clear
	echo -e "\033[36m$BuyLogo\033[0m";
	echo
	echo -n -e "\033[32m请输入授权码：\033[0m"
	read user
	echo
	if [[ $sqlcnm == *已授权* ]];then
		echo -e '\033[1;34mIP状态：            \033[32m[  OK  ]\033[0m'
		sleep 0.5 && echo
		echo -e '\033[1;34m密匙正确！    高级模式：\033[32m[ 已开启 ]\033[0m'
		sleep 1 && echo
		echo -e '\033[1;34m此授权码已成功绑定您的机器，可永久重复无限搭建\033[0m';
		sleep 1
	else
		echo -e '\033[1;34m MD\033[31mZZ\033[0m'
		exit 1
	fi
fi
clear
echo "请选择要安装的类型："
echo 
echo -e "1 - \033[36m全新流控\033[0m >> 安装最新版本 N17-6.4"
echo -e "2 - \033[36m一键负载\033[0m >> 一键N台服务器共用账号"
echo -e "3 - \033[36m备份数据\033[0m >> 方便重新搭建恢复数据"
echo -e "4 - \033[36mAPP生成\033[0m >> 一键生成代理独立专属APP"
echo -e "5 - \033[36m在线升级\033[0m >> 更新到快云流控最新版"
echo -e "6 - \033[36m卸载流控\033[0m >> 清空本机已安装的文件"
echo
echo -n "输入选项: "
read install 
if [[ $install == 2 ]];then
  clear
  echo -e -n "\033[34m请输入主机IP：\033[0m"
  read zhuip
if [[ "$zhuip" == '' ]]; then
  echo
  echo -e -n '输入的内容不能为空白，请重新输入：'
  read zhuip
fi
echo
echo -e -n "\033[34m回车开始搞事\033[0m"
read
echo && echo -e  "正在进行一键负载..."
sed -i "s/localhost/$zhuip/g" /etc/Kyun/kyun.conf 
sed -i "s/localhost/$zhuip/g" /Data/wwwroot/Kyun/Data/config.php
sed -i "s/localhost/$zhuip/g" /Data/wwwroot/Kyun/Kyws/config.php
echo
vpn
echo && echo -e "恭喜你已完成服务器负载。"
exit 0
elif [[ $install == 3 ]];then
  # 加载系统配置
  source /etc/Kyun/kyun.conf
  clear
  echo -e -n "\033[34m你需要导入还是导出数据？(1导出/2导入)\033[0m"
  read caozuo
  if [ $caozuo == '1' ];then
    echo -e -n "\033[34m只要导出用户数据吗？(y/n)\033[0m"
    read user
    if [[ $user == 'y' || $user == 'Y' ]];then
       mysqldump -u$Kyun_USER -p$Kyun_PASS $Kyun_NAME openvpn > /Data/wwwroot/Kyun/Ky.sql
    else
       mysqldump -u$Kyun_USER -p$Kyun_PASS $Kyun_NAME > /Data/wwwroot/Kyun/Ky.sql
	   # 获取httpd端口
       weba=`netstat -ntlp|grep httpd|awk '{print $4}'`
       webb=${weba/:::/}
       webdk=${webb/0.0.0.0:/}
       echo && echo -e "数据下载地址：http://$IP:$webdk/Ky.sql"
    fi 
  else
    echo -e "请到备份好的数据上传到服务器root目录下,并命名为Ky.sql(如：/root/Ky.sql)"
	mysql -u$Kyun_USER -p$Kyun_PASS $Kyun_NAME < /root/Ky.sql
	echo && echo -e "恭喜你已完成数据导入！"
  fi
  exit 0
elif [[ $install == 4 ]];then
  clear
  echo -e -n "\033[34m请输入APP名称：\033[0m"
  read appname
  echo
  echo -e -n "\033[34m请输入代理ID：\033[0m"
  read dlapp
  echo -n -e "你想自定义APP图标和启动图吗？(y/n)："
  read userimg
  if [[ $userimg == 'y' || $userimg == 'Y' ]];then
    img=yes
    # APP软件图标
    echo
    echo -n -e "请输入APP图标地址 [默认:快云Logo图标 ]"
    read urlA
    if [ -z $urlA ];then 
      img=no
    fi

    # APP启动图
    echo
    echo -n -e "请输入APP启动图地址 [默认:快云启动图 ]"
    read urlB
    if [ -z $urlB ];then 
      img=no
    fi
  else
    img=no
  fi
  mkdir /home/android 
  chmod 0777 -R /home/android 
  cd /home/android
  wget -q ${web}$Host/apktool.jar
  wget -q ${web}$Host/DlAPP.apk
  # 获取httpd端口
  weba=`netstat -ntlp|grep httpd|awk '{print $4}'`
  webb=${weba/:::/}
  webdk=${webb/0.0.0.0:/}
  # 反编译
  echo && echo -e "正在反编译APP..."
  java -jar apktool.jar d DlAPP.apk >/dev/null 2>&1 

  sed -i 's/'wap.kuaiyum.com:8888'/'${IP}:${webdk}'/g' "/home/android/DlAPP/smali/net/openvpn/openvpn/base.smali"
  sed -i 's/'wap.kuaiyum.com:8888'/'${IP}:${webdk}'/g' "/home/android/DlAPP/smali/net/openvpn/openvpn/OpenVPNClient.smali" 
  sed -i 's/'wap.kuaiyum.com:8888'/'${IP}:${webdk}'/g' "/home/android/DlAPP/smali/net/openvpn/openvpn/OpenVPNClient\$10.smali" 
  sed -i 's/'wap.kuaiyum.com:8888'/'${IP}:${webdk}'/g' "/home/android/DlAPP/smali/net/openvpn/openvpn/OpenVPNClient\$11.smali" 
  sed -i 's/'wap.kuaiyum.com:8888'/'${IP}:${webdk}'/g' "/home/android/DlAPP/smali/net/openvpn/openvpn/OpenVPNClient\$13.smali" 
  sed -i 's/'wap.kuaiyum.com:8888'/'${IP}:${webdk}'/g' "/home/android/DlAPP/smali/net/openvpn/openvpn/Main2Activity\$MyListener\$1.smali" 
  sed -i 's/'wap.kuaiyum.com:8888'/'${IP}:${webdk}'/g' '/home/android/DlAPP/smali/net/openvpn/openvpn/Main2Activity$MyListener.smali' 
  sed -i 's/'wap.kuaiyum.com:8888'/'${IP}:${webdk}'/g' '/home/android/DlAPP/smali/net/openvpn/openvpn/MainActivity.smali' 
  sed -i 's/'wap.kuaiyum.com:8888'/'${IP}:${webdk}'/g' '/home/android/DlAPP/smali/net/openvpn/openvpn/update$myClick$1.smali'
  sed -i 's/'wap.kuaiyum.com:8888'/'${IP}:${webdk}'/g' '/home/android/DlAPP/smali/net/openvpn/openvpn/AutoScrollTextView.smali' 
  sed -i 's/快云流量/'$appname'/g' "/home/android/DlAPP/res/values/strings.xml"
  sed -i 's/dlapp=1797106720/'dlapp=$dlapp'/g' "/home/android/DlAPP/smali/net/openvpn/openvpn/OpenVPNClient.smali" 
  sed -i 's/dlapp=1797106720/'dlapp=$dlapp'/g' "/home/android/DlAPP/smali/net/openvpn/openvpn/OpenVPNClient\$13.smali" 
  
  if [[ $img == 'yes' ]];then
    # 图标
    rm -rf /home/android/DlAPP/res/drawable-hdpi-v4/icon.png
    rm -rf /home/android/DlAPP/res/drawable-mdpi-v4/icon.png
    rm -rf /home/android/DlAPP/res/drawable-xhdpi-v4/icon.png
    wget -q -O /home/android/DlAPP/res/drawable-xhdpi-v4/icon.png $urlA
    cp /home/android/DlAPP/res/drawable-xhdpi-v4/icon.png /home/android/DlAPP/res/drawable-mdpi-v4/icon.png
    cp /home/android/DlAPP/res/drawable-xhdpi-v4/icon.png /home/android/DlAPP/res/drawable-hdpi-v4/icon.png

    # 启动图
    rm -rf /home/android/DlAPP/res/drawable/splash.png
    wget -q -O /home/android/DlAPP/res/drawable/splash.png $urlB
  fi

  # 打包
  echo && echo -e "正在签名打包APP..."
  chmod +x /home/android/apktool.jar
  java -jar apktool.jar b DlAPP >/dev/null 2>&1
  cd /home/android/DlAPP/dist
  wget -q ${web}$Host/signer.tar.gz
  tar zxf signer.tar.gz
  java -jar signapk.jar testkey.x509.pem testkey.pk8 DlAPP.apk app.apk >/dev/null 2>&1 
  NowTime=`date +%Y%m%d%H%M`
  cp -rf /home/android/DlAPP/dist/app.apk /Data/wwwroot/Kyun/user/app/$NowTime\.apk
  rm -rf /home/*
  echo
  echo "软件下载地址：http://$IP:$webdk/user/app/$NowTime.apk"
  exit 0
elif [[ $install == 5 ]];then
  clear
  printf "\033[31m----------------------------------------------------------\n\n目前只支持N17-6.4升到N17-6.6,低于V6.4版本的请立即终止！！！\n\n----------------------------------------------------------\033[0m"
  echo -e -n "\033[34m\n清楚明白,回车继续\033[0m"
  read
  # 加载系统配置
  source /etc/Kyun/kyun.conf
  #echo -e '正在为您备份用户数据...\n'
  #mysqldump -u$Kyun_USER -p$Kyun_PASS $Kyun_NAME openvpn > /mnt/openvpn.sql
  #echo -e '正在为您备份卡密数据...\n'
  #mysqldump -u$Kyun_USER -p$Kyun_PASS $Kyun_NAME auth_kms > /mnt/auth_kms.sql
  #echo -e '正在为您备份线路数据...\n'
  #mysqldump -u$Kyun_USER -p$Kyun_PASS $Kyun_NAME line > /mnt/line.sql
  #echo -e '正在为您备份排行榜数据...\n'
  #mysqldump -u$Kyun_USER -p$Kyun_PASS $Kyun_NAME top > /mnt/top.sql
  echo -e '\n正在为您备份系统文件...\n'
  cp /Data/wwwroot/Kyun/Data/config.php /mnt/config_one.php.bak
  cp /Data/wwwroot/Kyun/Kyws/config.php /mnt/config_two.php.bak
  mv /Data/wwwroot/Kyun/mysql_* /mnt
  rm -rf /Data/wwwroot/Kyun/*
  echo -e '正在更新WEB文件...\n'
  cd /Data/wwwroot/Kyun 
  wget -q ${web}$Host/$KyWEB 
  unzip -q $KyWEB 
  rm -rf $KyWEB 
  rm -rf /Data/wwwroot/Kyun/Data/config.php 
  rm -rf /Data/wwwroot/Kyun/Kyws/config.php 
  mv /mnt/mysql_*   /Data/wwwroot/Kyun/
  mv /mnt/config_one.php.bak /Data/wwwroot/Kyun/Data/config.php 
  mv /mnt/config_two.php.bak /Data/wwwroot/Kyun/Kyws/config.php 
  cd /mnt 
  wget -q ${web}$Host/gxsql.sql
  sed -i 's/hunan.kuaiyum.com:8888/'$IP:$webdk'/g' /mnt/gxsql.sql
  sed -i 's/hunan.kuaiyum.com/'$IP'/g' /mnt/gxsql.sql
  mysql -u$Kyun_USER -p$Kyun_PASS $Kyun_NAME < /mnt/gxsql.sql
  echo -e '正在更新系统文件...\n'
  cd /etc/openvpn 
  wget -q ${web}$Host/$peizhi
  unzip -q $peizhi 
  rm -rf *.conf 
  mv K/*.conf /etc/openvpn
  chmod 0777 /etc/openvpn/*
  rm -rf /bin/vpn 
  mv /etc/openvpn/K/vpn /bin/vpn
  rm -rf /bin/Kps 
  mv /etc/openvpn/K/Kps /bin/Kps
  rm -rf /etc/Kyun/*.sh
  mv /etc/openvpn/K/*.sh /etc/Kyun
  chmod 0777 /etc/Kyun/* 
  rm -rf /bin/K666
  wget -q ${web}$Host/K666
  mv K666 /bin/K666
  chmod 0777 /bin/*
  vpn
  chmod 0777 /Data/wwwroot/Kyun/Online/*
  #echo -e '正在为您恢复用户数据...\n'
  #mysql -u$Kyun_USER -p$Kyun_PASS $Kyun_NAME < /mnt/openvpn.sql
  #echo -e '正在为您恢复卡密数据...\n'
  #mysql -u$Kyun_USER -p$Kyun_PASS $Kyun_NAME < /mnt/auth_kms.sql
  #echo -e '正在为您恢复线路数据...\n'
  #mysql -u$Kyun_USER -p$Kyun_PASS $Kyun_NAME < /mnt/line.sql
  #echo -e '正在为您恢复排行榜数据...\n'
  #mysql -u$Kyun_USER -p$Kyun_PASS $Kyun_NAME < /mnt/top.sql
  clear
  printf "\033[34m--------------------------------------------\n\n恭喜你已成功升级到最新版V6.6，赶快去体验吧\n\n--------------------------------------------\033[0m"
  exit 0
elif [[ $install == 6 ]];then
  clear
  echo "开始卸载流控系统.."
  rm -rf /Data 
  rm -rf /etc/Kyun
  rm -rf /etc/openvpn 
  rm -rf /bin/Ky 
  rm -rf /bin/Kps
  rm -rf /bin/vpn
  rm -rf /bin/K666
  rm -rf /var/lib/mysql
  killall K666
  killall Ky 
  killall Kps
  systemctl stop openvpn@server-*.service
  systemctl stop httpd.service 
  systemctl stop mariadb.service
  yum remove -y openvpn httpd mariadb-server mariadb
  yum remove -y php php-mysql php-gd libjpeg* php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-bcmath php-mhash php-fpm
  echo '卸载完成，欢迎你下次再使用哦。'
  exit 0
else
  KyunClear
  KyunVPN
  KyunWeb
  KyunApp
  LASTLINE=`date +"%Y-%m-%d %H:%M:%S"`; # 获取结束时间
  Sys_data=`date -d  "$CURTIME" +%s` # 获取开始时间阀
  In_data=`date -d  "$LASTLINE" +%s`; # 获取结束时间阀
  all_time=`expr $In_data - $Sys_data`; #计算总时间差
  # 置为开机自启
  echo && echo -e "正在置为开机自启..."
  systemctl enable crond.service >/dev/null 2>&1
  systemctl enable iptables.service >/dev/null 2>&1
  systemctl enable httpd.service >/dev/null 2>&1 
  echo "#!/bin/bash
touch /var/lock/subsys/local
vpn
bash /Data/start.sh " >>/etc/rc.local
  chmod +x /etc/rc.d/rc.local
  echo "#!/bin/bash
# 快云开机自启脚本 请自行添加">>/Data/start.sh
  rm -rf /root/.local
  rm -rf /home/* && rm -rf /root/* 
  rm -rf /Data/wwwroot/Kyun/*.sql
  if [ $NowV != '4.13.7-1.el7.elrepo.x86_64' ];then
    if [ -e "/opt/BBR_elrepo_install" ];then
      elrepo='你已经升级过内核啦,请手动重启服务器即可生效,重启服务器命令：reboot'
    else
      elrepo='请你手动重启服务器用于激活为你升级的最新内核，重启服务器命令：reboot'
    fi
  else
    elrepo='欢迎你使用快云VPN产品,如果你有Bug和好的建议反馈给我们，欢迎联系邮箱：fyuewl@qq.com'
  fi
fi
clear
echo -e "
---------------------------------------------------------
     欢迎您使用快云免流两分钟极速一键VPN搭建脚本     
---------------------------------------------------------
流量前台地址：http://$IP:$webdk/user
代理后台地址：http://$IP:$webdk/daili
管理员后台地址：http://$IP:$webdk/admin
软件下载地址：http://$IP:$webdk/user/app
数据库地址为：http://$IP:$webdk/$sql 
---------------------------------------------------------
---------------------------------------------------------
你本次安装快云VPN程序一共花费时间 $all_time 秒
管理员账号：$adminuser         管理员密码：$adminpass 
本地二级密码：$admintwopass       数据库密码：$sqlpass

---------------------------------------------------------
---------------------------------------------------------
温馨提示：每天自动备份的数据在(/Data/Backups),记得及时下载保存哦
$elrepo
----------------------------------------------------------"
return 1
}

Kyun

exit 0

# By Fyue/飞跃 
# 2017年10月28日
# 本脚本版权归快云免流所有
