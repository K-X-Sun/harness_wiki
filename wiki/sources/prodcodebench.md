---
type: source
title: "ProdCodeBench: A Production-Derived Benchmark for Evaluating AI Coding Agents"
author: "Smriti Jha, Matteo Paltenghi, Chandra Maddila, Vijayaraghavan Murali, Shubham Ugare, Satish Chandra"
date: "2026-04-02"
ingested: "2026-04-14"
updated: "2026-04-14"
source_path: "raw/web/2026-04-14_arxiv_2604_01527_prodcodebench.md"
source_url: "https://arxiv.org/abs/2604.01527"
source_domain: "arxiv.org"
source_type: "paper"
tags: ["benchmark-prodcodebench", "eval-offline", "eval-production", "method-multi-run-stability"]
---

## Summary

ProdCodeBench presents a methodology for constructing production-derived benchmarks that better reflect real-world coding agent usage. Unlike existing academic benchmarks, this benchmark is sourced directly from real developer-agent sessions, capturing the actual programming language distribution, prompt styles, and codebase structures encountered in production environments. The paper addresses a critical gap: existing benchmarks often diverge significantly from how coding agents are used in industrial settings.

The benchmark methodology includes several key innovations: LLM-based task classification to categorize the types of coding tasks, test relevance validation to ensure tests actually verify the intended functionality, and multi-run stability checks to account for the non-deterministic nature of LLM outputs in monorepo environments. Each curated sample preserves the verbatim prompt from the developer, the actual committed code change, and fail-to-pass tests that validate the solution.

The authors evaluated four foundation models on ProdCodeBench, achieving solve rates between 53.2% and 72.2%. They emphasize that while offline benchmarks like ProdCodeBench provide valuable directional signals for model selection and harness design decisions, they should be complemented with online A/B testing for final production deployment decisions. The paper shares their complete methodology and lessons learned to enable other organizations to build similar production-derived benchmarks.

## Key Takeaways

- Production-derived benchmarks better reflect real-world usage than synthetic academic benchmarks
- Key methodology components: LLM-based task classification, test relevance validation, multi-run stability checks
- Benchmark spans seven programming languages with verbatim prompts from real developer sessions
- Four foundation models achieved solve rates ranging from 53.2% to 72.2%
- Offline benchmarks provide directional signal but should be complemented with online A/B testing
- Complete methodology shared to enable other organizations to replicate the approach

## Entities Mentioned

- [[ProdCodeBench]] — The production-derived benchmark introduced in this paper
- [[Smriti Jha]] — First author, researcher on AI coding evaluation
- [[Matteo Paltenghi]] — Co-author, researcher on software engineering benchmarks
- [[Chandra Maddila]] — Co-author, researcher on developer productivity
- [[Vijayaraghavan Murali]] — Co-author, researcher on code intelligence
- [[Shubham Ugare]] — Co-author, researcher on AI-assisted coding
- [[Satish Chandra]] — Senior author, researcher on programming languages and software engineering

## Concepts Covered

- [[Production-Derived Benchmarking]] — Methodology for creating benchmarks from real production usage rather than synthetic tasks
- [[Multi-Run Stability]] — Testing methodology to account for non-deterministic LLM behavior across multiple executions
- [[Test Relevance Validation]] — Ensuring that tests actually verify the intended functionality of code changes
- [[LLM-Based Task Classification]] — Using language models to automatically categorize coding tasks
- [[Solve Rate]] — Evaluation metric measuring the percentage of benchmark tasks successfully completed
- [[Offline vs Online Evaluation]] — Complementary evaluation strategies balancing reproducibility with production validity
- [[Monorepo Evaluation Challenges]] — Special considerations when evaluating code changes in large multi-project repositories

## Notable Quotes

> "Benchmarks that reflect production workloads are better for evaluating AI coding agents in industrial settings, yet existing benchmarks differ from real usage in programming language distribution, prompt style and codebase structure."

> "Our systematic analysis of four foundation models yields solve rates ranging from 53.2% to 72.2%."

> "We demonstrate how these offline evaluation signals drive practical decisions around model selection and harness design, while noting that offline benchmarks provide directional signal that we complement with online A/B testing for production deployment decisions."

## Contradictions and Confirmations

- **Challenges**: Existing academic benchmarks — this paper argues they don't adequately represent production usage patterns
- **Confirms**: The importance of complementary evaluation strategies (offline + online) for production systems
