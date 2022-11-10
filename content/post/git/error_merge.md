---
title: "error merge"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "merge了错误的分支，之后还有 commit"    # 文章描述信息
lastmod: 2022-11-08T20:36:18+08:00        # 文章修改日期
date: 2022-11-08T20:36:18+08:00
tags : [                    # 文章所属标签
    "git",
]
categories : [              # 文章所属标签
    "git",
]

---
# 测试准备
## 初始化仓库
```
➜  ~ mkdir git-test
➜  ~ cd git-test/
➜  git-test git init 
已初始化空的 Git 仓库于 /home/cjx/git-test/.git/
```
## 初始化文件
```
➜  git-test git:(master) echo master > 1.txt
➜  git-test git:(master) ✗ echo master > 2.txt
➜  git-test git:(master) ✗ echo master > 3.txt
➜  git-test git:(master) ✗ echo master > 4.txt
➜  git-test git:(master) ✗ git add .    
➜  git-test git:(master) ✗ git commit -m'master: commit'
[master （根提交） 6b0a805] master: commit
 4 files changed, 4 insertions(+)
 create mode 100644 1.txt
 create mode 100644 2.txt
 create mode 100644 3.txt
 create mode 100644 4.txt
```
## 新建分支
```
 ➜  git-test git:(master) git checkout -b branch-a      
切换到一个新分支 'branch-a'
➜  git-test git:(branch-a) echo branch-a > 5.txt
➜  git-test git:(branch-a) ✗ rm 1.txt 
➜  git-test git:(branch-a) ✗ echo branch-a > 2.txt 
➜  git-test git:(branch-a) ✗ git add .    
➜  git-test git:(branch-a) ✗ git commit -m'branch-a: commit'

➜  git-test git:(branch-a) ll 
总用量 16K
-rw-rw-r-- 1 cjx cjx 9 11月 10 22:45 2.txt
-rw-rw-r-- 1 cjx cjx 7 11月 10 22:45 3.txt
-rw-rw-r-- 1 cjx cjx 7 11月 10 22:37 4.txt
-rw-rw-r-- 1 cjx cjx 9 11月 10 22:45 5.txt
➜  git-test git:(branch-a) cat 2.txt  
branch-a
➜  git-test git:(branch-a) cat 3.txt  
master
➜  git-test git:(branch-a) cat 4.txt  
master
➜  git-test git:(branch-a) cat 5.txt  
branch-a
```
## 修改 master 分支
```
➜  git-test git:(branch-a) git checkout master 
切换到分支 'master'
➜  git-test git:(master) echo master > 5.txt 
➜  git-test git:(master) ✗ rm 3.txt 
➜  git-test git:(master) ✗ echo master-2 > 2.txt 
➜  git-test git:(master) ✗ ll 
总用量 16K
-rw-rw-r-- 1 cjx cjx 7 11月 10 22:43 1.txt
-rw-rw-r-- 1 cjx cjx 9 11月 10 22:43 2.txt
-rw-rw-r-- 1 cjx cjx 7 11月 10 22:37 4.txt
-rw-rw-r-- 1 cjx cjx 7 11月 10 22:43 5.txt
➜  git-test git:(master) ✗ cat 1.txt
master
➜  git-test git:(master) ✗ cat 2.txt  
master-2
➜  git-test git:(master) ✗ cat 4.txt  
master
➜  git-test git:(master) ✗ cat 5.txt  
master
➜  git-test git:(master) ✗ git add .    
➜  git-test git:(master) ✗ git commit -m'master: commit -2'
[master c43e460] master: commit -2
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename 3.txt => 5.txt (100%)
```
## 错误的 merge
```
➜  git-test git:(master) git checkout branch-a 
切换到分支 'branch-a'
➜  git-test git:(branch-a) git merge master 
冲突（重命名/添加）：在 master 中重命名 3.txt->5.txt。在 HEAD 中添加 5.txt
自动合并 5.txt
自动合并 2.txt
冲突（内容）：合并冲突于 2.txt
自动合并失败，修正冲突然后提交修正的结果。
➜  git-test git:(branch-a) ✗ vim 2.txt
➜  git-test git:(branch-a) ✗ ll 
总用量 12K
-rw-rw-r-- 1 cjx cjx  9 11月 10 22:47 2.txt
-rw-rw-r-- 1 cjx cjx  7 11月 10 22:37 4.txt
-rw-rw-r-- 1 cjx cjx 52 11月 10 22:46 5.txt
➜  git-test git:(branch-a) ✗ cat 2.txt  
branch-a
➜  git-test git:(branch-a) ✗ cat 4.txt  
master
➜  git-test git:(branch-a) ✗ cat 5.txt  
<<<<<<< HEAD
branch-a
=======
master
>>>>>>> master
➜  git-test git:(branch-a) ✗ vim 5.txt
➜  git-test git:(branch-a) ✗ cat 5.txt  
branch-a

➜  git-test git:(branch-a) ✗ git add .    
➜  git-test git:(branch-a) ✗ git commit
[branch-a 89c0c25] Merge branch 'master' into branch-a
➜  git-test git:(branch-a) git status 
位于分支 branch-a
无文件要提交，干净的工作区

➜  git-test git:(branch-a) ll 
总用量 12K
-rw-rw-r-- 1 cjx cjx 9 11月 10 22:47 2.txt
-rw-rw-r-- 1 cjx cjx 7 11月 10 22:37 4.txt
-rw-rw-r-- 1 cjx cjx 9 11月 10 22:48 5.txt
➜  git-test git:(branch-a) cat 2.txt
branch-a
➜  git-test git:(branch-a) cat 4.txt  
master
➜  git-test git:(branch-a) cat 5.txt  
branch-a
```
## 正常提交
```
➜  git-test git:(branch-a) echo branch-a > 6.txt
➜  git-test git:(branch-a) ✗ rm 4.txt
➜  git-test git:(branch-a) ✗ echo branch-a-2 > 5.txt   
➜  git-test git:(branch-a) ✗ ll 
总用量 12K
-rw-rw-r-- 1 cjx cjx  9 11月 10 22:47 2.txt
-rw-rw-r-- 1 cjx cjx 11 11月 10 22:52 5.txt
-rw-rw-r-- 1 cjx cjx  9 11月 10 22:51 6.txt
➜  git-test git:(branch-a) ✗ cat 2.txt
branch-a
➜  git-test git:(branch-a) ✗ cat 5.txt
branch-a-2
➜  git-test git:(branch-a) ✗ cat 6.txt
branch-a
➜  git-test git:(branch-a) ✗ git status  
位于分支 branch-a
尚未暂存以备提交的变更：
  （使用 "git add/rm <文件>..." 更新要提交的内容）
  （使用 "git restore <文件>..." 丢弃工作区的改动）
        删除：     4.txt
        修改：     5.txt

未跟踪的文件:
  （使用 "git add <文件>..." 以包含要提交的内容）
        6.txt

修改尚未加入提交（使用 "git add" 和/或 "git commit -a"）
➜  git-test git:(branch-a) ✗ git add .    
➜  git-test git:(branch-a) ✗ git commit -m'branch-a: commit-2'
[branch-a 6d7ee80] branch-a: commit-2
 3 files changed, 2 insertions(+), 2 deletions(-)
 delete mode 100644 4.txt
 create mode 100644 6.txt
```
## 查看 log
```
commit 6d7ee8056cbac6443d07791ccff9231bffb8e73e (HEAD -> branch-a)
Author: cjx <1067446576@qq.com>
Date:   Thu Nov 10 22:52:50 2022 +0800

    branch-a: commit-2

commit 89c0c259852b912c2fbbcd5c3c7f49157203dc91
Merge: 310f23a c43e460
Author: cjx <1067446576@qq.com>
Date:   Thu Nov 10 22:50:01 2022 +0800

    Merge branch 'master' into branch-a

commit c43e460cf928e79b5e209a63eb211f99ef2702c7 (master)
Author: cjx <1067446576@qq.com>
Date:   Thu Nov 10 22:45:26 2022 +0800

    master: commit -2

commit 310f23a070195b57e245ccbfc67f8a6226154568
Author: cjx <1067446576@qq.com>
Date:   Thu Nov 10 22:42:41 2022 +0800

    branch-a: commit

commit b1bf9ae33762d9b7a15eeee2c8b088a13e48ee75
Author: cjx <1067446576@qq.com>
Date:   Thu Nov 10 22:40:12 2022 +0800

    branch-a: commit

commit 6b0a805936af34e903f9ebf003f5c729ff6afb12
Author: cjx <1067446576@qq.com>
Date:   Thu Nov 10 22:38:21 2022 +0800

    master: commit
```
## 消除 merge 操作
### 方法一
1. 首先 `git log` 查看提交记录，找到出错的前一笔提交的 commit_id: `310f23a070195b57e245ccbfc67f8a6226154568`
2. 用命令 `git rebase -i commit_id`，查找提交记录
```
➜  git-test git:(branch-a) git rebase -i 310f23a070195b57e245ccbfc67f8a6226154568
```
3. 将出错那笔提交的 pick 改为 drop
```
  GNU nano 4.8                                                       /home/cjx/git-test/.git/rebase-merge/git-rebase-todo                                                        已更改  
drop c43e460 master: commit -2
pick 6d7ee80 branch-a: commit-2

# 变基 310f23a..6d7ee80 到 310f23a（2 个提交）
#
# 命令:
# p, pick <提交> = 使用提交
# r, reword <提交> = 使用提交，但修改提交说明
# e, edit <提交> = 使用提交，进入 shell 以便进行提交修补
# s, squash <提交> = 使用提交，但融合到前一个提交
# f, fixup <提交> = 类似于 "squash"，但丢弃提交说明日志
# x, exec <命令> = 使用 shell 运行命令（此行剩余部分）
# b, break = 在此处停止（使用 'git rebase --continue' 继续变基）
# d, drop <提交> = 删除提交
# l, label <label> = 为当前 HEAD 打上标记
# t, reset <label> = 重置 HEAD 到该标记
# m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
# .       创建一个合并提交，并使用原始的合并提交说明（如果没有指定
# .       原始提交，使用注释部分的 oneline 作为提交说明）。使用
# .       -c <提交> 可以编辑提交说明。
#
# 可以对这些行重新排序，将从上至下执行。
#
# 如果您在这里删除一行，对应的提交将会丢失。
#
# 然而，如果您删除全部内容，变基操作将会终止。
#
# 注意空提交已被注释掉
```
4. 保存修改
```
Successfully rebased and updated refs/heads/branch-a.
```
查看状态
```
➜  git-test git:(branch-a) git status  
位于分支 branch-a
无文件要提交，干净的工作区
➜  git-test git:(branch-a) ll 
总用量 16K
-rw-rw-r-- 1 cjx cjx  9 11月 10 22:47 2.txt
-rw-rw-r-- 1 cjx cjx  7 11月 10 23:01 3.txt
-rw-rw-r-- 1 cjx cjx 11 11月 10 23:01 5.txt
-rw-rw-r-- 1 cjx cjx  9 11月 10 23:01 6.txt
➜  git-test git:(branch-a) cat 2.txt
branch-a
➜  git-test git:(branch-a) cat 3.txt  
master
➜  git-test git:(branch-a) cat 5.txt
branch-a-2
➜  git-test git:(branch-a) cat 6.txt
branch-a
```
### 方法二

### 方法三
