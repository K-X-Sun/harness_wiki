---
name: web-discovery
description: >-
  Search for AI agent externalization research: Memory architectures, Skills frameworks,
  Protocols , and Harness Engineering. Downloads as structured markdown to raw/web/.
  Focus on novel methods and engineering practices, NOT benchmarks or evaluation.
  Use when user says "search for", "find papers on", "discover resources about"
  Memory, Skills, Protocols, or Harness engineering topics.
version: 2.0.0
argument-hint: "<dimension> <topic> [--arxiv] [--github] [--all] [--limit=N]"
allowed-tools: Bash, Read, Write, WebSearch, WebFetch
---

# Web Discovery — Externalization Engineering

Search for research on **LLM agent externalization** across four dimensions:
- **Memory** — State persistence, retrieval, context management
- **Skills** — Procedural expertise, tool use, capability composition
- **Protocols** — Agent-tool/agent-agent/agent-user interaction
- **Harness** — Runtime design, sandboxing, observability, control flow

Downloads findings as structured markdown to `raw/web/`, ready for `/wiki-ingest`.

**NEW FOCUS**: Novel methods and engineering practices. NO benchmarks, NO evaluation metrics.

## Usage

```
/web-discovery <dimension> <topic> [--arxiv] [--github] [--limit=N]
```

**Examples**:
```
/web-discovery memory "episodic memory LLM agents"
/web-discovery skills "tool composition patterns" --arxiv
/web-discovery protocols "Model Context Protocol MCP"
/web-discovery harness "agent loop design" --limit=5
```

Follow [references/discovery-workflow.md](references/discovery-workflow.md), passing
`$ARGUMENTS[0..]` to detect dimension and build targeted queries.

## Dimension Detection

Read `$ARGUMENTS[0]` to detect dimension:
- `memory` → Memory architectures, retrieval, state management
- `skills` → Skill acquisition, composition, tool use frameworks
- `protocols` → MCP, LSP, agent communication
- `harness` → Runtime, sandbox, observability, loop design
- (no dimension) → Cross-cutting search across all dimensions

## Flags

- `--arxiv`    → arXiv-only search
- `--github`   → GitHub-only search  
- `--all`      → Explicit full-scope (web + arXiv + GitHub)
- `--limit=N`  → Max results to download (default: 10)

## Quality Filters (UPDATED)

**KEEP** if matches:
- ✅ Novel memory architecture, retrieval method, or context management strategy
- ✅ Skill acquisition, composition, or tool use framework design
- ✅ Protocol specification, agent communication design
- ✅ Harness engineering: loop design, sandboxing, observability
- ✅ Cognitive artifact analysis (how externalization transforms tasks)
- ✅ Primary source: arXiv paper, GitHub repo, official docs

**DROP** if matches:
- ❌ Benchmark papers (SWE-Bench, HumanEval, evaluation metrics)
- ❌ Pure performance comparison without architectural details
- ❌ Marketing content, SEO spam, content farms
- ❌ Social media, videos, paywalled content

## Temporal Prioritization 

Downloads are **sorted by recency** to prioritize emerging trends:

**Priority order**:
1. 🔥 **Recent & Hot** (last 2 months) — Download FIRST
   - Latest arXiv papers, active GitHub repos(latest, fast star growth, relevant, high stars), new blog posts
2. 📈 **Recent** (2026, older than 2 months) — Download SECOND  
   - This year's work, validated and stable
3. 📚 **Classic** (2025) — Download THIRD
   - Last year's foundational work, frequently cited
4. 🗂️ **Foundational** (before 2025) — Download LAST
   - Only if highly relevant, historical context

**Result**: You get the latest methods first, then this year's work, then last year's classics, then older foundational papers.

## Supporting References

- [references/discovery-workflow.md](references/discovery-workflow.md) — 8-step search procedure (UPDATED for externalization dimensions)
- [references/raw-web-conventions.md](references/raw-web-conventions.md) — File naming, frontmatter rules
