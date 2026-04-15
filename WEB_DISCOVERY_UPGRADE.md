# Web Discovery Skill — v2.0 Upgrade

**Date**: 2026-04-15  
**From**: Generic harness engineering (CI/CD focus)  
**To**: LLM agent externalization engineering (Memory/Skills/Protocols/Harness)

## What Changed

### 🎯 New Focus

**v1.0** (old):
- Generic "harness engineering" = CI/CD platform (harness.io)
- Broad search including benchmarks, evaluation, testing
- No conceptual framework

**v2.0** (new):
- **Four externalization dimensions** (Zhou et al., 2026):
  1. Memory — State persistence, retrieval, context management
  2. Skills — Procedural expertise, tool use, capability composition
  3. Protocols — Agent-tool/agent-agent/agent-user interaction
  4. Harness — Runtime design, orchestration, control flow
- **Engineering focus**: Novel methods and architectures
- **NO benchmarks**: Filters out evaluation and performance comparison
- **Cognitive artifact framing**: Tracks how externalization transforms tasks

## Updated Files

### `web_discovery/skill/SKILL.md` (v2.0.0)
- New description: "Search for AI agent externalization research"
- Dimension-aware argument parsing
- Updated quality filters (KEEP engineering, DROP benchmarks)

### `web_discovery/skill/references/discovery-workflow.md`
**Major rewrite**:
- **Dimension detection** (step 1): Parses `memory`, `skills`, `protocols`, `harness` keywords
- **Dimension-specific queries** (step 2): 15-20 targeted queries per dimension
  - Memory queries: episodic memory, RAG, context management, MemGPT, Mem0
  - Skills queries: tool use, skill composition, Toolformer, progressive disclosure
  - Protocols queries: MCP, LSP, agent communication, schema validation
  - Harness queries: agent loop, sandboxing, observability, Meta-Harness, AutoGen
- **Updated filters** (step 4): Keep engineering/architecture, drop benchmarks
- **Dimension tagging** (step 5): Add `dimension: memory|skills|protocols|harness` to frontmatter

### `web_discovery/README.md`
- New introduction with four-dimension framework
- Usage examples per dimension
- Quality filters aligned with externalization focus
- Dimension-specific search examples
- Workflow diagram showing dimension → entity/concept creation

## New Search Patterns

### Memory Dimension
```bash
/web-discovery memory "episodic memory LLM agents"
/web-discovery memory "hierarchical memory architecture"
```

**Query examples**:
- `site:arxiv.org "LLM agent memory" architecture`
- `site:github.com MemGPT OR MemoryBank OR Mem0`
- `"context window management" strategies`

**Expected entities**: MemGPT, MemoryBank, Mem0, RAG systems

### Skills Dimension
```bash
/web-discovery skills "tool composition patterns"
/web-discovery skills "skill distillation trajectory"
```

**Query examples**:
- `site:arxiv.org "skill acquisition" agent learning`
- `site:github.com "tool orchestration" agent`
- `"procedural expertise" externalization`

**Expected entities**: Toolformer, Voyager, skill registries

### Protocols Dimension
```bash
/web-discovery protocols "Model Context Protocol"
/web-discovery protocols "agent-tool protocol design"
```

**Query examples**:
- `site:arxiv.org "agent protocol" communication`
- `site:github.com "Model Context Protocol" MCP`
- `"schema validation" agent tools`

**Expected entities**: MCP, LSP, agent communication protocols

### Harness Dimension
```bash
/web-discovery harness "agent loop architecture"
/web-discovery harness "sandbox execution isolation"
```

**Query examples**:
- `site:arxiv.org "Meta-Harness" OR "harness engineering"`
- `site:github.com AutoGen OR LangGraph OR CrewAI`
- `"agent observability" best practices`

**Expected entities**: Meta-Harness, AutoGen, LangGraph, OpenHands

## Quality Filter Changes

### What We NOW Keep ✅

**v2.0 criteria**:
- Novel memory architectures (hierarchical, adaptive, retrieval methods)
- Skill acquisition/composition frameworks
- Protocol specifications (MCP, LSP, custom)
- Harness engineering (loop design, sandboxing, observability)
- Cognitive artifact analysis
- Primary sources: arXiv (2024-2026), GitHub repos, official docs

### What We NOW Drop ❌

**v2.0 exclusions**:
- Benchmark papers (SWE-Bench, HumanEval, MBPP)
- Evaluation metrics (pass@k, solve rate, accuracy)
- Pure performance comparison
- Evaluation methodology (unless harness-related)
- Generic ML papers without agent engineering focus

**Special case**: Papers mentioning benchmarks are OK if they focus on architecture. Example: "Meta-Harness" validates designs using benchmarks → KEEP (it's about harness engineering, not benchmark evaluation).

## Frontmatter Changes

**New required field**:
```yaml
dimension: memory | skills | protocols | harness
```

**Example for Memory paper**:
```yaml
---
title: "MemGPT: Towards LLMs as Operating Systems"
source_url: "https://arxiv.org/abs/2310.08560"
source_type: paper
fetched: 2026-04-15
authors: ["Charles Packer", "Sarah Wooders", "et al."]
categories: ["cs.AI"]
dimension: memory  # NEW
---
```

**Example for Harness repo**:
```yaml
---
title: "microsoft/autogen"
source_url: "https://github.com/microsoft/autogen"
source_type: repo
fetched: 2026-04-15
stars: 25000
language: Python
dimension: harness  # NEW
---
```

## Integration with Wiki Ingest

When `/wiki-ingest` processes files with `dimension` field:

1. **Routes to correct entity type**:
   - `dimension: memory` → Create [[Memory System]] entity
   - `dimension: skills` → Create [[Skill Framework]] entity
   - `dimension: protocols` → Create [[Protocol]] entity
   - `dimension: harness` → Create [[Harness]] entity

2. **Creates dimension-specific concepts**:
   - Memory → [[Memory Architecture]], [[Retrieval Strategy]]
   - Skills → [[Skill Acquisition]], [[Skill Composition]]
   - Protocols → [[Protocol Design]], [[Capability Discovery]]
   - Harness → [[Agent Loop]], [[Sandboxing]], [[Observability]]

3. **Tags appropriately**:
   - Memory: `memory-hierarchical`, `memory-episodic`
   - Skills: `skill-authored`, `skill-distilled`
   - Protocols: `protocol-mcp`, `protocol-lsp`
   - Harness: `harness-loop`, `harness-sandbox`

## Example Usage

### Search for Memory Research
```bash
/web-discovery memory "MemGPT hierarchical memory"
```

**Expected output**:
```
## Discovery Report — Memory Dimension

Downloaded:
1. arxiv_2310_08560_memgpt.md (dimension: memory)
2. github_cpacker_memgpt.md (dimension: memory)
3. memgpt-architecture-overview.md (dimension: memory)

Next: /wiki-ingest raw/web/
→ Creates [[MemGPT]] entity
→ Creates [[Hierarchical Memory]] concept
```

### Search for Harness Engineering
```bash
/web-discovery harness "Meta-Harness agent loop"
```

**Expected output**:
```
## Discovery Report — Harness Dimension

Downloaded:
1. arxiv_2603_28052_meta-harness.md (dimension: harness)
2. github_autogen.md (dimension: harness)
3. langgraph-orchestration.md (dimension: harness)

Next: /wiki-ingest raw/web/
→ Creates [[Meta-Harness]] entity
→ Creates [[Agent Loop Design]] concept
→ Creates [[Harness Optimization]] concept
```

## Migration from v1.0

**Existing raw/web/ files** (from v1.0):
- Keep: `meta-harness.md`, `claude-code-harness-architecture.md`
- Archive/delete: All benchmark-focused papers

**To clean up**:
```bash
mkdir -p raw/archived/benchmark-focus
mv raw/web/*bench*.md raw/archived/benchmark-focus/
mv raw/web/*eval*.md raw/archived/benchmark-focus/
```

**To tag existing files**:
Manually add `dimension:` field to frontmatter of keeper files:
- `meta-harness.md` → `dimension: harness`
- `claude-code-harness-architecture.md` → `dimension: harness`

## Testing the New Skill

```bash
# Test each dimension
/web-discovery memory "RAG architecture" --limit=3
/web-discovery skills "tool use framework" --limit=3
/web-discovery protocols "MCP specification" --limit=3
/web-discovery harness "agent loop design" --limit=3

# Verify frontmatter contains dimension field
cat raw/web/2026-04-15_*.md | grep "dimension:"

# Ingest and check entity creation
/wiki-ingest raw/web/
cat wiki/index.md  # Should show new Memory/Skills/Protocols/Harness entities
```

## Reference

Based on: **"Externalization in LLM Agents: A Unified Review of Memory, Skills, Protocols and Harness Engineering"**
- Authors: Chenyu Zhou et al.
- arXiv: 2604.08224
- Date: 2026-04-09
- Framework: Four externalization dimensions with cognitive artifact analysis

---

**Status**: ✅ v2.0 upgrade complete  
**Ready to use**: `/web-discovery <dimension> <topic>`  
**Next step**: Test with real searches and ingest results
