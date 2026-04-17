# raw/ Dimension-Specific Conventions

File naming, frontmatter, and content rules for web-discovered content organized by externalization dimension.

---

## Directory Structure (v2.0)

```
raw/
  memory/                 # Memory dimension (MemGPT, Mem0, RAG, hierarchical memory)
    assets/               # Images for memory papers/docs
    2026-04-15_arxiv_2603_11768_ssgm-framework.md
    2026-04-15_github_mem0ai-mem0.md
    2026-04-15_openai-memory-architecture.md
  
  skills/                 # Skills dimension (Voyager, tool use, skill composition)
    assets/               # Images for skills papers/docs
    2026-04-15_arxiv_2602_12430_agent-skills-llm.md
    2026-04-15_github_voyager.md
  
  protocols/              # Protocols dimension (MCP, LSP, agent communication)
    assets/               # Images for protocol specs/docs
    2026-04-15_arxiv_2503_23278_mcp-landscape.md
    2026-04-15_github_modelcontextprotocol-servers.md
    2026-04-15_mcp-specification.md
  
  harness/                # Harness dimension (Meta-Harness, AutoGen, agent loops)
    assets/               # Images for harness papers/docs
    2026-04-15_arxiv_2603_28052_meta-harness.md
    2026-04-15_github_microsoft-autogen.md
  
  web/                    # Cross-cutting / unclassified content
    assets/
    2026-04-15_general-agent-engineering.md
```

**Routing logic**:
- Search with `/web-discovery memory ...` → save to `raw/memory/`
- Search with `/web-discovery skills ...` → save to `raw/skills/`
- Search with `/web-discovery protocols ...` → save to `raw/protocols/`
- Search with `/web-discovery harness ...` → save to `raw/harness/`
- Search with no dimension → save to `raw/web/`

The wiki ingest process treats all files in `raw/` uniformly — subdirectories enable
dimension-aware entity creation and concept extraction.

---

## File Naming

### Pattern

```
YYYY-MM-DD_[source_]slug.md
```

### Components

| Part | Description | Example |
|------|-------------|---------|
| `YYYY-MM-DD` | Date the content was fetched | `2026-04-14` |
| `source_` | Source prefix: `arxiv_` or `github_` (empty for general web) | `arxiv_` |
| `slug` | Kebab-case from title, max 50 chars | `swe-bench-eval` |
| `.md` | Extension | `.md` |

### Slug Generation

1. Take the original title of the content
2. Convert to lowercase
3. Replace spaces with hyphens
4. Remove all characters except `[a-z0-9-]`
5. Collapse consecutive hyphens to single hyphen
6. Truncate to 50 characters
7. Remove leading/trailing hyphens

**Examples:**

| Original Title | Slug |
|----------------|------|
| "SWE-bench: Evaluating LLMs on GitHub Issues" | `swe-bench-evaluating-llms-on-github-iss` |
| "Attention Is All You Need" | `attention-is-all-you-need` |
| "owner/repo" (GitHub) | `owner-repo` |
| "2309.12345: Code Generation Benchmark" (arXiv) | `2309-12345-code-generation-benchmark` |

### Uniqueness

If a file with the same name already exists in `raw/web/`:
- Append `-2` → `2026-04-14_arxiv_2309_12345_swe-bench-2.md`
- Then `-3`, `-4`, etc.

Check for collisions against ALL files in `raw/web/`, not just those with the same source prefix.

---

## Frontmatter

Every file downloaded to `raw/web/` MUST have YAML frontmatter at the top.

### Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `title` | string | Original title of the content |
| `source_url` | URL | The URL this content was fetched from |
| `source_type` | enum | One of: `article`, `paper`, `repo`, `blog`, `documentation` |
| `fetched` | date | Date the content was downloaded (YYYY-MM-DD) |

### Optional Fields (include if available)

| Field | Type | Description | Applies to |
|-------|------|-------------|------------|
| `author` | string | Single author name | article, blog, documentation |
| `authors` | array | Multiple authors | paper |
| `domain` | string | Domain of the source URL | article, blog |
| `stars` | integer | GitHub star count | repo |
| `language` | string | Primary programming language | repo |
| `categories` | array | arXiv categories | paper |
| `description` | string | Short description / summary | repo, article |

### Examples

**Article:**
```yaml
---
title: "How to Evaluate Code Generation Models"
source_url: "https://openai.com/blog/code-eval"
source_type: article
fetched: 2026-04-14
author: "Jane Smith"
domain: "openai.com"
---
```

**arXiv Paper:**
```yaml
---
title: "SWE-bench: Evaluating LLMs on Real-World Software Issues"
source_url: "https://arxiv.org/abs/2309.12345"
source_type: paper
fetched: 2026-04-14
authors: ["Carlos E. Jimenez", "John Yang"]
categories: ["cs.SE", "cs.AI"]
---
```

**GitHub Repo:**
```yaml
---
title: "swe-bench/swe-bench"
source_url: "https://github.com/swe-bench/swe-bench"
source_type: repo
fetched: 2026-04-14
stars: 3420
language: Python
description: "Evaluating LLMs on real-world software engineering issues"
---
```

---

## Content Preservation Rules

### Core Principle — FULL TEXT as Markdown

**CRITICAL**: Save **complete original content** converted to clean markdown.

**For arXiv papers**:
- ✅ Fetch HTML version: `https://arxiv.org/html/<id>v1`
- ✅ Convert to markdown with ALL sections: title, abstract, intro, methods, results, conclusion, references
- ✅ Preserve equations as LaTeX: `$inline$` and `$$display$$`
- ✅ Convert tables to markdown tables
- ✅ Include figure captions: `[Figure N: caption]`
- ❌ NO summaries, NO truncation, NO "Key Points" sections

**For GitHub repos**:
- ✅ Fetch raw README: `https://raw.githubusercontent.com/owner/repo/main/README.md`
- ✅ Save complete markdown verbatim
- ✅ Add metadata (stars, language, license) to frontmatter
- ❌ NO summarization of README content

**For web articles/docs**:
- ✅ Convert HTML to clean markdown
- ✅ Include complete article: all headings, paragraphs, code blocks, tables
- ✅ Preserve code blocks with language tags
- ✅ Exclude navigation, sidebar, ads, footer (handled by web_fetch prompt)
- ❌ NO summaries, NO paraphrasing

**DO**:
- Add YAML frontmatter at the top
- Save the complete content as markdown
- Use proper web_fetch prompts that request "complete content as markdown, do NOT summarize"

### Images

- Reference as `![alt text](URL)` in the markdown
- Do NOT automatically download images (the user can do this manually via Obsidian Web Clipper or the hotkey workflow described in the LLM Wiki concept doc)
- If images are downloaded to `raw/web/assets/`, reference as `![alt text](assets/filename.png)`

---

## Source Type Definitions

| Type | When to Use | Extraction Focus |
|------|-------------|------------------|
| `article` | Technical articles, tutorials, analysis pieces on any domain | Full article text, code examples, data tables |
| `paper` | Academic papers from arXiv, conferences, journals | Title, authors, abstract, categories, key conclusions |
| `repo` | GitHub/GitLab repositories | Complete README verbatim, stars, language, description |
| `blog` | Blog posts from company or personal blogs | Full post text, code examples, author, date |
| `documentation` | Official docs, API references, user guides | Document structure, API details, usage examples |

---

## Relationship to Wiki Ingest

Files in `raw/web/` are treated identically to other raw sources by `/wiki-ingest`:

1. The ingest process reads the file and extracts content
2. The `source_url` frontmatter field is preserved in the wiki source summary page
3. The `source_type` helps the LLM understand what kind of content it's processing
4. All frontmatter fields become metadata available for search and categorization

The wiki source summary page created during ingest will include a reference back to
the original URL, making it easy to revisit the source for verification or updates.
