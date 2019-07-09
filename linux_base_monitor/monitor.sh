#!/bin/bash
#***********************************************
#
#      Filename: monitor.sh
#
#      Author: lrtxpra@163.com
#      Description: ---
#      Create: 2018-02-26 16:20:08
#      Last Modified: 2018-02-26 16:20:08
#***********************************************


#clean monitor.txt
if [[ ! -d /home/monitor ]] ; then
	mkdir -p /home/monitor
	touch /home/monitor/monitor.txt
	echo -n "" > /home/monitor/monitor.txt
else
	>/home/monitor/monitor.txt

fi


ip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | grep -Ev  '192.*$' | grep -Ev '172.*$' | grep -Ev '10\..*$'`
if [[ -z $ip ]] ; then
	hostname=$(hostname)
fi


#system uptime info
start_time=`uptime | awk '{print $1}'`
run_time=`uptime | awk '{print $3}' | sed 's/.$//'`
fifteen_load=`uptime | awk '{print $NF}'`


#cpu processor number
cpu_proc_num=`grep -c 'processor' /proc/cpuinfo`

#cpu running info
cpu_info=`vmstat | sed -n '3p'`
cpu_us=`echo $cpu_info | awk '{print $13}'`
cpu_sy=`echo $cpu_info | awk '{print $14}'`
cpu_id=`echo $cpu_info | awk '{print $15}'`
cpu_wa=`echo $cpu_info | awk '{print $16}'`
cpu_st=`echo $cpu_info | awk '{print $17}'`

#mem info
mem_info=`free -h | sed -n '2p'`
mem_total=`echo $mem_info | awk '{print $2}'`
mem_used=`echo $mem_info | awk '{print $3}'`
mem_free=`echo $mem_info | awk '{print $4}'`
mem_shared=`echo $mem_info | awk '{print $5}'`
mem_buf_cache=`echo $mem_info | awk '{print $6}'`
mem_available=`echo $mem_info | awk '{print $7}'`


#swap info
swap_info=`free -h | sed -n '3p'`
swap_total=`echo $swap_info | awk '{print $2}'`
swap_used=`echo $swap_info | awk '{print $3}'`
swap_free=`echo $swap_info | awk '{print $4}'`

if [[ -z $ip ]] ; then
	echo "$hostname" >> /home/monitor/monitor.txt
else
	echo "$ip" >> /home/monitor//monitor.txt
fi
echo "系统启动时间:$start_time" >> /home/monitor/monitor.txt
echo "系统运行时间:$run_time" >> /home/monitor/monitor.txt
echo "中央处理器15分钟负载:$fifteen_load" >> /home/monitor/monitor.txt
echo "中央处理器正在处理程序的个数:$cpu_proc_num" >> /home/monitor/monitor.txt
echo "用户所占中央处理器的百分比:$cpu_us" >> /home/monitor/monitor.txt
echo "内核所占中央处理器的百分比:$cpu_sy" >> /home/monitor/monitor.txt
echo "中央处理器空闲率:$cpu_id" >> /home/monitor/monitor.txt
echo "中央处理器等待IO的百分比:$cpu_wa" >> /home/monitor/monitor.txt
echo "虚拟机被hypervisor使用的时间:$cpu_st" >> /home/monitor/monitor.txt
echo "内存总量:$mem_total" >> /home/monitor/monitor.txt
echo "内存使用量:$mem_used" >> /home/monitor/monitor.txt
echo "内存剩余:$mem_free" >> /home/monitor/monitor.txt
echo "内存共享:$mem_shared" >> /home/monitor/monitor.txt
echo "内存的缓存和缓冲:$mem_buf_cache" >> /home/monitor/monitor.txt
echo "可用内存:$mem_available" >> /home/monitor/monitor.txt
echo "swap空间总量:$swap_total">> /home/monitor/monitor.txt
echo "已使用swap空间:$swap_used">> /home/monitor/monitor.txt
echo "剩余swap空间:$swap_free">> /home/monitor/monitor.txt
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print "总磁盘量：" $2 " 已用空间：" $3 " 磁盘剩余空间：" $4 " 磁盘盘路径：" $1}' >> /home/monitor/monitor.txt
    
