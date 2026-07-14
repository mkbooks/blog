---
title: 关于
menu:
    main: 
        weight: -90
        url: "/about"
        params:
            icon: user
---
<div class="resume-wrapper">

# 陈金鑫｜云原生平台 / 多云K8s集群管理 / 中间件运维

## 基础信息

- 手机：17137621499
- 邮箱：<chenjinxin@chenjinxin.cn>
- 博客：<https://chenjinxin.cn>
- 学历：黑河学院｜计算机科学与技术｜本科｜2019届
- 方向：云原生平台、多云K8s集群管理、中间件运维、IaC、可观测性

## 个人简介

近7年平台研发与运维经验，其中5年+聚焦云原生与基础设施平台建设。在华为数据底座项目中，主导 **300+ 集群**的统一纳管与监控体系建设，覆盖 EKS 等多云环境，推动资源利用率提升 30%+、成本降低 20%+。在可利邦主导 **从0到1搭建 Kubernetes 基础平台**（含镜像仓库、NFS、监控告警、日志平台、APISIX 网关、OpenVPN 网络），具备生产级集群规划、部署、升级与维护经验。擅长中间件体系搭建与运维（Kafka、APISIX、Nacos、Elasticsearch、RabbitMQ 等），有 Prometheus / Grafana / AlertManager 可观测性体系从0到1的完整建设经验。具备技术方案评审、Code Review、研发规范制定、跨域团队协作经验，将 AI Coding 实践融入日常研发流程。

## 核心技能

### Expert

- **多云 K8s 集群管理**：精通 K8s 核心架构（API 对象、调度器、CNI/CSI），有 EKS 生产级集群纳管经验（300+ 集群、最大 1000+ 节点），熟悉集群规划、部署、升级、RBAC、资源配额、网络策略与安全加固。
- **中间件运维**：有 Kafka、APISIX、Nacos、Elasticsearch、RabbitMQ 等中间件的生产级部署、运维、监控与调优经验，熟悉 APISIX 网关路由、限流、鉴权能力建设。
- **可观测性平台**：从0到1构建 Prometheus / Grafana / AlertManager / ECK（EFK）监控、日志与告警体系，采集频率分钟级、覆盖 50+ 指标、数据准确率 99%+，故障发现时间从 0.5 天缩短至 5 分钟。
- **Helm / K8s 生态**：有 Helm Chart 开发与容器化交付经验，熟悉 HPA / VPA、资源配额、GPU 共享与资源隔离策略（Volcano 调度器），了解 Kubernetes Operator 开发模式。
- **后端语言**：Java、Python、Go、Shell

### Proficient

- **IaC 与 DevOps**：Docker、Jenkins / CI/CD、镜像构建、Git 工作流，具备 Fabric 自动化部署脚本编写经验，正在深入学习 Terraform 多云 IaC 落地。
- **中间件扩展**：熟悉 Nacos 服务注册与配置中心、Kafka 高吞吐消息链路，了解 Pulsar、RocketMQ、Consul、Polaris 等中间件的架构原理与应用场景。
- **数据库与存储**：MySQL、PostgreSQL / DWS、Redis、MongoDB、Elasticsearch / CSS、NFS 存储
- **Linux 基础设施**：熟悉 Linux 网络、存储、安全等基础知识，具备故障排查和问题定位能力（网络、磁盘、内存、CPU 等维度）。
- **分布式计算**：Spark、Flink、Hive、Hadoop、YARN，有 TB 级日志处理经验。

## 工作经历

## 上海科之锐人才咨询有限公司｜软件开发工程师｜华为数据底座方向

- 时间：2023年7月 - 至今
- 方向：云原生平台、多云K8s集群管理、资源纳管、可观测性、GPU调度

### 项目一：多云 K8s 集群统一纳管｜资源采集 / 资源监控 / 利用率治理

- 建设异构资源统一纳管与监控链路，覆盖 **300+ 集群**（含 EKS 等多云环境）、最大 1000+ 节点集群、约 500+ GPU 卡、1000+ 数据库实例、2000+ 作业、500+ 用户应用。
- 对接云资源接口与内部 IAM，完成资源归属识别、资源亲缘关系、利用率分析、容量治理和运营看板数据同步。
- 将监控采集频率从小时级提升至 **每分钟一次**，覆盖 50+ 指标，监控数据准确率达到 99%+，故障发现时间从平均 0.5 天缩短至 **5 分钟以内**。
- 通过资源治理、调度优化和利用率分析，推动资源利用率提升 30%+，整体成本降低 20%+。
- 参与 K8s 集群安全基线梳理与 RBAC 权限治理，推动集群规范化运维。

**核心技术**：Java、Python、Flink、Spark、Kafka、Prometheus、Grafana、EKS、MRS、DWS、CSS

### 项目二：GPU K8s 集群建设与调度优化｜Volcano / 高性能网络

- 新增纳管高性能 GPU Kubernetes 集群（3 Master + 40 Worker，单节点 72 核 / 512G 内存 / 8 张 V100，配备 IB 网卡），打通 RDMA 加速跨节点数据传输链路。
- 基于 **Volcano** 构建队列调度、优先级调度、GPU 共享和资源隔离机制，保障计算资源高效利用与公平分配。
- 对接 Prometheus / Grafana / 内部日志告警平台，实现任务、资源链路的可观测与故障定位。
- 推动 Helm Chart 标准化交付，参与 K8s 集群网络策略与安全组配置。

**核心技术**：Kubernetes、Volcano、Helm、RDMA、InfiniBand、Prometheus、Grafana、Python、Java

### 项目三：中间件与计算平台运维｜Kafka / Flink / EKS

- 参与统一计算与数据服务平台建设，集成 Spark、Flink、Hive、OBS、DWS、CSS 等能力，支撑批处理、流处理与交互式 SQL。
- 建设数据库统一纳管与查询能力，覆盖 MySQL、MongoDB、Redis、DWS、CSS 等 1000+ 数据库与数据服务实例。
- 维护 Kafka 消息链路（TB 级日志采集与处理），对接 Nacos 服务注册与配置中心，完成平台可观测、合规审计、镜像构建与容器化部署。

**核心技术**：Java、Spring Boot、Spring Cloud、Kafka、Flink、Spark、Hive、EKS、Nacos、MRS

## 北京可利邦信息技术股份有限公司｜大数据 & 后台开发工程师

- 时间：2021年8月 - 2023年7月
- 方向：Kubernetes 平台建设、中间件运维、监控告警、网关平台

### 项目一：Kubernetes 基础设施从0到1｜集群搭建 / 中间件运维

- **从0到1主导** K8s 基础平台建设，搭建包含 Kubernetes 集群、Docker 镜像仓库（Harbor）、NFS 共享存储、OpenVPN 安全网络在内的完整基础设施层。
- 独立完成 **Prometheus / AlertManager 监控告警体系**建设，覆盖集群节点、Pod、中间件等维度，设定分级告警策略。
- 基于 ECK（Elasticsearch on Kubernetes）搭建日志平台，集成 Fluentd 采集、Kibana 可视化，实现全链路日志检索与故障排查。
- 建设 **APISIX 统一网关中心**，实现路由管理、限流、鉴权、灰度发布等能力，为多个微服务提供统一入口。
- 负责 K8s 集群日常运维，包括版本升级、节点扩缩容、RBAC 权限管理、网络策略配置与安全加固。

**核心技术**：Python、Go、Kubernetes、Docker、Prometheus、AlertManager、APISIX、ECK、Elasticsearch、Fluentd、Kibana、Helm、OpenVPN

### 项目二：隐私计算平台容器化｜KubeFATE / 中间件集成

- 基于 KubeFATE 框架完成联邦学习平台的容器化部署和产品化封装，项目获得信通院《联邦学习基础能力评测证书》和中互金《联邦学习产品安全认证证书》。
- 集成 Kafka 消息队列、Redis 缓存、MySQL 持久化存储等中间件，完成中间件性能调优与运维文档规范。
- 负责生产环境部署、运维脚本编写和 Fabric 自动化编排。

**核心技术**：Kubernetes、KubeFATE、Docker、Kafka、Redis、MySQL、APISIX、Prometheus、Fabric

## 深圳掌众智能科技股份有限公司｜高级 Scala / Java 后端开发

- 时间：2019年7月 - 2019年11月
- 方向：高并发广告交易平台、Kafka 日志采集、准实时计算

### 核心成果

- 维护 ADX 广告交易平台，支撑每日约 **4 亿次**广告源请求、约 1 亿次广告展示、TB 级日志生产、100+ DSP 对接，具备高并发系统运维经验。
- 设计并实现日志分析系统，构建 **Flume → Kafka → Spark Streaming → Hive / HBase / HDFS** 完整链路，完成 Kafka 集群的高吞吐配置与消费组管理。
- 参与 CDH 企业大数据平台搭建（15 台节点、60TB 存储），部署 Zookeeper、YARN HA、HDFS HA、Hive、HBase、Flume、Spark 等组件。

**核心技术**：Scala、Java、Kafka、Spark Streaming、Hadoop、Hive、HBase、HDFS、MySQL、PostgreSQL、Prometheus

## 深圳市维知科技有限责任公司｜大数据研发工程师

- 时间：2020年4月 - 2021年8月
- 参与 AI 中台服务平台建设，负责 Kubernetes 平台部署、Docker 镜像制作、Kafka / Redis / RabbitMQ 等中间件运维，以及 Bot / ASR / TTS / OCR 等 AI 引擎的容器化接入与管理。

**核心技术**：Kotlin、Vert.x、Kubernetes、Docker、Prometheus、Kafka、Redis、MySQL、RabbitMQ

## 文思海辉｜初级大数据分析与挖掘顾问

- 时间：2019年12月 - 2020年4月
- 参与中广核供应链数据仓库建设，负责 HANA / MSSQL / Oracle 数据迁移方案验证、ETL 自动化流程设计和技术文档输出。

**核心技术**：SQL、MSSQL、HANA、Inceptor、HyperBase、Search

## 中诚信国际信用评级有限责任公司｜全栈开发工程师｜实习

- 时间：2018年7月 - 2019年6月
- 参与金融风控 SaaS 平台建设，负责后端开发、数据库设计、SQL、ETL；项目获"2019中国金融创新奖——十佳智能风控创新奖"。

**核心技术**：Java、Spring Boot、Redis、MySQL、MSSQL、SQL

## 证书与荣誉

- 阿里云云计算高级工程师 ACP 认证
- 阿里云大模型高级工程师 ACP 认证
- 国家奖学金
- 省三好学生
- 蓝桥杯全国软件和信息技术专业人才大赛决赛三等奖
- 信通院《联邦学习基础能力评测证书》项目参与
- 中互金认证《联邦学习产品安全认证证书》项目参与

## 专业发展 & 技术前瞻

- **K8s 认证方向**：备考 CKAD、CKA、CKS 认证，系统强化应用开发、集群管理、安全加固与云原生安全能力，持续学习 K8s 网络隔离加固、Admission Controller 开发与 OPA/Gatekeeper 策略引擎。
- **中间件与多云方向**：持续加深 Kafka / Pulsar / RocketMQ 等消息中间件的性能调优与容量规划，关注 Consul / Polaris 服务网格技术在异构环境下的落地实践，跟进 Terraform 多云 IaC 自动化编排。
- **安全合规方向**：关注 KSPM / CSPM 云安全态势管理，学习容器镜像安全扫描（Trivy）、运行时安全（Falco）与网络策略精细化管控。
- **技术前沿关注**：持续跟踪云原生生态（Istio、Cilium、Kyverno、Crossplane 等），在日常开发中深度使用 Cursor / Copilot / OpenCode 等 AI Coding 工具提升运维自动化水平。

</div>

<style>
.resume-wrapper {
    --resume-primary: #2563eb;
    --resume-primary-dark: #1e40af;
    --resume-primary-soft: #eff6ff;
    --resume-text: #1f2937;
    --resume-muted: #5b6472;
    --resume-border: #dbe4f0;
    --resume-surface: #ffffff;
    --resume-section: #f8fafc;

    max-width: 920px;
    margin: 2.5rem auto;
    padding: clamp(1.5rem, 4vw, 3rem);
    color: var(--resume-text);
    background: var(--resume-surface);
    border: 1px solid rgba(148, 163, 184, 0.22);
    border-radius: 18px;
    box-shadow: 0 18px 45px rgba(15, 23, 42, 0.08);
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "PingFang SC", "Microsoft YaHei", sans-serif;
    font-size: 16px;
    line-height: 1.72;
    letter-spacing: 0.01em;
}

.resume-wrapper * {
    box-sizing: border-box;
}

.resume-wrapper h1,
.resume-wrapper h2,
.resume-wrapper h3,
.resume-wrapper h4 {
    color: var(--resume-text);
    line-height: 1.28;
    letter-spacing: 0;
}

.resume-wrapper h1 {
    margin: 0 0 1.2rem;
    padding: 0 0 1.15rem;
    border-bottom: 3px solid var(--resume-primary);
    font-size: clamp(1.9rem, 4vw, 2.65rem);
    font-weight: 800;
    text-align: center;
}

.resume-wrapper h2 {
    margin: 2.4rem 0 1rem;
    padding: 0 0 0.55rem 0.8rem;
    border-bottom: 1px solid var(--resume-border);
    border-left: 0.38rem solid var(--resume-primary);
    font-size: 1.55rem;
    font-weight: 750;
}

.resume-wrapper h3 {
    margin: 1.6rem 0 0.85rem;
    padding: 0.85rem 1rem;
    border-left: 4px solid var(--resume-primary);
    border-radius: 12px;
    background: linear-gradient(90deg, var(--resume-primary-soft), rgba(239, 246, 255, 0));
    font-size: 1.22rem;
    font-weight: 750;
}

.resume-wrapper h4 {
    margin: 1.25rem 0 0.65rem;
    font-size: 1.05rem;
    font-weight: 720;
    color: var(--resume-primary-dark);
}

.resume-wrapper p {
    margin: 0.7rem 0;
}

.resume-wrapper ul {
    margin: 0.45rem 0 1rem;
    padding-left: 1.35rem;
}

.resume-wrapper li {
    margin: 0.34rem 0;
    color: var(--resume-text);
}

.resume-wrapper li::marker {
    color: var(--resume-primary);
}

.resume-wrapper strong {
    color: var(--resume-primary-dark);
    font-weight: 700;
}

.resume-wrapper a {
    color: var(--resume-primary-dark);
    text-decoration: none;
    border-bottom: 1px solid rgba(37, 99, 235, 0.35);
}

.resume-wrapper a:hover {
    color: var(--resume-primary);
    border-bottom-color: currentColor;
}

.resume-wrapper hr {
    height: 1px;
    margin: 1.75rem 0;
    border: 0;
    background: linear-gradient(90deg, transparent, var(--resume-border), transparent);
    opacity: 1;
}

.resume-wrapper h2:first-of-type + ul {
    margin: 0.6rem 0 1.2rem;
    padding: 1rem 1.15rem;
    border: 1px solid var(--resume-border);
    border-radius: 14px;
    background: var(--resume-section);
    list-style-position: inside;
}

.resume-wrapper h2:first-of-type + ul li {
    margin: 0;
    color: var(--resume-muted);
}

.resume-wrapper h3 + ul {
    margin-top: 0.65rem;
    padding: 0.85rem 1rem 0.85rem 1.35rem;
    border: 1px solid rgba(219, 228, 240, 0.85);
    border-radius: 12px;
    background: rgba(248, 250, 252, 0.7);
}

.resume-wrapper h4 + ul {
    margin-top: 0.45rem;
}

@media (max-width: 768px) {
    .resume-wrapper {
        margin: 0;
        padding: 1.25rem;
        border-radius: 0;
        border-left: 0;
        border-right: 0;
        box-shadow: none;
        font-size: 15px;
    }
}

@media print {
    @page {
        size: A4 portrait;
        margin: 12mm 11mm;
    }

    html,
    body {
        margin: 0 !important;
        padding: 0 !important;
        background: #fff !important;
    }

    body * {
        visibility: hidden !important;
    }

    .resume-wrapper,
    .resume-wrapper * {
        visibility: visible !important;
    }

    .resume-wrapper {
        position: absolute;
        inset: 0 auto auto 0;
        width: 100% !important;
        max-width: none !important;
        margin: 0 !important;
        padding: 0 !important;
        border: 0 !important;
        border-radius: 0 !important;
        box-shadow: none !important;
        background: #fff !important;
        color: #111827 !important;
        font-size: 9.2pt;
        line-height: 1.42;
        -webkit-print-color-adjust: exact;
        print-color-adjust: exact;
    }

    .resume-wrapper h1 {
        margin-bottom: 6pt;
        padding-bottom: 6pt;
        border-bottom: 1.5pt solid var(--resume-primary);
        font-size: 17pt;
    }

    .resume-wrapper h2 {
        margin: 12pt 0 5pt;
        padding: 0 0 3pt 5pt;
        border-left: 3pt solid var(--resume-primary);
        break-after: avoid;
        page-break-after: avoid;
        font-size: 12.5pt;
    }

    .resume-wrapper h3 {
        margin: 8pt 0 4pt;
        padding: 4pt 6pt;
        border-left: 2.5pt solid var(--resume-primary);
        border-radius: 4pt;
        background: var(--resume-primary-soft) !important;
        break-after: avoid;
        page-break-after: avoid;
        font-size: 10.5pt;
    }

    .resume-wrapper h4 {
        margin: 6pt 0 3pt;
        break-after: avoid;
        page-break-after: avoid;
        color: var(--resume-primary-dark) !important;
        font-size: 9.8pt;
    }

    .resume-wrapper p,
    .resume-wrapper ul {
        margin-top: 3pt;
        margin-bottom: 5pt;
    }

    .resume-wrapper ul {
        padding-left: 13pt;
    }

    .resume-wrapper li {
        margin: 1.6pt 0;
        break-inside: avoid;
        page-break-inside: avoid;
    }

    .resume-wrapper h2:first-of-type + ul {
        margin-bottom: 6pt;
        padding: 5pt 7pt;
        border: 0.6pt solid var(--resume-border);
        border-radius: 5pt;
        background: #f8fafc !important;
    }

    .resume-wrapper h3 + ul {
        padding: 4pt 6pt 4pt 13pt;
        border: 0.5pt solid var(--resume-border);
        border-radius: 5pt;
        background: #fbfcfe !important;
    }

    .resume-wrapper hr {
        margin: 7pt 0;
        background: var(--resume-border) !important;
    }

    .resume-wrapper a {
        color: #111827 !important;
        border-bottom: 0 !important;
        text-decoration: none !important;
    }

    .resume-wrapper img,
    .sidebar,
    .right-sidebar,
    .left-sidebar,
    .sticky,
    .article-details,
    .article-footer,
    .site-footer,
    .disqus-container {
        display: none !important;
    }

    .resume-wrapper,
    .resume-wrapper section,
    .resume-wrapper div {
        break-inside: auto;
        page-break-inside: auto;
    }
}
</style>
