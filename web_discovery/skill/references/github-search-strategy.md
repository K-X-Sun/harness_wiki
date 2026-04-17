# GitHub Search Strategy for Harness Engineering

## Problem: 漏掉高星近期repo

**案例**: `Yeachan-Heo/oh-my-claudecode` (29k stars, created 2026-01-09)
- **Description**: "Teams-first Multi-agent orchestration for Claude Code"
- **Topics**: claude-code, multi-agent-systems, agentic-coding, automation
- **关键问题**: 不包含 "harness" 或 "harness engineering"

## Root Cause Analysis

1. **单一关键词依赖**：只用 `harness engineering` 搜索会漏掉用其他术语的repo
2. **术语多样性**：同一功能有多种描述方式：
   - harness engineering
   - orchestration
   - multi-agent
   - automation
   - workflow
   - runtime
   - agent framework
3. **分页限制**：GitHub API默认只返回前100个结果
4. **排序策略**：只按stars排序会漏掉新repo

## Improved Search Strategy

### 1. Multi-Dimensional Keyword Matrix

**核心功能维度** × **框架名维度** × **时间维度**

#### 核心功能关键词（至少用3个组合）
- `orchestration`
- `multi-agent`
- `agent-runtime`
- `agent-loop`
- `automation`
- `workflow`
- `harness`
- `teams`
- `coordination`

#### 框架名关键词
- `claude-code` / `claude code`
- `codex`
- `opencode`
- `gemini-cli`
- `cursor`
- `aider`
- `cline`

#### 时间过滤器
- `created:>2026-01-01` - 今年新创建
- `created:>2025-12-01` - 最近4个月
- `updated:>2026-03-01` - 最近更新

### 2. Multi-Sort Strategy

**对每个查询，执行3次不同排序**：

```bash
# Round 1: 按stars排序（找高星repo）
q=claude-code+multi-agent&sort=stars&order=desc&per_page=100

# Round 2: 按更新时间排序（找活跃repo）
q=claude-code+multi-agent&sort=updated&order=desc&per_page=100

# Round 3: 按创建时间排序（找新repo）
q=claude-code+multi-agent created:>2026-01-01&sort=created&order=desc&per_page=100
```

### 3. Star Growth Detection

对于新repo（created < 3个月），计算star增长率：
```
star_growth_rate = stars / days_since_created
```

**阈值**：
- 高增长：> 100 stars/day
- 中增长：> 20 stars/day
- 稳定：> 5 stars/day

### 4. Comprehensive Query List for Harness Dimension

#### Tier 1: 直接功能搜索（20个查询）

```
1. claude-code multi-agent orchestration
2. claude-code teams workflow
3. claude-code automation framework
4. codex orchestration multi-agent
5. opencode agent runtime
6. gemini-cli orchestration
7. multi-agent coordination claude
8. agent teams claude-code
9. autonomous coding agents
10. agent workflow orchestration
11. claude-code plugin orchestration
12. codex plugin multi-agent
13. agent runtime framework
14. multi-agent automation
15. teams-first orchestration
16. agent coordination framework
17. parallel agent execution
18. agent pipeline orchestration
19. distributed agent system
20. agent swarm orchestration
```

#### Tier 2: 框架+harness组合（10个查询）

```
21. claude-code harness
22. codex harness engineering
23. opencode agent harness
24. gemini-cli harness
25. cursor agent harness
26. aider harness
27. claude-code runtime harness
28. codex runtime harness
29. agent harness framework
30. harness engineering ai coding
```

#### Tier 3: 特定模式搜索（10个查询）

```
31. oh-my-claudecode
32. oh-my-codex
33. oh-my-opencode
34. ralph ultrawork (oh-my-claudecode keywords)
35. autopilot agent orchestration
36. deep-interview agent
37. skill system agent
38. agent sdk orchestration
39. session management agent
40. tmux agent orchestration
```

#### Tier 4: 时间+增长搜索（10个查询）

```
41. multi-agent created:>2026-01-01 sort:stars
42. claude-code created:>2026-01-01 sort:stars
43. orchestration created:>2025-12-01 sort:stars
44. agent-runtime created:>2026-01-01 sort:updated
45. harness engineering created:>2025-12-01
46. multi-agent updated:>2026-03-01 sort:stars
47. claude-code updated:>2026-03-01 sort:stars
48. teams orchestration created:>2026-01-01
49. agent coordination created:>2026-01-01
50. workflow automation created:>2026-01-01
```

### 5. Deduplication Strategy

**After gathering results**:
1. 按 repo full_name 去重
2. 按 temporal priority 排序（见下）
3. 按 star_growth_rate 二级排序

### 6. Temporal Priority + Star Growth Hybrid

```python
def calculate_priority_score(repo):
    stars = repo['stargazers_count']
    created = parse_date(repo['created_at'])
    updated = parse_date(repo['updated_at'])
    
    days_since_created = (now - created).days
    days_since_updated = (now - updated).days
    
    # Star growth rate
    if days_since_created > 0:
        star_growth = stars / days_since_created
    else:
        star_growth = stars
    
    # Temporal priority (1-4)
    if created > date('2026-02-15'):  # Last 2 months
        temporal_tier = 1
    elif created.year == 2026:
        temporal_tier = 2
    elif created.year == 2025:
        temporal_tier = 3
    else:
        temporal_tier = 4
    
    # Combine: lower tier number = higher priority
    # Higher star_growth = higher priority
    priority_score = temporal_tier - (star_growth / 100)
    
    return priority_score

# Sort: lower score = higher priority
repos_sorted = sorted(repos, key=calculate_priority_score)
```

### 7. Implementation in Workflow

```yaml
# Step 1: Generate 50 queries (Tier 1-4)
queries = generate_harness_queries()

# Step 2: For each query, run 3 sorts
for query in queries:
    results += github_search(q=query, sort='stars', order='desc', per_page=100)
    results += github_search(q=query, sort='updated', order='desc', per_page=100)
    if 'created:>' in query:
        results += github_search(q=query, sort='created', order='desc', per_page=100)

# Step 3: Deduplicate
unique_repos = deduplicate_by_fullname(results)

# Step 4: Calculate priority scores
for repo in unique_repos:
    repo['priority_score'] = calculate_priority_score(repo)

# Step 5: Sort by priority
sorted_repos = sorted(unique_repos, key=lambda r: r['priority_score'])

# Step 6: Download top N (respecting limit)
download_repos(sorted_repos[:limit])
```

## Expected Results

使用这个策略，`oh-my-claudecode` 会在这些查询中被找到：
- `claude-code multi-agent orchestration` (Tier 1, Query 1)
- `claude-code teams workflow` (Tier 1, Query 2)
- `teams-first orchestration` (Tier 1, Query 15)
- `oh-my-claudecode` (Tier 3, Query 31)
- `multi-agent created:>2026-01-01 sort:stars` (Tier 4, Query 41)
- `claude-code created:>2026-01-01 sort:stars` (Tier 4, Query 42)

即使在 "harness engineering" 查询中找不到，也会通过其他6+个查询找到。

## Performance Considerations

- **Total queries**: 50 × 3 sorts = 150 API calls
- **Rate limit**: GitHub API allows 10 requests/minute (unauthenticated)
- **Estimated time**: 15 minutes for full discovery
- **Optimization**: 并行执行 + 使用GitHub token提升rate limit
