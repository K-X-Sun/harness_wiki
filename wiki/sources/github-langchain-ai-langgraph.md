---
type: source
title: LangGraph
date: 2026-04-15
dimension: harness
source_type: repo
tags:
- type-repo
- harness
- framework-langgraph
---

# LangGraph

Low-level orchestration framework for building stateful agents as graphs.

- GitHub: https://github.com/langchain-ai/langgraph
- Stars: 9,000 | Language: Python | License: MIT
- Dimension: Harness
- Project Type: Agent orchestration framework

## Overview

LangGraph is a low-level orchestration framework for building, managing, and deploying long-running, stateful agents. It provides durable execution, human-in-the-loop, and comprehensive memory capabilities.

## Key Features

- **Durable Execution**: Build agents that persist through failures and can run for extended periods, automatically resuming from exactly where they left off
- **Human-in-the-Loop**: Seamlessly incorporate human oversight by inspecting and modifying agent state at any point during execution
- **Comprehensive Memory**: Create truly stateful agents with both short-term working memory and long-term persistent memory across sessions
- **Debugging with LangSmith**: Gain deep visibility into complex agent behavior with visualization tools
- **Production-ready Deployment**: Deploy sophisticated agent systems with scalable infrastructure

## Architecture

LangGraph is inspired by:
- [Pregel](https://research.google/pubs/pub37252/) - Google's distributed computing framework
- [Apache Beam](https://beam.apache.org/) - Batch and stream processing
- [NetworkX](https://networkx.org/documentation/latest/) - Graph structures

## Ecosystem

- **LangChain**: Provides integrations and composable components
- **LangSmith**: Agent evals and observability
- **LangSmith Deployment**: Purpose-built deployment platform
- **Deep Agents** (new): Build agents that can plan, use subagents, and leverage file systems

## JavaScript/TypeScript

The JS/TS version is available at [LangGraph.js](https://github.com/langchain-ai/langgraphjs).

## Citation

LangGraph is built by LangChain Inc but can be used without LangChain.
