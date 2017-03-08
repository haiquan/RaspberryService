#!/bin/sh

source /etc/profile

NetCard=wlan0	 		# the netcard connected to the internet
PingTarget=192.168.123.1 	# the ping target, router ip or website, etc: 192.168.1.1, www.baidu.com
PingTest=192.168.123.247
LogFile=/home/pi/daemon/NetReconnector.log	# log file
LogAll=true			# log msg no matter whether the net is connected, used to be check whether the script is running.

test -e $LogFile || sudo touch $LogFile

time=$(date "+%Y/%m/%d %H:%M:%S")

ret=$(ping -c 2 -W 1 -I $NetCard $PingTarget | grep 'received' | cut -d ',' -f 2 | cut -d ' ' -f 2)

if [ "$ret" = "0" -o -z "$ret" ]; then
    echo "Try Reconnect: $?, $time" | tee -a $LogFile
    sudo ifdown wlan0 && sudo ifup wlan0
else
    ret2=$(ifconfig wlan0 | grep 192.168.123.234)
    if [ "$ret2" = "" ]; then
        echo "Try Reconnect: $?, $time" | tee -a $LogFile
        sudo ifdown wlan0 && sudo ifup wlan0
    fi
    if [ "$LogAll" = "true" ]; then
        #echo "Network is ok, ret = $ret, $time" | tee -a $LogFile
        echo "Network is ok, ret = $ret, $time"
        #ping -c 4 $PingTest
    fi
fi

exit 0
