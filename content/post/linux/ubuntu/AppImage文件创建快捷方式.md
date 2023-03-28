---
title: "Ubuntu系统中给AppImage文件创建快捷启动"          
author: "陈金鑫"             
description : "在Ubuntu系统中，怎么给AppImage文件创建快捷启动"   
date: 2023-3-28T20:00:00+08:00           
lastmod: 2023-3-28T20:00:00+08:00        

tags : [                 
    "Ubuntu",
]
categories : [            
    "Ubuntu",
]

---
要在Ubuntu系统中为AppImage文件创建快捷启动，可以按照以下步骤进行操作：
# 一般流程
<li>
<p>1. 打开终端，进入到AppImage文件所在的目录。</p>
</li>
<li>
<p>2. 输入以下命令，将文件标记为可执行文件：</p>
<p>chmod +x 文件名.AppImage</p>
</li>
<li>
<p>3. 运行以下命令，将AppImage文件拷贝到/usr/local/bin目录中：</p>
<p>sudo cp 文件名.AppImage /usr/local/bin/程序名</p>
<p>（注意将“文件名”替换为实际的文件名，“程序名”替换为你想要的程序名）</p>
</li>
<li>
<p>4. 创建一个.desktop文件，在桌面上创建一个快捷方式。在终端中输入以下命令：</p>
<p>gedit ~/.local/share/applications/程序名.desktop</p>
<p>（注意将“程序名”替换为你想要的程序名）</p>
</li>
<li>
<p>5. 在打开的gedit窗口中输入以下内容：</p>
<p>[Desktop Entry]
Type=Application
Name=程序名
Exec=/usr/local/bin/程序名
Icon=/路径/图标名.png</p>
<p>（注意将“程序名”替换为你想要的程序名，“/路径/图标名.png”替换为你想要使用的图标的路径和文件名）</p>
</li>
<li>
<p>6. 保存并关闭gedit窗口。</p>
</li>
现在，在桌面上应该会出现一个新的快捷方式，你可以使用它来启动你的AppImage程序了。

# 以 Cursor-0.1.9.AppImage 为例
1. 打开终端，进入到AppImage文件所在的目录。
2. `chmod +x Cursor-0.1.9.AppImage`
3. `sudo cp Cursor-0.1.9.AppImage /usr/local/bin/Cursor`
4. `gedit ~/.local/share/applications/Cursor.desktop`
5. 在打开的gedit窗口中输入以下内容：
```
[Desktop Entry]
Type=Application
Name=Cursor
Exec=/usr/local/bin/Cursor
Icon=/home/cjx/图片/Cursor.png
```
6. 保存并关闭gedit窗口。
现在，在桌面上应该会出现一个新的快捷方式，你可以使用它来启动你的AppImage程序了。
