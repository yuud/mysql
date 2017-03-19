#!/bin/sh
################################################
#this scripts is created by oldboy at 2007-06-09
#oldboy QQ:31333741
#site:http://www.etiantian.org
#blog:http://oldboy.blog.51cto.com
#oldboy trainning QQ group: 208160987 226199307  44246017
################################################

#init
port=3307
mysql_user="root"
mysql_pwd="oldboy"
CmdPath="/application/mysql/bin"
mysql_sock="/data/${port}/mysql.sock"
#startup function
function_start_mysql()
{
    if [ ! -e "$mysql_sock" ];then
      printf "Starting MySQL...\n"
      /bin/sh ${CmdPath}/mysqld_safe --defaults-file=/data/${port}/my.cnf 2>&1 > /dev/null &
    else
      printf "MySQL is running...\n"
      exit
    fi
}

#stop function
function_stop_mysql()
{
    if [ ! -e "$mysql_sock" ];then
       printf "MySQL is stopped...\n"
       exit
    else
       printf "Stoping MySQL...\n"
       ${CmdPath}/mysqladmin -u ${mysql_user} -p${mysql_pwd} -S /data/${port}/mysql.sock shutdown
   fi
}

#restart function
function_restart_mysql()
{
    printf "Restarting MySQL...\n"
    function_stop_mysql
    sleep 2
    function_start_mysql
}

case $1 in
start)
    function_start_mysql
;;
stop)
    function_stop_mysql
;;
restart)
    function_restart_mysql
;;
*)
    printf "Usage: /data/${port}/mysql {start|stop|restart}\n"
esac