---
title: "FerrumDeck - AgentOps Control Plane"
source_url: "https://github.com/sattyamjjain/ferrumdeck"
source_type: github
fetched: 2026-04-16
dimension: harness
stars: 421
forks: 38
license: Apache 2.0
primary_language: Rust
github_owner: sattyamjjain
github_repo: ferrumdeck
---

# FerrumDeck - AgentOps Control Plane

**Source**: GitHub - sattyamjjain/ferrumdeck  
**Stars**: 421 | **Forks**: 38 | **License**: Apache 2.0  
**Primary Language**: Rust + Python + Next.js  
**Published**: 2025-2026

---

## Overview

**AgentOps Control Plane** — A production-grade platform for running agentic AI workflows with deterministic governance, comprehensive observability, and measurable reliability.

> "While LLMs are probabilistic and unpredictable, production systems require deterministic governance, audit trails, and budget controls."

---

## Key Features

| Feature | Description |
|---------|-------------|
| **Dual-Plane Architecture** | Control Plane (Rust) + Data Plane (Python) |
| **Deterministic Governance** | Policy enforcement before execution |
| **Comprehensive Observability** | Full trace visibility across agents |
| **Measurable Reliability** | SLA metrics, P50/P95/P99 latency |
| **Budget Controls** | Token spend limits and quotas |
| **Audit Trails** | Complete history of agent actions |

---

## Architecture

### Dual-Plane Architecture

| Plane | Language | Responsibility |
|-------|----------|----------------|
| **Control Plane** | Rust | Policy engine, classification, safety kernel |
| **Data Plane** | Python | Agent execution, tool calling, event logging |
| **Dashboard** | Next.js | UI for monitoring, policy management |

```
┌─────────────────────────────────────────────────────────────────┐
│                      FerrumDeck Control Plane (Rust)            │
│                                                                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐             │
│  │ Policy      │  │ Classifier  │  │ Safety      │             │
│  │ Engine      │  │             │  │ Kernel      │             │
│  └─────────────┘  └─────────────┘  └─────────────┘             │
│                                                                 │
│  Policy enforcement  │  Classification  │  Safety gates        │
└──────────────────────┴───────────────────┴──────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────────┐
│                      Data Plane (Python)                        │
│                                                                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐             │
│  │ Agent       │  │ Tool        │  │ Event       │             │
│  │ Executor    │  │ Callers     │  │ Logger      │             │
│  └─────────────┘  └─────────────┘  └─────────────┘             │
│                                                                 │
│  Agent execution ──────────────► Event capture                 │
└─────────────────────────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────────┐
│                      Dashboard (Next.js)                        │
│                                                                 │
│  Live feed │ Policy management │ Cost tracking │ Audit log    │
└─────────────────────────────────────────────────────────────────┘
```

---

## Components

### 1. Control Plane (Rust)

The control plane handles:
- **Policy Evaluation** - Declarative policy rules
- **Tool Classification** - Automatic categorization (SQL, file, network)
- **Anomaly Detection** - Behavioral baseline deviation
- **Risk Scoring** - CRITICAL/HIGH/MEDIUM/LOW assessment

### 2. Data Plane (Python)

The data plane handles:
- **Agent Execution** - Orchestrates agent workflows
- **Tool Calling** - Integrates with agent toolsets
- **Event Logging** - Captures agent actions

### 3. Dashboard (Next.js)

The dashboard provides:
- **Live Feed** - Real-time tool call monitoring
- **Policy Management** - Visual policy editor
- **Cost Tracking** - Token usage and cost analysis
- **Audit Log** - Complete execution history

---

## Policy Engine

### Default Policies

| Policy | Risk | Detection |
|--------|------|-----------|
| SQL Injection | HIGH | SQL keywords in arguments |
| File Access | MEDIUM | Sensitive path patterns |
| Network Access | MEDIUM | HTTP requests |
| Prompt Injection | CRITICAL | Known attack patterns |
| Data Exfiltration | HIGH | Large payloads to external endpoints |
| Supply Chain | HIGH | Publish/deploy command patterns |

### Custom Policies

Write policies in declarative YAML:

```yaml
name: block_file_deletions
description: Block all file deletions outside /tmp
risk: HIGH
condition: |
  tool_name == "delete_file" && !args.path.startsWith("/tmp")
action: block
```

---

## Observability

### Tracing

- **Full trace visibility** - Every agent action recorded
- **Token usage tracking** - Per-call and cumulative
- **Latency metrics** - P50/P95/P99 latency tracking
- **Error analysis** - Failed call breakdown

### Cost Tracking

- **Token usage** - Per model, per agent
- **USD cost** - Real-time cost estimation
- **Budget alerts** - Threshold notifications

---

## SDK Support

### Python

```bash
pip install ferrumdeck
```

```python
from ferrumdeck import AgentGuard

guard = AgentGuard(
    gateway_url="http://localhost:8080",
    agent_id="my-agent"
)

@guard.track
def my_agent_workflow(prompt: str):
    # Your agent code here
    pass
```

### JavaScript/TypeScript

```bash
npm install @ferrumdeck/sdk
```

```typescript
import { AgentGuard } from '@ferrumdeck/sdk';

const guard = new AgentGuard({
  gatewayUrl: 'http://localhost:8080',
  agentId: 'my-agent'
});

guard.track(async () => {
  // Your agent code here
});
```

---

## Deployment

### Docker Compose

```bash
git clone https://github.com/sattyamjjain/ferrumdeck
cd ferrumdeck
docker compose up -d
```

### Manual

```bash
# Build Control Plane
cd control-plane
cargo build --release

# Build Data Plane
cd data-plane
pip install -r requirements.txt
python main.py

# Build Dashboard
cd dashboard
npm install
npm run build
npm start
```

---

## Cross-References

**Related**: [[AEGIS]], [[Cordum]], [[GoClaw]] (agent control plane)  
**Similar Systems**: [[Logfire]] (observability), [[Altimate Code]] (specialized harness)
