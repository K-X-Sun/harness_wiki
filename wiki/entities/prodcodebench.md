---
type: entity
title: "ProdCodeBench"
entity_type: "benchmark"
created: "2026-04-14"
updated: "2026-04-14"
source_count: 1
task_count: "Not specified in source"
languages: ["Seven programming languages (specific languages not detailed)"]
metrics_used: ["solve-rate"]
created_date: "2026-04-02"
tags: ["benchmark-prodcodebench", "eval-production", "lang-multi"]
---

## Overview

ProdCodeBench is a production-derived benchmark for evaluating AI coding agents, distinguishing itself from academic benchmarks by sourcing tasks directly from real developer-agent sessions in industrial settings. Each benchmark sample consists of a verbatim prompt from an actual developer, a committed code change, and fail-to-pass tests spanning seven programming languages.

The benchmark was created to address the gap between existing academic benchmarks and production usage, where differences in programming language distribution, prompt style, and codebase structure can significantly impact evaluation validity.

## Key Facts

- **Source**: Real developer-agent sessions from production environments
- **Task composition**: Verbatim prompt + committed code change + fail-to-pass tests
- **Programming languages**: Spans seven languages (specific languages not detailed in available source)
- **Curation methodology**: LLM-based task classification, test relevance validation, multi-run stability checks
- **Environment**: Designed for monorepo evaluation scenarios
- **Release date**: April 2, 2026 (paper publication)
- **Evaluation results**: Four foundation models achieved solve rates between 53.2% and 72.2%

## Relationships

- Evaluated by [[GPT-4]], [[Claude]], and other foundation models (specific models achieving 53.2-72.2% solve rates)
- Created using [[Multi-Run Stability]] testing methodology
- Implements [[Test Relevance Validation]] as part of curation process
- Addresses limitations of traditional academic benchmarks
- Complements [[Online A/B Testing]] for production deployment decisions

## Mentioned In

- [[ProdCodeBench: A Production-Derived Benchmark for Evaluating AI Coding Agents]] — Primary source introducing the benchmark

## Open Questions

- What are the specific seven programming languages covered?
- What is the total task count in the benchmark?
- How does the solve rate distribution vary across programming languages?
- What specific foundation models were evaluated?
- Is the benchmark publicly available? What is the access mechanism?
- How does performance correlate between ProdCodeBench and online production metrics?
