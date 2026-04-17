# Web Discovery Skill v2.4.0 — User-Configurable Source Ratio

**Date**: 2026-04-17
**Upgrade**: Changed default ratio to 3:5:2 and added `--ratio` flag for user customization

## User Request

"占比控制默认3：5：2吧，然后也是写成用户可以修改的形式"

**Translation**: "Change default ratio to 3:5:2, and make it user-configurable"

## Changes Summary

| Aspect | v2.3.1 | v2.4.0 |
|--------|--------|--------|
| **Default ratio** | 3:4:3 (hard-coded) | **3:5:2** (configurable) |
| **Articles %** | 30% | **30%** (same) |
| **GitHub %** | 40% | **50%** ⬆️ |
| **Other %** | 30% | **20%** ⬇️ |
| **User customization** | ❌ Not available | ✅ **`--ratio=A:G:O` flag** |

---

## Change #1: New Default Ratio (3:5:2)

### Rationale

**User feedback**: Increase GitHub proportion to 50%
- GitHub repos are primary source of implementation code
- More valuable for understanding real-world patterns
- Reduce "Other" category from 30% to 20%

### New Distribution (--limit=60)

```
Total: 60 results
├─ Articles (30%, 18个)
│  ├─ arXiv papers: 9 (15%)
│  └─ Web articles: 9 (15%)
├─ GitHub repos: 30 (50%) ⬆️ increased from 40%
└─ Other web: 12 (20%) ⬇️ decreased from 30%
```

### Comparison

| Source | v2.3.1 (3:4:3) | v2.4.0 (3:5:2) | Change |
|--------|----------------|----------------|--------|
| arXiv papers | 9 (15%) | 9 (15%) | — |
| Web articles | 9 (15%) | 9 (15%) | — |
| **GitHub repos** | **24 (40%)** | **30 (50%)** | **+6 repos** ⬆️ |
| **Other web** | **18 (30%)** | **12 (20%)** | **-6 sources** ⬇️ |
| **Total** | 60 | 60 | — |

**Key change**: +25% more GitHub repos (24 → 30)

---

## Change #2: User-Configurable Ratio (`--ratio=A:G:O`)

### New Flag Syntax

```bash
--ratio=A:G:O
```

Where:
- `A` = Articles ratio (arXiv + web articles combined)
- `G` = GitHub repos ratio
- `O` = Other web sources ratio

**Default**: `--ratio=3:5:2` (if not specified)

### Implementation

```python
import re

# Parse --ratio flag
ratio_match = re.search(r'--ratio=(\d+):(\d+):(\d+)', arguments)
if ratio_match:
    ratio_articles, ratio_github, ratio_other = map(int, ratio_match.groups())
else:
    # Default: 3:5:2
    ratio_articles, ratio_github, ratio_other = 3, 5, 2

# Convert to percentages
total_ratio = ratio_articles + ratio_github + ratio_other
pct_articles = ratio_articles / total_ratio
pct_github = ratio_github / total_ratio
pct_other = ratio_other / total_ratio

# Apply to limit
total_limit = 60  # or user-specified
articles_count = int(total_limit * pct_articles)
github_count = int(total_limit * pct_github)
other_count = int(total_limit * pct_other)

# Articles split equally between arXiv and web
arxiv_count = articles_count // 2
web_article_count = articles_count // 2

print(f"Distribution for --limit={total_limit} --ratio={ratio_articles}:{ratio_github}:{ratio_other}")
print(f"  arXiv: {arxiv_count}")
print(f"  Web articles: {web_article_count}")
print(f"  GitHub: {github_count}")
print(f"  Other web: {other_count}")
print(f"  Total: {arxiv_count + web_article_count + github_count + other_count}")
```

---

## Usage Examples

### Example 1: Default Ratio (3:5:2)

```bash
/web-discovery harness "orchestration"
# Equivalent to:
/web-discovery harness "orchestration" --ratio=3:5:2
```

**Result** (--limit=60):
- arXiv papers: 9 (15%)
- Web articles: 9 (15%)
- GitHub repos: 30 (50%)
- Other web: 12 (20%)

### Example 2: Research-Focused (5:3:2)

```bash
/web-discovery memory "episodic memory" --ratio=5:3:2
```

**Result** (--limit=60):
```
5+3+2 = 10 total ratio units

Articles: 60 × (5/10) = 30 (50%)
  ├─ arXiv: 15
  └─ Web articles: 15

GitHub: 60 × (3/10) = 18 (30%)

Other: 60 × (2/10) = 12 (20%)

Total: 30 + 18 + 12 = 60
```

**Use case**: Academic research, theory-heavy topics

### Example 3: Implementation-Focused (2:6:2)

```bash
/web-discovery skills "tool composition" --ratio=2:6:2
```

**Result** (--limit=60):
```
2+6+2 = 10 total ratio units

Articles: 60 × (2/10) = 12 (20%)
  ├─ arXiv: 6
  └─ Web articles: 6

GitHub: 60 × (6/10) = 36 (60%)

Other: 60 × (2/10) = 12 (20%)

Total: 12 + 36 + 12 = 60
```

**Use case**: Looking for code examples, implementation patterns

### Example 4: Balanced Mix (4:4:2)

```bash
/web-discovery protocols "MCP" --ratio=4:4:2
```

**Result** (--limit=60):
```
4+4+2 = 10 total ratio units

Articles: 60 × (4/10) = 24 (40%)
  ├─ arXiv: 12
  └─ Web articles: 12

GitHub: 60 × (4/10) = 24 (40%)

Other: 60 × (2/10) = 12 (20%)

Total: 24 + 24 + 12 = 60
```

**Use case**: Equal weight on theory and practice

### Example 5: Pure Code Exploration (1:8:1)

```bash
/web-discovery harness "agent runtime" --ratio=1:8:1
```

**Result** (--limit=60):
```
1+8+1 = 10 total ratio units

Articles: 60 × (1/10) = 6 (10%)
  ├─ arXiv: 3
  └─ Web articles: 3

GitHub: 60 × (8/10) = 48 (80%)

Other: 60 × (1/10) = 6 (10%)

Total: 6 + 48 + 6 = 60
```

**Use case**: Exploring implementations, code-first learning

---

## Ratio Presets Reference

| Ratio | Articles | GitHub | Other | Best For |
|-------|----------|--------|-------|----------|
| **3:5:2** | 30% | **50%** | 20% | **Default: code-focused** |
| **5:3:2** | **50%** | 30% | 20% | Academic research |
| **2:6:2** | 20% | **60%** | 20% | Implementation patterns |
| **4:4:2** | 40% | 40% | 20% | Balanced theory+practice |
| **1:8:1** | 10% | **80%** | 10% | Pure code exploration |
| **6:2:2** | **60%** | 20% | 20% | Literature review |
| **3:3:4** | 30% | 30% | **40%** | Tutorials & guides |

---

## Scaling with Different Limits

### --limit=30 --ratio=3:5:2

```
Total: 30 results

Articles: 30 × 0.30 = 9 (30%)
  ├─ arXiv: 4
  └─ Web articles: 4-5

GitHub: 30 × 0.50 = 15 (50%)

Other: 30 × 0.20 = 6 (20%)

Total: 9 + 15 + 6 = 30
```

### --limit=90 --ratio=3:5:2

```
Total: 90 results

Articles: 90 × 0.30 = 27 (30%)
  ├─ arXiv: 13
  └─ Web articles: 13-14

GitHub: 90 × 0.50 = 45 (50%)

Other: 90 × 0.20 = 18 (20%)

Total: 27 + 45 + 18 = 90
```

### --limit=100 --ratio=5:3:2 (research-focused)

```
Total: 100 results

Articles: 100 × 0.50 = 50 (50%)
  ├─ arXiv: 25
  └─ Web articles: 25

GitHub: 100 × 0.30 = 30 (30%)

Other: 100 × 0.20 = 20 (20%)

Total: 50 + 30 + 20 = 100
```

---

## All-Dimensions Mode with Custom Ratio

```bash
/web-discovery "AI coding agents" --all-dimensions --ratio=2:6:2
```

**Execution**:
```
For each dimension (Memory, Skills, Protocols, Harness):
  - Articles: 60 × 0.20 = 12 (arXiv: 6, web: 6)
  - GitHub: 60 × 0.60 = 36
  - Other: 60 × 0.20 = 12
  - Subtotal: 60

Total before dedup: 60 × 4 = 240 results
After dedup: ~180-200 unique results

Final distribution (approximate):
  - Articles: ~40-50 (arXiv + web)
  - GitHub: ~110-120 (60% of total)
  - Other: ~30-40
```

---

## Override Behavior

### Source-Specific Flags Ignore Ratio

```bash
# GitHub-only: 100% GitHub (--ratio ignored)
/web-discovery harness "orchestration" --github --ratio=3:5:2
→ Downloads 60 GitHub repos (100%)

# arXiv-only: 100% arXiv (--ratio ignored)
/web-discovery memory "retrieval" --arxiv --ratio=3:5:2
→ Downloads 60 arXiv papers (100%)
```

### Combined with Other Flags

```bash
# Custom limit + ratio + date
/web-discovery skills "tool use" --limit=90 --ratio=4:4:2 --since=2025-06-01

Result:
  - Articles: 90 × 0.40 = 36 (arXiv: 18, web: 18)
  - GitHub: 90 × 0.40 = 36
  - Other: 90 × 0.20 = 18
  - Date filter: created:>2025-06-01
```

---

## Files Modified

### 1. `.claude/skills/web-discovery/SKILL.md`

**Changes**:
- Version: `2.3.1` → `2.4.0`
- Added `--ratio=A:G:O` flag to Flags section
- Updated default ratio: 3:4:3 → **3:5:2**
- Updated "Source Distribution Target" section with:
  - New default ratio table
  - `--ratio` flag usage examples
  - Implementation pseudocode with ratio parsing
- Updated examples with various ratio use cases

### 2. `web_discovery/skill/references/discovery-workflow.md`

**Changes**:
- Added `--ratio=A:G:O` to flags list
- Updated default behavior: 3:4:3 → **3:5:2**
- Rewrote "Source Distribution Strategy" section:
  - Added ratio parsing logic
  - Added custom ratio examples table
  - Added scaling examples with different ratios
  - Explained override behavior

### 3. `web_discovery/IMPROVEMENTS_V2.4.0.md` (NEW)

**Purpose**: Document ratio change and --ratio flag feature.

---

## Migration Guide

### From v2.3.1 to v2.4.0

**If you relied on v2.3.1's 3:4:3 ratio**:

```bash
# v2.3.1 behavior (3:4:3 = 30%:40%:30%)
/web-discovery harness "orchestration"

# v2.4.0 equivalent (restore old ratio)
/web-discovery harness "orchestration" --ratio=3:4:3

# Results for --limit=60:
# Articles: 18, GitHub: 24, Other: 18
```

**If you're okay with new default (3:5:2)**:

```bash
# v2.4.0 (no changes needed)
/web-discovery harness "orchestration"

# Results for --limit=60:
# Articles: 18, GitHub: 30, Other: 12
```

---

## Validation Tests

### Test 1: Default Ratio (3:5:2)

```bash
/web-discovery harness "orchestration" --limit=60

# Expected distribution:
# - arXiv: 9 (15%)
# - Web articles: 9 (15%)
# - GitHub: 30 (50%)
# - Other: 12 (20%)

# Verify:
ls raw/web/2026-04-17_github_*.md | wc -l
# Should output: ~30 (50% of 60)

ls raw/web/2026-04-17_arxiv_*.md | wc -l
# Should output: ~9 (15% of 60)
```

### Test 2: Custom Ratio (5:3:2)

```bash
/web-discovery memory "episodic" --limit=60 --ratio=5:3:2

# Expected distribution:
# - Articles: 30 (50%)
# - GitHub: 18 (30%)
# - Other: 12 (20%)

# Verify:
total_articles=$(ls raw/web/2026-04-17_arxiv_*.md raw/web/2026-04-17_web_*article*.md 2>/dev/null | wc -l)
echo "Articles: $total_articles"
# Should output: ~30

github_count=$(ls raw/web/2026-04-17_github_*.md | wc -l)
echo "GitHub: $github_count"
# Should output: ~18
```

### Test 3: Ratio with All-Dimensions

```bash
/web-discovery "AI coding" --all-dimensions --ratio=2:6:2

# Expected per dimension (--limit=60):
# - Articles: 12 (20%)
# - GitHub: 36 (60%)
# - Other: 12 (20%)

# Total before dedup: 240
# After dedup: ~180-200

# Verify GitHub dominance:
github_count=$(ls raw/web/2026-04-17_github_*.md | wc -l)
github_pct=$(echo "scale=2; $github_count / 200 * 100" | bc)
echo "GitHub percentage: $github_pct%"
# Should output: ~55-65% (accounting for dedup)
```

---

## Benefits Summary

### For Users

1. **More GitHub repos**: 50% vs 40% (default)
2. **Full customization**: `--ratio` flag for any use case
3. **Preset patterns**: Use proven ratios for common scenarios
4. **Scales perfectly**: Works with any `--limit=N`

### For Different Use Cases

1. **Code learners** (default 3:5:2): 50% GitHub for examples
2. **Researchers** (5:3:2): 50% articles for theory
3. **Implementers** (2:6:2): 60% GitHub for patterns
4. **Balanced users** (4:4:2): Equal theory + practice

### For Quality

1. **Flexible discovery**: Adapt ratio to topic needs
2. **Consistent articles**: Always 30% by default (theory grounding)
3. **Code-focused**: Default 50% GitHub aligns with practical learning
4. **Reduced noise**: Other web reduced to 20% (still useful but not dominant)

---

## Real-World Example: Complete Workflow

```bash
# Step 1: Comprehensive discovery with default ratio
/web-discovery "AI coding agents" --all-dimensions

# Result: ~180-200 unique sources
# - Articles: ~54 (30%): arXiv + web
# - GitHub: ~90-100 (50%): implementations
# - Other: ~36-40 (20%): docs, guides

# Step 2: Deep dive into specific dimension with more code
/web-discovery harness "multi-agent orchestration" --ratio=2:6:2 --limit=90

# Result: 90 sources
# - Articles: 18 (20%)
# - GitHub: 54 (60%): oh-my-claudecode, agents, etc.
# - Other: 18 (20%)

# Step 3: Research-focused follow-up
/web-discovery memory "retrieval mechanisms" --ratio=6:2:2 --limit=50

# Result: 50 sources
# - Articles: 30 (60%): arXiv papers on RAG, memory systems
# - GitHub: 10 (20%): reference implementations
# - Other: 10 (20%): tutorials
```

---

## Summary

v2.4.0 delivers user-requested improvements:

1. ✅ **默认占比 3:5:2**: More GitHub (50%), less Other (20%)
2. ✅ **用户可配置**: `--ratio=A:G:O` flag for full control
3. ✅ **预设模式**: Common ratios for typical use cases

**New default distribution** (--limit=60):
- arXiv: 9 papers (15%)
- Web articles: 9 (15%)
- GitHub repos: **30 (50%)** ⬆️
- Other web: 12 (20%) ⬇️

**Recommended usage**:

```bash
# Default (code-focused)
/web-discovery "AI coding" --all-dimensions

# Research-focused
/web-discovery "memory architectures" --ratio=5:3:2

# Implementation-focused
/web-discovery "orchestration patterns" --ratio=2:6:2
```

**Upgrade path**: All users can migrate seamlessly; old 3:4:3 ratio available via `--ratio=3:4:3` if needed.
