---
type: overview
updated: 2026-04-14
---

# AI Coding Systems Engineering — Overview

This wiki documents the engineering practices behind AI coding assistants, focusing on four core areas:

## Memory Systems

How AI agents manage context, store project knowledge, and retrieve relevant information:
- RAG (Retrieval-Augmented Generation) architectures
- Vector databases and semantic search
- Knowledge graphs and structured memory
- Context window management and caching strategies

## Skills & Tools

How AI agents define, compose, and execute capabilities:
- Tool use frameworks and APIs
- Skill composition patterns (sequential, parallel, hierarchical)
- Capability discovery and registration
- Error handling and retry strategies

## Protocols

How AI agents communicate with IDEs, users, and other agents:
- Model Context Protocol (MCP) — Anthropic's standard for context sharing
- Language Server Protocol (LSP) integration
- Custom agent-IDE protocols
- Agent-agent coordination protocols

## Harness Engineering

How AI coding systems execute code safely and efficiently:
- Sandbox architectures (Docker, VMs, process isolation)
- Execution engines and runtime environments
- Security boundaries and threat models
- Permission systems and capability-based security

---

**Current status**: Wiki reset to focus on engineering practices. Ready to ingest sources.

**Priority sources to seek**:
- MCP specification and implementations
- Framework repositories (Claude Code, Cursor, Aider, Continue)
- Papers on agent memory architectures
- Protocol design documentation
- Sandbox/execution environment designs
