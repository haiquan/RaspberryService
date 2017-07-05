#! /bin/sh

date +%y-%m-%d_%X >> /tmp/checkdaemon.txt
echo 'check oray daemon:' >> /tmp/checkdaemon.txt
ps -A | grep oraynewph
if [ $? != 0 ]
then
    echo 'need to run oray' >> /tmp/checkdaemon.txt
    sh /home/pi/daemon/restartOraynewph.sh >> /tmp/checkdaemon.txt
else
    echo 'oray is running' >> /tmp/checkdaemon.txt
fi

echo 'check thunder daemon:' >> /tmp/checkdaemon.txt
ps -A | grep EmbedThunderMa
if [ $? != 0 ]
then
    echo 'need to run thunder' >> /tmp/checkdaemon.txt
    sh /home/pi/daemon/startThunder.sh >> /tmp/checkdaemon.txt
else
    echo 'thunder is running' >> /tmp/checkdaemon.txt
fi
