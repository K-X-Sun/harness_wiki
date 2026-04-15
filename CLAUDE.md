# Wiki Schema — AI Coding Systems Engineering

## Domain

This wiki captures knowledge about the **engineering of AI coding systems**: memory architectures, skill/tool frameworks, agent-IDE protocols, and harness runtime design. The focus is on **how these systems are built**, not how they are evaluated.

Core areas:
- **Memory Systems** — How AI agents manage context, project knowledge, long-term memory (RAG, vector stores, knowledge graphs)
- **Skills & Tools** — Tool use frameworks, skill composition, agent capabilities, API design
- **Protocols** — Agent-IDE communication (MCP, LSP), agent-agent coordination, execution protocols
- **Harness Engineering** — Runtime environments, sandboxes, execution engines, security isolation

The goal is to maintain a structured, cross-referenced knowledge base that tracks novel methods and engineering practices for building LLM-based coding assistants, enabling informed architectural decisions.

## Structure

Three layers:

- `raw/` — **Immutable source documents. Source of truth. Never modify files here.** Papers, docs, repo READMEs, protocol specs. The LLM reads from raw/ but never writes to it.
- `raw/assets/` — Downloaded images and attachments.
- `wiki/` — LLM-maintained markdown pages. The LLM owns this layer entirely. You read it; the LLM writes it.
  - `wiki/index.md` — Content catalog. Update on every ingest, query (when filing), and lint.
  - `wiki/log.md` — Append-only chronological log. Records every ingest, query, and lint pass.
  - `wiki/overview.md` — High-level synthesis. Update after every ingest.
  - `wiki/sources/` — One summary page per ingested source.
  - `wiki/entities/` — Pages for frameworks, protocols, memory systems, harnesses, organizations, people, tools.
  - `wiki/concepts/` — Pages for memory strategies, skill composition patterns, protocol design principles, execution models, security boundaries.
  - `wiki/queries/` — Filed query answers and analysis.
  - `wiki/syntheses/` — Synthesis and comparison pages.

## Conventions

### Linking

- Use `[[Page Title]]` (Obsidian wikilinks) for all cross-references.
- Link every mention of a known entity or concept (at least the first mention per section).
- Page filenames use kebab-case slugs derived from titles (lowercase, hyphens, max 60 chars).
- Example: `[[Model Context Protocol]]` resolves to `wiki/entities/model-context-protocol.md`.

### Frontmatter

Every wiki content page (sources, entities, concepts, syntheses, queries) has YAML frontmatter with at minimum: `type`, `title`, `updated`. Meta pages (index.md, log.md, overview.md) require only `type`.
Tags, dates, and source counts in frontmatter enable Obsidian Dataview queries.

### Entity Types

Entities tracked in `wiki/entities/`:

- **framework** — AI coding frameworks and platforms (Claude Code, Cursor, Aider, Continue, Cline, etc.)
  - Frontmatter: `primary_language`, `architecture_type`, `github_url`, `stars`, `license`
- **protocol** — Communication protocols (MCP, LSP, custom agent protocols)
  - Frontmatter: `protocol_type` (transport/data/control), `spec_url`, `implementations`, `version`
- **memory-system** — Memory architectures (RAG systems, vector stores, knowledge graphs, context managers)
  - Frontmatter: `storage_backend`, `retrieval_method`, `scalability`, `github_url`
- **harness** — Runtime execution environments (sandboxes, containers, execution engines)
  - Frontmatter: `isolation_method`, `supported_languages`, `security_model`, `github_url`
- **tool** — Specific tools and capabilities (code search, file ops, test runners, debuggers)
  - Frontmatter: `tool_category`, `api_surface`, `github_url`
- **organization** — Companies and research groups (Anthropic, OpenAI, Microsoft, academic labs)
  - Frontmatter: `type` (company/academic/research_lab)
- **person** — Researchers, engineers, and authors
  - Frontmatter: `affiliation`, `areas`

### Concept Categories

Concepts tracked in `wiki/concepts/`:

- **memory-strategy** — Memory management approaches (caching, retrieval, indexing, pruning)
  - Frontmatter: `pattern_type`, `trade_offs`, `use_cases`
- **skill-composition** — How tools/skills are composed (sequential, parallel, hierarchical, DAG-based)
  - Frontmatter: `composition_model`, `execution_semantics`, `examples`
- **architecture-pattern** — System design patterns (agent loop, planning, reflection, tool use, RAG)
  - Frontmatter: `components`, `control_flow`, `use_cases`
- **protocol-design** — Protocol design principles (versioning, backwards compatibility, error handling)
  - Frontmatter: `design_principles`, `trade_offs`
- **execution-model** — How code/tools are executed (synchronous, async, streaming, sandboxed)
  - Frontmatter: `execution_semantics`, `safety_guarantees`
- **security-boundary** — Isolation and security mechanisms (containers, VMs, capability-based, permission systems)
  - Frontmatter: `threat_model`, `guarantees`, `limitations`

### Tags

Standard tags used in frontmatter:

- Framework tags: `framework-claude-code`, `framework-cursor`, `framework-aider`, `framework-continue`
- Protocol tags: `protocol-mcp`, `protocol-lsp`, `protocol-custom`
- Memory tags: `memory-rag`, `memory-vector-db`, `memory-kg`, `memory-cache`
- Architecture tags: `arch-agent-loop`, `arch-tool-use`, `arch-planning`, `arch-reflection`, `arch-rag`
- Execution tags: `exec-sync`, `exec-async`, `exec-streaming`, `exec-sandboxed`
- Security tags: `security-container`, `security-vm`, `security-capability`, `security-permission`
- Language tags: `lang-python`, `lang-javascript`, `lang-typescript`, `lang-go`, `lang-rust`

## Workflows

### On Ingest

1. Read the source document fully. For sources with inline images: read text first, then view referenced images separately.
2. **Mode-dependent**: In interactive mode — discuss key takeaways with the user, ask what to emphasize, and wait for a proceed signal before writing. In auto or batch mode — proceed directly to writing.
3. Create a source summary page in `wiki/sources/`.
4. For each entity found: create or update the entity page in `wiki/entities/`. When updating, **integrate**: note contradictions with existing claims, strengthen claims with new evidence, challenge the synthesis if warranted. Update cross-references.
5. For each concept found: create or update the concept page in `wiki/concepts/`. Same integration approach.
6. If the source reveals comparisons or cross-cutting arguments worth capturing: create a page in `wiki/syntheses/<slug>.md`.
7. Append an entry to `wiki/log.md`: `## [YYYY-MM-DD] ingest | <source-title>`.
8. Update `wiki/index.md` with all new and changed pages.
9. Update `wiki/overview.md` to reflect the new source.
10. Report pages created/updated. Suggest follow-up questions and sources to look for.

### On Query

1. Read `wiki/index.md` to identify relevant pages.
2. Read the relevant wiki pages (not raw sources — the wiki is the intermediary layer).
3. Synthesize an answer with `[[wikilink]]` citations.
4. Choose output format based on question type: markdown, comparison table, Marp slide deck, matplotlib chart, or Obsidian canvas.
5. Ask if the answer is worth filing as a wiki page (novel synthesis, comparison, or discovered connection). If yes: create page, update index.
6. **Always** append to `wiki/log.md`: `## [YYYY-MM-DD] query | <question>` — written after the filing decision so the "Filed as" field is accurate in a single append.
7. Note knowledge gaps; suggest follow-up questions and new sources.

### On Lint

1. Check for: contradictions between pages, stale claims, orphan pages (no inbound links), missing pages (entities/concepts mentioned but lacking pages), missing cross-references (known entities/concepts mentioned in plain text but not wikilinked), data gaps.
2. For data gaps: suggest specific web searches to fill them.
3. Suggest new questions to investigate and new sources to look for.
4. Auto-fix mechanical issues (broken wikilinks, index gaps). Flag judgment calls for human review.
5. Append to `wiki/log.md`: `## [YYYY-MM-DD] lint | Health check`.

## Domain-Specific Notes

### For arXiv Papers
- Always extract abstract verbatim
- Focus on **novel methods** for memory, skills, protocols, harness design
- Record architectural diagrams and system descriptions
- Track implementation details (languages, frameworks used)
- Note performance characteristics (latency, throughput, memory usage)
- Record limitations and future work sections
- Note institutional affiliations of authors

### For GitHub Repositories
- Record primary programming language and framework
- Extract architecture overview from README/docs
- Note tool/skill system design (how capabilities are defined and executed)
- Track memory/context management approach
- Record protocol support (MCP, LSP, custom)
- Note sandbox/execution environment architecture
- Track dependencies and system requirements
- Record GitHub stars, forks, and last commit date as indicators of activity
- Note license type

### For Protocol Specifications
- Record protocol version and spec URL
- Extract key design decisions and rationale
- Note message formats, transport mechanisms
- Track implementations in different languages
- Document versioning and compatibility strategy
- Record security considerations

### For Framework Entities
Must record:
- Architecture type (agent loop, tool orchestrator, etc.)
- Memory/context management strategy
- Tool/skill system design
- Protocol support (MCP, LSP, custom)
- Execution environment (local, cloud, hybrid)
- Key dependencies and infrastructure requirements
- GitHub activity (stars, last commit)

### For Memory System Entities
Must record:
- Storage backend (vector DB, graph DB, file system, hybrid)
- Retrieval method (semantic search, graph traversal, keyword)
- Indexing strategy
- Scalability characteristics
- Integration points with frameworks

### For Protocol Entities
Must record:
- Protocol type (transport, data format, control flow)
- Versioning scheme
- Known implementations
- Design principles and trade-offs
- Security model

### For Harness Entities
Must record:
- Isolation method (Docker, VM, process, capability-based)
- Supported languages and runtimes
- Security model and threat assumptions
- Performance characteristics
- Integration with frameworks

---

*This schema co-evolves over time. Update it as you discover what works for your domain and workflow. The goal is for CLAUDE.md to be a complete specification of how this wiki works, so that any future session can pick up seamlessly where the last left off.*
