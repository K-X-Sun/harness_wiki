# Wiki Schema — AI Coding Systems Engineering

## Domain

This wiki captures knowledge about the **engineering of AI coding systems** through the lens of **externalization**—the progressive relocation of cognitive burdens from the model's internal computation into persistent, inspectable, and reusable external structures.

**Foundational framework**: "Externalization in LLM Agents: A Unified Review of Memory, Skills, Protocols and Harness Engineering" (arXiv:2604.08224)

Core thesis: *LLM agents are increasingly built not by changing model weights, but by reorganizing the runtime around them. Capabilities that earlier systems expected the model to recover internally are now externalized into memory stores, reusable skills, interaction protocols, and the surrounding harness.*

Four externalization dimensions:
- **Memory** — Externalizes state across time (converting recall into retrieval)
- **Skills** — Externalizes procedural expertise (converting generation into composition)  
- **Protocols** — Externalizes interaction structure (converting ad-hoc into governed)
- **Harness Engineering** — The unification layer that coordinates them into governed execution

The goal is to maintain a structured, cross-referenced knowledge base tracking novel methods and engineering practices for building LLM-based coding assistants.

## Structure

Three layers:

- `raw/` — **Immutable source documents. Source of truth. Never modify files here.** Papers, docs, repo READMEs, protocol specs. The LLM reads from raw/ but never writes to it.
  - `raw/memory/` — Memory dimension sources (full-text markdown)
  - `raw/skills/` — Skills dimension sources (full-text markdown)
  - `raw/protocols/` — Protocols dimension sources (full-text markdown)
  - `raw/harness/` — Harness dimension sources (full-text markdown)
  - `raw/web/` — Cross-cutting sources (no specific dimension)
  - `raw/*/assets/` — Downloaded images and attachments per dimension
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

- **framework** — AI coding frameworks and platforms (Claude Code, Cursor, Aider, Continue, Cline, OpenHands, etc.)
  - Frontmatter: `primary_language`, `architecture_type`, `github_url`, `stars`, `license`
- **protocol** — Communication protocols (MCP, LSP, custom agent protocols)
  - Frontmatter: `protocol_type` (agent-tool/agent-agent/agent-user), `spec_url`, `implementations`, `version`
- **memory-system** — Memory architectures and implementations
  - Frontmatter: `architecture_type` (monolithic/retrieval-store/hierarchical/adaptive), `storage_backend`, `retrieval_method`, `github_url`
- **harness** — Runtime execution environments and agent frameworks
  - Frontmatter: `isolation_method`, `loop_architecture`, `observability_features`, `github_url`
- **tool** — Specific tools and capabilities (code search, file ops, test runners, debuggers)
  - Frontmatter: `tool_category`, `api_surface`, `github_url`
- **organization** — Companies and research groups (Anthropic, OpenAI, Microsoft, SJTU, academic labs)
  - Frontmatter: `type` (company/academic/research_lab)
- **person** — Researchers, engineers, and authors
  - Frontmatter: `affiliation`, `areas`

### Concept Categories

Concepts tracked in `wiki/concepts/`:

#### Memory Concepts

- **memory-content-type** — The four dimensions of externalized state:
  - **working-context** — Live intermediate state (open files, temp vars, checkpoints)
  - **episodic-experience** — Prior execution records (decision points, tool calls, failures, outcomes)
  - **semantic-knowledge** — Abstractions that outlive episodes (domain facts, heuristics, conventions)
  - **personalized-memory** — User-specific state (preferences, habits, recurring constraints)
  - Frontmatter: `temporal_scope`, `retention_policy`, `retrieval_pattern`

- **memory-architecture** — How memory is externalized (Du 2026):
  - **monolithic-context** — All history in prompt
  - **context-with-retrieval** — Near-term in context + external retrieval
  - **hierarchical-memory** — Managed lifecycle (extraction, consolidation, forgetting)
  - **adaptive-memory** — Dynamic modules + feedback-based strategy optimization
  - Frontmatter: `control_policy`, `scalability`, `trade_offs`

#### Skill Concepts

- **procedural-expertise-type** — Three components externalized by skills:
  - **operational-procedure** — Task skeleton (steps, phases, dependencies, stopping conditions)
  - **decision-heuristics** — Branching rules and preference orderings
  - **normative-constraints** — Acceptability conditions (safety, compliance, scope limits)
  - Frontmatter: `stability_gains`, `variance_reduction`

- **skill-lifecycle** — How skills are acquired and evolve:
  - **authored** — Human-designed (SKILL.md, AGENTS.md, SOP templates)
  - **distilled** — Induced from trajectories and episodic memory
  - **discovered** — Extracted from environment exploration
  - **composed** — Built from existing skill units
  - Frontmatter: `acquisition_method`, `evolution_mechanism`

- **skill-activation** — How skills become operational:
  - **specification** — Declarative artifact (capabilities, scope, preconditions)
  - **discovery** — Registry-based retrieval
  - **progressive-disclosure** — Staged loading (name → manifest → full guide)
  - **execution-binding** — Connection to tools, APIs, files, sub-agents
  - **composition** — Serial, parallel, conditional, recursive coordination
  - Frontmatter: `binding_targets`, `composition_patterns`

#### Protocol Concepts

- **protocol-type** — Interaction structure being externalized:
  - **agent-tool** — Tool invocation, function calling, API schemas
  - **agent-agent** — Multi-agent coordination, delegation, collaboration
  - **agent-user** — User interaction, approval gates, feedback loops
  - Frontmatter: `interaction_model`, `state_management`, `error_handling`

- **protocol-design-principle** — How protocols transform tasks:
  - **intent-capture** — Structured representation of agent goals
  - **capability-discovery** — Tool registration and description
  - **lifecycle-management** — Session states, transitions, checkpoints
  - **schema-validation** — Typed fields, format enforcement
  - Frontmatter: `representational_transformation`, `cognitive_offload`

#### Harness Concepts

- **harness-dimension** — Six analytical dimensions (Section 6.2):
  - **agent-loop** — Control flow (perceive-plan-act-observe), termination, recursion bounds
  - **sandboxing** — Execution isolation, filesystem restrictions, resource quotas
  - **human-oversight** — Approval gates, escalation triggers, hook systems
  - **observability** — Structured logging, execution traces, feedback loops
  - **configuration** — Permission layers (user/project/org), policy encoding
  - **context-budget** — Token allocation, summarization, staged loading, eviction
  - Frontmatter: `control_mechanism`, `safety_guarantees`, `resource_management`

- **externalization-transformation** — Cognitive artifact analysis:
  - **recall-to-recognition** — Memory transforms unbounded recall into curated retrieval
  - **generation-to-composition** — Skills transform improvisation into structured reuse
  - **ad-hoc-to-governed** — Protocols transform ambiguous coordination into contracts
  - Frontmatter: `cognitive_burden_relocated`, `task_restructuring`

### Tags

Standard tags used in frontmatter:

- Framework tags: `framework-claude-code`, `framework-cursor`, `framework-aider`, `framework-openhands`
- Protocol tags: `protocol-mcp`, `protocol-lsp`, `protocol-custom`
- Memory architecture tags: `memory-monolithic`, `memory-retrieval`, `memory-hierarchical`, `memory-adaptive`
- Memory content tags: `memory-working`, `memory-episodic`, `memory-semantic`, `memory-personalized`
- Skill tags: `skill-authored`, `skill-distilled`, `skill-discovered`, `skill-composed`
- Harness tags: `harness-loop`, `harness-sandbox`, `harness-observability`, `harness-context-mgmt`
- Architecture tags: `arch-agent-loop`, `arch-tool-use`, `arch-planning`, `arch-reflection`, `arch-rag`
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
- Record which externalization dimension(s) the paper addresses
- Track architectural innovations (new memory architectures, skill lifecycle methods, protocol designs)
- Note the "representational transformation" claim (what cognitive burden is externalized? how?)
- Record performance characteristics and empirical results
- Note institutional affiliations of authors

### For GitHub Repositories
- Record primary programming language and framework
- Extract architecture overview focusing on externalization dimensions:
  - Memory: what state is persistent? what's the retrieval method?
  - Skills: are there reusable capability packages? how are they loaded?
  - Protocols: what interaction contracts exist? (MCP, LSP, custom)
  - Harness: loop architecture, sandboxing, observability, context management
- Note system boundaries and integration points
- Track dependencies and infrastructure requirements
- Record GitHub stars, forks, and last commit date
- Note license type

### For Protocol Specifications
- Record protocol version and spec URL
- Identify protocol type: agent-tool, agent-agent, or agent-user
- Extract key design decisions (state management, error handling, versioning)
- Note message formats, transport mechanisms
- Track implementations in different languages/frameworks
- Document how the protocol externalizes interaction structure

### For Framework Entities
Must record all six harness dimensions:
1. **Agent loop**: control flow architecture, termination logic
2. **Sandboxing**: isolation method, resource restrictions
3. **Human oversight**: approval modes, escalation rules
4. **Observability**: logging, tracing, metrics
5. **Configuration**: permission layers, policy encoding
6. **Context budget**: summarization, staged loading, eviction

Also track:
- Memory architecture (monolithic/retrieval/hierarchical/adaptive)
- Skill system design (acquisition, discovery, binding, composition)
- Protocol support (MCP, LSP, custom)

### For Memory System Entities
Categorize by architecture type (Du 2026):
- **Monolithic Context**: all history in prompt
- **Context with Retrieval Storage**: near-term in context + external retrieval
- **Hierarchical Memory**: managed lifecycle (extraction, consolidation, forgetting)
- **Adaptive Memory**: dynamic modules + feedback optimization

Record which content types are externalized:
- Working context, episodic experience, semantic knowledge, personalized memory

### For Skill Entities
Record all three components:
- **Operational procedure**: task decomposition, step sequencing
- **Decision heuristics**: branching rules, preference orderings
- **Normative constraints**: safety boundaries, compliance requirements

Track lifecycle:
- Acquisition method (authored/distilled/discovered/composed)
- Evolution mechanism (how skills improve over time)
- Activation pipeline (specification → discovery → progressive disclosure → binding → composition)

### For Research Papers on Externalization
- Identify which transformation is being optimized:
  - Memory: recall → recognition
  - Skills: generation → composition
  - Protocols: ad-hoc → governed
- Note the "cognitive artifact" perspective: how does externalization change the task the model faces?
- Track empirical evidence: does externalization reduce variance? improve reliability? enable governance?
- Record trade-offs between parametric and externalized capability

---

*This schema is directly derived from "Externalization in LLM Agents" (Zhou et al., 2026, arXiv:2604.08224). The goal is to maintain a complete specification of how this wiki works, so that any future session can pick up seamlessly where the last left off.*
