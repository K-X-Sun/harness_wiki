---
title: "ProdCodeBench: A Production-Derived Benchmark for Evaluating AI Coding Agents"
source_url: "https://arxiv.org/abs/2604.01527"
source_type: paper
fetched: 2026-04-14
authors: ["Smriti Jha", "Matteo Paltenghi", "Chandra Maddila", "Vijayaraghavan Murali", "Shubham Ugare", "Satish Chandra"]
categories: ["cs.SE", "cs.AI", "cs.LG"]
---

# ProdCodeBench: A Production-Derived Benchmark for Evaluating AI Coding Agents

**Authors:** Smriti Jha, Matteo Paltenghi, Chandra Maddila, Vijayaraghavan Murali, Shubham Ugare, Satish Chandra
**Date:** 2026-04-02
**URL:** https://arxiv.org/abs/2604.01527
**Categories:** cs.SE, cs.AI, cs.LG

## Abstract
> Benchmarks that reflect production workloads are better for evaluating AI coding agents in industrial settings, yet existing benchmarks differ from real usage in programming language distribution, prompt style and codebase structure. This paper presents a methodology for curating production-derived benchmarks, illustrated through ProdCodeBench, a benchmark sourced from real developer-agent sessions. We detail our data collection and curation practices including LLM-based task classification, test relevance validation, and multi-run stability checks which address challenges in constructing reliable evaluation signals from monorepo environments. Each curated sample consists of a verbatim prompt, a committed code change and fail-to-pass tests spanning seven programming languages. Our systematic analysis of four foundation models yields solve rates ranging from 53.2% to 72.2%. We demonstrate how these offline evaluation signals drive practical decisions around model selection and harness design, while noting that offline benchmarks provide directional signal that we complement with online A/B testing for production deployment decisions. We share our methodology and lessons learned to enable other organizations to construct similar production-derived benchmarks.

## Key Points
- Production-derived benchmark from real developer-agent sessions across 7 programming languages
- Each sample: verbatim prompt + committed code change + fail-to-pass tests
- LLM-based task classification, test relevance validation, multi-run stability checks
- Four foundation models scored 53.2% to 72.2% solve rates
- Offline benchmarks provide directional signal; complement with online A/B testing for production deployment
- Shares methodology and lessons learned for organizations to build similar benchmarks

## Relevance to AI Coding Harness
- Directly addresses the gap between academic benchmarks and production coding agent performance
- Demonstrates how offline evaluation signals drive model selection and harness design decisions
- Provides a reproducible methodology for building production-derived benchmarks
