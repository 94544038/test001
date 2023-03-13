tar -zxvf  zmeTool_20230216_centos7.tar.gz -C /home/sun

cp tool_db_connection.conf /home/sun/zme_tool/config
cp license.lic /home/sun/zme_tool/config


root {
  rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022 
  yum localinstall https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm 
  yum install mysql-community-server 
  
  systemctl start mysqld 
  systemctl enable mysqld 
  
  grep 'A temporary password' /var/log/mysqld.log |tail -1 
  2023-03-08T14:20:26.705247Z 1 [Note] A temporary password is generated for root@localhost: tSq&kUF!3%:-

  tSq&kUF!3%:-

  /usr/bin/mysql_secure_installation 
 
}


yum -y install wget
wget https://download.oracle.com/otn_software/linux/instantclient/1918000/oracle-instantclient19.18-basic-19.18.0.0.0-2.x86_64.rpm
wget https://download.oracle.com/otn_software/linux/instantclient/1918000/oracle-instantclient19.18-sqlplus-19.18.0.0.0-2.x86_64.rpm
wget https://download.oracle.com/otn_software/linux/instantclient/1918000/oracle-instantclient19.18-tools-19.18.0.0.0-2.x86_64.rpm

rpm -ivh *.rpm


