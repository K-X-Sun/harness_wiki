---
type: concept
title: "Production-Derived Benchmarking"
created: "2026-04-14"
updated: "2026-04-14"
source_count: 1
tags: ["benchmark-design", "eval-production"]
---

## Definition

Production-derived benchmarking is a methodology for creating evaluation benchmarks by extracting real tasks from production usage rather than constructing synthetic challenges. This approach preserves the actual programming language distributions, prompt styles, and codebase structures encountered in real-world deployments.

## Key Aspects

- **Authenticity**: Tasks come from genuine developer-agent interactions, not artificially constructed problems
- **Representativeness**: Reflects actual usage patterns including language distribution, prompt formulation, and code complexity
- **Verbatim preservation**: Maintains original prompts without sanitization or simplification
- **Test grounding**: Uses actual fail-to-pass tests from committed code changes
- **Environmental realism**: Captures monorepo complexity and production constraints

## Related Concepts

- [[Multi-Run Stability]] — Required to handle non-deterministic LLM behavior in production-derived scenarios
- [[Test Relevance Validation]] — Ensures extracted tests actually validate intended functionality
- [[LLM-Based Task Classification]] — Automated categorization of production-derived tasks
- [[Offline vs Online Evaluation]] — Production-derived benchmarks provide offline signal to complement online testing
- [[Solve Rate]] — Primary metric for measuring performance on production-derived tasks

## Evidence and Examples

- From [[ProdCodeBench: A Production-Derived Benchmark for Evaluating AI Coding Agents]]: ProdCodeBench demonstrates this methodology by curating tasks from real developer-agent sessions, resulting in solve rates between 53.2% and 72.2% across four foundation models—significantly different from performance on academic benchmarks

## Evolution

Initially introduced through [[ProdCodeBench]] as a response to the recognition that existing academic benchmarks (like HumanEval and MBPP) diverge from real production usage patterns. The methodology emphasizes that offline benchmarks should provide "directional signal" for model selection and harness design, while being complemented with online A/B testing for final production decisions.

## Open Questions

- How much does benchmark performance on production-derived vs academic benchmarks correlate?
- What is the minimum sample size needed from production to create a statistically valid benchmark?
- How frequently should production-derived benchmarks be refreshed to stay representative?
- Can production-derived methodologies be extended beyond coding to other AI tasks?
- How do contamination risks differ between production-derived and synthetic benchmarks?
