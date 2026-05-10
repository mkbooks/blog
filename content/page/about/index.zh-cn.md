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

---
## 个人简介

近7年平台研发经验，其中5年+聚焦云原生与AI基础设施平台建设，长期负责资源纳管、任务调度、监控告警、分布式计算与平台工程化落地。在华为数据底座项目中，主导异构资源纳管体系（覆盖300+集群/192卡/1000+实例）的建设，推动资源利用率提升30%+、成本降低20%+；同时主导分布式 Python 计算能力技术规划与关键选型，围绕 Ray / KubeRay / RayService / Volcano 构建离线推理加速、AI任务生命周期管理、MLOps 与 GPU 调度能力。具备技术方案评审、Code Review、研发规范制定、项目排期、跨团队协作和招聘面试经验，持续关注 AI Native、LLM Infra 与云原生调度技术演进。
---
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
---
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
---

## 北京可利邦信息技术股份有限公司｜大数据 & 后台开发工程师

- 时间：2021年8月 - 2023年7月
- 方向：AI中台、隐私计算、Kubernetes平台、模型市场、监控告警、网关平台

### 核心成果
- **从0到1主导** AI 中台与隐私计算平台的架构设计与落地，搭建包含 Kubernetes、Docker 镜像仓库、NFS、OpenVPN 在内的完整基础设施层。
- 独立完成 Prometheus / AlertManager 监控告警体系、APISIX 统一网关中心，以及基于 Elasticsearch / Fluentd / Kibana（ECK）的日志平台建设。
- 基于 KubeFATE 框架，完成联邦学习平台的容器化部署和产品化封装，推动项目获得信通院和中互金两项权威认证。
- 打通模型开发到上线的最后一公里，主导开发推理代理服务和模型市场，为平台用户提供模型导入、管理与在线推理服务。

**核心技术**：Python、Go、Kubernetes、KubeFATE、Docker、Prometheus、AlertManager、APISIX、ECK、Elasticsearch、Fluentd、Kibana、MySQL、Redis、FastAPI、Flask
---
## 深圳掌众智能科技股份有限公司｜高级 Scala / Java 后端开发

- 时间：2019年7月 - 2019年11月
- 方向：高并发广告交易平台、实时计算、日志分析

### 核心成果
- 维护 ADX 广告交易平台，支撑每日约 4 亿次广告源请求、约 1 亿次广告展示、TB 级日志生产和 100+ DSP 对接。
- 设计并实现日志分析系统，构建从 Flume / Kafka 采集、Spark Streaming 准实时计算、Hive / HBase / HDFS 存储到 ECharts 可视化的完整链路。

**核心技术**：Scala、Java、AKKA、Kafka、Spark Streaming、Hadoop、Hive、HBase、HDFS、MySQL、PostgreSQL、Prometheus
---
## 深圳市维知科技有限责任公司｜大数据研发工程师

- 时间：2020年4月 - 2021年8月
- 参与 AI 中台服务平台建设，负责后端接口、数据库设计、Kubernetes 部署和 Bot / ASR / TTS / OCR 等 AI 引擎接入。
- 独立维护引擎管理服务与虚拟交互服务，完成 Docker 镜像、部署脚本和交付文档建设。

**核心技术**：Kotlin、Vert.x、Kubernetes、Docker、Prometheus、Kafka、Hadoop、Hive、Spark、Redis、MySQL、RabbitMQ
---
## 文思海辉｜初级大数据分析与挖掘顾问

- 时间：2019年12月 - 2020年4月
- 参与中广核供应链数据仓库建设，负责 HANA / MSSQL / Oracle 数据迁移方案验证、ETL 自动化流程设计和技术文档输出。

**核心技术**：SQL、MSSQL、HANA、Inceptor、HyperBase、Search
---
## 中诚信国际信用评级有限责任公司｜全栈开发工程师｜实习

- 时间：2018年7月 - 2019年6月
- 参与金融风控 SaaS 平台建设，负责后端开发、数据库设计、SQL、ETL 和数据准确性验证；项目获“2019中国金融创新奖——十佳智能风控创新奖”。

**核心技术**：Java、Spring Boot、Redis、MySQL、MSSQL、SQL
---
## 证书与荣誉

- 阿里云云计算高级工程师 ACP 认证
- 国家奖学金
- 省三好学生
- 蓝桥杯全国软件和信息技术专业人才大赛决赛三等奖
- 信通院《联邦学习基础能力评测证书》项目参与
- 中互金认证《联邦学习产品安全认证证书》项目参与
---
## 专业发展 & 技术前瞻

- **Kubernetes方向**：备考 CKAD、CKA、CKS 认证，系统强化应用开发、集群管理、安全加固与云原生安全能力。
- **AI大模型方向**：备考阿里云 ACP 大模型认证，系统学习 LLM、RAG、Agent、Prompt Engineering、LoRA 微调、模型蒸馏及企业级AI平台建设。
- **技术前沿关注**：持续跟踪 vLLM / TensorRT 推理优化、Ray / KubeRay 分布式计算、AI Native Infra 及 Cursor / Copilot 等 AI 工程效率工具。

</div>

<style>
/* ==========================================================================
   1. 全局变量定义 (方便统一调整)
   ========================================================================== */
:root {
    /* 核心配色 */
    --primary-color: #007bff;      /* 主色调：蓝色 */
    --text-main: #2c3e50;          /* 主要文字颜色 */
    --text-sub: #666666;           /* 次要文字颜色 */
    --bg-header: #f8f9fa;          /* 标题背景色 */

    /* 间距与字体 */
    --spacing-base: 20px;
    --font-base: 16px;             /* 网页浏览字体大小 */
    --line-height: 1.6;
}

/* 简历容器 - 模拟 A4 纸质感或干净的网页布局 */
.resume-wrapper {
    max-width: 850px;
    margin: 40px auto;
    padding: 40px;
    background: #fff;
    color: #333;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
    line-height: var(--line-height);
}

/* ---------------- 头部信息 ---------------- */
.resume-wrapper h1 {
    font-size: 2.5rem;
    color: var(--text-main);
    border-bottom: none;
    margin-bottom: 0.5rem;
    text-align: center;
    font-weight: 700;
}

/* 基本信息列表转横排 */
.resume-wrapper h1 + ul {
    list-style: none;
    padding: 0;
    text-align: center;
    margin-bottom: 30px;
    font-size: 0.95rem;
    color: var(--text-sub);
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 15px;
}

.resume-wrapper h1 + ul li {
    display: inline-block;
}

/* 链接样式 */
.resume-wrapper a {
    color: var(--primary-color);
    text-decoration: none;
    border-bottom: 1px dashed var(--primary-color);
    transition: all 0.2s;
}
.resume-wrapper a:hover {
    color: #0056b3;
    border-bottom-style: solid;
}

/* ---------------- 标题通用样式 ---------------- */
.resume-wrapper h2 {
    font-size: 1.8rem;
    color: var(--text-main);
    border-bottom: 2px solid #eaeaea;
    padding-bottom: 10px;
    margin-top: 40px;
    margin-bottom: 20px;
    position: relative;
}

.resume-wrapper h2::after {
    content: '';
    position: absolute;
    bottom: -2px;
    left: 0;
    width: 60px;
    height: 2px;
    background-color: #007bff; /* 强调色条 */
}

/* ---------------- 核心技能 ---------------- */
/* 针对技能列表的样式优化 */
.resume-wrapper h2 + ul li {
    margin-bottom: 8px;
}
.resume-wrapper h2 + ul li strong {
    color: var(--text-main);
    font-weight: 600;
    display: inline-block;
    min-width: 100px; /* 让技能分类对齐 */
}

/* ---------------- 工作经历 ---------------- */
/* 建议 HTML 结构：
   <h3>
     <span>公司名称</span>
     <span class="job-title">职位名称</span>
     <span class="job-date">2020.01 - 至今</span>
   </h3>
   如果无法修改HTML，以下CSS依然兼容您的 h3 + p 结构
*/
.resume-wrapper h3 {
    font-size: 1.6rem;
    color: #333;
    margin-top: 25px;
    margin-bottom: 15px;
    background-color: var(--bg-header);
    padding: 10px 0 10px 26px;
    border-left: 4px solid var(--primary-color);
    border-radius: 0 4px 4px 0;

    /* Flex 布局实现两端对齐 */
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
}
/* 针对原结构的补丁：如果时间写在 h3 外面的 p 标签里 */
.resume-wrapper h3 + p {
    margin: -38px 15px 15px 0; /* 负边距拉上去 */
    text-align: right;
    pointer-events: none; /* 防止遮挡点击 */
}
/* 处理时间段 */
.resume-wrapper h3 + p em {
    display: block;
    margin-bottom: 15px;
    font-style: normal;
    color: var(--text-sub);
    font-size: 1.4rem;
    text-align: right;
    margin-top: -40px; /* 调整位置与标题同行或紧随其后 */
    padding-right: 15px;
    background: var(--bg-header); /* 遮挡背景防止文字重叠 */
}

/* 项目名称 */
.resume-wrapper h4 {
    font-size: 1.5rem;
    color: #444;
    margin-top: 20px;
    margin-bottom: 10px;
    font-weight: 600;
}

/* 项目详情列表 */
.resume-wrapper ul {
    padding-left: 20px;
}

.resume-wrapper li {
    margin-bottom: 6px;
    color: #444;
}

/* ---------------- 图片展示 ---------------- */
.resume-wrapper img {
    max-width: 100%;
    height: auto;
    margin: 10px;
    border: 1px solid #ddd;
    padding: 5px;
    border-radius: 4px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

/* ==========================================================================
   4. 打印专用样式 (Ctrl+P 触发)
   ========================================================================== */
@media print {
    @page {
        margin: 1cm; /* 标准 A4 边距 */
        size: A4 portrait;
    }
     /* 1. 全局净化：隐藏所有无关元素 */
    body * {
        visibility: hidden;
    }

    /* 2. 独显主角：只显示简历容器及其子元素 */
    .resume-wrapper, .resume-wrapper * {
        visibility: visible;
    }
    /* 同时也建议去掉页面的默认边距，防止产生额外线条 */
    body, html {
        margin: 0;
        padding: 0;
    }
    body {
        background: #fff;
        -webkit-print-color-adjust: exact; /* 强制打印背景色 (Chrome/Safari) */
        print-color-adjust: exact;         /* 强制打印背景色 (Firefox) */
    }

    .resume-wrapper {
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        max-width: none;
        margin: 0;
        padding: 0;
        border: none;
        /* 关键：去除所有可能产生边框的样式 */
        border: none !important;
        box-shadow: none !important;
        outline: none !important; /* 有时候是轮廓线 */
        border-radius: 0 !important;
        background: transparent !important; /* 防止背景色形成色块 */
    }

    /* 字体调整：使用 pt 单位更适合打印 */
    .resume-wrapper { font-size: 10.5pt; line-height: 1.4; }
    .resume-wrapper h1 { font-size: 18pt; margin-bottom: 5pt; }
    .resume-wrapper h1 + ul { font-size: 9pt; margin-bottom: 15pt; gap: 10pt; }
    .resume-wrapper h2 { font-size: 14pt; margin-top: 15pt; margin-bottom: 8pt; padding-bottom: 3pt; }
    .resume-wrapper h3 {
        font-size: 11pt;
        margin-top: 10pt;
        padding: 4pt 8pt 4pt 30px; /* 调整了左内边距，让文字离边框近一点，更美观 */
    }
    .resume-wrapper h3 + p {
        /* 核心修复代码 START */
        border-left: 4px solid #007bff !important; /* 1. 加上 !important */
        -webkit-print-color-adjust: exact;         /* 2. 强制该元素打印背景/边框颜色 */
        print-color-adjust: exact;                 /* 3. Firefox 兼容 */
        background-color: rgba(0, 123, 255, 0.05) !important; /* 4. 可选：加个极淡的背景色增强存在感 */
        /* 核心修复代码 END */

        page-break-after: avoid;
    }
    .resume-wrapper h4 { font-size: 11pt; margin-top: 8pt; }

    /* 隐藏网页端特有的元素 */
    .resume-wrapper a { border-bottom: none; color: #000; text-decoration: none; }

    /* 关键：分页控制 */
    h2, h3, h4 { page-break-after: avoid; } /* 标题后不分页 */
    li { page-break-inside: avoid; }        /* 列表项内部不分页 */
    section, div { page-break-inside: auto; }

    /* 打印时的布局微调 */
    .resume-wrapper h3 + p {
        margin-top: -32px; /* 打印时微调位置 */
    }

    /* 移除不必要的装饰 */
    .resume-wrapper img { display: none; } /* 简历通常不打印装饰图片，除非是作品集 */
    .sidebar,.right-sidebar,.left-sidebar,.sticky,.article-details,.site-footer,.disqus-container,.article-footer { display: none; }

}

/* ==========================================================================
   5. 移动端适配
   ========================================================================== */
@media (max-width: 600px) {
    .resume-wrapper {
        padding: 20px;
        margin: 0;
        border-radius: 0;
    }

    /* 移动端取消负边距，改为流式布局 */
    .resume-wrapper h3 {
        flex-direction: column;
        align-items: flex-start;
    }

    .resume-wrapper h3 + p {
        margin: 0 0 10px 0;
        text-align: left;
    }

    .resume-wrapper h3 + p em {
        background: none;
        padding-left: 0;
        display: block;
        margin-bottom: 5px;
        color: #888;
        font-size: 0.85rem;
    }
}
</style>
