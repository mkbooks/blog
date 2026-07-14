---
name: tailor-resume
description: Use when the user provides a job description (JD) and explicitly asks to generate or tailor a new resume based on their base experience. Trigger keywords: "定制简历", "针对岗位", "根据 JD 生成简历", "tailor resume", "岗位描述". Do not use for updating or supplementing base resume facts. Reads index-base.md as the only fact source and generates a new tailored .md file in content/page/about/.
---

# Tailor Resume from Job Description

根据用户提供的岗位描述（JD），从 `content/page/about/index-base.md` 中提取匹配的经历，生成一份定制简历。

## 前置文件

| 文件                               | 用途                                                                         |
| ---------------------------------- | ---------------------------------------------------------------------------- |
| `content/page/about/index-base.md` | **基础简历（唯一事实来源）**，包含所有工作经历、项目、技术栈、证书等完整信息 |
| `content/page/about/ai-infra.md`   | 参考样例——只用于参考 Markdown 结构、排版和 CSS，不作为事实来源               |

## 工作流程

### 第一步：读取基础信息

读取 `content/page/about/index-base.md`，理解用户的完整经历，包括：

- 个人基础信息（姓名、学历、联系方式）
- 每段工作经历的公司、时间、角色、项目详情、技术栈
- 技术方向与技能等级
- 证书与荣誉
- 博客与开源

### 第二步：分析岗位描述

分析用户提供的岗位描述，提取：

- **岗位方向**：如 AI Infra、后端开发、大数据平台、云原生等
- **核心技术要求**：如 Kubernetes、Ray、Spark、Flink、Go、Python 等
- **加分项**：如 MLOps、GPU 调度、联邦学习、隐私计算等
- **软技能要求**：如团队协作、技术文档、项目管理等
- **年限要求**：工作年限、特定领域经验年限

### 第三步：匹配经历

将岗位要求与 `index-base.md` 中的经历进行匹配：

1. **技术匹配度评分**：逐项对比 JD 技术栈与经历中的技术栈
2. **项目相关性排序**：按相关度从高到低排列工作经历和项目
3. **经历裁剪**：
   - 高度相关的项目 → 详细展开，用具体数据说话
   - 中度相关的项目 → 保留概要
   - 低相关度的经历 → 大幅压缩或合并为一句话
4. **技能重组**：Expert / Proficient 分级重新评估；Expert 只能放 `index-base.md` 中有强项目证据或成果支撑的能力，JD 核心但证据较弱的能力放入 Proficient 或不列

### 第四步：生成简历

输出格式严格参照 `ai-infra.md`（也是 `index.zh-cn.md` 的格式），但只参考结构、排版和 CSS；事实、数字、项目描述以 `index-base.md` 为准。包含：

```
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

# [姓名]｜[针对该岗位的简短定位描述]

## 基础信息
（从 index-base.md 复制，方向字段根据 JD 调整）

## 个人简介
（约 150-250 字，融合最相关的经历亮点，用数据和具体技术说话）

## 核心技能
### Expert
（列出与 JD 最匹配的 5-8 项技能，用加粗关键词开头，附带具体成果/数据）
### Proficient
（列出次要但相关的能力，同样用加粗关键词+描述）

## 工作经历
（按相关度排序，最相关的公司和项目放最前面，每个项目通过要点列表描述）
- 高度相关项目：4-6 个要点
- 中等相关项目：2-3 个要点
- 低相关经历：合并为一句或省略

## 证书与荣誉
（从 index-base.md 筛选与 JD 方向相关的证书）

## 专业发展 & 技术前瞻
（根据 JD 方向定制动向内容）

</div>

<style>
（完整复制 ai-infra.md 中的 <style>...</style> 块——CSS 必须完全一致）
</style>
```

## 生成规则

1. **诚实优先**：只使用 `index-base.md` 中存在的经历，不编造任何数据、项目或技术；如果 `ai-infra.md` 样例与 `index-base.md` 冲突，以 `index-base.md` 为准
2. **数据驱动**：优先使用有具体数字的成果描述（如 "300+ 集群"、"利用率提升 30%+"）
3. **时间不虚构**：公司名、时间范围、项目名称必须与 `index-base.md` 完全一致
4. **语言风格**：专业、简洁、数据化，避免空洞形容词
5. **文件命名**：新文件保存为 `content/page/about/<岗位方向关键词>.md`（如 `backend-go.md`、`data-platform.md`）；写入前必须检查目标文件是否已存在，如已存在，先询问用户是否覆盖、另存为新文件名，或只生成草稿
6. **标题中的定位描述**：`# 陈金鑫｜<2-4个最相关的技术方向，用 / 分隔>`
7. **个人简介的结构**：年限概述 → 核心匹配经历（2-3句，带数据） → 软技能与工程素养（1句）
8. **工作经历排序**：默认按与 JD 的相关度排序，最相关的经历放在最前面，标注完整的公司、时间、方向，低相关度的经历可合并为简要条目放在末尾；如果用户说明用于 ATS、正式投递或要求时间线清晰，则优先保持时间倒序，只调整每段经历的详略
9. **CSS 样式块**必须完整复制 `ai-infra.md` 中的 `<style>...</style>` 部分，不得修改或省略；不要复制样例中的正文事实、数字或项目成果
10. **能力缺口处理**：如果 JD 中有关键要求在 `index-base.md` 中缺少证据，不要强行补写；可在完成说明中提示该方向证据较弱，建议用户补充真实经历后再更新基础简历

## 完成后

生成文件后告知用户：

- 新文件路径
- 文件写入方式（新建、覆盖，或另存为新文件名）
- 简历针对的方向
- 主要突出的经历和技能
- JD 中证据较弱或未覆盖的关键要求（如果有）
- 提示：如需微调某个部分的详略，可以直接说明
