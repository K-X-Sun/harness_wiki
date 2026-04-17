# Web Discovery — Externalization Engineering

Search for research on **LLM agent externalization** across four dimensions: Memory, Skills, Protocols, and Harness Engineering. Downloads **complete full-text content** as markdown to dimension-specific directories (`raw/memory/`, `raw/skills/`, etc.), ready for `/wiki-ingest`.

Part of the [AI Coding Systems Engineering Wiki](../README.md) — based on the framework from "Externalization in LLM Agents" (arXiv:2604.08224).

**Focus**: Novel methods and engineering practices. NO benchmarks, NO evaluation metrics.

**Output**: Full-text markdown (arXiv papers: complete HTML→markdown conversion; GitHub: full README; articles: complete content).

## Usage

```bash
/web-discovery <dimension> <topic> [--arxiv] [--github] [--limit=N]
```

**Examples**:
```bash
# Memory dimension
/web-discovery memory "episodic memory LLM agents"
/web-discovery memory "hierarchical memory architecture"

# Skills dimension  
/web-discovery skills "tool composition patterns" --arxiv
/web-discovery skills "skill distillation" --github

# Protocols dimension
/web-discovery protocols "Model Context Protocol"
/web-discovery protocols "agent-tool protocol design"

# Harness dimension
/web-discovery harness "agent loop architecture"
/web-discovery harness "sandbox execution isolation" --limit=5

# Cross-cutting (all dimensions)
/web-discovery "agent infrastructure engineering"
```

## Four Externalization Dimensions

Based on Zhou et al. (2026), this skill searches for:

### 1️⃣ Memory
State persistence, retrieval, context management:
- **Architectures**: Monolithic, Retrieval-storage, Hierarchical, Adaptive
- **Content types**: Working context, Episodic experience, Semantic knowledge, Personalized memory
- **Keywords**: RAG, vector DB, memory consolidation, forgetting, context window management

### 2️⃣ Skills
Procedural expertise, tool use, capability composition:
- **Acquisition**: Authored, Distilled, Discovered, Composed
- **Components**: Operational procedures, Decision heuristics, Normative constraints
- **Keywords**: Tool use, function calling, skill composition, SOP, progressive disclosure

### 3️⃣ Protocols
Agent-tool/agent-agent/agent-user interaction:
- **Types**: Agent-tool, Agent-agent, Agent-user
- **Principles**: Intent capture, Capability discovery, Lifecycle management, Schema validation
- **Keywords**: MCP, LSP, agent communication, tool invocation protocols

### 4️⃣ Harness Engineering
Runtime design, orchestration, control flow:
- **Six dimensions**: Agent loop, Sandboxing, Human oversight, Observability, Configuration, Context budget
- **Keywords**: Agent runtime, execution isolation, approval gates, orchestration, agent loop design

## What It Does

1. **Dimension-aware search** — Generates 15-20 targeted queries per dimension
2. **Quality filter** — Keeps engineering/architecture content, drops benchmarks and evaluations
3. **Full-text download as markdown**:
   - **arXiv papers**: HTML version → complete markdown (all sections, equations, tables, figures)
   - **GitHub repos**: Raw README.md → complete markdown + metadata
   - **Web articles**: HTML → clean markdown (all content, excluding nav/ads)
4. **Dimension-specific routing** — Saves to `raw/<dimension>/` directories
5. **Structured frontmatter** — YAML with `dimension` field + source metadata
6. **Discovery report** — Organized by dimension with file paths and sizes
7. **Ready for ingest** — `/wiki-ingest raw/` processes all dimension directories

## Flags

| Flag | Behavior |
|------|----------|
| (none) | Search web + arXiv + GitHub (default) |
| `--arxiv` | arXiv only |
| `--github` | GitHub only |
| `--all` | Explicit full-scope search |
| `--limit=N` | Max results to download (default: 10) |

## Quality Filters (NEW)

**✅ KEEP** if matches:
- Novel memory architecture, retrieval method, or state management strategy
- Skill acquisition, composition, or tool use framework design
- Protocol specification, schema design, agent communication protocol
- Harness engineering: loop design, sandboxing, observability, orchestration
- Cognitive artifact analysis (how externalization transforms tasks)
- Primary source: arXiv (2024-2026), GitHub repo, official docs

**❌ DROP** if matches:
- Benchmark papers (SWE-Bench, HumanEval, evaluation metrics)
- Pure performance comparison without architectural details
- Evaluation methodology without engineering insights
- Social media, videos, paywalled content, SEO spam

**Special case**: Papers mentioning benchmarks are OK if they focus on harness/memory/skills/protocols architecture. Example: "Meta-Harness" validates harness design using benchmarks — keep it because it's about harness engineering.

## Output Format

Each downloaded file in `raw/<dimension>/`:

```yaml
---
title: "Paper/Repo/Article Title"
source_url: "https://..."
source_type: paper | repo | article | documentation | blog
fetched: 2026-04-15
dimension: memory | skills | protocols | harness  # Routes to correct directory
# Additional fields based on source type
authors: [...]          # for papers
categories: [...]       # for arXiv papers
stars: 1234            # for GitHub repos
language: Python       # for GitHub repos
---

[FULL ORIGINAL CONTENT as clean markdown]

For arXiv papers:
- Complete paper text (all sections: abstract, intro, methods, results, conclusion, references)
- Math equations as LaTeX ($inline$ and $$display$$)
- Tables as markdown tables
- Figure captions preserved

For GitHub repos:
- Complete README.md verbatim
- All code examples, tables, badges preserved

For web articles:
- Full article content (all headings, paragraphs, code blocks)
- Clean markdown format (no navigation/ads)
```

**Critical**: `dimension` field enables both directory routing and targeted entity/concept creation during ingest.

## Workflow

```
/web-discovery memory "episodic memory agents"
       ↓
  Dimension detection: memory
       ↓
  Generate 15-20 memory-specific queries
       ↓
  web_search × N queries (arXiv + GitHub + Web)
       ↓
  Filter: engineering focus, no benchmarks
       ↓
  For each URL:
    - arXiv: fetch https://arxiv.org/html/<id>v1 → convert to markdown (ALL sections)
    - GitHub: fetch raw README.md → preserve as markdown
    - Web: fetch article → convert HTML to clean markdown
       ↓
  Save to raw/memory/2026-04-15_arxiv_xxxx_topic.md
       ↓
  Discovery report organized by dimension
       ↓
/wiki-ingest raw/  →  wiki/entities/memory-systems/, wiki/concepts/memory-architecture/
```

## Installation

```bash
cp -r web_discovery/skill ~/.claude/skills/web-discovery
```

Or use directly from the repo:
```bash
/web-discovery memory "hierarchical memory LLM"
```

## File Structure

```
web_discovery/
  README.md                          # This file (updated for externalization focus)
  skill/
    SKILL.md                         # Skill entry point (v2.0.0)
    references/
      discovery-workflow.md          # 8-step procedure with dimension-specific queries
      raw-web-conventions.md         # File naming, frontmatter, dimension tagging
```

## Supported Sources

| Type | Focus | Example |
|------|-------|---------|
| **arXiv papers** | Full text, all sections | Memory architectures, skill frameworks, protocol specs |
| **GitHub repos** | README + metadata | Agent frameworks, MCP implementations, memory systems |
| **Technical articles** | Full content | Official blogs (Anthropic, OpenAI), technical overviews |
| **Documentation** | API reference, guides | MCP spec, LSP integration, framework docs |

## Dimension-Specific Search Examples

### Memory Dimension
```bash
/web-discovery memory "MemGPT architecture"
→ Searches: arXiv, GitHub, official blogs
→ Downloads: MemGPT paper (full HTML→markdown), Mem0 repo (README), memory architecture articles
→ Saves to: raw/memory/2026-04-15_arxiv_2310_08560_memgpt.md (45KB full text)
→ After ingest: Creates [[MemGPT]] entity, [[Hierarchical Memory]] concept
```

### Skills Dimension
```bash
/web-discovery skills "Voyager skill acquisition"
→ Searches: arXiv, GitHub, technical docs
→ Downloads: Voyager paper (full text), AutoGPT repo (README), skill framework articles
→ Saves to: raw/skills/2026-04-15_arxiv_2305_16291_voyager.md (62KB full text)
→ After ingest: Creates [[Voyager]] entity, [[Skill Distillation]] concept
```

### Protocols Dimension
```bash
/web-discovery protocols "Model Context Protocol"
→ Searches: arXiv, GitHub, Anthropic blogs, MCP docs
→ Downloads: MCP papers (full text), MCP spec (complete), server repos (README)
→ Saves to: raw/protocols/2026-04-15_mcp-specification.md (38KB full spec)
→ After ingest: Creates [[Model Context Protocol]] entity, [[Capability Discovery]] concept
```

### Harness Dimension
```bash
/web-discovery harness "Meta-Harness optimization"
→ Searches: arXiv, GitHub, framework docs
→ Downloads: Meta-Harness paper (full text), AutoGen/LangGraph repos (README)
→ Saves to: raw/harness/2026-04-15_arxiv_2603_28052_meta-harness.md (67KB full text)
→ After ingest: Creates [[Meta-Harness]] entity, [[Agent Loop]] concept
```

## Next Steps After Discovery

1. **Review the discovery report** — Check downloaded files match your dimension
2. **Run wiki ingest**: `/wiki-ingest raw/web/`
3. **Verify entity creation** — Check `wiki/index.md` for new Memory/Skills/Protocols/Harness entities
4. **Query the wiki** — Ask dimension-specific questions to test knowledge integration

## Changes from v1.0

**v1.0** (old):
- Generic "harness engineering" focused on CI/CD platform (harness.io)
- Broad search including benchmarks and evaluation
- No dimension classification

**v2.0** (new):
- Four-dimension taxonomy (Memory, Skills, Protocols, Harness)
- Engineering and architecture focus, NO benchmarks
- Dimension tagging in frontmatter
- Aligned with "Externalization in LLM Agents" framework
- Cognitive artifact analysis (recall→recognition, generation→composition, ad-hoc→governed)

---

**Based on**: "Externalization in LLM Agents: A Unified Review of Memory, Skills, Protocols and Harness Engineering" (Zhou et al., 2026, arXiv:2604.08224)
