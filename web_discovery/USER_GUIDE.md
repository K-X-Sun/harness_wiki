# Web Discovery Skill - User Guide

**Version**: v2.4.0  
**Last Updated**: 2026-04-17

---

## Quick Start

```bash
/web-discovery "AI coding agents" --all-dimensions
```

**Result**: ~180-200 resources across 4 dimensions, takes ~11 minutes

---

## Syntax

```bash
/web-discovery [dimension] <topic> [flags]
```

---

## Flags

### `--all-dimensions`
Search all 4 dimensions (Memory, Skills, Protocols, Harness).

```bash
/web-discovery "orchestration" --all-dimensions
```

---

### `--limit=N`
Results per dimension. **Default: 60**

```bash
--limit=10   # Quick preview
--limit=100  # Deep dive
```

---

### `--since=YYYY-MM-DD`
Date filter. **Default: 2026-01-01**

```bash
--since=2025-01-01  # Include 2025
--since=2026-02-15  # Last 2 months only
```

---

### `--ratio=A:G:O`
Source distribution (Articles : GitHub : Other). **Default: 3:5:2**

| Ratio | Articles | GitHub | Other | Use Case |
|-------|----------|--------|-------|----------|
| `3:5:2` | 30% | **50%** | 20% | Code-focused (default) |
| `5:3:2` | **50%** | 30% | 20% | Research-focused |
| `2:6:2` | 20% | **60%** | 20% | Implementation-focused |
| `4:4:2` | 40% | 40% | 20% | Balanced |

**Examples**:
```bash
# Research-focused
/web-discovery memory "retrieval" --ratio=5:3:2

# Code-heavy
/web-discovery harness "orchestration" --ratio=2:6:2
```

---

### `--arxiv`
arXiv only (100%). Ignores `--ratio`.

```bash
/web-discovery memory "episodic memory" --arxiv
```

---

### `--github`
GitHub only (100%). Ignores `--ratio`.

```bash
/web-discovery harness "multi-agent" --github
```

---

## Common Examples

### 1. Quick Preview
```bash
/web-discovery harness "agent loop" --limit=10
```
Result: 10 resources, ~1 minute

---

### 2. Comprehensive Discovery
```bash
/web-discovery "AI coding agents" --all-dimensions
```
Result: ~180-200 resources, ~11 minutes

---

### 3. Academic Research
```bash
/web-discovery memory "RAG" --ratio=6:2:2 --limit=80
```
Result: 60% articles, 20% GitHub, 20% other

---

### 4. Code Learning
```bash
/web-discovery harness "orchestration" --ratio=2:6:2
```
Result: 60% GitHub repos

---

### 5. Recent Trends
```bash
/web-discovery harness "runtime" --since=2026-02-15
```
Result: Last 2 months only

---

### 6. Include 2025
```bash
/web-discovery "externalization" --all-dimensions --since=2025-01-01
```
Result: 2025-2026 content

---

## FAQ

**Q: Why `--all-dimensions` vs 4 separate searches?**  
A: Auto-deduplication, global ranking, saves time.

**Q: What does `--limit=60` mean in `--all-dimensions`?**  
A: 60 per dimension = 240 total → ~180-200 after dedup.

**Q: Can I use `--ratio` with `--arxiv`?**  
A: No. `--arxiv` or `--github` overrides `--ratio` (100% single source).

**Q: Where are files saved?**  
A: `raw/web/YYYY-MM-DD_source_name.md`

**Q: How long does it take?**  
A: Single dimension ~2-5 min, all dimensions ~11 min (with GitHub token).

---

## Quick Reference

### Most Common Commands

```bash
# Comprehensive (recommended)
/web-discovery "AI coding agents" --all-dimensions

# Quick preview
/web-discovery harness "orchestration" --limit=10

# Custom ratio
/web-discovery memory "retrieval" --ratio=5:3:2
```

---

### Parameter Summary

| Flag | Default | Description |
|------|---------|-------------|
| `--all-dimensions` | OFF | All 4 dimensions |
| `--limit=N` | 60 | Per dimension |
| `--since=DATE` | 2026-01-01 | Date filter |
| `--ratio=A:G:O` | 3:5:2 | 30%:50%:20% |
| `--arxiv` | OFF | arXiv only |
| `--github` | OFF | GitHub only |
| `--all` | **ON** | All sources (default) |

---

### Decision Tree

```
What do you need?
├─ Quick look → --limit=10
├─ Full survey → --all-dimensions
├─ Theory → --ratio=5:3:2
├─ Code → --ratio=2:6:2
├─ Recent → --since=2026-02-01
└─ Include 2025 → --since=2025-01-01
```

---

**Version**: v2.4.0
