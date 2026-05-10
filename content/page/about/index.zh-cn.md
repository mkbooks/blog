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

# 陈金鑫｜AI异构算力平台 / 云原生架构 / 后端研发

## 基础信息

- 手机：17137621499
- 邮箱：chenjinxin@chenjinxin.cn
- 博客：https://chenjinxin.cn
- 学历：黑河学院｜计算机科学与技术｜本科｜2019届
- 方向：AI基础设施平台、异构资源纳管与调度、云原生平台、MLOps、后端架构

## 个人简介

近7年平台研发经验，其中5年+聚焦云原生与AI基础设施平台建设，长期负责资源纳管、任务调度、监控告警、分布式计算与平台工程化落地。在华为数据底座项目中，主导异构资源纳管体系（覆盖300+集群/192卡/1000+实例）的建设，推动资源利用率提升30%+、成本降低20%+；同时主导分布式 Python 计算能力技术规划与关键选型，围绕 Ray / KubeRay / RayService / Volcano 构建离线推理加速、AI任务生命周期管理、MLOps 与 GPU 调度能力。具备技术方案评审、Code Review、研发规范制定、项目排期、跨团队协作和招聘面试经验，持续关注 AI Native、LLM Infra 与云原生调度技术演进。

## 核心技能

### Expert
- **Kubernetes / 调度体系**：精通 K8s 调度器扩展与 Volcano，熟练构建队列调度、优先级抢占、GPU 共享与资源隔离策略。
- **异构资源纳管**：有大规模统一纳管经验（300+ 集群、192 卡、1000+ 实例），覆盖资源采集、利用率分析与成本治理，推动利用率提升 30%+。
- **AI任务调度与MLOps**：主导基于 Ray / KubeRay 的分布式计算平台建设，实现离线推理加速（6小时→3分钟）、模型灰度发布、回滚与 A/B 测试。
- **可观测性平台**：擅长从0到1构建监控、日志与告警体系，实现故障发现时间从 0.5 天缩短至 5 分钟，数据准确率 99%+。
- **后端语言**：Java、Python、Go

### Proficient
- **分布式计算**：Spark、Flink、Hive、Hadoop、YARN、Kafka，有 TB 级日志处理经验。
- **微服务与网关**：Spring Boot、Spring Cloud、FastAPI、Flask、Gin、APISIX，有微服务拆分与容器化交付经验。
- **数据库与中间件**：
  - 关系型 / MPP：MySQL、PostgreSQL、DWS (基于 PostgreSQL)
  - NoSQL / 缓存：Redis、MongoDB
  - 搜索引擎：Elasticsearch、CSS (基于ECK的Elasticsearch服务)
  - 消息队列：Kafka、RabbitMQ
- **工程化**：Docker、CI/CD、镜像构建、方案与接口文档规范、Code Review

## 工作经历

## 上海科之锐人才咨询有限公司｜软件开发工程师｜华为数据底座方向

- 时间：2023年7月 - 至今
- 方向：AI基础设施、融合计算、异构资源纳管、GPU调度、MLOps、可观测性

### 项目一：融合计算中心｜Ray / KubeRay / Volcano / MLOps
- 主导分布式 Python 计算能力整体技术规划与关键技术选型，围绕 Ray / KubeRay / RayService / Dask / Volcano 设计 AI 任务提交、编排、调度、监控、弹性伸缩与生命周期管理能力。
- 基于 Ray 集群优化离线推理任务，将平均推理耗时从 6 小时降低至 30 分钟以内，并进一步优化至 3 分钟以内，显著提升 AI 推理效率与资源利用率。
- 基于 RayService 建设模型发布、回滚、监控、灰度发布、A/B 测试等 MLOps 能力，支撑模型服务稳定迭代与平台化交付。
- 基于 Volcano 高价值资源调度机制，结合队列调度、优先级调度、GPU共享和资源隔离，保障 GPU 计算资源高效利用与公平分配。
- 对接 Prometheus / Grafana / 内部日志告警平台，实现任务、资源、推理链路的可观测与故障定位。

**核心技术**：Java、Python、Spring Boot、Kubernetes、Ray、KubeRay、RayService、Dask、Volcano、Prometheus、Grafana

### 项目二：资源高效 / 资源采集 / 资源监控
- 建设异构资源统一纳管与监控链路，覆盖 300+ MRS 集群、最大 1000+ 节点集群、约 192 张 GPU 卡、1000+ 数据库实例、2000+ 作业、500+ 用户应用。
- 对接云资源接口与内部 IAM，完成资源归属识别、资源亲缘关系、利用率分析、容量治理和运营看板数据同步。
- 将监控采集频率提升至每分钟一次，覆盖 50+ 指标，监控数据准确率达到 99%+，故障发现时间从平均 0.5 天缩短至 5 分钟以内。
- 通过资源治理、调度优化和利用率分析，推动资源利用率提升 30%+，整体成本降低 20%+。

**核心技术**：Java、Flink、Spark、Kafka、Prometheus、Grafana、MRS、DWS (基于 PostgreSQL)、CSS (基于ECK的Elasticsearch服务)

### 项目三：大数据融合计算引擎 / 数据库管家
- 参与统一计算与数据服务平台建设，集成 Spark、Flink、Hive、OBS、DWS、CSS 等能力，支撑批处理、流处理、交互式 SQL、统一作业提交与状态监控。
- 建设数据库统一纳管与查询能力，覆盖 MySQL、MongoDB、Redis、DWS (基于 PostgreSQL)、CSS (基于ECK的Elasticsearch服务) 等 1000+ 数据库与数据服务实例。
- 对接内部日志、告警、可信平台，完成平台可观测、合规审计、镜像构建与容器化部署。

**核心技术**：Java、Spring Boot、Spring Cloud、Maven、MRS、DWS、CSS、Spark、Flink、Hive、OBS、EKS

## 北京可利邦信息技术股份有限公司｜大数据 & 后台开发工程师

- 时间：2021年8月 - 2023年7月
- 方向：AI中台、隐私计算、Kubernetes平台、模型市场、监控告警、网关平台

### 核心成果
- **从0到1主导** AI 中台与隐私计算平台的架构设计与落地，搭建包含 Kubernetes、Docker 镜像仓库、NFS、OpenVPN 在内的完整基础设施层。
- 独立完成 Prometheus / AlertManager 监控告警体系、APISIX 统一网关中心，以及基于 Elasticsearch / Fluentd / Kibana（ECK）的日志平台建设。
- 基于 KubeFATE 框架，完成联邦学习平台的容器化部署和产品化封装，推动项目获得信通院和中互金两项权威认证。
- 打通模型开发到上线的最后一公里，主导开发推理代理服务和模型市场，为平台用户提供模型导入、管理与在线推理服务。

**核心技术**：Python、Go、Kubernetes、KubeFATE、Docker、Prometheus、AlertManager、APISIX、ECK、Elasticsearch、Fluentd、Kibana、MySQL、Redis、FastAPI、Flask

## 深圳掌众智能科技股份有限公司｜高级 Scala / Java 后端开发

- 时间：2019年7月 - 2019年11月
- 方向：高并发广告交易平台、实时计算、日志分析

### 核心成果
- 维护 ADX 广告交易平台，支撑每日约 4 亿次广告源请求、约 1 亿次广告展示、TB 级日志生产和 100+ DSP 对接。
- 设计并实现日志分析系统，构建从 Flume / Kafka 采集、Spark Streaming 准实时计算、Hive / HBase / HDFS 存储到 ECharts 可视化的完整链路。

**核心技术**：Scala、Java、AKKA、Kafka、Spark Streaming、Hadoop、Hive、HBase、HDFS、MySQL、PostgreSQL、Prometheus

## 深圳市维知科技有限责任公司｜大数据研发工程师

- 时间：2020年4月 - 2021年8月
- 参与 AI 中台服务平台建设，负责后端接口、数据库设计、Kubernetes 部署和 Bot / ASR / TTS / OCR 等 AI 引擎接入。
- 独立维护引擎管理服务与虚拟交互服务，完成 Docker 镜像、部署脚本和交付文档建设。

**核心技术**：Kotlin、Vert.x、Kubernetes、Docker、Prometheus、Kafka、Hadoop、Hive、Spark、Redis、MySQL、RabbitMQ

## 文思海辉｜初级大数据分析与挖掘顾问

- 时间：2019年12月 - 2020年4月
- 参与中广核供应链数据仓库建设，负责 HANA / MSSQL / Oracle 数据迁移方案验证、ETL 自动化流程设计和技术文档输出。

**核心技术**：SQL、MSSQL、HANA、Inceptor、HyperBase、Search

## 中诚信国际信用评级有限责任公司｜全栈开发工程师｜实习

- 时间：2018年7月 - 2019年6月
- 参与金融风控 SaaS 平台建设，负责后端开发、数据库设计、SQL、ETL 和数据准确性验证；项目获“2019中国金融创新奖——十佳智能风控创新奖”。

**核心技术**：Java、Spring Boot、Redis、MySQL、MSSQL、SQL

## 证书与荣誉

- 阿里云云计算高级工程师 ACP 认证
- 国家奖学金
- 省三好学生
- 蓝桥杯全国软件和信息技术专业人才大赛决赛三等奖
- 信通院《联邦学习基础能力评测证书》项目参与
- 中互金认证《联邦学习产品安全认证证书》项目参与

## 专业发展 & 技术前瞻

- **Kubernetes方向**：备考 CKAD、CKA、CKS 认证，系统强化应用开发、集群管理、安全加固与云原生安全能力。
- **AI大模型方向**：备考阿里云 ACP 大模型认证，系统学习 LLM、RAG、Agent、Prompt Engineering、LoRA 微调、模型蒸馏及企业级AI平台建设。
- **技术前沿关注**：持续跟踪 vLLM / TensorRT 推理优化、Ray / KubeRay 分布式计算、AI Native Infra 及 Cursor / Copilot 等 AI 工程效率工具。

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
    width: 100%;
    height: 1px;
    margin: 1.75rem 0;
    border: 0;
    background: linear-gradient(90deg, transparent, var(--resume-border), transparent);
    opacity: 1;
}

.resume-wrapper h2:first-of-type + ul {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 0.5rem 1.25rem;
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

    .resume-wrapper h2:first-of-type + ul {
        grid-template-columns: 1fr;
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
        background: #f3f6fb !important;
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
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 2pt 8pt;
        margin-bottom: 6pt;
        padding: 5pt 7pt;
        border: 0.6pt solid #d7dee9;
        border-radius: 5pt;
        background: #f8fafc !important;
    }

    .resume-wrapper h3 + ul {
        padding: 4pt 6pt 4pt 13pt;
        border: 0.5pt solid #e5eaf2;
        border-radius: 5pt;
        background: #fbfcfe !important;
    }

    .resume-wrapper hr {
        margin: 7pt 0;
        background: #d7dee9 !important;
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
