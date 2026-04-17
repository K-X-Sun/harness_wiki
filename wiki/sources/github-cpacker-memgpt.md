---
type: source
title: MemGPT (Letta)
date: 2026-04-15
dimension: memory
source_type: repo
tags:
- type-repo
- memory-system
- framework-letta
---

# MemGPT (Letta)

Stateful agents with OS-style memory management and self-improving capabilities.

- GitHub: https://github.com/cpacker/MemGPT
- Stars: 22,000 | Language: Python | License: MIT
- Dimension: Memory
- Project Type: Stateful agent framework

## Overview

Letta (formerly MemGPT) is a framework for building AI agents with advanced memory that can learn and self-improve over time. It provides stateful agents with OS-style memory management through memory blocks that persist across sessions.

## Key Features

- **Memory Blocks**: User-defined memory blocks that persist state across agent sessions
- **Multi-Level Memory**: Human and persona memory blocks for structured state management
- **Tool Integration**: Extensible tool system for web search, webpage fetching, and more
- **Model Agnostic**: Works with any LLM, recommended Opus 4.5 and GPT-5.2 for best performance
- **CLI and API**: Letta Code for local terminal agents, Letta API for application integration
- **Skills and Subagents**: Built-in support for advanced memory and continual learning

## Architecture

Letta implements a context-with-retrieval memory architecture where:
- Active memory blocks are kept in context
- Memory can be retrieved based on queries
- State persists across sessions through agent IDs

## Integration

- TypeScript/Node.js SDK: `@letta-ai/letta-client`
- Python SDK: `letta-client`
- API documentation: https://docs.letta.com/api
- Community: Discord, forum, Twitter/X, LinkedIn, YouTube
