---
type: entity
title: "OpenHands"
entity_type: "harness"
created: "2026-04-14"
updated: "2026-04-14"
source_count: 1
primary_language: "Python"
supported_benchmarks: ["SWE-Bench", "GAIA", "Commit0", "OpenAgentSafety"]
github_url: "https://github.com/OpenHands/OpenHands"
tags: ["arch-agent-loop", "lang-python"]
---

## Overview

OpenHands is an AI coding agent framework with a comprehensive evaluation infrastructure. The project consists of the core agent system and a separate benchmarks repository that provides standardized evaluation pipelines. OpenHands V1 is built on the OpenHands Agent SDK, emphasizing modularity and SDK-based architecture.

## Key Facts

- **Primary language**: Python
- **Supported benchmarks**: SWE-Bench, GAIA, Commit0, OpenAgentSafety
- **Architecture**: Agent SDK-based with modular design
- **Workspace types**: Local Docker and remote cloud runtime
- **Version**: Currently migrating from V0 to V1
- **Evaluation infrastructure**: Separate benchmarks repository with git submodule pinning
- **Scalability**: Supports massive parallelization (32+ concurrent workers via remote runtime)

## Relationships

- Uses [[OpenHands Agent SDK]] — Core infrastructure for agent implementation
- Evaluates on [[SWE-Bench]] — Primary software engineering benchmark
- Evaluates on [[GAIA]] — General AI assistant tasks
- Evaluates on [[Commit0]] — Python implementation tasks
- Evaluates on [[OpenAgentSafety]] — Safety evaluation benchmark
- Implements [[Workspace Isolation]] through Docker and remote runtime
- Supports [[Benchmark Parallelization]] for large-scale evaluations

## Mentioned In

- [[OpenHands/benchmarks]] — Evaluation infrastructure documentation

## Open Questions

- What specific agent architectures does OpenHands V1 implement?
- What are the performance benchmarks (solve rates) on supported benchmarks?
- How does the agent loop structure differ from other harnesses?
- What tool-use capabilities does the agent expose?
- How does V1 architecture differ from V0?
- What is the adoption/usage status in research and industry?
