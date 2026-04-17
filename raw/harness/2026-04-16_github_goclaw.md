---
title: "GoClaw - Multi-Tenant AI Agent Platform"
source_url: "https://github.com/nextlevelbuilder/goclaw"
source_type: github
fetched: 2026-04-16
dimension: harness
stars: 892
forks: 98
license: CC BY-NC 4.0
primary_language: Go
github_owner: nextlevelbuilder
github_repo: goclaw
---

# GoClaw - Multi-Tenant AI Agent Platform

**Source**: GitHub - nextlevelbuilder/goclaw  
**Stars**: 892 | **Forks**: 98 | **License**: CC BY-NC 4.0  
**Primary Language**: Go  
**Published**: 2025-2026

---

## Overview

**Multi-Tenant AI Agent Platform**

Multi-agent AI gateway built in Go. 20+ LLM providers. 7 channels. Multi-tenant PostgreSQL. Single binary. Production-tested. Agents that orchestrate for you.

**Key claims**:
- Single ~25 MB static Go binary, no Node.js runtime
- Runs on a $5 VPS
- <1s startup time

---

## Core Features

### 8-Stage Agent Pipeline

```
Context → History → Prompt → Think → Act → Observe → Memory → Summarize
```

Each stage is pluggable with "always-on execution" support.

### 4-Mode Prompt System

| Mode | Description | Use Case |
|------|-------------|----------|
| Full | Complete context | Complex tasks |
| Task | Scoped context | Focused work |
| Minimal | Basic context | Quick queries |
| None | No context | Context-free tasks |

### 3-Tier Memory

| Tier | Description | Capacity |
|------|-------------|----------|
| Working | Conversation context | Session-limited |
| Episodic | Session summaries | Long-term |
| Semantic | Knowledge graph | Cross-agent |

### Knowledge Vault

- Document registry with wikilinks
- Hybrid search (FTS + pgvector)
- Filesystem sync

### Agent Teams & Orchestration

- Shared task boards
- Inter-agent delegation (sync/async/bidirectional)
- 3 orchestration modes: auto/explicit/manual

### Self-Evolution

- Metrics → suggestions → auto-adapt
- Guardrails prevent identity changes
- Agents refine communication style

### Multi-Tenant PostgreSQL

- Per-user workspaces
- Per-user context files
- Encrypted API keys (AES-256-GCM)
- RBAC
- Isolated sessions

### 20+ LLM Providers

- Anthropic (native HTTP+SSE with prompt caching)
- OpenAI, OpenRouter, Groq, DeepSeek, Gemini, Mistral
- xAI, MiniMax, DashScope, Claude CLI, Codex, ACP
- Any OpenAI-compatible endpoint

### 7 Messaging Channels

- Telegram, Discord, Slack, Zalo OA, Zalo Personal
- Feishu/Lark, WhatsApp

### Production Security

- 5-layer permission system
- Rate limiting
- Prompt injection detection
- SSRF protection
- AES-256-GCM encryption

### Observability

- Built-in LLM call tracing with spans
- Prompt cache metrics
- Optional OpenTelemetry OTLP export

---

## Desktop Edition (GoClaw Lite)

A native desktop app for local AI agents — no Docker, no PostgreSQL, no infrastructure.

**Features**:
- Single native app (Wails v2 + React), ~30 MB
- SQLite database (zero setup)
- Chat with agents (streaming, tools, media, file attachments)
- Agent management (max 5), provider config, MCP servers, skills, cron
- Team tasks with Kanban board and real-time updates
- Auto-update from GitHub Releases

---

## Architecture Diagrams

### Multi-Tenant Architecture

```
┌──────────────────────────────────────────────────────────────┐
│                      GoClaw Gateway                          │
├──────────────────────────────────────────────────────────────┤
│  Multi-tenant PostgreSQL (per-user workspaces)               │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐       │
│  │ User 1   │ │ User 2   │ │ User 3   │ │ User N   │       │
│  │ Workspace│ │ Workspace│ │ Workspace│ │ Workspace│       │
│  └──────────┘ └──────────┘ └──────────┘ └──────────┘       │
│                                                                │
│  RBAC ──► Encrypted API Keys (AES-256-GCM)                   │
└──────────────────────────────────────────────────────────────┘
```

### 3-Tier Memory Architecture

```
┌──────────────────────────────────────────────────────────────┐
│                      3-Tier Memory                           │
├──────────────────────────────────────────────────────────────┤
│  L0: Working (Session) ──► Fast, volatile                   │
│  L1: Episodic (Summaries) ──► Medium-term persistence        │
│  L2: Semantic (Knowledge Graph) ──► Cross-agent memory       │
└──────────────────────────────────────────────────────────────┘
```

### 8-Stage Agent Pipeline

```
┌──────────┬──────────┬──────────┬──────────┬──────────┬──────────┬──────────┬──────────┐
│ Context  │ History  │  Prompt  │  Think   │   Act    │ Observe  │ Memory   │Summarize │
└──────────┴──────────┴──────────┴──────────┴──────────┴──────────┴──────────┴──────────┘
```

---

## Quick Start

### From Source

```bash
git clone -b main https://github.com/nextlevelbuilder/goclaw.git && cd goclaw
make build
./goclaw onboard        # Interactive setup wizard
source .env.local && ./goclaw
```

### With Docker

```bash
chmod +x prepare-env.sh && ./prepare-env.sh
make up
```

**Web Dashboard**: http://localhost:18790 (built-in)

---

## Built-in Tools

30+ tools across 8 categories:

| Category | Tools |
|----------|-------|
| **Filesystem** | `read_file`, `write_file`, `edit_file`, `list_files`, `search`, `glob` |
| **Runtime** | `exec`, `browser` |
| **Web** | `web_search`, `web_fetch` |
| **Memory** | `memory_search`, `memory_get`, `knowledge_graph_search` |
| **Media** | `create_image`, `create_audio`, `create_video`, `read_*`, `tts` |
| **Skills** | `skill_search`, `use_skill`, `skill_manage` |
| **Teams** | `team_tasks`, `spawn`, `delegate`, `message` |
| **Automation** | `cron`, `heartbeat`, `sessions_*` |

---

## Configuration

### Environment Variables

| Variable | Description |
|----------|-------------|
| `GOCLAW_*_API_KEY` | LLM provider API keys |
| `DATABASE_URL` | PostgreSQL connection |
| `REDIS_URL` | Optional Redis cache |
| `OLLAMA_HOST` | Local Ollama instance |

### Docker Optional Services

| Flag | Service | Description |
|------|---------|-------------|
| `WITH_BROWSER=1` | Headless Chrome | Browser automation tool |
| `WITH_OTEL=1` | Jaeger | OpenTelemetry tracing UI |
| `WITH_SANDBOX=1` | Docker sandbox | Isolated untrusted code |
| `WITH_TAILSCALE=1` | Tailscale | Private network exposure |
| `WITH_REDIS=1` | Redis | Caching layer |

---

## Documentation

Full documentation at **[docs.goclaw.sh](https://docs.goclaw.sh)**

| Section | Topics |
|---------|--------|
| Getting Started | Installation, Quick Start, Configuration |
| Core Concepts | Agent Loop, Sessions, Tools, Memory, Multi-Tenancy |
| Agents | Creating Agents, Context Files, Personality, Sharing |
| Providers | Anthropic, OpenAI, OpenRouter, Gemini, DeepSeek, +15 more |
| Channels | Telegram, Discord, Slack, Feishu, Zalo, WhatsApp, WebSocket |
| Agent Teams | Teams, Task Board, Messaging, Delegation & Handoff |
| Advanced | Custom Tools, MCP, Skills, Cron, Sandbox, Hooks, RBAC |
| Deployment | Docker Compose, Database, Security, Observability, Tailscale |

---

## Cross-References

**Related**: [[AgentMemory]], [[DeerFlow]], [[AIO Sandbox]]  
**Similar Systems**: [[GoClaw Lite]], [[OpenClaw]], [[GoClaw]]
