---
type: source
title: "What is SWE-bench?"
author: "Yuval Belfer"
date: "2026-03-25"
ingested: "2026-04-14"
updated: "2026-04-14"
source_path: "raw/web/2026-04-14_what-is-swe-bench.md"
source_url: "https://www.ai21.com/glossary/tech/what-is-swe-bench/"
source_domain: "ai21.com"
source_type: "article"
tags: ["benchmark-swe-bench", "eval-offline"]
---

## Summary

This article provides an accessible overview of SWE-bench, describing it as the primary standard for measuring coding capability of agentic AI systems in realistic conditions. Unlike synthetic coding challenges, SWE-bench presents AI agents with genuine GitHub issues from popular open-source repositories, requiring agents to navigate large codebases, maintain state across multiple steps, and produce code patches that pass existing test suites.

The article explains SWE-bench Verified, a curated subset of 500 instances validated by human experts in collaboration with OpenAI, which ensures each task is well-formed and unambiguously solvable. This verified version addresses measurement noise and improves reproducibility across different evaluation setups, making it the preferred choice for research comparisons.

The piece emphasizes SWE-bench's unique demands: high-latency multi-step workflows, significant infrastructure requirements for containerized test execution, and the practice of "duplicity" (repeating instances across multiple random seeds) to achieve statistical confidence. The benchmark has become the de facto standard for comparing agent frameworks, evaluating orchestration strategies like test-time compute scaling, and tracking progress in multi-step reasoning and tool use.

## Key Takeaways

- SWE-bench uses genuine GitHub issues from popular open-source repositories
- Each instance pairs an issue description with a codebase snapshot at a specific Git commit
- Agents must navigate large codebases autonomously with tools (read files, run bash, edit code)
- Success determined by passing unit tests against generated patches in isolated Docker environments
- SWE-bench Verified: 500 human-validated instances curated with OpenAI
- Duplicity: repeating instances across multiple random seeds for statistical confidence
- Has become the primary standard for measuring agentic AI coding capability

## Entities Mentioned

- [[SWE-Bench]] — The benchmark for evaluating AI agents on software engineering tasks
- [[SWE-Bench Verified]] — Curated 500-instance subset validated by human experts
- [[OpenAI]] — Collaborated on validating SWE-bench Verified instances

## Concepts Covered

- [[Real-World Software Engineering Tasks]] — Using genuine GitHub issues vs synthetic challenges
- [[Multi-Step Workflow]] — High-latency agentic processes requiring state maintenance
- [[Test-Based Validation]] — Success measured by passing existing unit tests
- [[Duplicity]] — Repeating evaluations across random seeds for statistical confidence
- [[Docker-Based Evaluation]] — Isolated containerized environments for test execution
- [[Test-Time Compute Scaling]] — Orchestration strategy evaluated using SWE-bench

## Notable Quotes

> "Unlike synthetic coding challenges, it presents agents with genuine GitHub issues drawn from popular open-source repositories and asks them to produce a code patch that resolves each issue and passes the project's existing test suite."

> "Because agents must traverse large codebases, maintain state across many steps, and avoid breaking unrelated functionality, each run is a high-latency, multi-step workflow that places significant demands on both the model and the evaluation infrastructure."

> "A strong SWE-bench score is widely regarded as evidence that a system can handle the kind of multi-step reasoning and tool use required for practical software development work."

## Contradictions and Confirmations

- **Confirms**: SWE-bench is the primary standard for realistic coding agent evaluation
- **Confirms**: Human validation (SWE-bench Verified) improves reproducibility and reduces noise
