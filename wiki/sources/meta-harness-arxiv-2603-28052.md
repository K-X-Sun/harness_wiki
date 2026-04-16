---
type: source
title: "Meta-Harness: End-to-End Optimization of Model Harnesses"
source_type: paper
arxiv_id: "2603.28052"
url: "https://arxiv.org/abs/2603.28052"
authors: ["Yoonho Lee", "Roshen Nair", "Qizheng Zhang", "Kangwook Lee", "Omar Khattab", "Chelsea Finn"]
affiliations: ["Stanford University", "University of Wisconsin-Madison", "MIT"]
published: "2026-03-30"
dimension: harness
tags: [harness-loop, harness-observability, harness-context-mgmt, arch-agent-loop, lang-python]
updated: 2026-04-16
---

# Meta-Harness: End-to-End Optimization of Model Harnesses

**Source**: arXiv:2603.28052  
**Authors**: Yoonho Lee, Roshen Nair, Qizheng Zhang, Kangwook Lee, Omar Khattab, Chelsea Finn  
**Affiliations**: Stanford University, University of Wisconsin-Madison, MIT  
**Published**: March 30, 2026

## Abstract

The performance of large language model (LLM) systems depends not only on model weights, but also on their **harness**: the code that determines what information to store, retrieve, and present to the model. Yet harnesses are still designed largely by hand, and existing text optimizers are poorly matched to this setting because they compress feedback too aggressively.

This paper introduces **Meta-Harness**, an outer-loop system that searches over harness code for LLM applications. It uses an agentic proposer that accesses the source code, scores, and execution traces of all prior candidates through a filesystem interface.

## Key Contributions

1. **Formulation of harness optimization as program synthesis** with filesystem interface for accessing source code, execution traces, and performance scores
2. **Substantial empirical gains** across three diverse tasks (+4.7 to +7.7 percentage points)
3. **Analysis showing execution trace access is critical** for effective optimization
4. **Discovery of reusable harness design patterns**: adaptive budgets, staged retrieval, execution checkpointing

## Empirical Results

### Online Text Classification
- **Accuracy improvement**: +7.7 points (72.3% → 80.0%)
- **Context token reduction**: 4x (2,400 → 600 tokens per query)
- **Latency improvement**: 2.3x faster response time
- **Discovered pattern**: Hierarchical memory structure with short-term buffer, semantic index, and category-specific summaries

### Retrieval-Augmented Math Reasoning
- **Dataset**: 200 IMO-level problems
- **Average improvement**: +4.7 points across 5 models
  - Claude Opus 4.6: +5.2 points (34.5% → 39.7%)
  - Claude Sonnet 4.6: +4.8 points (28.1% → 32.9%)
  - GPT-4: +4.3 points
  - Gemini Ultra: +4.9 points
  - LLaMA 3.1 405B: +3.9 points
- **Discovered pattern**: Two-stage retrieval (coarse over problem types, fine-grained over theorems) + theorem paraphrasing (+23% utilization improvement)

### Agentic Coding
- **Task**: TerminalBench-2 (167 real-world coding tasks)
- **Pass@1 improvement**: +5.7 points (52.7% → 58.4%)
- **Average steps reduction**: 8.3 → 6.1
- **Token usage reduction**: -18%
- **Discovered pattern**: Test-driven harness design with front-loaded exploration, incremental verification, and automatic rollback on regression

## Architecture

Meta-Harness consists of three components:

### 1. Filesystem Interface

All harness candidates, execution traces, and scores are stored in a structured directory:

```
workspace/
  candidates/
    h001_baseline.py
    h002_add_retrieval.py
  traces/
    h001_trace_example1.json
  scores/
    h001_scores.json
```

This enables the proposer to read any prior harness implementation, analyze execution traces for debugging, compare scores across variants, and track provenance of design decisions.

### 2. Agentic Proposer

An LLM-based agent that:
- Explores the filesystem to understand prior attempts
- Identifies patterns in successful vs. failed harnesses
- Generates new harness code through targeted modifications
- Explains its reasoning through natural language commentary

The proposer is given access to workspace/ and asked to review execution traces to identify failure patterns and propose improvements.

### 3. Evaluation Loop

Iterative process:
1. Proposer generates new harness
2. Execute on training examples with logging
3. Compute score
4. Save candidate, traces, and score to filesystem
5. Update best harness if score improves

Most gains occur in the first 20 iterations (typically 3-4 hours of compute).

## Ablation Studies

### Importance of Filesystem Access

| Access Level | Online Classification | Math Reasoning | Agentic Coding |
|--------------|---------------------|----------------|----------------|
| No filesystem (baseline) | 72.3% | 34.5% | 52.7% |
| Source code only | 75.1% (+2.8) | 36.2% (+1.7) | 54.3% (+1.6) |
| + Scores | 76.8% (+4.5) | 37.1% (+2.6) | 55.9% (+3.2) |
| + Execution traces | 80.0% (+7.7) | 39.7% (+5.2) | 58.4% (+5.7) |

**Conclusion**: Execution traces provide the most value, enabling the proposer to debug failures and understand causality.

### Proposer Model Scaling

More capable proposer models (e.g., Claude Opus 4.6) yield better harness designs, but even mid-tier models (Claude Sonnet 4.0) achieve substantial gains.

## Discovered Design Patterns

Across experiments, Meta-Harness consistently discovered several non-obvious patterns:

1. **Adaptive context budgets**: Allocate more tokens to difficult examples, fewer to easy ones
2. **Staged retrieval**: Coarse-to-fine search reduces retrieval latency while maintaining quality
3. **Execution checkpoints**: Save intermediate state for rollback on failure
4. **Selective logging**: Log detailed traces only for low-confidence outputs

These patterns were **not explicitly programmed** and emerged through iterative refinement.

## Generalization Across Models

Harnesses optimized for one model show some transfer to others, but model-specific optimization provides additional benefits. Ensembling across multiple proposer models provides a middle ground between generalization and specialization.

## Limitations

1. **Computational cost**: Requires 20-50 optimization iterations, each evaluating on training data
2. **Task specification**: Requires clear task definition and evaluation metrics
3. **Safety**: Automated code generation requires sandboxing (Docker containers, static analysis)
4. **Interpretability**: Discovered harnesses can be complex; mitigated through proposer-generated documentation

## Externalization Perspective

Meta-Harness represents a **meta-level externalization**: instead of manually designing how memory, context, and tools are managed (harness engineering), the system externalizes the optimization process itself into an automated search through program space.

The filesystem interface is the key externalization mechanism—it converts the harness optimization problem from an unbounded search into a **structured exploration** of a persistent workspace where all prior attempts, their traces, and their outcomes are available for inspection and learning.

## Related Work

- **Prompt optimization**: DSPy, TextGrad, ProTeGi, OPRO (focus on text prompts, not executable harness code)
- **Context management**: [[MemGPT]], [[Mem0]], hierarchical memory systems
- **Agent frameworks**: AutoGen, [[LangGraph]], CrewAI
- **Program synthesis**: PROSE, FlashFill, AlphaCode
- **Harness engineering**: Natural-Language Agent Harnesses (NLAH), agent loop design patterns

Meta-Harness uniquely combines elements from all these areas into a unified optimization framework operating on executable harness code.

## Implementation Details

- **Computational budget**: 4 NVIDIA A100 GPUs per experiment, 3-4 hours per optimization run, ~$50-100 in compute costs per task
- **Code release**: https://github.com/meta-harness/meta-harness

## Significance for Harness Engineering

This work demonstrates that harness engineering—traditionally a manual, expertise-intensive process—can be partially automated through program synthesis with rich feedback. The key insight is that **execution traces** provide the information necessary for an LLM proposer to understand causality and generate targeted improvements.

The discovered patterns (adaptive budgets, staged retrieval, test-driven execution) suggest that there are reusable harness design principles that can be learned from data rather than requiring human architectural insight.

## Cross-References

Related entities: [[Meta-Harness Framework]]  
Related concepts: [[Harness Optimization]], [[Execution Trace Analysis]], [[Adaptive Context Budget]], [[Staged Retrieval]], [[Test-Driven Harness Design]]  
Related papers: [[Externalization in LLM Agents]]
