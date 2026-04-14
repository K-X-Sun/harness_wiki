# Media Experience Wiki

A knowledge management system for media software engineering. Combines automated experience extraction from Claude Code sessions with Karpathy's [LLM Wiki](https://x.com/karpathy/status/1937539189399474427) pattern for persistent, compounding knowledge.

## Skills

Six Claude Code skills, each installed independently:

| Skill | Command | Purpose |
|---|---|---|
| [web_discovery](web_discovery/) | `/web-discovery` | Search web, arXiv, GitHub for domain topics; download as markdown to `raw/web/` |
| [experience_extraction](experience_extraction/) | `/cc-experience-extraction` | Extract structured knowledge from Claude Code conversation logs (JSONL) |
| [wiki_init](wiki_init/) | `/wiki-init` | Bootstrap a new LLM Wiki knowledge base (three-layer architecture) |
| [wiki_ingest](wiki_ingest/) | `/wiki-ingest` | Process source documents into the wiki (auto, interactive, or batch) |
| [wiki_query](wiki_query/) | `/wiki-query` | Answer questions from the wiki with citations |
| [wiki_lint](wiki_lint/) | `/wiki-lint` | Health-check the wiki for contradictions, orphans, stale claims, and gaps |

## Architecture

```
  Claude Code Sessions                    Web Search              Raw Sources
        |                                      |                      |
        v                                      v                      v
  /cc-experience-extraction           /web-discovery          (user drops files)
        |                                      |                      |
        v                                      v                      v
    .source.md  ──>  raw/  <── raw/web/ <── web_fetch × N     (additional files)
                             |
                             v
                      /wiki-ingest  ──>  wiki/
                                      |       |
                                      v       v
                                /wiki-query  /wiki-lint
                                      |       |
                                      v       v
                              Filed answers  Health reports
                              compound back  suggest new sources
                              into wiki/     and queries
```

## Workflow

1. **Init** -- `/wiki-init "domain description"` bootstraps the wiki structure
2. **Discover** -- `/web-discovery "topic"` searches web/arXiv/GitHub, downloads findings to `raw/web/`
3. **Extract** -- `/cc-experience-extraction` turns Claude Code sessions into structured source files
4. **Ingest** -- `/wiki-ingest raw/<source>` or `/wiki-ingest raw/web/` integrates sources into cross-referenced wiki pages
5. **Query** -- `/wiki-query "question"` answers from the wiki with citations; good answers get filed back
6. **Lint** -- `/wiki-lint` health-checks for contradictions, orphans, and gaps; suggests next sources and search queries

## Live Wiki

A wiki built with these skills for media software experience is at: [media-experience-base](https://github.com/intel-sandbox/media-experience-base/tree/main)

## Installation

```bash
# Install all skills
cp -r web_discovery/skill         ~/.claude/skills/web-discovery
cp -r experience_extraction/skill ~/.claude/skills/cc-experience-extraction
cp -r wiki_init/skill             ~/.claude/skills/wiki-init
cp -r wiki_ingest/skill           ~/.claude/skills/wiki-ingest
cp -r wiki_query/skill            ~/.claude/skills/wiki-query
cp -r wiki_lint/skill             ~/.claude/skills/wiki-lint
```

## Repo Structure

```
media-experience-wiki/
  README.md                    # This file
  web_discovery/               # Web search → markdown download
    README.md
    skill/
  experience_extraction/       # CC conversation -> structured source files
    README.md
    skill/
  wiki_init/                   # Bootstrap wiki structure
    README.md
    skill/
  wiki_ingest/                 # Process sources into wiki
    README.md
    skill/
  wiki_query/                  # Answer questions from wiki
    README.md
    skill/
  wiki_lint/                   # Health-check the wiki
    README.md
    skill/
  sample_doc/                  # Sample documents
```
