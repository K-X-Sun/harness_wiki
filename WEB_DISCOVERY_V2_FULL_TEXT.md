# Web Discovery v2.1 — Full-Text Markdown Download

**Date**: 2026-04-15  
**Version**: v2.0 → v2.1  
**Change**: From summaries to full-text markdown, with dimension-specific directory routing

---

## What Changed

### ❌ Old Behavior (v2.0)

**Problem**: WebSearch returns only abstracts/summaries, not full papers

**Example output**:
```markdown
# raw/web/2026-04-14_arxiv_2603_28052_meta-harness.md (only 18 lines!)

---
title: "Meta-Harness: End-to-End Optimization of Model Harnesses"
source_url: "https://arxiv.org/abs/2603.28052"
source_type: paper
fetched: 2026-04-14
authors: ["Yoonho Lee", ...]
categories: ["cs.AI"]
---

**Title:** META-HARNESS: ...
**Authors:** ...
**Abstract:** The performance of large language model (LLM) systems depends...
**Submission Date:** ...
**Categories:** ...
```

**Issues**:
1. ❌ Only abstract (~300 words), no full paper content (~10,000+ words)
2. ❌ All files mixed in `raw/web/` directory
3. ❌ No dimension-based organization
4. ❌ File sizes: 1-3KB instead of 45-67KB for full papers

---

## ✅ New Behavior (v2.1)

### 1. Full-Text Download as Markdown

**arXiv Papers**:
- Fetch HTML version: `https://arxiv.org/html/<paper-id>v1`
- Convert to complete markdown with ALL sections:
  - Title, Authors, Abstract
  - Introduction, Related Work
  - Method, Architecture, Implementation
  - Experiments, Results, Discussion
  - Conclusion, Limitations, Future Work
  - References (all citations)
- Preserve LaTeX equations: `$inline$` and `$$display$$`
- Convert tables to markdown tables
- Include figure captions: `[Figure 1: Architecture diagram]`
- **Expected size**: 45-80KB (full paper text)

**WebFetch Prompt** (critical change):
```
Convert this arXiv paper to clean markdown format.

REQUIREMENTS:
1. Include ALL sections verbatim: title, authors, abstract, introduction, 
   method, experiments, results, discussion, conclusion, references
2. Convert all math equations to LaTeX syntax ($inline$ and $$display$$)
3. Preserve all tables as markdown tables
4. Include figure captions with [Figure N: caption text]
5. Keep all citations and references
6. Do NOT add summaries, do NOT add commentary
7. Output ONLY the markdown content, no preamble

Format the output as clean, readable markdown.
```

**GitHub Repos**:
- Fetch raw README: `https://raw.githubusercontent.com/owner/repo/main/README.md`
- Save complete markdown verbatim (no summarization)
- Add metadata to frontmatter: stars, language, license
- **Expected size**: 10-30KB (full README)

**Web Articles/Docs**:
- Fetch HTML and convert to markdown
- Include complete content: all headings, paragraphs, code blocks, tables
- Exclude navigation, ads, footer (via web_fetch prompt)
- **Expected size**: 15-50KB (full article)

### 2. Dimension-Specific Directory Routing

**Old**: Everything in `raw/web/`

**New**: Organized by externalization dimension:

```
raw/
  memory/                 # Memory dimension
    2026-04-15_arxiv_2603_11768_ssgm-framework.md
    2026-04-15_github_mem0ai-mem0.md
    assets/
  
  skills/                 # Skills dimension
    2026-04-15_arxiv_2602_12430_agent-skills-llm.md
    2026-04-15_github_voyager.md
    assets/
  
  protocols/              # Protocols dimension
    2026-04-15_arxiv_2503_23278_mcp-landscape.md
    2026-04-15_github_modelcontextprotocol-servers.md
    2026-04-15_mcp-specification.md
    assets/
  
  harness/                # Harness dimension
    2026-04-15_arxiv_2603_28052_meta-harness.md
    2026-04-15_github_microsoft-autogen.md
    assets/
  
  web/                    # Cross-cutting / unclassified
    assets/
```

**Routing logic**:
```bash
/web-discovery memory "..."    → raw/memory/
/web-discovery skills "..."    → raw/skills/
/web-discovery protocols "..." → raw/protocols/
/web-discovery harness "..."   → raw/harness/
/web-discovery "..." (no dim)  → raw/web/
```

### 3. Updated Frontmatter

```yaml
---
title: "Meta-Harness: End-to-End Optimization of Model Harnesses"
source_url: "https://arxiv.org/abs/2603.28052"
source_type: paper
fetched: 2026-04-15
dimension: harness          # NEW: determines directory
authors: ["Yoonho Lee", "Roshen Nair", "Qizheng Zhang", ...]
categories: ["cs.AI"]
---

# Meta-Harness: End-to-End Optimization of Model Harnesses

**Authors:** Yoonho Lee, Roshen Nair, Qizheng Zhang, Kangwook Lee, Omar Khattab, Chelsea Finn

## Abstract

The performance of large language model (LLM) systems depends not only on model weights...
[FULL 67KB paper content continues for ~30 pages...]

## 1. Introduction

Modern LLM applications require more than just model weights...
[Complete introduction section...]

## 2. Background and Related Work
...

[ALL sections through Conclusion and References]
```

---

## Files Modified

### 1. `web_discovery/skill/references/discovery-workflow.md`

**Step 1 — Pre-check**:
- ✅ Create dimension directories: `mkdir -p raw/{memory,skills,protocols,harness}/assets`

**Step 5a — arXiv papers**:
```diff
- Use web_search (returns only abstract)
+ Use web_fetch on HTML endpoint with explicit "complete paper as markdown" prompt
+ URL: https://arxiv.org/html/<paper-id>v1
+ Fallback: ar5iv.labs.arxiv.org/html/<paper-id>
```

**Step 5b — GitHub repos**:
```diff
- Generic web_fetch
+ Fetch raw README: https://raw.githubusercontent.com/owner/repo/main/README.md
+ Prompt: "Return complete content as-is, do NOT summarize"
```

**Step 5c — Web articles**:
```diff
- Basic web_fetch
+ Detailed prompt: "Convert to clean markdown, include ALL content, do NOT summarize"
```

**Step 6 — Save location**:
```diff
- Save to: raw/web/YYYY-MM-DD_<slug>.md
+ Save to: raw/<dimension>/YYYY-MM-DD_<slug>.md
+ Route by detected dimension (memory/skills/protocols/harness)
```

**Step 7 — Discovery report**:
```diff
- Flat list of downloads
+ Organized by dimension with file sizes
+ Example: "raw/memory/ (3 files): 45KB, 52KB, 38KB"
```

### 2. `web_discovery/skill/references/raw-web-conventions.md`

**Directory structure**:
```diff
- raw/web/ (all files mixed)
+ raw/memory/, raw/skills/, raw/protocols/, raw/harness/ (organized by dimension)
```

**Content preservation**:
```diff
- "Save exactly what web_fetch returns"
+ "CRITICAL: Save COMPLETE original content converted to clean markdown"
+ Added explicit requirements for arXiv (ALL sections), GitHub (complete README), articles (full content)
```

### 3. `web_discovery/README.md`

**Description**:
```diff
- "Downloads findings as structured markdown to raw/web/"
+ "Downloads complete full-text content as markdown to dimension-specific directories"
```

**What It Does**:
```diff
3. Full-text download — arXiv papers (complete), GitHub READMEs
+ 3. Full-text download as markdown:
+    - arXiv papers: HTML → complete markdown (all sections, equations, tables)
+    - GitHub repos: Raw README.md → complete markdown + metadata
+    - Web articles: HTML → clean markdown (all content, no nav/ads)
```

**Workflow diagram**:
```diff
- Save to raw/web/2026-04-15_arxiv_xxxx_memory-topic.md
+ Save to raw/memory/2026-04-15_arxiv_xxxx_topic.md (dimension-specific)
```

**Examples updated**:
```diff
- → Tags: dimension: memory
+ → Downloads: MemGPT paper (full HTML→markdown)
+ → Saves to: raw/memory/2026-04-15_arxiv_2310_08560_memgpt.md (45KB full text)
```

### 4. `CLAUDE.md`

**Structure section**:
```diff
- raw/ — Immutable source documents
- raw/assets/ — Downloaded images
+ raw/
+   raw/memory/ — Memory dimension sources (full-text markdown)
+   raw/skills/ — Skills dimension sources (full-text markdown)
+   raw/protocols/ — Protocols dimension sources (full-text markdown)
+   raw/harness/ — Harness dimension sources (full-text markdown)
+   raw/web/ — Cross-cutting sources
+   raw/*/assets/ — Images per dimension
```

### 5. Directory creation

```bash
mkdir -p raw/{memory,skills,protocols,harness}/assets
```

---

## Migration from v2.0 to v2.1

### Existing `raw/web/` Files

**Keep**: 
- `2026-04-14_arxiv_2603_28052_meta-harness.md` → Move to `raw/harness/`
- `2026-04-14_arxiv_2603_25723_nlahs.md` → Move to `raw/harness/`

**Action needed**: Re-download these as full-text versions:
```bash
/web-discovery harness "Meta-Harness NLAH" --limit=2
```

**Archive old summaries**:
```bash
mkdir -p raw/archived/v2.0-summaries
mv raw/web/*.md raw/archived/v2.0-summaries/
```

### Testing v2.1

**Test arXiv full-text download**:
```bash
/web-discovery memory "SSGM Framework" --limit=1
# Expected: raw/memory/2026-04-15_arxiv_2603_11768_ssgm.md (~45KB)
# Check: Should contain Introduction, Method, Results, Conclusion sections
```

**Test GitHub full README**:
```bash
/web-discovery memory "Mem0" --github --limit=1
# Expected: raw/memory/2026-04-15_github_mem0ai-mem0.md (~18KB)
# Check: Should contain complete README with all sections, not summary
```

**Test web article**:
```bash
/web-discovery protocols "MCP specification" --limit=1
# Expected: raw/protocols/2026-04-15_mcp-specification.md (~38KB)
# Check: Complete spec content, all sections
```

**Verify file sizes**:
```bash
ls -lh raw/memory/*.md
ls -lh raw/skills/*.md
ls -lh raw/protocols/*.md
ls -lh raw/harness/*.md
```

Expected sizes:
- arXiv papers: 40-80KB (full text, ~20-40 pages)
- GitHub READMEs: 10-30KB (complete documentation)
- Web articles/docs: 15-50KB (full content)

**NOT 1-3KB** (that's summary-only, v2.0 behavior)

---

## Expected Output Example

### Before (v2.0) — 18 lines, ~1.5KB

```markdown
---
title: "Meta-Harness: End-to-End Optimization of Model Harnesses"
...
---

**Abstract:** The performance of large language model (LLM) systems...
```

### After (v2.1) — 800+ lines, ~67KB

```markdown
---
title: "Meta-Harness: End-to-End Optimization of Model Harnesses"
source_url: "https://arxiv.org/abs/2603.28052"
source_type: paper
fetched: 2026-04-15
dimension: harness
authors: ["Yoonho Lee", ...]
categories: ["cs.AI"]
---

# Meta-Harness: End-to-End Optimization of Model Harnesses

Yoonho Lee¹, Roshen Nair¹, Qizheng Zhang², Kangwook Lee², Omar Khattab³, Chelsea Finn¹

¹Stanford University, ²University of Wisconsin-Madison, ³MIT

## Abstract

The performance of large language model (LLM) systems depends not only on model 
weights, but also on their harness: the code that determines what information to 
store, retrieve, and present to the model. Yet harnesses are still designed largely 
by hand, and existing text optimizers are poorly matched to this setting because 
they compress feedback too aggressively...

[CONTINUES FOR 30+ PAGES WITH FULL CONTENT]

## 1. Introduction

Modern LLM applications require more than just model weights. The surrounding 
infrastructure—what we call the harness—plays an equally critical role...

## 2. Background and Related Work

### 2.1 Prompt Optimization
...

### 2.2 Context Management
...

## 3. Meta-Harness Framework

### 3.1 Problem Formulation
...

### 3.2 Agentic Proposer
...

## 4. Experiments

### 4.1 Online Text Classification
...

### 4.2 Retrieval-Augmented Math Reasoning
...

### 4.3 Agentic Coding
...

## 5. Results and Analysis
...

## 6. Discussion
...

## 7. Conclusion
...

## References

[1] Brown, T., et al. (2020). Language models are few-shot learners...
[2] ...
[Complete reference list]

## Appendix A: Implementation Details
...

## Appendix B: Additional Results
...
```

---

## Benefits

1. **Complete knowledge capture**: Full papers instead of abstracts enables deep technical understanding
2. **Organized by dimension**: Easier to navigate, better for dimension-specific analysis
3. **Ready for wiki ingest**: Full content enables richer entity/concept extraction
4. **Proper citations**: All references preserved for tracking paper relationships
5. **Reproducible**: Can verify technical details, equations, experimental setup

---

## Status

✅ **v2.1 complete**  
✅ **Dimension directories created**: `raw/{memory,skills,protocols,harness}/`  
✅ **Workflow updated**: Full-text markdown download with proper prompts  
✅ **Documentation updated**: README, CLAUDE.md, conventions  

**Ready to use**: `/web-discovery <dimension> <topic>` now downloads full-text markdown to dimension-specific directories

**Next step**: Test with real downloads from SOURCES_TO_DOWNLOAD.md list

---

**Date**: 2026-04-15  
**Version**: v2.1  
**Framework**: "Externalization in LLM Agents" (Zhou et al., 2026, arXiv:2604.08224)
