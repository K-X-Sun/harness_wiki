---
type: overview
updated: 2026-04-16
---

# AI Coding Systems Engineering — Overview

This wiki documents the engineering practices behind AI coding assistants through the lens of **externalization**—the progressive relocation of cognitive burdens from the model's internal computation into persistent, inspectable, and reusable external structures.

**Foundational framework**: "Externalization in LLM Agents: A Unified Review of Memory, Skills, Protocols and Harness Engineering" (arXiv:2604.08224)

## Four Externalization Dimensions

### Memory Systems

**Transformation**: Recall → Recognition

How AI agents externalize state management across time:
- **Architecture types**: Monolithic context, context-with-retrieval, hierarchical memory, adaptive memory (Du 2026 taxonomy)
- **Content types**: Working context, episodic experience, semantic knowledge, personalized memory
- **Retrieval strategies**: Hybrid search (semantic + BM25 + entity), vector databases, knowledge graphs
- **Production systems**: [[Mem0]] (+26% accuracy, 91% faster, 90% token reduction vs. OpenAI Memory)

**Key insight**: Retrieval-based memory scales better than context-based memory as conversation history grows. The cognitive burden of "remembering user preferences" relocates from model parameters to external storage.

### Skills & Tools

**Transformation**: Generation → Composition

How AI agents externalize procedural expertise:
- **Three components**: Operational procedures, decision heuristics, normative constraints
- **Lifecycle**: Authored, distilled, discovered, composed
- **Activation pipeline**: Specification → discovery → progressive disclosure → binding → composition
- **Patterns**: Tool use frameworks, capability discovery, error handling strategies

**Key insight**: Skills convert unbounded generation (model improvises procedure) into structured composition (model assembles from reusable units).

### Protocols

**Transformation**: Ad-hoc → Governed

How AI agents externalize interaction structure:
- **Protocol types**: Agent-tool (MCP, LSP), agent-agent (multi-agent coordination), agent-user (approval gates)
- **Design principles**: Intent capture, capability discovery, lifecycle management, schema validation
- **Production examples**: [[Model Context Protocol (MCP)]] (<50ms latency, capability-based security)

**Key insight**: Protocols convert ambiguous coordination into explicit contracts with typed fields and format enforcement.

### Harness Engineering

**Unification Layer**: Coordinates Memory, Skills, Protocols into Governed Execution

Six analytical dimensions:
1. **Agent loop**: Control flow (perceive-plan-act-observe), termination, recursion bounds
2. **Sandboxing**: Execution isolation, filesystem restrictions, resource quotas
3. **Human oversight**: Approval gates, escalation triggers, hook systems
4. **Observability**: Structured logging, execution traces, feedback loops
5. **Configuration**: Permission layers (user/project/org), policy encoding
6. **Context budget**: Token allocation, summarization, staged loading, eviction

**Novel contribution**: [[Meta-Harness]] demonstrates harness engineering itself can be externalized through automated program synthesis with filesystem-based execution trace access. Achieves +4.7 to +7.7 point improvements by discovering non-obvious patterns like adaptive context budgets and staged retrieval.

---

## Current Status

**Sources ingested**: 10+
- [[MCP Technical Overview]]: Protocol design with capability-based security
- [[Meta-Harness paper|meta-harness-arxiv-2603-28052]]: Automated harness optimization
- [[Mem0 GitHub|mem0-github]]: Production memory system with hybrid search
- [[DeerFlow]]: Super agent harness by ByteDance (61K+ stars)
- [[AIO Sandbox]]: All-in-one agent sandbox (2.8K stars)
- [[AEGIS]]: Pre-execution firewall for AI agents (arXiv:2603.12621)
- [[AgentMemory]]: Persistent memory for AI coding agents (43 MCP tools)
- [[FerrumDeck]]: AgentOps control plane with dual-plane architecture
- [[GoClaw]]: Multi-tenant AI agent platform in Go
- [[Cordum]]: Agent control plane with CAP protocol
- [[Hive]]: Multi-agent harness for production (10K+ stars)
- [[Chorus]]: Agent harness for AI-Human Collaboration (AI-DLC workflow)
- [[Citadel]]: Operating system for autonomous engineering
- [[AgentScope Studio]]: Development-oriented visualization toolkit

**Entities documented**: 10+
- Frameworks: [[Meta-Harness]], [[DeerFlow]], [[GoClaw]], [[Hive]], [[Citadel]], [[Chorus]]
- Protocols: [[Model Context Protocol (MCP)]], [[CAP]]
- Memory Systems: [[Mem0]], [[AgentMemory]]
- Harnesses: [[AIO Sandbox]], [[AEGIS]], [[Cordum]], [[FerrumDeck]]
- Tools: [[Logfire]], [[AgentScope Studio]]

**Concepts established**: 3+
- Memory: [[Hybrid Search]] (semantic + BM25 + entity fusion)
- Harness: [[Harness Optimization]] (program synthesis with execution traces)
- Security: [[Capability-Based Security]] (unforgeable tokens vs. ambient authority)

---

## Key Findings

### Memory Architecture Validation

[[Mem0]]'s success (48K GitHub stars, YC-backed, +26% accuracy) validates the **context-with-retrieval architecture**:
- Pure context (monolithic): Doesn't scale beyond ~100K tokens
- Context-with-retrieval: Scales to millions of tokens, 90% cost reduction
- **Hybrid search matters**: Semantic alone misses exact matches; BM25 + entity boost recall by 15-30%

**Implication**: Production memory systems should use hybrid retrieval, not pure semantic search.

### Harness Engineering Can Be Automated

[[Meta-Harness]] demonstrates harness optimization through program synthesis:
- **Execution traces are critical**: +7.7 points with traces vs. +4.5 with scores alone
- **Non-obvious patterns emerge**: Adaptive budgets, staged retrieval, test-driven design (not explicitly programmed)
- **Convergence is fast**: 20 iterations (3-4 hours) capture most gains

**Implication**: Harness engineering is not inherently human-only—automated optimization is tractable and effective.

### Externalization Trade-offs

**When externalization wins**:
- Large state (memory > context window)
- Reusable procedures (skills amortize cost)
- Governed interactions (protocols enforce contracts)
- Complex harnesses (optimization finds non-obvious patterns)

**When internalization (parametric) wins**:
- Small state (fits in context)
- One-off tasks (no reuse)
- Latency-critical (retrieval adds 10-50ms)
- Simple harnesses (manual design sufficient)

---

## Next Priorities

### Memory Dimension
- MemGPT (hierarchical memory with tier-based consolidation)
- Adaptive memory architectures (feedback-based strategy optimization)
- Episodic memory systems (execution trace storage and retrieval)

### Skills Dimension
- Skill distillation (inducing reusable skills from trajectories)
- Skill composition patterns (serial, parallel, conditional, recursive)
- Progressive disclosure mechanisms (staged loading of skill guides)

### Protocols Dimension
- LSP integration patterns in AI coding systems
- Multi-agent coordination protocols
- MCP community server implementations (filesystem, git, databases)

### Harness Dimension
- Framework comparisons (Claude Code, Cursor, Aider, OpenHands)
- Sandboxing architectures (Docker, VMs, worktrees)
- Context budget management strategies
- Observability and execution tracing designs

### Cross-Cutting
- Externalization measurement: How to quantify cognitive burden relocation?
- Transfer learning: Do memory/skill/protocol designs generalize across domains?
- Security boundaries: How do memory, skills, protocols interact with sandboxing?
