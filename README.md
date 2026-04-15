# AI Coding Systems Engineering Wiki

A structured knowledge base for building AI coding assistants: memory architectures, skill/tool frameworks, agent-IDE protocols, and harness runtime design.

## What's Inside

This wiki tracks **engineering practices and novel methods** for AI coding systems:

- **Memory Systems**: RAG architectures, vector stores, knowledge graphs, context window management
- **Skills & Tools**: Tool use frameworks, skill composition patterns, agent capabilities, API design
- **Protocols**: MCP (Model Context Protocol), LSP integration, agent-agent communication, execution protocols
- **Harness Engineering**: Sandboxes, execution engines, runtime environments, security isolation
- **Architecture Patterns**: Agent loops, planning systems, reflection, tool orchestration

**Focus**: How these systems are **built**, not how they are evaluated.

## Structure

Three-layer architecture following [Karpathy's LLM Wiki](https://x.com/karpathy/status/1937539189399474427) pattern:

```
raw/                    Source documents (immutable, LLM read-only)
├── web/                Web-fetched articles, arXiv papers, GitHub READMEs, protocol specs
└── assets/             Downloaded images and attachments

wiki/                   LLM-maintained knowledge base
├── index.md            Content catalog (updated on every ingest/query/lint)
├── log.md              Chronological activity log
├── overview.md         High-level synthesis
├── sources/            One summary page per ingested source
├── entities/           Frameworks, protocols, memory systems, harnesses, tools, organizations
├── concepts/           Memory strategies, skill composition, protocol design, execution models
├── queries/            Filed query answers and analysis
└── syntheses/          Cross-cutting comparisons and arguments
```

All pages use `[[Wikilinks]]` for cross-references and YAML frontmatter for metadata (enabling Obsidian Dataview queries).

## Current Coverage

**Sources to ingest**: arXiv papers on novel methods, GitHub repos (frameworks, protocols, tools), technical docs, protocol specs

**Key areas to document**:
- Frameworks: Claude Code, Cursor, Aider, Continue, Cline, OpenHands
- Protocols: MCP, LSP, custom agent protocols
- Memory: RAG systems, vector databases, knowledge graphs
- Execution: Sandboxes, containers, security boundaries

**See [`wiki/index.md`](wiki/index.md) for the full content catalog.**

## How to Use

This wiki is designed to be used with Claude Code and the LLM Wiki workflow:

1. **Ingest** new sources: Drop papers/docs/repos into `raw/`, then run the ingest workflow to extract entities, concepts, and cross-references
2. **Query** the wiki: Ask questions about memory systems, protocols, harness design — answers cite wiki pages with `[[wikilinks]]`
3. **Lint** for health: Check for contradictions, orphans, missing cross-references, and knowledge gaps

See [`CLAUDE.md`](CLAUDE.md) for the complete schema and workflow specifications.

## Source Types

- **arXiv papers**: Novel methods for memory, skills, protocols, harness engineering
- **GitHub repositories**: Open-source frameworks, MCP implementations, harness codebases
- **Technical blogs/docs**: Anthropic, OpenAI, Microsoft engineering posts
- **Protocol specs**: MCP spec, LSP spec, custom agent protocol documentation

## License

Knowledge base content is derived from cited sources. See individual source pages in `wiki/sources/` for attribution.
