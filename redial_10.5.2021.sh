#!/bin/sh

#做30次拨号循环，30次如果都没拨上也停止
for i in `seq 30`;

do 
IP=$(ifconfig pppoe-wan 2> /dev/null | grep 'inet addr' | awk '{print $2}' | cut -d: -f2)
#获取wan口ip
sleep 2
IPP=${IP:0:5}
#取wan口IP前五位

if [ "$IPP" = "58.32" ]; then
#如果IP开头是58.32的话，跳出循环
  echo "CN2 Public IP："
  echo $IP
  break
  
else 
  echo "Current Public IP："
  echo $IP
  echo "Redial ..."
  ifdown wan | ifup wan 
  sleep 10
#否则保留IP，重拨

fi

done