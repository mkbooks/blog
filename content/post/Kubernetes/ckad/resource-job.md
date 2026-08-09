---
title: "CKAD 常用资源：Job"
author: "陈金鑫"
description : "Job 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:07:00+08:00
date: 2026-08-09T12:07:00+08:00
tags : ["kubernetes", "ckad", "Job"]
categories : ["kubernetes"]

---

`Job` 用来运行一次性任务，目标是成功完成指定数量的 Pod。CKAD 常考执行命令、设置重试和超时时间。

## YAML 模板

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: hello-job
  namespace: jobs
spec:
  completions: 1
  parallelism: 1
  backoffLimit: 3
  activeDeadlineSeconds: 60
  template:
    spec:
      restartPolicy: Never
      containers:
      - name: hello
        image: busybox
        command: ["sh", "-c", "echo hello && sleep 5"]
```

## 常考字段解析

- `spec.template`：Pod 模板，和 Pod 的 `spec` 写法一致。
- `spec.template.spec.restartPolicy`：Job 里必须是 `Never` 或 `OnFailure`。
- `spec.completions`：需要成功完成的 Pod 数量。
- `spec.parallelism`：并发运行的 Pod 数量。
- `spec.backoffLimit`：失败重试次数。
- `spec.activeDeadlineSeconds`：Job 总超时时间。

## 常用命令

```bash
k create job hello-job -n jobs --image=busybox -- sh -c 'echo hello'
k get job,pod -n jobs
k logs job/hello-job -n jobs
k describe job hello-job -n jobs
```

## 易错点

- Job 的 Pod 不应该写 `restartPolicy: Always`。
- `command` 覆盖 ENTRYPOINT，`args` 传参数；不确定时用 `sh -c` 最稳。
