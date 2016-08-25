#!/bin/sh

source /etc/profile

NetCard=wlan0	 		# the netcard connected to the internet
PingTarget=192.168.31.1 	# the ping target, router ip or website, etc: 192.168.1.1, www.baidu.com
LogFile=/home/pi/daemon/NetReconnector.log	# log file
LogAll=true			# log msg no matter whether the net is connected, used to be check whether the script is running.

test -e $LogFile || sudo touch $LogFile

time=$(date "+%Y/%m/%d %H:%M:%S")

ret=$(ping -c 2 -W 1 -I $NetCard $PingTarget | grep 'received' | cut -d ',' -f 2 | cut -d ' ' -f 2)

if [ "$ret" = "0" -o -z "$ret" ]; then
    echo "Try Reconnect: $?, $time" | tee -a $LogFile
    sudo ifdown wlan0 && sudo ifup wlan0
else
    if [ "$LogAll" = "true" ]; then
        #echo "Network is ok, ret = $ret, $time" | tee -a $LogFile
        echo "Network is ok, ret = $ret, $time" | tee -a $LogFile
    fi
fi

exit 0
