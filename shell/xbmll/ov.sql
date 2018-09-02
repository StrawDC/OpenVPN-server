-- MySQL dump 10.14  Distrib 5.5.56-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: ov
-- ------------------------------------------------------
-- Server version	5.5.56-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alipay`
--

DROP TABLE IF EXISTS `alipay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alipay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `partner` text NOT NULL,
  `alikey` text NOT NULL,
  `url` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alipay`
--

LOCK TABLES `alipay` WRITE;
/*!40000 ALTER TABLE `alipay` DISABLE KEYS */;
INSERT INTO `alipay` VALUES (1,'','','');
/*!40000 ALTER TABLE `alipay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_admin`
--

DROP TABLE IF EXISTS `app_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `op` text NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_admin`
--

LOCK TABLES `app_admin` WRITE;
/*!40000 ALTER TABLE `app_admin` DISABLE KEYS */;
INSERT INTO `app_admin` VALUES (1,'0','root','admin');
/*!40000 ALTER TABLE `app_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_config`
--

DROP TABLE IF EXISTS `app_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `system` text NOT NULL,
  `qq` text NOT NULL,
  `top_content` text NOT NULL,
  `no_limit` text NOT NULL,
  `reg` int(11) NOT NULL,
  `col1` text NOT NULL,
  `col2` text NOT NULL,
  `col3` text NOT NULL,
  `col4` text NOT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_config`
--

LOCK TABLES `app_config` WRITE;
/*!40000 ALTER TABLE `app_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_daili`
--

DROP TABLE IF EXISTS `app_daili`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_daili` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `default` int(11) NOT NULL,
  `qq` text NOT NULL,
  `conetnt` text NOT NULL,
  `chongzhi` text NOT NULL,
  `name` text NOT NULL,
  `pass` text NOT NULL,
  `web` text NOT NULL,
  `show` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_daili`
--

LOCK TABLES `app_daili` WRITE;
/*!40000 ALTER TABLE `app_daili` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_daili` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_gg`
--

DROP TABLE IF EXISTS `app_gg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_gg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `time` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_2` (`id`),
  KEY `id` (`id`),
  KEY `id_3` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_gg`
--

LOCK TABLES `app_gg` WRITE;
/*!40000 ALTER TABLE `app_gg` DISABLE KEYS */;
INSERT INTO `app_gg` VALUES (10,'欢迎使用小白流量卫士','欢迎您使用小白流量卫士。首次使用请点击云端线路安装适合自己的线路。\r\n如果遇到任何问题请联系客服','1474274509');
/*!40000 ALTER TABLE `app_gg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_qq`
--

DROP TABLE IF EXISTS `app_qq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_qq` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `time` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_2` (`id`),
  KEY `id` (`id`),
  KEY `id_3` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_qq`
--

LOCK TABLES `app_qq` WRITE;
/*!40000 ALTER TABLE `app_qq` DISABLE KEYS */;
INSERT INTO `app_qq` VALUES (10,'欢迎使用小白流量卫士','欢迎您使用小白流量卫士。首次使用请点击云端线路安装适合自己的线路。\r\n如果遇到任何问题请联系客服','1474274509');
/*!40000 ALTER TABLE `app_qq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_read`
--

DROP TABLE IF EXISTS `app_read`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_read` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` text NOT NULL,
  `readid` text NOT NULL,
  `time` text NOT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_read`
--

LOCK TABLES `app_read` WRITE;
/*!40000 ALTER TABLE `app_read` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_read` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_config`
--

DROP TABLE IF EXISTS `auth_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_config` (
  `id` varchar(80) NOT NULL DEFAULT '1',
  `gg` text,
  `ggs` text,
  `dl1` float DEFAULT NULL COMMENT 'vip1',
  `dl2` float DEFAULT NULL COMMENT 'vip2',
  `dl3` float DEFAULT NULL COMMENT 'vip3',
  `dl4` float DEFAULT NULL COMMENT 'vip4',
  `dl5` float DEFAULT NULL COMMENT 'vip5',
  `dl0` float DEFAULT NULL COMMENT 'vip0',
  `dls1` float NOT NULL,
  `dls2` float NOT NULL,
  `dls3` float NOT NULL,
  `dls4` float NOT NULL,
  `dls5` float NOT NULL,
  `member_reg` int(2) NOT NULL DEFAULT '0',
  `dls0` float NOT NULL,
  `regok` int(11) DEFAULT NULL,
  `activeok` int(11) DEFAULT NULL,
  `ok` int(11) DEFAULT NULL,
  `shopUrl` text NOT NULL,
  `shopCode` text NOT NULL,
  `daili_cash` float NOT NULL,
  `reg_cash` float NOT NULL,
  `user_cash` float NOT NULL,
  `qian` float NOT NULL,
  `user_endtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_config`
--

LOCK TABLES `auth_config` WRITE;
/*!40000 ALTER TABLE `auth_config` DISABLE KEYS */;
INSERT INTO `auth_config` VALUES ('1','欢迎使用小白免流™流控','欢迎使用小白免流™流控',0,0,0,0,0,0,3.5,3,2.5,2,1.5,0,4,0,0,2,'http://www.917ka.com/','<div id=\"pdBuy\"  class=\"PDB2C_moban_warp\"><img src=\"http://code.jiasale.com/pdbs/images/init_wait.gif\"></div> <script type=\"text/javascript\" id=\"pdB2C_js\"></script> <script type=\"text/javascript\" id=\"pdB2C_shell_js\" src=\"http://code.jiasale.com/shoptemplet/3c07dc175a1242d7b4770de7650044db/t30834.js\"></script>',10,20971500,52428800,10485800,1);
/*!40000 ALTER TABLE `auth_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_daili`
--

DROP TABLE IF EXISTS `auth_daili`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_daili` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `tj_rmb` decimal(11,2) NOT NULL,
  `tj_user` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `pass` varchar(255) DEFAULT NULL,
  `rmb` decimal(11,2) NOT NULL DEFAULT '0.00',
  `vip` int(11) DEFAULT NULL,
  `kmlist` int(11) DEFAULT NULL,
  `active` int(11) DEFAULT NULL,
  `regdate` datetime DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `qq` varchar(100) NOT NULL,
  `tel` varchar(100) NOT NULL,
  `buy` text NOT NULL,
  `buy2` text NOT NULL,
  `income` decimal(11,2) NOT NULL DEFAULT '0.00',
  `adtext` text NOT NULL,
  `adimg` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_daili`
--

LOCK TABLES `auth_daili` WRITE;
/*!40000 ALTER TABLE `auth_daili` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_daili` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_fwq`
--

DROP TABLE IF EXISTS `auth_fwq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_fwq` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `ipport` varchar(64) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_fwq`
--

LOCK TABLES `auth_fwq` WRITE;
/*!40000 ALTER TABLE `auth_fwq` DISABLE KEYS */;
INSERT INTO `auth_fwq` VALUES (1,'默认服务器','服务器IP:后台端口','2016-08-29 03:14:36');
/*!40000 ALTER TABLE `auth_fwq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_kms`
--

DROP TABLE IF EXISTS `auth_kms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_kms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kind` tinyint(1) NOT NULL DEFAULT '1',
  `daili` int(11) NOT NULL DEFAULT '0',
  `km` varchar(64) DEFAULT NULL,
  `value` int(11) NOT NULL DEFAULT '0',
  `values` decimal(11,2) DEFAULT NULL,
  `money` decimal(11,2) DEFAULT '0.00',
  `isuse` tinyint(1) DEFAULT '0',
  `user` varchar(50) DEFAULT NULL,
  `usetime` datetime DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  `kmtype_id` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `km` (`km`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_kms`
--

LOCK TABLES `auth_kms` WRITE;
/*!40000 ALTER TABLE `auth_kms` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_kms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_log`
--

DROP TABLE IF EXISTS `auth_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action` varchar(255) NOT NULL,
  `msg` text NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_log`
--

LOCK TABLES `auth_log` WRITE;
/*!40000 ALTER TABLE `auth_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banner`
--

DROP TABLE IF EXISTS `banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banner` (
  `id` int(11) NOT NULL,
  `img1` text CHARACTER SET utf8 NOT NULL,
  `tit1` text CHARACTER SET utf8 NOT NULL,
  `info1` text CHARACTER SET utf8 NOT NULL,
  `img2` text CHARACTER SET utf8 NOT NULL,
  `tit2` text CHARACTER SET utf8 NOT NULL,
  `info2` text CHARACTER SET utf8 NOT NULL,
  `img3` text CHARACTER SET utf8 NOT NULL,
  `tit3` text CHARACTER SET utf8 NOT NULL,
  `info3` text CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banner`
--

LOCK TABLES `banner` WRITE;
/*!40000 ALTER TABLE `banner` DISABLE KEYS */;
INSERT INTO `banner` VALUES (0,'http://i.niupic.com/images/2016/09/22/s2rWJE.jpg','超实惠流量冲浪新时代','抵制高价流量，让你使用专用的流量服务，从而价格远远低于运营商，安全快捷！','http://i.niupic.com/images/2016/09/22/QC3qln.jpg','支持IOS6-IOS9系统','一次安装永久支持续费，VPN连接100M服务器转接','http://i.niupic.com/images/2016/09/22/JHtWio.jpg','安卓系统完美支持','操作人性化，流量软件上手很简单，使用仅需简单操作几步');
/*!40000 ALTER TABLE `banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kmtype`
--

DROP TABLE IF EXISTS `kmtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kmtype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `days` float NOT NULL,
  `maxll` float NOT NULL,
  `dlid` float NOT NULL,
  `km_rmb` decimal(11,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `id_2` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kmtype`
--

LOCK TABLES `kmtype` WRITE;
/*!40000 ALTER TABLE `kmtype` DISABLE KEYS */;
/*!40000 ALTER TABLE `kmtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `line`
--

DROP TABLE IF EXISTS `line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `line` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `content` text NOT NULL,
  `type` text NOT NULL,
  `group` text NOT NULL,
  `show` int(11) NOT NULL,
  `label` text NOT NULL,
  `time` text NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `line`
--

LOCK TABLES `line` WRITE;
/*!40000 ALTER TABLE `line` DISABLE KEYS */;
/*!40000 ALTER TABLE `line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `line_grop`
--

DROP TABLE IF EXISTS `line_grop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `line_grop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_bin NOT NULL,
  `show` int(11) NOT NULL,
  `order` int(11) NOT NULL,
  UNIQUE KEY `id_2` (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `line_grop`
--

LOCK TABLES `line_grop` WRITE;
/*!40000 ALTER TABLE `line_grop` DISABLE KEYS */;
INSERT INTO `line_grop` VALUES (1,'中国移动',1,1),(2,'中国电信',1,1),(3,'中国联通',1,1);
/*!40000 ALTER TABLE `line_grop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lyj_article`
--

DROP TABLE IF EXISTS `lyj_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lyj_article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '无题',
  `content` text NOT NULL,
  `visit_count` int(10) unsigned NOT NULL DEFAULT '0',
  `timeline` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='文章表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lyj_article`
--

LOCK TABLES `lyj_article` WRITE;
/*!40000 ALTER TABLE `lyj_article` DISABLE KEYS */;
INSERT INTO `lyj_article` VALUES (2,1,'移动','1',0,1471086665);
/*!40000 ALTER TABLE `lyj_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lyj_category`
--

DROP TABLE IF EXISTS `lyj_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lyj_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '默认栏目',
  `description` varchar(255) NOT NULL DEFAULT '栏目简介',
  `sortby` int(5) NOT NULL DEFAULT '0',
  `hidden` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='栏目表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lyj_category`
--

LOCK TABLES `lyj_category` WRITE;
/*!40000 ALTER TABLE `lyj_category` DISABLE KEYS */;
INSERT INTO `lyj_category` VALUES (1,'移动','',1,0),(2,'联通','',2,0),(3,'电信','',3,0);
/*!40000 ALTER TABLE `lyj_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lyj_link`
--

DROP TABLE IF EXISTS `lyj_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lyj_link` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL,
  `name` varchar(200) NOT NULL DEFAULT '链接名称',
  `description` varchar(255) NOT NULL DEFAULT '链接简介',
  `url` varchar(255) NOT NULL DEFAULT 'http://',
  `icon` varchar(255) NOT NULL DEFAULT 'http://',
  `sortby` int(5) NOT NULL DEFAULT '0',
  `hidden` int(2) NOT NULL DEFAULT '0',
  `timeline` int(8) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `url` (`url`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='友链表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lyj_link`
--

LOCK TABLES `lyj_link` WRITE;
/*!40000 ALTER TABLE `lyj_link` DISABLE KEYS */;
INSERT INTO `lyj_link` VALUES (1,1,'流控地址','链接简介','http://119.28.15.59:1024/','.',1,0,0),(2,1,'卡密地址','链接简介','http://ip:port','.',0,0,1471028321),(3,1,'官方商城','链接简介','http://ip:port/','.',2,0,1471029048),(4,1,'使用说明','链接简介','http://119.28.15.59:1024/shuoming.html','.',3,0,1471029100),(5,1,'背景图片','链接简介','http://图片','.',4,0,1471029221);
/*!40000 ALTER TABLE `lyj_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lyj_setting`
--

DROP TABLE IF EXISTS `lyj_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lyj_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `skey` varchar(100) NOT NULL DEFAULT '要设置的键',
  `sval` varchar(1024) NOT NULL DEFAULT '要设置的值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `skey` (`skey`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='设置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lyj_setting`
--

LOCK TABLES `lyj_setting` WRITE;
/*!40000 ALTER TABLE `lyj_setting` DISABLE KEYS */;
INSERT INTO `lyj_setting` VALUES (1,'contact','qq'),(2,'seo_title','qqkey'),(3,'seo_keywords','图片地址'),(4,'seo_description','公告信息'),(5,'copyright','流控地址');
/*!40000 ALTER TABLE `lyj_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lyj_token`
--

DROP TABLE IF EXISTS `lyj_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lyj_token` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `token` varchar(32) NOT NULL,
  `expire_timeline` int(10) NOT NULL,
  `update_timeline` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='登录令牌表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lyj_token`
--

LOCK TABLES `lyj_token` WRITE;
/*!40000 ALTER TABLE `lyj_token` DISABLE KEYS */;
INSERT INTO `lyj_token` VALUES (1,1,'f826ef30ddc531f51c107a8c18d8ff8',1473619585,1471027585),(2,2,'a01906',1473619585,1471027585);
/*!40000 ALTER TABLE `lyj_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lyj_user`
--

DROP TABLE IF EXISTS `lyj_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lyj_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(15) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `nick` varchar(15) NOT NULL,
  `face` varchar(255) DEFAULT NULL,
  `sex` int(2) DEFAULT '0',
  `device_id` varchar(20) NOT NULL,
  `is_forbidden` int(10) NOT NULL DEFAULT '0',
  `is_app` int(2) DEFAULT '0',
  `timeline` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`account`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lyj_user`
--

LOCK TABLES `lyj_user` WRITE;
/*!40000 ALTER TABLE `lyj_user` DISABLE KEYS */;
INSERT INTO `lyj_user` VALUES (1,'root','21232f297a57a5a743894a0e4a801fc3','纱幕下的人生','',1,'1163844562',0,0,0);
/*!40000 ALTER TABLE `lyj_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `open`
--

DROP TABLE IF EXISTS `open`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `open` (
  `id` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `mo` longtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `open`
--

LOCK TABLES `open` WRITE;
/*!40000 ALTER TABLE `open` DISABLE KEYS */;
/*!40000 ALTER TABLE `open` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `openvpn`
--

DROP TABLE IF EXISTS `openvpn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `openvpn` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iuser` varchar(16) NOT NULL,
  `isent` bigint(128) DEFAULT '0',
  `irecv` bigint(128) DEFAULT '0',
  `maxll` bigint(128) NOT NULL,
  `pass` varchar(18) NOT NULL,
  `i` int(1) NOT NULL,
  `starttime` varchar(30) DEFAULT NULL,
  `endtime` int(11) DEFAULT '0',
  `dlid` int(11) DEFAULT NULL,
  `fwqid` int(11) DEFAULT '1',
  `notes` varchar(255) DEFAULT NULL,
  `tian` float NOT NULL,
  `qian_date` date NOT NULL,
  `qian_num` float NOT NULL,
  `tj_user` text CHARACTER SET utf8 NOT NULL,
  `tj_ok` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `iuser` (`iuser`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `openvpn`
--

LOCK TABLES `openvpn` WRITE;
/*!40000 ALTER TABLE `openvpn` DISABLE KEYS */;
INSERT INTO `openvpn` VALUES (5,'943756780',0,0,1073741824,'123456',1,'1533088427',1533174827,NULL,1,'',1,'0000-00-00',0,'',0);
/*!40000 ALTER TABLE `openvpn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `top`
--

DROP TABLE IF EXISTS `top`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `top` (
  `id` int(11) NOT NULL,
  `username` text NOT NULL,
  `data` bigint(20) NOT NULL,
  `time` text NOT NULL,
  UNIQUE KEY `id_2` (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `top`
--

LOCK TABLES `top` WRITE;
/*!40000 ALTER TABLE `top` DISABLE KEYS */;
/*!40000 ALTER TABLE `top` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `website`
--

DROP TABLE IF EXISTS `website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `website` (
  `id` int(2) NOT NULL,
  `logo` text CHARACTER SET utf8 NOT NULL,
  `title` text CHARACTER SET utf8 NOT NULL,
  `app1` text CHARACTER SET utf8 NOT NULL,
  `app2` text CHARACTER SET utf8 NOT NULL,
  `qq` text CHARACTER SET utf8 NOT NULL,
  `tel` text CHARACTER SET utf8 NOT NULL,
  `ipinfo` text CHARACTER SET utf8 NOT NULL,
  `appleid1` text CHARACTER SET utf8 NOT NULL,
  `appleps1` text CHARACTER SET utf8 NOT NULL,
  `appleid2` text CHARACTER SET utf8 NOT NULL,
  `appleps2` text CHARACTER SET utf8 NOT NULL,
  `appleid3` text CHARACTER SET utf8 NOT NULL,
  `appleps3` text CHARACTER SET utf8 NOT NULL,
  `and_img1` text CHARACTER SET utf8 NOT NULL,
  `and_img2` text CHARACTER SET utf8 NOT NULL,
  `and_img3` text CHARACTER SET utf8 NOT NULL,
  `and_img4` text CHARACTER SET utf8 NOT NULL,
  `jia1` text CHARACTER SET utf8 NOT NULL,
  `jia2` text CHARACTER SET utf8 NOT NULL,
  `jia3` text CHARACTER SET utf8 NOT NULL,
  `jia4` text CHARACTER SET utf8 NOT NULL,
  `seo` text CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `website`
--

LOCK TABLES `website` WRITE;
/*!40000 ALTER TABLE `website` DISABLE KEYS */;
INSERT INTO `website` VALUES (0,'http://i.niupic.com/images/2016/08/05/ZEsqL4.png','小白免流™全新一代流控管理系统 ','https://www.pgyer.com/','http://fir.im/','943756780','943756780','121.41.*.* 浙江省杭州市 阿里云','cuod061@icloud.com','Dd112211','1335538902@qq.com','Aa20162016','hah4073@icloud.com','Dd112211','http://i.niupic.com/images/2016/08/15/YkoMbx.jpg','http://i.niupic.com/images/2016/08/15/BYwMZQ.jpg','http://i.niupic.com/images/2016/08/15/Egl15P.jpg','http://i.niupic.com/images/2016/08/15/rpb5BX.jpg','0','5','50','200','<!-- JiaThis Button BEGIN -->\r\n<script type=\"text/javascript\" src=\"http://v3.jiathis.com/code/jiathis_r.js?move=0\" charset=\"utf-8\"></script>\r\n<!-- JiaThis Button END -->');
/*!40000 ALTER TABLE `website` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-08-01  9:57:02
