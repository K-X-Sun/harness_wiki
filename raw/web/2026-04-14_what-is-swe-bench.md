---
title: "What is SWE-bench?"
source_url: "https://www.ai21.com/glossary/tech/what-is-swe-bench/"
source_type: article
fetched: 2026-04-14
author: "Yuval Belfer"
domain: "ai21.com"
---

# WHAT IS SWE-BENCH?

Yuval Belfer, Senior Developer Advocate @ AI21
Mar 25, 2026

Tech

## SWE-BENCH / SWE-BENCH VERIFIED

SWE-bench is a benchmark for evaluating large language models and AI agents on real-world software engineering tasks. Unlike synthetic coding challenges, it presents agents with genuine GitHub issues drawn from popular open-source repositories and asks them to produce a code patch that resolves each issue and passes the project's existing test suite. SWE-bench Verified is a curated subset of 500 instances from the original benchmark, reviewed and validated by human experts in collaboration with OpenAI, that ensures each task is well-formed and unambiguously solvable.

## HOW IT WORKS

Each SWE-bench instance pairs an issue description with a codebase snapshot checked out at a specific Git commit. An agent is given access to the repository and a set of tools, such as the ability to read files, run bash commands, and edit code, and must navigate the codebase autonomously to identify the root cause and produce a valid patch. Success is determined by running the repository's unit tests against the generated patch in an isolated environment, typically a Docker container. Because agents must traverse large codebases, maintain state across many steps, and avoid breaking unrelated functionality, each run is a high-latency, multi-step workflow that places significant demands on both the model and the evaluation infrastructure. To measure variance and reach statistical confidence, evaluation campaigns typically repeat each instance across multiple random seeds, a practice known as duplicity.

## WHAT IT IS USED FOR

SWE-bench has become the primary standard for measuring the coding capability of agentic AI systems in realistic conditions. AI labs, enterprise teams, and open-source developers use it to compare agent frameworks, evaluate the impact of orchestration strategies such as test-time compute scaling or best-of-N sampling, and track progress as models improve. Because the tasks originate from genuine software projects, a strong SWE-bench score is widely regarded as evidence that a system can handle the kind of multi-step reasoning and tool use required for practical software development work. SWE-bench Verified is commonly preferred for research comparisons because its human-validated task set reduces measurement noise and makes results more reproducible across different evaluation setups.
