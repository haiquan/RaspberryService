#! /bin/sh

#/home/pi/thunder/portal
#exit
LogFile=/home/pi/daemon/thunder.log

ps -A | grep EmbedThunderMa
if [ $? != 0 ]
then
    echo 'need to run thunder' | tee -a $LogFile
    sh /home/pi/daemon/startThunder.sh >> /tmp/checkdaemon.txt
else
    #echo 'thunder is running' >> /tmp/checkdaemon.txt
    echo 'thunder is running'
fi
