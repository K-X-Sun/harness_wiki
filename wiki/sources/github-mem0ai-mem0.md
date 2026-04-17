---
type: source
title: Mem0 - Universal Memory Layer
date: 2026-04-15
dimension: memory
source_type: repo
tags:
- type-repo
- memory-system
- framework-mem0
---

# Mem0 - Universal Memory Layer

Universal, self-improving memory layer for LLM applications with hybrid search.

- GitHub: https://github.com/mem0ai/mem0
- Stars: 48,000 | Language: Python | License: Apache 2.0
- Paper: arXiv:2504.19413
- Dimension: Memory
- Project Type: Memory system

## Overview

Mem0 ("mem-zero") enhances AI assistants and agents with an intelligent memory layer, enabling personalized AI interactions. It remembers user preferences, adapts to individual needs, and continuously learns over time.

## Key Features

- **Multi-Level Memory**: User, Session, and Agent state retention
- **Hybrid Search**: Semantic + BM25 + entity extraction for +26% accuracy over OpenAI Memory
- **Developer-Friendly**: Intuitive API, cross-platform SDKs, hosted platform option
- **91% Faster Responses** and **90% Lower Token Usage** than full-context approaches

## Architecture

Mem0 implements a context-with-retrieval memory architecture with:
- Semantic embeddings using text-embedding-3-small (configurable)
- BM25 keyword matching
- Entity extraction for enhanced retrieval
- Hybrid search combining multiple retrieval signals

## Integrations

- LangGraph: Customer bot development
- CrewAI: Output tailoring
- ChatGPT with Memory: Personalized chat
- Browser Extension: Store memories across ChatGPT, Perplexity, Claude

## Applications

- AI Assistants: Consistent, context-rich conversations
- Customer Support: Recall past tickets and user history
- Healthcare: Track patient preferences and history
- Productivity & Gaming: Adaptive workflows and environments

## Citation

```bibtex
@article{mem0,
  title={Mem0: Building Production-Ready AI Agents with Scalable Long-Term Memory},
  author={Chhikara, Prateek and Khant, Dev and Aryan, Saket and Singh, Taranjeet and Yadav, Deshraj},
  journal={arXiv preprint arXiv:2504.19413},
  year={2025}
}
```
