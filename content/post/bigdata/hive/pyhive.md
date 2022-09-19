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
[PyHive](https://github.com/dropbox/PyHive)
# 安装依赖包
```
pip install sasl
pip install thrift
pip install thrift-sasl
pip install PyHive
```
如果安装 sasl 出现错误，尝试以下解决方法
- ubuntu20.04
```
sudo apt-get install libsasl2-dev
```
- windows
```
# 下载: https://www.lfd.uci.edu/~gohlke/pythonlibs/#sasl
pip install xxx/sasl-0.3.1-cp38-cp38-win_amd64.whl
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
    <!--下面二选一，root 可以改为真实使用的用户，name 和 value 中的 root 都要改-->
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
        <description>指定解析jar包 注意修改成自己的类，注意是全路径名即包名和类名</description>
	</property>  
	<property>
		<name>hive.jdbc_passwd.auth.root</name>
		<value>123456</value>
        <description>设置用户名和密码，如果有多个用户和密码，可以多写几个property。name: 用户名为最后一个:用户,value: 密码</description>
	</property-->  

	<property>
        <name>hive.server2.authentication</name>
        <value>NOSASL</value>
    </property>

</configuration>
```
# 可能出现的问题
```
AccessControlException: Permission denied: user=anonymous, access=EXECUTE, inode="/tmp/hive":root:supergroup:d-wx-w
类似于以上错误；可以对hdfs上的/tmp目录加权：
[root@node1 ~]# hdfs dfs -chmod -R 777 /tmp
```

# hiveserver2 自定义验证账户类（未验证）
将此自定义类打成jar包放入到 hive/lib 目录下。不然会报错找不到class。
```Java
package org.apache.hadoop.hive.contrib.auth;
 
 
import javax.security.sasl.AuthenticationException;
 
 
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hive.conf.HiveConf;
import org.slf4j.Logger;
 
 
public class CustomPasswdAuthenticator implements org.apache.hive.service.auth.PasswdAuthenticationProvider{
	
	private Logger LOG = org.slf4j.LoggerFactory.getLogger(CustomPasswdAuthenticator.class);
	
	private static final String HIVE_JDBC_PASSWD_AUTH_PREFIX="hive.jdbc_passwd.auth.%s";
	
	private Configuration conf=null;
	
	@Override
	public void Authenticate(String userName, String passwd) throws AuthenticationException {  
        LOG.info("user: "+userName+" try login.");  
        String passwdConf = getConf().get(String.format(HIVE_JDBC_PASSWD_AUTH_PREFIX, userName));  
        if(passwdConf==null){  
            String message = "user's ACL configration is not found. user:"+userName;  
            LOG.info(message);  
            throw new AuthenticationException(message);  
        }   
        if(!passwd.equals(passwdConf)){  
            String message = "user name and password is mismatch. user:"+userName;  
            throw new AuthenticationException(message);  
        }  
    }  
	
    public Configuration getConf() {  
        if(conf==null){  
            this.conf=new Configuration(new HiveConf());  
        }  
        return conf;  
    }  
    
    public void setConf(Configuration conf) {  
        this.conf=conf;  
    }
	
}
```