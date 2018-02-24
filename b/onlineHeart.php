<?php
/**
 *  Author： METO
 *  Version: 0.1.0
 */

class bilibili{

    protected $_COOKIE='_dfcaptcha=6ba6dc770dd5499de2b92db6207005eb; user_face=http%3A%2F%2Fi2.hdslb.com%2Fbfs%2Fface%2F33e5347af52a721681645d462b9ed29784e532c3.jpg; bili_jct=168cb0ec97b3dd14bbf202b3293fbefd; DedeUserID=156737731; DedeUserID__ckMd5=23560370ab35fb43; SESSDATA=afe757a2%2C1517045104%2Ccada4b32; JSESSIONID=CEE3973A70696973AEFCC90B716C2F13; LIVE_BUVID=a431336eef1dc3c37e14cbafa5fa25e1; LIVE_BUVID__ckMd5=43a84fa262573ff2; sid=4o9sl3ju';
    protected $_USERAGENT='Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.101 Safari/537.36';
    protected $_REFERER='http://live.bilibili.com/';

    private function getinfo(){
        $data=json_decode(self::curl('http://live.bilibili.com/User/getUserInfo'),1);
        $a=$data['data']['user_intimacy'];
        $b=$data['data']['user_next_intimacy'];
        $per=round($a/$b*100,2);
        echo "===============================\n";
        echo "昵称: {$data['data']['uname']} \n";
        echo "等级: {$data['data']['user_level']} \n";
        echo "经验值: {$a}/{$b} {$per}%\n";
        echo "签到状态: ".self::sign()."\n";
        echo "===============================\n";
    }

    private function sign(){
        $raw=json_decode(self::curl('http://live.bilibili.com/sign/doSign'),1);
        return $raw['msg'];
    }

    public function cron(){
        header('Content-Type: text/txt; charset=UTF-8');
        echo date('[Y-m-d H:i:s]',time())."\n";
        $raw=json_decode(self::curl('http://live.bilibili.com/User/userOnlineHeart'),1);
        if(!isset($raw['data'][1]))echo " > SUCCESS\n";
        else echo " > INFO: already send @ ".date('Y-m-d H:i:s',$raw['data'][1])."\n";

        self::getinfo();
    }

    protected function curl($url){
        $curl=curl_init();
        curl_setopt($curl,CURLOPT_URL,$url);
        curl_setopt($curl,CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl,CURLOPT_CONNECTTIMEOUT, 10);
        curl_setopt($curl,CURLOPT_REFERER,$this->_REFERER);
        curl_setopt($curl,CURLOPT_COOKIE,$this->_COOKIE);
        curl_setopt($curl,CURLOPT_USERAGENT,$this->_USERAGENT);
        $result=curl_exec($curl);
        curl_close($curl);
        return $result;
    }
}

(new bilibili)->cron();
