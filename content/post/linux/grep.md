---
title: "grep 使用"
author: "陈金鑫"
description : "grep 使用"
lastmod: 2023-03-22T17:00:00+08:00
date: 2023-03-22T17:00:00+08:00
tags : [
    "Linux",
    "grep"
]
categories : [
    "grep"
]

---
### 文件内容查找
```
sudo grep -r --exclude="*.log" --exclude="*.pom" --exclude=".zsh_history" --exclude-dir=.vscode --exclude-dir=wise-projects --exclude-dir=go --exclude-dir=maven --exclude-dir=temp --exclude-dir=.gradle --exclude="*.xml" --exclude="*.tar" --exclude-dir="images" "JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64" /etc 2>/dev/null
```
output:
```
/etc/profile:export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
```
这是一个在Linux系统中使用sudo命令搜索文件内容的命令。该命令的作用是在/etc目录下搜索包含"JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64"字符串的文件内容，但是排除了一些文件类型和目录。具体的参数解释如下：
```
sudo: 表示以管理员权限运行该命令。
grep: 用于在文件中查找匹配的字符串。
-r: 表示递归搜索子目录。
--exclude="*.log": 排除所有后缀为.log的文件。
--exclude="*.pom": 排除所有后缀为.pom的文件。
--exclude=".zsh_history": 排除所有名为.zsh_history的文件。
--exclude-dir=.vscode: 排除名为.vscode的子目录。
--exclude-dir=wise-projects: 排除名为wise-projects的子目录。
--exclude-dir=go: 排除名为go的子目录。
--exclude-dir=maven: 排除名为maven的子目录。
--exclude-dir=temp: 排除名为temp的子目录。
--exclude-dir=.gradle: 排除名为.gradle的子目录。
--exclude="*.xml": 排除所有后缀为.xml的文件。
--exclude="*.tar": 排除所有后缀为.tar的文件。
--exclude-dir="images": 排除名为images的子目录。
"JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64": 要搜索的字符串。
/etc: 要搜索的目录。
2>/dev/null: 将错误信息输出到空设备，即不输出任何错误信息。
```
