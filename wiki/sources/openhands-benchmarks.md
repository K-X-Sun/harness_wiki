---
type: source
title: "OpenHands/benchmarks"
author: "OpenHands team"
date: "2026-04-14"
ingested: "2026-04-14"
updated: "2026-04-14"
source_path: "raw/web/2026-04-14_github_openhands_benchmarks.md"
source_url: "https://github.com/OpenHands/benchmarks"
source_domain: "github.com"
source_type: "repo"
tags: ["arch-agent-loop", "lang-python", "benchmark-swe-bench"]
---

## Summary

OpenHands/benchmarks is a comprehensive evaluation infrastructure repository providing standardized evaluation pipelines for the OpenHands V1 agent framework. The repository implements support for multiple benchmark suites including SWE-Bench, GAIA, Commit0, and OpenAgentSafety, offering a unified interface for testing AI agent capabilities across diverse real-world tasks.

The infrastructure is built on the OpenHands Agent SDK and emphasizes reproducibility through git submodule pinning, workspace isolation (Docker and remote execution), and rich logging capabilities. The repository is currently undergoing migration from V0 to V1, adopting the new Software Agent SDK architecture for improved extensibility and standardization.

A key architectural feature is support for two workspace types: local Docker containers for development and testing, and remote cloud-based runtime for large-scale parallel evaluations. The remote workspace can provision hundreds of containers simultaneously, enabling evaluation campaigns that would be resource-prohibitive on local machines. The system also provides GitHub Actions integration for triggering cloud evaluations directly from the repository.

## Key Takeaways

- Unified evaluation infrastructure supporting four active benchmarks: SWE-Bench, GAIA, Commit0, OpenAgentSafety
- Built on OpenHands Agent SDK with git submodule for reproducible evaluations
- Dual workspace architecture: local Docker (development) and remote runtime (scale)
- Remote runtime enables massive parallelization (32+ concurrent workers)
- Rich logging with color-coded tool calls and structured output
- GitHub Actions integration for cloud evaluation dispatch
- SDK version compatibility management critical due to evolving API surface

## Entities Mentioned

- [[OpenHands]] — The agent framework being evaluated
- [[OpenHands Agent SDK]] — Core SDK providing agent infrastructure
- [[SWE-Bench]] — Primary software engineering benchmark supported
- [[GAIA]] — General AI assistant benchmark with multi-step reasoning tasks
- [[Commit0]] — Python function implementation benchmark with unit tests
- [[OpenAgentSafety]] — AI agent safety evaluation benchmark

## Concepts Covered

- [[Evaluation Harness Architecture]] — Standardized pipeline design for agent evaluation
- [[Workspace Isolation]] — Docker and remote runtime for isolated execution
- [[Benchmark Parallelization]] — Scaling evaluation through cloud-based containers
- [[SDK Versioning]] — Managing compatibility between harness and SDK versions
- [[Rich Logging]] — Structured, color-coded output for debugging agent behavior
- [[Pre-built Agent Images]] — Container images pinned to specific SDK commits

## Notable Quotes

> "The Benchmarks project uses a local git submodule for the OpenHands Agent SDK. This ensures your code runs against a specific, reproducible commit."

> "Remote runtime enables massive parallelization (e.g., 32+ concurrent workers)"

> "Not every version of the benchmarks is compatible with every version of the SDK. As the SDK evolves and introduces new features, the benchmarks code may adopt these features, creating version dependencies."

## Contradictions and Confirmations

- **Confirms**: The importance of reproducibility in evaluation infrastructure through version pinning
- **Confirms**: Need for both local (Docker) and scalable (remote) execution environments
