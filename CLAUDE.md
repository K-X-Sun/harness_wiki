# Wiki Schema — AI Coding Harness Engineering

## Domain

This wiki captures knowledge about AI coding harness engineering: evaluation benchmarks (SWE-Bench, HumanEval, ProdCodeBench), testing frameworks (OpenHands, Kortix, BigCode), agent architectures, evaluation methodologies, and the engineering practices for building and assessing LLM-based code generation systems.

The goal is to maintain a structured, cross-referenced knowledge base that tracks the evolving landscape of AI code evaluation, enabling informed decisions about benchmark design, harness architecture, and evaluation methodology.

## Structure

Three layers:

- `raw/` — **Immutable source documents. Source of truth. Never modify files here.** Articles, papers, images, data files. The LLM reads from raw/ but never writes to it.
- `raw/assets/` — Downloaded images and attachments.
- `wiki/` — LLM-maintained markdown pages. The LLM owns this layer entirely. You read it; the LLM writes it.
  - `wiki/index.md` — Content catalog. Update on every ingest, query (when filing), and lint.
  - `wiki/log.md` — Append-only chronological log. Records every ingest, query, and lint pass.
  - `wiki/overview.md` — High-level synthesis. Update after every ingest.
  - `wiki/sources/` — One summary page per ingested source.
  - `wiki/entities/` — Pages for benchmarks, harnesses, models, organizations, people, datasets, tools.
  - `wiki/concepts/` — Pages for evaluation metrics, testing methodologies, architecture patterns, benchmark design principles, harness components, prompt patterns.
  - `wiki/queries/` — Filed query answers and analysis.
  - `wiki/syntheses/` — Synthesis and comparison pages.

## Conventions

### Linking

- Use `[[Page Title]]` (Obsidian wikilinks) for all cross-references.
- Link every mention of a known entity or concept (at least the first mention per section).
- Page filenames use kebab-case slugs derived from titles (lowercase, hyphens, max 60 chars).
- Example: `[[SWE-Bench]]` resolves to `wiki/entities/swe-bench.md`.

### Frontmatter

Every wiki content page (sources, entities, concepts, syntheses, queries) has YAML frontmatter with at minimum: `type`, `title`, `updated`. Meta pages (index.md, log.md, overview.md) require only `type`.
Tags, dates, and source counts in frontmatter enable Obsidian Dataview queries.

### Entity Types

Entities tracked in `wiki/entities/`:

- **benchmark** — Evaluation benchmarks (SWE-Bench, HumanEval, ProdCodeBench, MBPP, etc.)
  - Frontmatter: `task_count`, `languages`, `metrics_used`, `created_date`
- **harness** — Evaluation harnesses and frameworks (OpenHands, Kortix, BigCode Evaluation Harness)
  - Frontmatter: `primary_language`, `supported_benchmarks`, `github_url`, `stars`
- **model** — LLM models evaluated (GPT-4, Claude, Codex, StarCoder, etc.)
  - Frontmatter: `organization`, `release_date`, `parameters`
- **organization** — Companies and research groups (Anthropic, OpenAI, Princeton NLP, Meta, etc.)
  - Frontmatter: `type` (company/academic/research_lab)
- **person** — Researchers and authors
  - Frontmatter: `affiliation`, `areas`
- **dataset** — Training and evaluation datasets
  - Frontmatter: `size`, `languages`, `source`, `license`
- **tool** — Supporting tools (test runners, sandboxes, metric collectors)
  - Frontmatter: `purpose`, `github_url`

### Concept Categories

Concepts tracked in `wiki/concepts/`:

- **evaluation-metric** — Metrics for measuring performance (pass@k, solve rate, accuracy, BLEU, CodeBLEU)
  - Frontmatter: `formula`, `interpretation`, `limitations`
- **testing-methodology** — Testing approaches (unit testing, integration testing, multi-run stability, test relevance validation)
  - Frontmatter: `scope`, `strengths`, `weaknesses`
- **architecture-pattern** — Design patterns (agent loop, tool use, multi-turn dialogue, retrieval-augmented generation)
  - Frontmatter: `components`, `use_cases`
- **benchmark-design** — Benchmark construction principles (task selection, data curation, contamination prevention, production-derivation)
  - Frontmatter: `principles`, `trade_offs`
- **harness-component** — Architectural components (execution sandbox, test runner, metric collector, prompt formatter)
  - Frontmatter: `responsibilities`, `interfaces`
- **prompt-pattern** — Prompting strategies (few-shot, chain-of-thought, self-correction, retrieval)
  - Frontmatter: `structure`, `effectiveness`

### Tags

Standard tags used in frontmatter:

- Benchmark tags: `benchmark-swe-bench`, `benchmark-humaneval`, `benchmark-prodcodebench`, `benchmark-mbpp`
- Metric tags: `metric-pass-at-k`, `metric-solve-rate`, `metric-accuracy`, `metric-bleu`
- Architecture tags: `arch-agent-loop`, `arch-tool-use`, `arch-multi-turn`, `arch-rag`
- Language tags: `lang-python`, `lang-javascript`, `lang-java`, `lang-cpp`, `lang-go`, `lang-rust`, `lang-typescript`
- Evaluation tags: `eval-offline`, `eval-online`, `eval-ab-testing`, `eval-production`
- Method tags: `method-unit-test`, `method-integration-test`, `method-contamination-check`

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
- Record evaluation metrics with exact numbers (e.g., "pass@1: 72.2%", "solve rate: 53.2%")
- Note all benchmark names and versions tested
- Track baseline comparisons and state-of-the-art claims
- Record dataset sizes and programming language distributions
- Note institutional affiliations of authors

### For GitHub Repositories
- Record primary programming language from repo metadata
- Extract supported benchmarks from README
- Note installation/usage instructions if complex
- Track dependencies and system requirements
- Record GitHub stars, forks, and last commit date as indicators of activity
- Note license type

### For Benchmark Entities
Must record:
- Task count and distribution
- Programming languages covered
- Evaluation metrics used
- Creation date and last update
- Maintainer/organization
- Solve rates for major models (GPT-4, Claude, etc.)

### For Harness Entities
Must record:
- Architecture overview (agent loop structure, tool system, test execution)
- Supported benchmarks and evaluation modes
- Programming languages supported
- Key dependencies and infrastructure requirements
- GitHub activity (stars, last commit)

### For Evaluation Metrics
- Include formal definition or formula
- Note interpretation guidelines (higher is better? range?)
- Document known limitations or biases
- Reference papers that introduced or validated the metric

### For Research Papers with Benchmarks
- If a paper introduces a new benchmark: create both a source page AND a benchmark entity page
- If a paper uses an existing benchmark: update the benchmark entity page with new results
- Always note the model context window, temperature, and other relevant hyperparameters when reported

---

*This schema co-evolves over time. Update it as you discover what works for your domain and workflow. The goal is for CLAUDE.md to be a complete specification of how this wiki works, so that any future session can pick up seamlessly where the last left off.*
