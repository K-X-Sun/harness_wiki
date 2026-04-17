---
type: source
title: AutoGen (Microsoft)
date: 2026-04-15
dimension: harness
source_type: repo
tags:
- type-repo
- harness
- framework-autogen
---

# AutoGen (Microsoft)

A programming framework for creating multi-agent AI applications (now in maintenance mode).

- GitHub: https://github.com/microsoft/autogen
- Stars: 52,000 | Language: Python | License: MIT
- Dimension: Harness
- Status: Maintenance Mode (successor: Microsoft Agent Framework)

## Overview

AutoGen is a framework for creating multi-agent AI applications that can act autonomously or work alongside humans. The project is now in maintenance mode and has been succeeded by Microsoft Agent Framework.

## Status

AutoGen is in maintenance mode - no new features or enhancements. Community managed going forward. New users should start with Microsoft Agent Framework.

## Architecture

AutoGen uses a layered and extensible design:

- **Core API** (`autogen-core`): Message passing, event-driven agents, local and distributed runtime
- **AgentChat API** (`autogen-agentchat`): Simpler API for rapid prototyping with multi-agent patterns
- **Extensions API** (`autogen-ext`): LLM clients, code execution, and other capabilities

## Key Components

- **AssistantAgent**: Core agent class with model client integration
- **AgentTool**: Enable multi-agent orchestration through tool delegation
- **McpWorkbench**: Integration with MCP servers for tool usage
- **Console**: UI for agent interaction and streaming output

## Developer Tools

- **AutoGen Studio**: No-code GUI for building multi-agent applications
- **AutoGen Bench**: Benchmarking suite for evaluating agent performance
- **Magentic-One**: State-of-the-art multi-agent team using the framework

## Successor

**Microsoft Agent Framework** (MAF) is the enterprise-ready successor with:
- Stable APIs and long-term support
- Enterprise-grade multi-agent orchestration
- Multi-provider model support
- Cross-runtime interoperability via A2A and MCP
