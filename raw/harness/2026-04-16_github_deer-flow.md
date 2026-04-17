---
title: "DeerFlow - Super Agent Harness"
source_url: "https://github.com/bytedance/deer-flow"
source_type: github
fetched: 2026-04-16
dimension: harness
stars: 61853
forks: 6143
license: MIT
primary_language: Python
github_owner: bytedance
github_repo: deer-flow
---

# DeerFlow - Super Agent Harness

**Source**: GitHub - bytedance/deer-flow  
**Stars**: 61,853 | **Forks**: 6,143 | **License**: MIT  
**Primary Language**: Python + Node.js  
**Published**: February 2026 (v2.0)

---

## Overview

DeerFlow (**D**eep **E**xploration and **E**fficient **R**esearch **Flow**) is an open-source **super agent harness** that orchestrates **sub-agents**, **memory**, and **sandboxes** to do almost anything — powered by **extensible skills**. It gained rapid popularity, claiming the #1 spot on GitHub Trending in February 2026.

DeerFlow 2.0 is a ground-up rewrite with no code shared with v1. The original Deep Research framework is maintained on the `1.x` branch.

---

## Key Features

### Core Architecture

| Component | Description |
|-----------|-------------|
| **Sub-Agents** | Orchestrated agents for parallel execution |
| **Memory** | Long-term persistent memory across sessions |
| **Sandbox** | Execution isolation with filesystem restrictions |
| **Extensible Skills** | Plugin-based skill system for extending capabilities |

### Multi-Language Support

- **Backend**: Python 3.12+
- **Frontend/Tooling**: Node.js 22+
- **Cross-platform**: macOS, Linux, Windows

---

## Architecture Highlights

### Skill & Tools System

DeerFlow integrates with multiple AI coding tools:
- **Claude Code Integration** - First-party support for Claude Code agent
- **MCP Server** - Model Context Protocol support for tool integration
- **Extensible Skills** - Plugin-based capability extension

### Sandbox & File System

- **Isolated execution environment** - Prevents dangerous operations
- **File system controls** - Restrictive file access policies
- **Multi-modal operations** - Browser, terminal, file ops unified

### Context Engineering

- **Dynamic context management** - Adaptive token budgeting
- **Long-term memory** - Cross-session persistence
- **Efficient retrieval** - Hybrid search for context recall

### Long-Term Memory

- **Persistent state** - Survives session boundaries
- **Episode tracking** - Records agent decisions and outcomes
- **Knowledge abstraction** - Extracts reusable patterns

---

## Installation & Setup

### Prerequisites

- Python 3.12+
- Node.js 22+
- Docker (optional, for sandbox mode)

### Quick Start

```bash
# Clone the repository
git clone https://github.com/bytedance/deer-flow.git
cd deer-flow

# Run setup wizard
make setup

# Verify installation
make doctor
```

### Configuration

Configuration is managed through `config.yaml` with support for:

```yaml
models:
  - name: gpt-4o
    display_name: GPT-4o
    use: langchain_openai:ChatOpenAI
    model: gpt-4o
    api_key: $OPENAI_API_KEY
```

---

## Integration Options

### Tracing

- **LangSmith Tracing** - Native support for LangSmith observability
- **Langfuse Tracing** - Alternative tracing backend

### IM Channels

- Multiple instant messaging channel support
- Configurable per-channel behavior

### Sandbox Modes

- **Sandbox Mode** - Isolated execution environment
- **MCP Server** - MCP protocol support

---

## Performance Characteristics

- **Fast startup** - Optimized initialization sequence
- **Efficient token usage** - Context compression strategies
- **Parallel execution** - Sub-agent coordination

---

## Use Cases

1. **Deep Research** - Multi-step information gathering
2. **Coding Assistants** - Code generation and review
3. **Data Engineering** - ETL pipeline orchestration
4. **Multi-Step Workflows** - Complex task decomposition

---

## Community & Support

- **GitHub Repository**: https://github.com/bytedance/deer-flow
- **License**: MIT
- **Active Development**: Q1 2026

---

## Externalization Perspective

DeerFlow demonstrates the **four externalization dimensions**:

1. **Memory** - Externalizes state across time via persistent memory
2. **Skills** - Externalizes procedural expertise via extensible skill plugins
3. **Protocols** - Uses MCP for tool interaction governance
4. **Harness** - Coordinates sub-agents, memory, sandboxes into unified execution

---

## Cross-References

**Related**: [[Meta-Harness]], [[Agent Memory]], [[AEGIS]]  
**Similar Systems**: [[OpenClaw]], [[GoClaw]], [[AgentScope Studio]]
