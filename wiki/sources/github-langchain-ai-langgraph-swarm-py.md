---
type: source
title: LangGraph Multi-Agent Swarm
date: 2026-04-15
dimension: harness
source_type: repo
tags:
- type-repo
- harness
- framework-langgraph
- multi-agent
---

# LangGraph Multi-Agent Swarm

Python library for creating swarm-style multi-agent systems using LangGraph.

- GitHub: https://github.com/langchain-ai/langgraph-swarm-py
- Stars: 1.5K | Language: Python | License: MIT
- Dimension: Harness
- Project Type: Multi-agent orchestration

## Overview

A Python library for creating swarm-style multi-agent systems using LangGraph. A swarm is a type of multi-agent architecture where agents dynamically hand off control to one another based on their specializations. The system remembers which agent was last active, ensuring that on subsequent interactions, the conversation resumes with that agent.

## Features

- **Multi-agent collaboration**: Enable specialized agents to work together and hand off context to each other
- **Customizable handoff tools**: Built-in tools for communication between agents
- **Built on LangGraph**: Out-of-box support for streaming, short-term and long-term memory, and human-in-the-loop

## Installation

```bash
pip install langgraph-swarm
```

## Quickstart

```bash
pip install langgraph-swarm langchain-openai
export OPENAI_API_KEY=<your_api_key>
```

The library enables agents to dynamically transfer control based on their specializations, with the system maintaining state about which agent was last active for each user session.

## Memory Support

- **Short-term memory**: Persistence across interactions within a thread
- **Long-term memory**: Cross-thread persistence using stores

## Customization

- Custom handoff tools with additional arguments and data passing
- Custom agent state schemas for isolated agent histories
