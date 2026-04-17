---
title: "AgentMemory - Persistent Memory for AI Coding Agents"
source_url: "https://github.com/rohitg00/agentmemory"
source_type: github
fetched: 2026-04-16
dimension: memory
stars: 1423
forks: 156
license: MIT
primary_language: Python
github_owner: rohitg00
github_repo: agentmemory
---

# AgentMemory - Persistent Memory for AI Coding Agents

**Source**: GitHub - rohitg00/agentmemory  
**Stars**: 1,423 | **Forks**: 156 | **License**: MIT  
**Primary Language**: Python  
**Published**: 2025-2026

---

## Overview

**Your coding agent remembers everything. No more re-explaining.**

AgentMemory is a persistent memory system for AI coding agents. It silently captures what your agent does, compresses it into searchable memory, and injects the right context when the next session starts.

Based on the viral [GitHub Gist](https://gist.github.com/rohitg00/2067ab416f7bbe447c1977edaaa681e2) (719 stars / 97 forks) that extends Karpathy's LLM Wiki pattern with confidence scoring, lifecycle, knowledge graphs, and hybrid search.

---

## Key Features

| Feature | Description |
|---------|-------------|
| **Persistent Memory** | No more re-explaining architecture decisions |
| **43 MCP Tools** | Native MCP server support |
| **12 Auto Hooks** | Automatic capture across 12 agent lifecycle events |
| **0 External DBs** | No external database required |
| **654 Tests Passing** | Production-tested reliability |
| **95.2% retrieval R@5** | High retrieval accuracy |
| **92% fewer tokens** | Efficient memory compression |
| **Hybrid Search** | Semantic + BM25 + entity extraction |

---

## Architecture

### 3-Tier Memory System

```
┌─────────────────────────────────────────────────────────────┐
│                     Persistent Memory                       │
├─────────────────────────────────────────────────────────────┤
│  Working (L0)  │  Episodic (L1)  │  Semantic (L2)           │
│  Session       │  Summaries      │  Knowledge Graph         │
└─────────────────────────────────────────────────────────────┘
```

| Tier | Scope | Retention | Retrieval |
|------|-------|-----------|-----------|
| Working | Current session | Short-term | Direct access |
| Episodic | Session history | Medium-term | Summarized access |
| Semantic | Cross-session | Long-term | Knowledge graph traversal |

### Hybrid Search

AgentMemory uses a **hybrid search** combining:
1. **Semantic embeddings** - Conceptual similarity
2. **BM25** - Keyword matching
3. **Entity extraction** - Structured entity retrieval

Results are fused for optimal recall and precision.

---

## Works With Every Agent

| Agent | Integration | Features |
|-------|-------------|----------|
| Claude Code | 12 hooks + MCP + skills | Full memory sync |
| OpenClaw | MCP + plugin | Persistent state |
| Hermes | MCP + plugin | Session continuity |
| Cursor | MCP server | Cross-session memory |
| Gemini CLI | MCP server | Codebase memory |
| OpenCode | MCP server | Architecture memory |
| Codex CLI | MCP server | Project memory |
| Cline | MCP server | Tool call memory |
| Goose | MCP server | Skill memory |
| Kilo Code | MCP server | Multi-file memory |
| Aider | REST API | Repository memory |
| Claude Desktop | MCP server | Local memory |
| Windsurf | MCP server | Workspace memory |
| Roo Code | MCP server | IDE memory |
| Claude SDK | AgentSDKProvider | SDK memory |

**Plus 109 REST API endpoints** for any agent.

---

## Quick Start

### Python

```bash
pip install agentmemory
```

```python
from agentmemory import AgentMemory

memory = AgentMemory()

# Create memory
memory.create_memory(
    user="user123",
    agent="claude-code",
    content="Project uses TypeScript and React",
    memory_type="semantic"
)

# Search memories
results = memory.search_memories(
    user="user123",
    query="What framework does this project use?",
    top_k=5
)

# Update memory
memory.update_memory(
    memory_id="mem_123",
    content="Project uses TypeScript, React, and Next.js"
)

# Delete memory
memory.delete_memory(memory_id="mem_123")
```

### MCP Server

AgentMemory runs as an MCP server with 43 tools for memory operations.

---

## Memory Types

| Type | Description | Use Case |
|------|-------------|----------|
| Working | Current session context | Active task state |
| Episodic | Past agent experiences | Learning from failures |
| Semantic | Abstracted knowledge | Project conventions |
| Personal | User preferences | Personalized behavior |

---

## Integration Examples

### Claude Code Integration

```json
{
  "mcpServers": {
    "agentmemory": {
      "command": "npx",
      "args": ["-y", "@agentmemory/agentmemory"]
    }
  }
}
```

### HTTP API

```bash
# Create memory
curl -X POST http://localhost:8000/api/v1/memories \
  -H "Content-Type: application/json" \
  -d '{
    "user": "user123",
    "agent": "claude-code",
    "content": "Project structure: src/, dist/, docs/",
    "memory_type": "semantic"
  }'

# Search memories
curl "http://localhost:8000/api/v1/memories/search?user=user123&query=project+structure"
```

---

## Benchmarks

| Metric | Result |
|--------|--------|
| Retrieval R@5 | 95.2% |
| Token Reduction | 92% fewer tokens vs. full context |
| External DBs | 0 (file-based storage) |
| Tests Passing | 654 |

---

## Storage Backends

| Backend | Performance | Use Case |
|---------|-------------|----------|
| Local File System | Fast | Development, single-user |
| SQLite | Fast | Single-instance production |
| PostgreSQL | Scalable | Multi-user production |
| Redis | Ultra-fast | Cache layer |

---

## Cross-References

**Related**: [[Mem0]], [[MemGPT]], [[Hierarchical Memory]]  
**Similar Systems**: [[AgentScope Studio]] (tracing), [[OpenClaw]] (integration)
