---
title: "pods"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "基于 nginx 官方镜像（它的 Dockerfile 明确写了 ENTRYPOINT [\"nginx\"] 和 CMD [\"-g\", \"daemon off;\"]）说明启动命令的差异"    # 文章描述信息
lastmod: 2026-08-09T10:39:00+08:00         # 文章修改日期
date: 2026-08-09T10:39:00+08:00
tags : [                    # 文章所属标签
    "kubernetes",
    "ckad",
    "Pod",
]
categories : [              # 文章所属标签
    "kubernetes"
]

---

用实际运行的 Pod 来直观验证。下面的 4 个示例都基于 `nginx` 官方镜像（它的 Dockerfile 明确写了 `ENTRYPOINT ["nginx"]` 和 `CMD ["-g", "daemon off;"]`）。

我会用 `kubectl run` 命令创建 4 个 Pod，并同步给出它们在 K8s 中对应的 `command` 和 `args` 字段含义。

## 场景一：什么都不设置（使用镜像默认值）

```bash
kubectl run demo-default --image=nginx --restart=Never
```

- K8s 字段：`command` 未设置，`args` 未设置。
- 实际执行：`nginx -g "daemon off;"`
- 运行差异：1 号进程是 `nginx`，参数是默认的 `daemon off`。这是最标准的 Web 容器启动方式。

## 场景二：只设置 `args`（覆盖 CMD，保留 ENTRYPOINT）

```bash
kubectl run demo-args --image=nginx --restart=never -- -g "daemon off; worker_processes 4;"
```

> 注意：`--` 后面的内容在 K8s 中会被解析为 `args`。

- K8s 字段：`command` 未设置，`args`: ["-g", "daemon off; worker_processes 4;"]
- 实际执行：`nginx -g "daemon off; worker_processes 4;"`
- 运行差异：程序骨架没变（仍是 `nginx`），但启动参数变了（`worker_processes` 从默认的 1 变成了 4）。这在调整运行配置时非常有用。

## 场景三：只设置 `command`（覆盖 ENTRYPOINT，原 CMD 被丢弃）

```bash
kubectl run demo-command --image=nginx --restart=Never --command -- /bin/sh -c "sleep 8888"
```

> 注意：`--command` 后面的内容在 K8s 中会被解析为 `command`。

- K8s 字段：`command`: ["/bin/sh", "-c", "sleep 8888"]，`args` 未设置。
- 实际执行：`/bin/sh -c "sleep 8888"`
- 运行差异：完全替换了可执行程序。容器里根本没有 `nginx` 进程，且镜像自带的 `-g daemon off` 参数被彻底丢弃。此时容器变成了一个单纯的“休眠器”。

## 场景四：同时设置 `command` 和 `args`（完全自定义）

```bash
kubectl run demo-both --image=nginx --restart=Never --command -- /bin/sh -c "echo $*" -- arg1 arg2
```

- K8s 字段：`command`: ["/bin/sh", "-c", "echo $*"]，`args`: ["arg1", "arg2"]
- 实际执行：`/bin/sh -c "echo $* arg1 arg2"`（终端会输出 arg1 arg2 后容器退出，这里仅做演示）
- 运行差异：启动程序和参数完全由用户操控，与原镜像定义的 `ENTRYPOINT` 和 `CMD` 毫无关系。

## 直观对比表

| Pod 名称 | K8s `command` | K8s `args` | 最终运行的命令 | 核心差异点 |
| --- | --- | --- | --- | --- |
| demo-default | 未设置 | 未设置 | `nginx -g "daemon off;"` | 原汁原味的镜像默认行为 |
| demo-args | 未设置 | 覆盖了 `CMD` | `nginx -g "daemon off; worker_processes 4;"` | 只改参数，保留原程序 |
| demo-command | 覆盖了 `ENTRYPOINT` | 未设置（被忽略） | `/bin/sh -c "sleep 8888"` | 彻底换程序，丢掉了镜像自带参数 |
| demo-both | 覆盖了 `ENTRYPOINT` | 覆盖了 `CMD` | `/bin/sh -c "echo $* arg1 arg2"` | 完全自定义，镜像只提供文件系统 |

## 如何肉眼验证差异？

创建 Pod 后，可以用下面命令进入容器查看 1 号进程：

```bash
## 查看 demo-default 的进程
kubectl exec demo-default -- ps aux | grep nginx

## 查看 demo-command 的进程（你会发现根本找不到 nginx）
kubectl exec demo-command -- ps aux | grep sleep
```

## 核心结论

`command` 是“谁是老大”，一旦设置，镜像的 `ENTRYPOINT` 就作废了。

`args` 是“给老大传啥话”，如果没设置 `command`，它就替换镜像的 `CMD` 传给原有的老大。
