---
title: "CKAD 常用资源：CronJob"
author: "陈金鑫"
description : "CronJob 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:08:00+08:00
date: 2026-08-09T12:08:00+08:00
tags : ["kubernetes", "ckad", "CronJob"]
categories : ["kubernetes"]

---

`CronJob` 按时间表达式创建 Job。CKAD 常考每分钟、每小时、每天执行一次，以及并发策略。

## YAML 模板

```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: log-cleaner
  namespace: jobs
spec:
  schedule: "0 * * * *"
  concurrencyPolicy: Forbid
  successfulJobsHistoryLimit: 3
  failedJobsHistoryLimit: 1
  jobTemplate:
    spec:
      backoffLimit: 2
      template:
        spec:
          restartPolicy: OnFailure
          containers:
          - name: cleaner
            image: busybox
            command: ["sh", "-c", "date && rm -rf /tmp/*.log"]
```

## 常考字段解析

- `spec.schedule`：cron 表达式，`*/5 * * * *` 表示每 5 分钟。
- `spec.concurrencyPolicy`：并发策略，`Allow`、`Forbid`、`Replace`。
- `spec.jobTemplate`：Job 模板，里面再写 Pod 模板。
- `successfulJobsHistoryLimit`：保留成功 Job 数量。
- `failedJobsHistoryLimit`：保留失败 Job 数量。

## 常用命令

```bash
k create cronjob log-cleaner -n jobs --image=busybox --schedule='0 * * * *' -- sh -c 'date'
k get cronjob,job,pod -n jobs
k create job manual-run -n jobs --from=cronjob/log-cleaner
k describe cronjob log-cleaner -n jobs
```

## 易错点

- `jobTemplate.spec.template.spec.restartPolicy` 仍然必须是 `Never` 或 `OnFailure`。
- cron 表达式要加引号，避免 `*` 被 shell 处理。
