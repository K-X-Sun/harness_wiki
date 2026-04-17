# Temporal Priority Strategy

## Overview

Web-discovery skill downloads sources in **temporal priority order**, ensuring you get the latest research first, then this year's work, then last year's classics, and finally older foundational papers.

## Priority Tiers (Current: April 2026)

```
┌─────────────────────────────────────────────────────────┐
│ 🔥 Tier 1: Recent & Hot (DOWNLOAD FIRST)               │
│ Last 2 months: Feb 2026 - Apr 2026                     │
│ • arXiv papers from 2602.xxxxx+                        │
│ • GitHub: commits in last 4 weeks OR 100+ stars/2mo    │
│ • Articles published in last 2 months                   │
│ WHY: Emerging trends, latest methods, active dev       │
└─────────────────────────────────────────────────────────┘
                         ↓
┌─────────────────────────────────────────────────────────┐
│ 📈 Tier 2: Recent (DOWNLOAD SECOND)                    │
│ This year (2026), older than 2 months                  │
│ • arXiv papers from 2601.xxxxx                         │
│ • GitHub: last commit in 2026                          │
│ • Articles from Jan 2026                                │
│ WHY: Recent but validated, stable work                 │
└─────────────────────────────────────────────────────────┘
                         ↓
┌─────────────────────────────────────────────────────────┐
│ 📚 Tier 3: Classic (DOWNLOAD THIRD)                    │
│ Last year (2025)                                        │
│ • arXiv papers from 2501-2512                          │
│ • GitHub: 1000+ stars OR commit in 2025                │
│ • Articles from 2025                                    │
│ WHY: Foundational work, frequently cited               │
└─────────────────────────────────────────────────────────┘
                         ↓
┌─────────────────────────────────────────────────────────┐
│ 🗂️ Tier 4: Foundational (DOWNLOAD LAST)                │
│ Before 2025 (2024 and earlier)                         │
│ • arXiv papers before 2501                             │
│ • GitHub: no commits in 2025-26, unless 5000+ stars    │
│ • Historical articles                                   │
│ WHY: Historical context, only if highly relevant       │
└─────────────────────────────────────────────────────────┘
```

## Date Extraction

### arXiv Papers

Parse paper ID to extract year and month:
- `2604.12345` → April 2026 → Tier 1 (recent & hot)
- `2601.67890` → January 2026 → Tier 2 (recent)
- `2508.11111` → August 2025 → Tier 3 (classic)
- `2403.22222` → March 2024 → Tier 4 (foundational)

### GitHub Repositories

Extract from snippet:
- "Updated 2 weeks ago" → Tier 1
- "Updated 3 months ago" (Jan 2026) → Tier 2
- "Updated 8 months ago" (Aug 2025) → Tier 3
- "Updated 2 years ago" → Tier 4

**Special**: Repos with 10+ commits in last month → boost to Tier 1

### Web Articles

Check publication date in metadata or snippet:
- "Published Mar 2026" → Tier 1
- "Published Jan 2026" → Tier 2
- "Published 2025" → Tier 3
- "Published 2024" → Tier 4

## Special Boosting Rules

### Active Development Boost
- GitHub repos with **10+ commits in last month** → Tier 1 (even if repo created in 2024)

### High Citation Boost
- arXiv papers with **20+ citations in last 3 months** → Boost by 1 tier
  - Tier 2 → Tier 1
  - Tier 3 → Tier 2
  - Tier 4 → Tier 3

### Survey/Review Boost
- Papers labeled "survey", "review", "unified framework" → Boost by 1 tier
  - These are comprehensive overviews worth prioritizing

## Download Behavior with --limit

When `--limit=N` is set, download first N results from temporally sorted list.

### Example 1: Balanced Results

Search returns 20 results:
- 5 Recent & Hot (Tier 1)
- 6 Recent 2026 (Tier 2)
- 7 Classic 2025 (Tier 3)
- 2 Foundational pre-2025 (Tier 4)

With `--limit=10`:
- Download: 5 (Tier 1) + 5 (Tier 2) = 10 total
- Skip: All Tier 3 and Tier 4

### Example 2: Mostly Old Results

Search returns 15 results:
- 2 Recent & Hot (Tier 1)
- 3 Recent 2026 (Tier 2)
- 4 Classic 2025 (Tier 3)
- 6 Foundational pre-2025 (Tier 4)

With `--limit=10`:
- Download: 2 (Tier 1) + 3 (Tier 2) + 4 (Tier 3) + 1 (Tier 4) = 10 total
- Skip: Last 5 from Tier 4

### Example 3: All Recent

Search returns 12 results:
- 8 Recent & Hot (Tier 1)
- 4 Recent 2026 (Tier 2)
- 0 Classic
- 0 Foundational

With `--limit=10`:
- Download: 8 (Tier 1) + 2 (Tier 2) = 10 total
- Skip: Last 2 from Tier 2

## Output Format

Results are grouped by tier in the search results table:

```markdown
## Search Results — Memory Dimension

### 🔥 Recent & Hot (last 2 months: Feb 2026+)
| # | Source | Date | Title | URL |
|---|--------|------|-------|-----|
| 1 | arxiv  | 2026-04 | Adaptive Memory Framework | ... |
| 2 | github | 2026-03 | mem0ai/mem0 | ... |

### 📈 Recent (2026, older than 2 months)
| # | Source | Date | Title | URL |
|---|--------|------|-------|-----|
| 3 | arxiv  | 2026-01 | Hierarchical Memory | ... |

### 📚 Classic (2025)
| # | Source | Date | Title | URL |
|---|--------|------|-------|-----|
| 4 | arxiv  | 2025-08 | MemGPT | ... |

### 🗂️ Foundational (before 2025)
| # | Source | Date | Title | URL |
|---|--------|------|-------|-----|
| 5 | arxiv  | 2024-06 | Retrieval Augmented Generation | ... |
```

## Benefits

1. **Stay current**: Always get latest research first
2. **Maximize value**: Limited downloads go to most recent content
3. **Avoid outdated**: Old papers only if no better recent alternative
4. **Context-aware**: Still download classics when they're the best source
5. **Active projects**: Boost recently-updated GitHub repos

## Yearly Update Behavior

As time progresses, the tiers automatically shift:

**Current (April 2026)**:
- Tier 1: Feb-Apr 2026
- Tier 2: Jan 2026
- Tier 3: 2025
- Tier 4: Before 2025

**Future (January 2027)**:
- Tier 1: Nov 2026-Jan 2027
- Tier 2: Jan-Oct 2026
- Tier 3: 2026
- Tier 4: Before 2026

**No manual updates needed** — the algorithm uses current date automatically.
