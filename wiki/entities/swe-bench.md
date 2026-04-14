---
type: entity
title: "SWE-Bench"
entity_type: "benchmark"
created: "2026-04-14"
updated: "2026-04-14"
source_count: 2
task_count: "500 (Verified subset); full benchmark size not specified"
languages: ["Multiple languages from open-source repositories"]
metrics_used: ["solve-rate", "pass-at-k"]
created_date: "Not specified"
tags: ["benchmark-swe-bench", "eval-offline"]
---

## Overview

SWE-Bench is the primary standard for evaluating large language models and AI agents on real-world software engineering tasks. It distinguishes itself from synthetic coding challenges by using genuine GitHub issues from popular open-source repositories. Each task requires agents to navigate large codebases, identify root causes, and produce code patches that pass existing unit test suites.

SWE-bench Verified is a curated subset of 500 instances that have been reviewed and validated by human experts in collaboration with OpenAI, ensuring each task is well-formed and unambiguously solvable. This verified version has become the preferred choice for research comparisons due to reduced measurement noise and improved reproducibility.

## Key Facts

- **Task source**: Genuine GitHub issues from popular open-source repositories
- **Task structure**: Issue description + codebase snapshot at specific Git commit
- **Agent capabilities required**: File reading, bash execution, code editing, multi-step reasoning
- **Evaluation environment**: Isolated Docker containers
- **Verified subset**: 500 human-validated instances (curated with OpenAI)
- **Evaluation practice**: Duplicity (multiple random seeds) for statistical confidence
- **Infrastructure demands**: High-latency multi-step workflows
- **Primary use**: Comparing agent frameworks, evaluating orchestration strategies, tracking progress

## Relationships

- Evaluated by [[OpenHands]] and other agent harnesses
- Validated by [[OpenAI]] for the Verified subset
- Uses [[Docker-Based Evaluation]] for isolated test execution
- Measures [[Multi-Step Workflow]] capability
- Implements [[Test-Based Validation]] for success criteria
- Requires [[Duplicity]] for statistical confidence

## Mentioned In

- [[What is SWE-bench?]] — Overview article explaining the benchmark
- [[OpenHands/benchmarks]] — Lists SWE-Bench as a supported benchmark in OpenHands infrastructure

## Open Questions

- What is the full task count in the original (non-Verified) SWE-bench?
- What specific open-source repositories are included?
- What programming languages are represented and in what distribution?
- What are current state-of-the-art solve rates?
- How does performance on SWE-bench correlate with production deployment success?
- What is the contamination risk given public GitHub issues?
