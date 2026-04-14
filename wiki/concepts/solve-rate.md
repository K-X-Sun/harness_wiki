---
type: concept
title: "Solve Rate"
created: "2026-04-14"
updated: "2026-04-14"
source_count: 1
formula: "(Number of successfully solved tasks / Total number of tasks) × 100%"
interpretation: "Higher is better; ranges from 0% to 100%"
limitations: ["Binary success measure", "Does not capture partial progress", "May require multiple runs for statistical significance"]
tags: ["metric-solve-rate", "eval-offline"]
---

## Definition

Solve rate is an evaluation metric measuring the percentage of benchmark tasks that an AI coding agent successfully completes. A task is typically considered "solved" when the generated code change passes all associated tests in an isolated evaluation environment.

## Key Aspects

- **Binary outcome**: Each task is either solved or not; no partial credit
- **Test-based validation**: Success determined by passing fail-to-pass test suites
- **Statistical variance**: Non-deterministic LLM behavior requires multiple runs for confidence
- **Environment isolation**: Typically evaluated in Docker containers or similar sandboxes
- **Benchmark-specific**: Solve rate values are only comparable within the same benchmark

## Related Concepts

- [[Multi-Run Stability]] — Addresses variance in solve rate across multiple executions
- [[Pass@k]] — Related metric measuring success rate when generating k attempts
- [[Production-Derived Benchmarking]] — Solve rate is the primary metric for production-derived benchmarks
- [[Offline vs Online Evaluation]] — Solve rate is an offline metric requiring online validation

## Evidence and Examples

- From [[ProdCodeBench: A Production-Derived Benchmark for Evaluating AI Coding Agents]]: Four foundation models achieved solve rates ranging from 53.2% to 72.2% on ProdCodeBench, demonstrating significant variance in model capability on production-derived tasks

## Evolution

Solve rate has become a standard metric in AI coding evaluation, used across benchmarks like [[SWE-Bench]], [[ProdCodeBench]], and others. The concept originated from software engineering test-driven development where passing all tests indicates successful implementation.

## Open Questions

- How does solve rate correlate with real-world developer productivity gains?
- What is an acceptable solve rate threshold for production deployment?
- How much does solve rate vary with test suite coverage and quality?
- Should partial solutions (passing some but not all tests) contribute to solve rate metrics?
