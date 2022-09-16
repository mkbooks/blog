---
title: "使用Python操作hive"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "在 Ubuntu20.04 系统下，使用 Python 操作 hive，这里使用 pyhive 包"    # 文章描述信息
lastmod: 2022-09-16T11:20:00+08:00     # 文章修改日期
date: 2022-09-16T11:20:00+08:00
tags : [                    # 文章所属标签
    "大数据",
    "hive"
]
categories : [              # 文章所属标签
    "大数据"
]

---
![PyHive](https://github.com/dropbox/PyHive)
# 安装依赖包
```
pip install sasl
pip install thrift
pip install thrift-sasl
pip install PyHive
```
如果安装 sasl 出现错误，尝试以下解决方法
```
sudo apt-get install libsasl2-dev
```
# 代码样例
```
from pyhive import hive

conn = hive.Connection(host='192.168.122.251', port=10000, username='root', database='default', auth='NOSASL')
cursor = conn.cursor()
cursor.execute('SELECT * FROM test LIMIT 10')
for i in cursor.fetchall():
    print(i)
conn.close()
```
# 配置
## hadoop
/opt/modules/hadoop-2.7.0/etc/hadoop/core-site.xml
```
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://172.168.0.2:9000</value>
        <description>配置NameNode的主机地址及其端口号</description>
    </property>
    <property>
        <name>hadoop.http.staticuser.user</name>
        <value>kfk</value>
        <description>HDFS Web UI 用户名</description>
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/opt/modules/hadoop-2.7.0/tmp</value>
        <description>其他临时目录的基础。（HDFS等相关文件的存储目录基础，很重要）</description>
    </property>

    <!--hive-->
    <property>
        <name>hadoop.proxyuser.root.hosts</name>
        <value>*</value>
    </property>
    <!--下面二选一-->
    <!--property>
        <name>hadoop.proxyuser.root.groups</name>
        <value>*</value>
    </property-->
    <property>
        <name>hadoop.proxyuser.root.groups</name>
        <value>root</value>
    </property>

</configuration>
```
## hive
/opt/modules/hive-2.3.4-bin/conf/hive-site.xml
```
<configuration>
	<!--Hive集成MySQL-->
	<property>
		<name>javax.jdo.option.ConnectionURL</name>
		<value>jdbc:mysql://172.168.0.3/metastore?createDatabaseIfNotExist=true</value>
		<description>JDBC connect string for a JDBC metastore</description>
	</property>

	<property>
		<name>javax.jdo.option.ConnectionDriverName</name>
		<value>com.mysql.jdbc.Driver</value>
		<description>Driver class name for a JDBC metastore</description>
	</property>
	
	<property>
		<name>javax.jdo.option.ConnectionUserName</name>
		<value>root</value>
		<description>username to use against metastore database</description>
	</property>

	<property>
		<name>javax.jdo.option.ConnectionPassword</name>
		<value>123456</value>
		<description>password to use against metastore database</description>
	</property>
	
	<!--Hive显示设置-->
	<property>
		<name>hive.cli.print.header</name>
		<value>true</value>
		<description>Whether to print the names of the columns in query output.</description>
	</property>
	<property>
	    <name>hive.cli.print.current.db</name>
	    <value>true</value>
	    <description>Whether to include the current database in the Hive prompt.</description>
	</property>


	<property>
		<name>hive.metastore.schema.verification</name>
		<value>false</value>
		<description>
		Enforce metastore schema version consistency.
		True: Verify that version information stored in metastore matches with one from Hive jars.  Also disable automatic
			schema migration attempt. Users are required to manully migrate schema after Hive upgrade which ensures
			proper metastore schema migration. (Default)
		False: Warn if the version information stored in metastore doesn't match with one from in Hive jars.
		</description>
	</property>
	<property>
		<name>datanucleus.schema.autoCreateAll</name>
		<value>true</value>
		<description>creates necessary schema on a startup if one doesn't exist. set this to false, after creating it once</description>
	</property>
	
    <!--hiveserver2 配置-->
	<!--property>
		<name>hive.server2.authentication</name>
		<value>CUSTOM</value>
	</property>
 
	<property>
		<name>hive.server2.custom.authentication.class</name>
		<value>org.apache.hadoop.hive.contrib.auth.CustomPasswdAuthenticator</value>
	</property>  
 
	<property>
		<name>hive.jdbc_passwd.auth.root</name>
		<value>123456</value>
	</property-->  
	<property>
        <name>hive.server2.authentication</name>
        <value>NOSASL</value>
    </property>

</configuration>
```