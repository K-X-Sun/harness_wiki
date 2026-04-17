# Web Discovery Skill — Changelog

## [2.1.0] - 2026-04-16

### Added - Temporal Prioritization Strategy

**Feature**: Download sources in temporal priority order, fetching recent/hot content before classic/foundational work.

**Motivation**: User request to prioritize emerging trends and active development before historical foundational work.

**Implementation**:

#### Four Priority Tiers (Year-based)

1. **🔥 Recent & Hot** (download FIRST):
   - arXiv papers from **last 2 months** (Feb 2026+ for current date April 2026)
   - GitHub repos with commits in last 4 weeks OR 100+ stars gained in last 2 months
   - Articles/docs published in last 2 months
   - **Why**: Captures emerging trends, latest methods, active development

2. **📈 Recent** (download SECOND):
   - arXiv papers from **2026** (this year, older than 2 months)
   - GitHub repos with last commit in 2026
   - Articles/docs from 2026
   - **Why**: Recent but not bleeding-edge, likely stable and validated

3. **📚 Classic** (download THIRD):
   - arXiv papers from **2025** (last year)
   - GitHub repos with 1000+ stars OR last commit in 2025
   - Seminal papers frequently cited in recent work
   - **Why**: Recent foundational work, well-established patterns

4. **🗂️ Foundational** (download LAST):
   - Papers **before 2025** (2024 and earlier)
   - Archived repos (no commits in 2025-2026, unless 5000+ stars)
   - **Why**: Historical context, only if no better recent source exists

#### Temporal Signal Extraction

- **arXiv**: Parse paper ID (e.g., `2603.28052` = March 2026)
- **GitHub**: Extract "Updated X days/weeks/months ago" from snippet
- **Articles**: Check publication date in metadata

#### Special Boosting Rules

- GitHub repos with **10+ commits in last month**: treat as tier 1 (even if repo is older)
- arXiv papers with **20+ citations in last 3 months**: boost to tier 2
- Papers labeled "survey", "review", "unified framework": boost by 1 tier

#### Download Behavior

When `--limit=N` is set, download first N results from **temporally sorted list**.

Example: If `--limit=10` and there are 15 results (3 recent & hot, 4 recent 2026, 5 classic 2025, 3 foundational pre-2025), download:
- All 3 recent & hot (tier 1: last 2 months)
- All 4 recent (tier 2: 2026)  
- First 3 classic (tier 3: 2025)
- None from foundational (tier 4: before 2025)

**Result**: User gets latest methods first, maximizing value per download.

### Changed

- Updated `discovery-workflow.md` Step 4 with temporal sorting algorithm
- Updated `SKILL.md` with temporal prioritization description
- Search results now grouped by temporal tier in output table

### Files Modified

- `web_discovery/skill/references/discovery-workflow.md`
- `web_discovery/skill/SKILL.md`
- `web_discovery/CHANGELOG.md` (this file)

---

## [2.0.0] - 2026-04-15

### Changed - Refocus to Externalization Engineering

**Breaking change**: Shifted focus from evaluation/benchmarks to Memory, Skills, Protocols, Harness engineering.

**Quality filters updated**:
- ✅ KEEP: Memory architectures, skill frameworks, protocols, harness design, cognitive artifact analysis
- ❌ DROP: Benchmark papers (SWE-Bench, HumanEval), pure evaluation methodology

**Directory structure**:
- `raw/memory/` — Memory dimension sources
- `raw/skills/` — Skills dimension sources
- `raw/protocols/` — Protocols dimension sources
- `raw/harness/` — Harness dimension sources
- `raw/web/` — Cross-cutting sources

**Dimension-specific queries**: 15-20 targeted queries per dimension (memory/skills/protocols/harness).

### Files Modified

- `web_discovery/skill/SKILL.md`
- `web_discovery/skill/references/discovery-workflow.md`
- `web_discovery/skill/references/raw-web-conventions.md`

---

## [1.0.0] - 2026-04-14

Initial release: AI coding benchmark and evaluation discovery.
