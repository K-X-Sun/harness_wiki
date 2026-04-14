---
title: "看看 Claude Code 怎么做 Harness —— Agent 工程化的真正难点"
source_url: "https://hub.baai.ac.cn/view/53619"
source_type: article
fetched: 2026-04-14
author: "极客公园"
domain: "hub.baai.ac.cn"
---

# 看看 Claude Code 怎么做 Harness，这才是 Agent 工程化的真正难点

**作者/来源：** 极客公园 | 2026-04-03
**Source:** https://hub.baai.ac.cn/view/53619

[Full article content reproduced below]

## 01 真正的难点，在模型之外的 HARNESS

Claude Code 的架构核心是一个「Harness」本地运行时外壳，更多依靠 Harness 的工程化与可靠性。

- 源代码跨越约 1,900 个文件，超过 512,000 行严格类型的 TypeScript
- 基于 Bun 运行时构建，用 React 和 Ink 驱动终端 UI
- 大型 QueryEngine、集中式工具注册表、数十个斜杠命令、持久化记忆、IDE 桥接、MCP 集成、远程会话、插件、技能

> 更准确的比喻：Claude Code 更像是一个用于软件工作的操作系统，围绕模型堆叠了权限管理、记忆层、后台任务、IDE 桥接、MCP 管道和多代理编排。

Agent 架构的三个代际演进：
1. **第一代 Chatbot** — 无状态问答
2. **第二代 Workflow** — 代码驱动的 DAG 流（n8n, LangChain）
3. **第三代 Autonomous Agent** — 模型控制循环，运行时只是执行器

## 02 TAOR LOOP 设计：ORCHESTRATOR 越笨，架构越稳定

执行引擎是 TAOR 循环：Think-Act-Observe-Repeat。

- Orchestrator 本身极其"愚蠢"，只负责驱动循环、执行工具调用、感知结果
- 所有的推理、决策、何时停止，全部交给模型
- **核心逻辑约 50 行**，但给了模型无限的操作空间
- 只提供四种能力原语：`Read`、`Write`、`Execute`、`Connect`
- Bash 是通用适配器，允许模型使用任何人类开发者会用的工具

> 随着模型变得更强，脚手架应该变薄，而不是变厚。

## 03 CONTEXT WINDOW 是稀缺资源，不是越大越好

三层 Context 管理：
1. **Auto-Compaction** — Context 使用达 ~50% 时自动触发，用 LLM 摘要替换原始对话
2. **Sub-Agent 隔离** — 重型探索任务卸载给独立子 Agent，有自己的 Context 预算
3. **Prompt Cache 经济学** — 追踪 14 个 cache-break 向量

Session 像 git branch 一样运作：checkpoint、rollback、fork。

## 04 记忆系统的核心是索引，不是存储

> 记忆是索引，不是存储。能从代码库中重新推导出的信息，绝不应该被存储。

六层记忆系统：
1. Managed Policy（组织级策略）
2. Project CLAUDE.md（项目配置）
3. User Preferences（用户偏好）
4. Auto-Memory（自动学习模式）
5. Session（会话上下文）
6. Sub-Agent Memory（子 Agent 记忆）

记忆系统具有主动自我编辑能力：重写、去重、剪除矛盾信息。过期记忆被视为"负债"。

## 05 权限系统的设计

五档信任光谱：
- `plan` — 只读
- `default` — 编辑和 shell 操作前需询问
- `acceptEdits` — 自动批准文件编辑，shell 仍需询问
- `dontAsk` — 自动批准白名单内操作
- `bypassPermissions` — 跳过所有检查

`bashSecurity.ts` 有 23 项安全检查，包括 18 个被阻止的 Zsh 内置命令、Unicode 零宽字符注入防御等。

API 请求在 JS 层之下做了身份验证（HTTP 传输层的 API 调用 DRM）。

## 06 多 AGENT 编排

**Sub-Agent：** 三种预设（Explore/Plan/General-purpose），独立进程、独立 Context、独立记忆

**Agent Teams（实验性）：** 完全独立实例通过共享文件系统协调
- Shared Task List — 自主认领任务
- Multicast/Broadcast 通信
- 质量门控 Hook：TeammateIdle、TaskCompleted

## 07 KAIROS — ALWAYS-ON AGENT（未发布）

- `/dream` 技能：夜间记忆蒸馏
- 每日 append-only 日志
- GitHub Webhook 订阅
- 后台 Daemon 工作进程
- 每 5 分钟 Cron 调度刷新

> 不是"你召唤它，它来帮你"，而是"它一直在，主动为你工作"。

## 08 彩蛋

**Anti-Distillation 机制：** API 请求中携带假工具定义，污染试图录制 API 流量训练竞品模型的行为。

**Undercover Mode：** 单向门 — 在外部仓库中，模型永远不会提及内部代号、Claude Code 名字本身。
