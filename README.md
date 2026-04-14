# AI Coding Harness Engineering Wiki

A structured knowledge base for AI code evaluation: benchmarks (SWE-Bench, HumanEval, ProdCodeBench), testing frameworks (OpenHands, Kortix, BigCode), agent architectures, and evaluation methodologies for LLM-based code generation systems.

## What's Inside

This wiki tracks:
- **Benchmarks**: SWE-Bench, HumanEval, ProdCodeBench, MBPP, and emerging variants
- **Harnesses**: OpenHands, Kortix, BigCode Evaluation Harness, and test frameworks
- **Evaluation Methodologies**: Metrics (pass@k, solve rate), testing approaches, benchmark design principles
- **Agent Architectures**: Tool use patterns, agent loops, multi-turn dialogue, RAG systems
- **Research**: 31+ arXiv papers and GitHub repositories documenting the state of AI code evaluation

## Structure

Three-layer architecture following [Karpathy's LLM Wiki](https://x.com/karpathy/status/1937539189399474427) pattern:

```
raw/                    Source documents (immutable, LLM read-only)
├── web/                Web-fetched articles, arXiv papers, GitHub READMEs
└── assets/             Downloaded images and attachments

wiki/                   LLM-maintained knowledge base
├── index.md            Content catalog (updated on every ingest/query/lint)
├── log.md              Chronological activity log
├── overview.md         High-level synthesis
├── sources/            One summary page per ingested source
├── entities/           Benchmarks, harnesses, models, datasets, tools, organizations
├── concepts/           Evaluation metrics, testing methodologies, architecture patterns
├── queries/            Filed query answers and analysis
└── syntheses/          Cross-cutting comparisons and arguments
```

All pages use `[[Wikilinks]]` for cross-references and YAML frontmatter for metadata (enabling Obsidian Dataview queries).

## Current Coverage

**Sources ingested**: 31 documents (as of 2026-04-14)
- 24 arXiv papers on AI code evaluation, benchmarks, and harness engineering
- 4 GitHub repositories (OpenHands, BigCode, Kortix, PacaBench)
- 3 technical articles on LLM coding benchmarks

**Key entities documented**:
- Benchmarks: SWE-Bench, ProdCodeBench
- Harnesses: OpenHands
- Concepts: solve-rate, production-derived benchmarking

**See [`wiki/index.md`](wiki/index.md) for the full content catalog.**

## How to Use

This wiki is designed to be used with Claude Code and the LLM Wiki workflow:

1. **Ingest** new sources: Drop papers/docs into `raw/`, then run the ingest workflow to extract entities, concepts, and cross-references
2. **Query** the wiki: Ask questions about benchmarks, harnesses, evaluation methods — answers cite wiki pages with `[[wikilinks]]`
3. **Lint** for health: Check for contradictions, orphans, missing cross-references, and knowledge gaps

See [`CLAUDE.md`](CLAUDE.md) for the complete schema and workflow specifications.

## License

Knowledge base content is derived from cited sources. See individual source pages in `wiki/sources/` for attribution.
