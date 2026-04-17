---
title: "AEGIS - Pre-Execution Firewall for AI Agents"
source_url: "https://github.com/Justin0504/Aegis"
source_type: github
fetched: 2026-04-16
dimension: harness
stars: 1124
forks: 127
license: MIT
primary_language: TypeScript
github_owner: Justin0504
github_repo: Aegis
arxiv_id: "2603.12621"
---

# AEGIS - Pre-Execution Firewall for AI Agents

**Source**: GitHub - Justin0504/Aegis | arXiv:2603.12621  
**Stars**: 1,124 | **Forks**: 127 | **License**: MIT  
**Primary Language**: TypeScript (Gateway), Python (SDK)  
**Published**: March 2026

---

## Overview

AEGIS is the **missing layer**: a **pre-execution firewall** that sits between your agent and its tools, classifies every call in real time, enforces policies, blocks violations, and creates a tamper-evident audit trail with hash chaining and optional signing support.

> "Every tool call. Intercepted. Classified. Blocked — before it executes."

---

## Key Features

| Feature | Description |
|---------|-------------|
| **Pre-Execution Blocking** | Stops dangerous tool calls before execution |
| **Zero-Config Classification** | Works on any tool name, any argument shape |
| **Behavioral Anomaly Detection** | Detects deviation from agent baseline |
| **Human-in-the-Loop Approvals** | Pause for human review on high-risk calls |
| **Cryptographic Audit Trail** | SHA-256 hash-chained, optionally Ed25519 signed |
| **Multi-Tenancy & RBAC** | Enterprise-grade access control |
| **Supply Chain Security** | Pre-publish scanning for source maps, secrets |

---

## Architecture

```
  Your agent calls a tool
          │
          ▼  SDK / HTTP Proxy / MCP Proxy intercepts
  ┌────────────────────────────────────────────────┐
  │  AEGIS Gateway                                 │
  │                                                │
  │  ① Classify   (SQL? file? network? shell?)     │
  │  ② Anomaly    (baseline deviation? spike?)     │
  │  ③ Evaluate   (injection? exfil? traversal?)   │
  │  ④ Decide     allow / block / pending          │
  └──────────┬─────────────────────────────────────┘
             │
      ┌──────┴──────────────┐
      │                     │
   allow                 pending ──► Human reviews in Cockpit
      │                     │               │
      ▼                     └──── allow ────┘
  Tool executes                        │
      │                             block
      ▼                                │
  Optional signing                    ▼
  SHA-256 hash-chained       AgentGuardBlockedError
  Stored in Cockpit          (agent gets the reason)
```

---

## Security Policies

| Policy | Risk | What it catches |
|--------|------|-----------------|
| SQL Injection Prevention | HIGH | `DROP`, `DELETE`, `TRUNCATE` in database tools |
| File Access Control | MEDIUM | Path traversal (`../`), `/etc/`, `/root/` |
| Network Access Control | MEDIUM | HTTP (non-HTTPS) requests |
| Prompt Injection Detection | CRITICAL | "ignore previous instructions" patterns |
| Data Exfiltration Prevention | HIGH | Large payloads to external endpoints |
| Source Map Leak Prevention | HIGH | `npm publish` when `.map` files present |
| Supply Chain Security | HIGH | Package publish, container push, deployment ops |

---

## SDK Support

### Python

```bash
pip install agentguard-aegis
```

```python
import agentguard
agentguard.auto("http://localhost:8080", agent_id="my-agent")

# Your existing code — completely unchanged
import anthropic
client = anthropic.Anthropic()
response = client.messages.create(model="claude-sonnet-4-20250514", tools=[...], messages=[...])
```

**Supported frameworks**: Anthropic, OpenAI, LangChain/LangGraph, CrewAI, Google Gemini, AWS Bedrock, Mistral, LlamaIndex, smolagents

### JavaScript/TypeScript

```bash
npm install @justinnn/agentguard
```

```typescript
import agentguard from '@justinnn/agentguard'
agentguard.auto('http://localhost:8080', {
  agentId: 'my-agent',
  blockingMode: true,
})
```

### Go

```bash
go get github.com/Justin0504/Aegis/packages/sdk-go
```

---

## Proxy Interception

### HTTP Forward Proxy

```bash
agentguard http-proxy --port 8081 --agent-id my-agent

export ANTHROPIC_BASE_URL=http://localhost:8081
export OPENAI_BASE_URL=http://localhost:8081/v1
```

### MCP Stdio Proxy

```bash
agentguard mcp-proxy \
  --server npx -y @modelcontextprotocol/server-filesystem / \
  --agent-id my-agent --blocking
```

---

## Observability Dashboard

The **Compliance Cockpit** provides:
- Live feed of tool calls with risk badges
- One-click allow/block for pending checks
- Agent baseline (7-day behavioral profile)
- Anomaly detection (automatic flagging)
- PII auto-redaction
- Token cost tracking across 40+ models
- Alert rules (Slack, PagerDuty, webhooks)
- Forensic PDF/CSV export
- Kill switch (auto-revoke agents)

---

## Integration Examples

### Claude Code

```bash
agentguard claude-code setup --blocking
# Restart Claude Code — done.
```

### Claude Desktop (MCP)

```json
{
  "mcpServers": {
    "aegis": { "url": "ws://localhost:8080/mcp-audit" }
  }
}
```

### OpenTelemetry

```bash
OTEL_ENABLED=true OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4318 node dist/server.js
```

Each span carries: `aegis.agent_id`, `aegis.risk_level`, `aegis.blocked`, `aegis.cost_usd`, `aegis.pii_detected`

---

## Enterprise Features

| Feature | Description |
|---------|-------------|
| **Multi-Tenancy** | Isolate data per organization |
| **RBAC** | Roles: owner / admin / auditor / viewer |
| **Audit Log** | Immutable record of all admin actions |
| **Usage Metering** | Track API calls, traces, judge evaluations |
| **SLA Metrics** | Real-time P50/P95/P99 latency tracking |
| **Data Retention** | Configurable auto-purge per resource type |

---

## Deployment

### Docker Compose

```bash
git clone https://github.com/Justin0504/Aegis
cd Aegis
docker compose up -d
```

| Service | URL | What it does |
|---------|-----|--------------|
| **Compliance Cockpit** | localhost:3000 | Dashboard — traces, policies, approvals, costs |
| **Gateway API** | localhost:8080 | Policy engine — classifies, checks, blocks |

### Manual

```bash
# Gateway
cd packages/gateway-mcp && npm install && npm run build && node dist/server.js

# Cockpit
cd apps/compliance-cockpit && npm install && npm run build && npm start
```

---

## CLI Commands

```bash
agentguard status                    # gateway health
agentguard traces list --agent X     # query traces
agentguard costs                     # token/cost summary
agentguard anomalies list            # behavioral anomaly events
agentguard http-proxy                # start HTTP forward proxy
agentguard mcp-proxy --server ...    # start MCP stdio proxy
agentguard judge batch               # auto-evaluate traces via LLM
agentguard scan ./my-package         # pre-publish supply chain scan
agentguard kill-switch revoke <id>   # emergency agent shutdown
agentguard admin orgs                # list organizations (multi-tenant)
```

---

## Performance

- **Latency**: <50ms for policy check (99th percentile)
- **Throughput**: 1000+ tool calls per second per gateway
- **Cold-start**: ~200 traces before blocking (lets new agents learn)

---

## Cross-References

**Related**: [[DeerFlow]] (sandbox integration), [[AIO Sandbox]]  
**Similar Systems**: [[GoClaw]] (agent control plane), [[Cordum]] (agent governance)
