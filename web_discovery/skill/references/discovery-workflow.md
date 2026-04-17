# Discovery Workflow — Externalization Engineering

Procedure for `/web-discovery <dimension> <topic>` focused on Memory, Skills, Protocols, and Harness Engineering.

**Core principle**: Find novel methods and engineering practices. Avoid benchmarks and evaluation papers.

## Search Strategy v2.1 — Multi-Keyword Coverage

**Problem identified**: Single-keyword searches (e.g., "harness engineering") miss high-star recent repos that use different terminology.

**Example**: `Yeachan-Heo/oh-my-claudecode` (29k stars, 2026-01-09)
- Description: "Teams-first Multi-agent orchestration for Claude Code"
- Topics: `claude-code`, `multi-agent-systems`, `agentic-coding`
- **Does NOT contain**: "harness" or "harness engineering"
- **Would be found by**: "multi-agent orchestration", "claude-code teams", "teams-first"

**Solution**: Multi-dimensional search matrix
- **50+ queries per dimension** covering functionality, frameworks, patterns, and time filters
- **3-way sorting** for each query: stars, updated, created
- **Priority scoring**: `temporal_tier - (star_growth_rate / 100)`
- **Deduplication**: by repo full_name before priority sorting

**Result**: Repos using ANY related terminology (orchestration, multi-agent, teams, automation, workflow, harness) will be found and prioritized by recency + star growth.

## Pre-check

1. Ensure dimension directories exist:
   ```bash
   mkdir -p raw/{memory,skills,protocols,harness}/assets
   ```

2. For cross-cutting searches (no dimension specified), use `raw/web/`:
   ```bash
   mkdir -p raw/web/assets
   ```

---

## Special Mode: All-Dimensions Search

When `--all-dimensions` flag is detected:

### Execution Flow

```
User input: /web-discovery "AI coding agents" --all-dimensions --limit=30
                                                ↓
                          Parse and detect --all-dimensions flag
                                                ↓
                          ┌─────────────────────────────────────┐
                          │ Execute 4 dimension searches        │
                          ├─────────────────────────────────────┤
                          │ 1. Memory dimension (15 queries)    │
                          │    → Collect up to 30 results       │
                          │ 2. Skills dimension (18 queries)    │
                          │    → Collect up to 30 results       │
                          │ 3. Protocols dimension (18 queries) │
                          │    → Collect up to 30 results       │
                          │ 4. Harness dimension (50 queries)   │
                          │    → Collect up to 30 results       │
                          └─────────────────────────────────────┘
                                                ↓
                          Deduplicate by repo full_name
                          (total unique: ~80-100 repos)
                                                ↓
                          Calculate priority scores for all
                          (temporal_tier - star_growth_rate/100)
                                                ↓
                          Sort by priority (lower = better)
                                                ↓
                          Download top 30 × 4 = 120 results
                          (or use --limit=N to control)
                                                ↓
                          Save to raw/web/ with dimension tags
```

### Key Differences from Single-Dimension Mode

| Aspect | Single Dimension | All-Dimensions Mode |
|--------|------------------|---------------------|
| Queries executed | 15-50 (one dimension) | 101 total (15+18+18+50) |
| API calls | 45-150 | ~300 (101 queries × 3 sorts) |
| Results collected | --limit=N | --limit=N per dimension → N×4 total |
| Deduplication | Within dimension | Across all dimensions |
| Priority scoring | Within dimension | Global across all dimensions |
| Download location | `raw/web/` | `raw/web/` (with dimension tag) |

### Implementation Notes

1. **Limit behavior**: `--limit=30` means "30 per dimension", yielding ~120 total before dedup
2. **Deduplication**: Cross-dimension dedup happens AFTER collecting from all dimensions
3. **Priority scoring**: Calculated globally across all results, not per-dimension
4. **Frontmatter**: Each file gets a `dimension` field (memory/skills/protocols/harness)
5. **Execution time**: ~20-30 minutes (300 API calls at 30/min with auth token)

### Example Execution

```bash
# User command
/web-discovery "AI coding agents" --all-dimensions --limit=25

# Internal execution
Search memory dimension: 15 queries × 3 sorts → 45 calls → collect top 25
Search skills dimension: 18 queries × 3 sorts → 54 calls → collect top 25
Search protocols dimension: 18 queries × 3 sorts → 54 calls → collect top 25
Search harness dimension: 50 queries × 3 sorts → 150 calls → collect top 25

# Results before dedup: ~100 repos (25×4)
# Results after dedup: ~75-85 unique repos
# Apply global priority scoring
# Download top 75-85 to raw/web/

# Output files:
raw/web/2026-04-17_github_anthropics-mem0.md (dimension: memory)
raw/web/2026-04-17_github_modelcontextprotocol-servers.md (dimension: protocols)
raw/web/2026-04-17_github_Yeachan-Heo-oh-my-claudecode.md (dimension: harness)
...
```

---

## Steps

### 1. Parse search intent

Read `$ARGUMENTS[0..]`. Detect dimension and topic:

```
/web-discovery memory "episodic memory LLM"
               ↑       ↑
          dimension   topic
```

**Dimension detection** (case-insensitive):
- `memory` → Memory dimension queries
- `skills` → Skills dimension queries
- `protocols` → Protocols dimension queries
- `harness` → Harness dimension queries
- `--all-dimensions` flag present → Execute all four dimensions sequentially
- (none) → Cross-cutting search

**Flags**:
- `--arxiv`           → arXiv only (overrides default --all)
- `--github`          → GitHub only (overrides default --all)
- `--all`             → Web + arXiv + GitHub **[DEFAULT - no flag needed]**
- `--all-dimensions`  → Search all four dimensions (Memory + Skills + Protocols + Harness)
- `--limit=N`         → Max results per dimension (default: 60 for all modes)
- `--since=YYYY-MM-DD` → Only include results created/published after this date (default: 2026-01-01)

**Default behavior** (no flags specified):
- Sources: Web + arXiv + GitHub (same as --all)
- Limit: 60 per dimension
- Source distribution: Articles:GitHub:Other = 3:4:3 (~18:24:18 results)
- Date filter: created/published since 2026-01-01

**Special handling for `--all-dimensions`**:
When `--all-dimensions` flag is present:
1. Ignore any dimension keyword in arguments
2. Execute searches for all four dimensions sequentially
3. Apply `--limit=N` to EACH dimension (total results = N × 4)
4. Collect results from all dimensions into a single priority-sorted list
5. Save all results to `raw/web/` with dimension tag in frontmatter

Strip flags. If topic is empty after removing dimension/flags, use dimension-specific default topic.

### Date Filter Processing

Extract `--since=YYYY-MM-DD` from arguments:

```python
# Parse --since flag
import re
since_match = re.search(r'--since=(\d{4}-\d{2}-\d{2})', arguments)
if since_match:
    since_date = since_match.group(1)
else:
    since_date = "2026-01-01"  # Default

# Apply to GitHub queries
# Replace all instances of "created:>YYYY-MM-DD" in queries with user-specified date
queries = [q.replace("created:>2026-01-01", f"created:>{since_date}") 
           for q in base_queries]
queries = [q.replace("created:>2025-12-01", f"created:>{since_date}") 
           for q in queries]

# For arXiv queries (use in temporal tier calculation)
# When calculating priority scores, use since_date as reference for temporal_tier:
# - created after since_date + 45 days → tier 1 (very recent)
# - created in same year as since_date → tier 2
# - created year before since_date → tier 3
# - older → tier 4
```

**Examples**:
```bash
# Default: 2026-01-01
/web-discovery harness "orchestration"
→ searches: created:>2026-01-01

# Custom: 2025-06-01
/web-discovery harness "orchestration" --since=2025-06-01
→ searches: created:>2025-06-01

# Recent 2 months only
/web-discovery memory "episodic" --since=2026-02-15
→ searches: created:>2026-02-15
```

### 2. Build dimension-specific search queries

Generate 15-20 targeted queries based on detected dimension.

**IMPORTANT**: Replace all date filters in queries with user-specified `--since` date:
- Default: `created:>2026-01-01`
- User specifies `--since=2025-06-01`: Replace with `created:>2025-06-01`
- User specifies `--since=2026-02-15`: Replace with `created:>2026-02-15`

**Implementation**:
```python
# After parsing --since flag
for query in all_queries:
    query = query.replace("created:>2026-01-01", f"created:>{since_date}")
    query = query.replace("created:>2025-12-01", f"created:>{since_date}")
```

### Source Distribution Strategy

**Target ratio**: Articles : GitHub : Other = **3 : 4 : 3**

For default `--limit=60`:

| Source Type | Target % | Target Count | Description |
|-------------|----------|--------------|-------------|
| **arXiv Papers** | 15% | ~9 | Academic papers from arXiv.org |
| **Web Articles** | 15% | ~9 | Blog posts, technical articles |
| **GitHub Repos** | 40% | ~24 | Open-source repositories |
| **Web Other** | 30% | ~18 | Docs, news, guides, tutorials |
| **Total** | 100% | **60** | Balanced mix |

**Execution strategy**:

```python
total_limit = 60  # default, or user-specified via --limit

# Calculate per-source sub-limits
arxiv_limit = int(total_limit * 0.15)       # ~9
web_article_limit = int(total_limit * 0.15) # ~9
github_limit = int(total_limit * 0.40)      # ~24
web_other_limit = int(total_limit * 0.30)   # ~18

# Execute searches with priority scoring within each source
arxiv_results = search_arxiv(queries, limit=arxiv_limit)
github_results = search_github(queries, limit=github_limit)
web_article_results = search_web(queries, type='article', limit=web_article_limit)
web_other_results = search_web(queries, type='other', limit=web_other_limit)

# Combine and deduplicate
all_results = arxiv_results + github_results + web_article_results + web_other_results
unique_results = deduplicate_by_url(all_results)

# Final priority scoring (if needed to meet exact limit)
sorted_results = sort_by_priority(unique_results)
final_results = sorted_results[:total_limit]
```

**Override behavior**:
- `--arxiv` flag: 100% arXiv papers (ignores ratio)
- `--github` flag: 100% GitHub repos (ignores ratio)
- Custom `--limit=N`: Ratio maintained, scales proportionally

**Example with --limit=30**:
- arXiv: 30 × 0.15 = ~5 papers
- GitHub: 30 × 0.40 = ~12 repos
- Web articles: 30 × 0.15 = ~4 articles
- Web other: 30 × 0.30 = ~9 other sources

---

#### 📦 **Memory Dimension Queries**

**Note**: Dates shown below are placeholders. Replace with user's `--since` value before execution.

**arXiv queries** (when --all, --arxiv, or no flag):
1. `site:arxiv.org "LLM agent memory" architecture`
2. `site:arxiv.org "episodic memory" agent retrieval`
3. `site:arxiv.org "semantic memory" LLM knowledge`
4. `site:arxiv.org "working memory" context window`
5. `site:arxiv.org "personalized memory" agent user`
6. `site:arxiv.org "retrieval augmented generation" RAG`
7. `site:arxiv.org "memory consolidation" agent`
8. `site:arxiv.org "hierarchical memory" LLM`
9. `site:arxiv.org "forgetting mechanism" agent`
10. `site:arxiv.org "context management" LLM`

**GitHub queries** (when --all, --github, or no flag):
1. `site:github.com "agent memory" architecture`
2. `site:github.com MemGPT OR MemoryBank OR Mem0`
3. `site:github.com "memory system" LLM agent`
4. `site:github.com "RAG" agent framework`
5. `site:github.com "context window" management`
6. `site:github.com "episodic memory" agent`
7. `site:github.com "vector database" agent memory`
8. `site:github.com "knowledge graph" LLM memory`
9. `site:github.com "persistent memory" claude-code created:>2026-01-01`
10. `site:github.com "session memory" agent created:>2026-01-01`
11. `site:github.com "memory management" LLM created:>2026-01-01`
12. `site:github.com "context compression" agent created:>2026-01-01`
13. `site:github.com "memory retrieval" framework created:>2026-01-01`
14. `site:github.com letta memgpt mem0 created:>2025-12-01`
15. `site:github.com "working memory" agent orchestration`

**Web queries** (always run unless --github only):
1. `"LLM agent memory" architecture design`
2. `"retrieval augmented generation" implementation`
3. `"context window management" strategies`
4. `"episodic memory" vs "semantic memory" agent`
5. `MemGPT architecture technical details`
6. `Mem0 memory lifecycle operations`

---

#### 🛠️ **Skills Dimension Queries**

**arXiv queries**:
1. `site:arxiv.org "tool use" LLM agent framework`
2. `site:arxiv.org "skill acquisition" agent learning`
3. `site:arxiv.org "skill composition" agent`
4. `site:arxiv.org "procedural knowledge" LLM`
5. `site:arxiv.org "function calling" agent architecture`
6. `site:arxiv.org "tool discovery" agent`
7. `site:arxiv.org "capability package" agent`
8. `site:arxiv.org "skill distillation" trajectory`
9. `site:arxiv.org "workflow externalization" agent`
10. `site:arxiv.org "SOP" agent "standard operating procedure"`

**GitHub queries**:
1. `site:github.com "skill system" agent framework`
2. `site:github.com "tool use" LLM agent`
3. `site:github.com "function calling" framework`
4. `site:github.com "agent skills" composition`
5. `site:github.com "tool orchestration" agent`
6. `site:github.com Toolformer OR ToolLLM`
7. `site:github.com "skill registry" agent`
8. `site:github.com "progressive disclosure" skills`
9. `site:github.com "agent skills" claude-code created:>2026-01-01`
10. `site:github.com superpowers obra skills created:>2025-12-01`
11. `site:github.com "skill learning" agent created:>2026-01-01`
12. `site:github.com "tool composition" framework created:>2026-01-01`
13. `site:github.com "capability system" agent created:>2026-01-01`
14. `site:github.com "skill extraction" agent created:>2026-01-01`
15. `site:github.com "reusable skills" agent framework`
16. `site:github.com "skill marketplace" agent`
17. `site:github.com "agent capabilities" composition`
18. `site:github.com "procedural knowledge" agent created:>2026-01-01`

**Web queries**:
1. `"tool use framework" LLM agent design`
2. `"skill composition patterns" agent`
3. `"function calling" agent architecture`
4. `"procedural expertise" externalization`
5. `Toolformer architecture implementation`
6. `"skill acquisition" agent systems`

---

#### 🔌 **Protocols Dimension Queries**

**arXiv queries**:
1. `site:arxiv.org "agent protocol" communication`
2. `site:arxiv.org "agent-tool" protocol design`
3. `site:arxiv.org "agent-agent" coordination protocol`
4. `site:arxiv.org "tool invocation" protocol agent`
5. `site:arxiv.org "capability discovery" protocol`
6. `site:arxiv.org "schema validation" agent tool`
7. `site:arxiv.org "lifecycle management" agent session`
8. `site:arxiv.org "multi-agent" communication protocol`

**GitHub queries**:
1. `site:github.com "Model Context Protocol" MCP`
2. `site:github.com "Language Server Protocol" LSP agent`
3. `site:github.com "agent protocol" specification`
4. `site:github.com "tool schema" agent framework`
5. `site:github.com "agent communication" protocol`
6. `site:github.com MCP server implementation`
7. `site:github.com "agent-tool" interface`
8. `site:github.com "capability-based security" agent`
9. `site:github.com "MCP server" created:>2026-01-01`
10. `site:github.com "agent protocol" specification created:>2026-01-01`
11. `site:github.com "tool invocation protocol" created:>2026-01-01`
12. `site:github.com "agent-agent protocol" created:>2026-01-01`
13. `site:github.com "protocol specification" agent communication`
14. `site:github.com anthropic MCP server created:>2025-12-01`
15. `site:github.com "schema validation" protocol created:>2026-01-01`
16. `site:github.com "capability discovery" protocol`
17. `site:github.com "session protocol" agent`
18. `site:github.com "coordination protocol" multi-agent`

**Web queries**:
1. `"Model Context Protocol" MCP specification`
2. `"Language Server Protocol" AI agent integration`
3. `"agent-tool protocol" design principles`
4. `"agent communication" standardization`
5. `Anthropic MCP technical overview`
6. `"tool invocation" protocol design`
7. `"schema validation" agent tools`

---

#### ⚙️ **Harness Dimension Queries**

**arXiv queries**:
1. `site:arxiv.org "agent harness" architecture`
2. `site:arxiv.org "agent loop" design control flow`
3. `site:arxiv.org "sandbox" agent execution`
4. `site:arxiv.org "agent runtime" architecture`
5. `site:arxiv.org "observability" LLM agent`
6. `site:arxiv.org "execution isolation" agent`
7. `site:arxiv.org "context budget" management agent`
8. `site:arxiv.org "agent orchestration" framework`
9. `site:arxiv.org "approval gates" agent oversight`
10. `site:arxiv.org "Meta-Harness" OR "harness engineering"`

**GitHub queries** (multi-dimensional: catch repos using different terminology):

**Core harness functionality (1-8)**:
1. `site:github.com "agent harness" runtime`
2. `site:github.com "agent loop" framework`
3. `site:github.com AutoGen OR LangGraph OR CrewAI`
4. `site:github.com "agent sandbox" execution`
5. `site:github.com "agent observability" logging`
6. `site:github.com "permission system" agent`
7. `site:github.com "agent orchestration" framework`
8. `site:github.com OpenHands OR SWE-agent architecture`

**Multi-agent orchestration (9-18)** - captures oh-my-claudecode style repos:
9. `site:github.com "multi-agent orchestration" claude-code`
10. `site:github.com "multi-agent" claude code created:>2026-01-01`
11. `site:github.com "teams-first" multi-agent`
12. `site:github.com "agent teams" workflow`
13. `site:github.com "team orchestration" claude created:>2026-01-01`
14. `site:github.com "agent coordination" framework created:>2026-01-01`
15. `site:github.com "parallel agents" execution`
16. `site:github.com "agent swarm" orchestration`
17. `site:github.com "distributed agents" system`
18. `site:github.com "agent workflow" automation`

**Specific frameworks & patterns (19-28)** - named repos:
19. `site:github.com oh-my-claudecode OR oh-my-codex OR oh-my-opencode`
20. `site:github.com superpowers agent skills`
21. `site:github.com everything-claude-code`
22. `site:github.com ralph ultrawork autoresearch`
23. `site:github.com autopilot agent autonomous`
24. `site:github.com deep-interview agent clarification`
25. `site:github.com agent-deck terminal manager`
26. `site:github.com citadel worktree agent`
27. `site:github.com harbor evaluation harness`
28. `site:github.com terminal-bench coding agent`

**Framework-specific orchestration (29-38)** - recent high-growth:
29. `site:github.com claude-code orchestration created:>2026-01-01`
30. `site:github.com claude-code plugin created:>2026-01-01`
31. `site:github.com codex orchestration created:>2026-01-01`
32. `site:github.com opencode orchestration created:>2026-01-01`
33. `site:github.com gemini-cli orchestration created:>2026-01-01`
34. `site:github.com cursor agent orchestration`
35. `site:github.com aider agent orchestration`
36. `site:github.com cline agent orchestration`
37. `site:github.com windsurf agent orchestration`
38. `site:github.com "AI coding agent" orchestration created:>2026-01-01`

**Runtime & infrastructure (39-50)** - harness components:
39. `site:github.com "agent runtime" framework created:>2026-01-01`
40. `site:github.com "agent sdk" orchestration created:>2026-01-01`
41. `site:github.com "session management" agent created:>2026-01-01`
42. `site:github.com "context management" agent runtime`
43. `site:github.com "agent loop" design created:>2026-01-01`
44. `site:github.com "approval gates" agent oversight`
45. `site:github.com "agent hooks" system`
46. `site:github.com "agent lifecycle" management`
47. `site:github.com "agent state" persistence`
48. `site:github.com "tmux agent" orchestration`
49. `site:github.com "background agents" execution`
50. `site:github.com "agent monitoring" observability created:>2026-01-01`

**NOTE**: Query execution strategy:
- Run each query with 3 sorts: stars, updated, created (if has created: filter)
- Deduplicate by repo full_name
- Calculate priority: temporal_tier - (star_growth_rate / 100)
- Sort by priority score (ascending = higher priority)
- This ensures oh-my-claudecode (multi-agent orchestration) is found via queries 9-18 even if missing from "harness" queries

**Web queries** (multi-keyword combinations for recent content):

**Core harness engineering (1-8)**:
1. `"agent harness" engineering architecture 2026`
2. `"agent loop" design patterns 2026`
3. `"sandboxing" agent execution isolation 2026`
4. `"agent runtime" architecture design 2026`
5. `AutoGen framework architecture 2026`
6. `LangGraph orchestration design 2026`
7. `"agent observability" best practices 2026`
8. `"context budget management" strategies 2026`

**Multi-agent orchestration (9-18)** - oh-my-claudecode style:
9. `"multi-agent orchestration" claude code 2026`
10. `"teams-first multi-agent" 2026`
11. `"agent teams" workflow coordination 2026`
12. `"team orchestration" claude code 2026`
13. `"parallel agent execution" 2026`
14. `"distributed agent system" 2026`
15. `"agent swarm" coordination 2026`
16. `"agent coordination framework" 2026`
17. `"multi-agent collaboration" 2026`
18. `"agent workflow automation" 2026`

**Specific tools & frameworks (19-30)**:
19. `"oh my claudecode" orchestration 2026`
20. `"oh my codex" multi-agent 2026`
21. `"everything claude code" harness 2026`
22. `"superpowers" agent skills 2026`
23. `"ralph ultrawork" agent 2026`
24. `"autopilot agent" autonomous 2026`
25. `"deep interview" agent clarification 2026`
26. `"agent deck" terminal manager 2026`
27. `"harbor" agent evaluation 2026`
28. `"terminal bench" coding agent 2026`
29. `"citadel" agent worktree 2026`
30. `"harness evolver" meta-harness 2026`

**Framework-specific (31-42)**:
31. `"claude code" plugin orchestration 2026`
32. `"claude code" marketplace 2026`
33. `"codex" plugin orchestration 2026`
34. `"opencode" agent orchestration 2026`
35. `"gemini cli" orchestration 2026`
36. `"cursor" agent orchestration 2026`
37. `"aider" agent orchestration 2026`
38. `"cline" agent orchestration 2026`
39. `"windsurf" agent orchestration 2026`
40. `"anthropic claude code" plugin 2026`
41. `"openai codex" plugin 2026`
42. `"google gemini" cli agent 2026`

**Runtime & infrastructure (43-50)**:
43. `"agent sdk" orchestration 2026`
44. `"agent runtime" framework 2026`
45. `"session management" LLM agent 2026`
46. `"agent hooks" system 2026`
47. `"agent lifecycle" management 2026`
48. `"tmux agent" orchestration 2026`
49. `"agent monitoring" observability 2026`
50. `"agent state" persistence 2026`

---

#### 🔀 **Cross-cutting Queries** (when no dimension specified)

**arXiv queries**:
1. `site:arxiv.org "externalization" LLM agent`
2. `site:arxiv.org "cognitive artifact" agent design`
3. `site:arxiv.org "agent infrastructure" architecture`
4. `site:arxiv.org "distributed cognition" LLM`
5. `site:arxiv.org "agent engineering" best practices`

**GitHub queries**:
1. `site:github.com "AI agent" framework architecture`
2. `site:github.com "LLM agent" infrastructure`
3. `site:github.com "agent system" engineering`

**Web queries**:
1. `"LLM agent" engineering architecture`
2. `"AI agent" infrastructure design`
3. `"agent externalization" cognitive artifact`

---

### 3. Execute web searches

For each query, use `web_search(query="<query>")`.

Collect into deduplicated list:
```
results = [
  { url, title, snippet, source },  # source = "web" | "arxiv" | "github"
  ...
]
```

Deduplicate by normalized URL (strip `www.`, trailing `/`, `http://`→`https://`).

---

### 4. Filter and prioritize (UPDATED with temporal sorting)

**Quality filters aligned with externalization focus:**

**KEEP** if matches at least ONE:
- ✅ **Memory**: architecture type (monolithic/retrieval/hierarchical/adaptive), content types (episodic/semantic/working/personalized), retrieval methods
- ✅ **Skills**: acquisition methods (authored/distilled/discovered/composed), composition patterns, activation pipeline, tool use frameworks
- ✅ **Protocols**: MCP, LSP, agent-tool/agent-agent/agent-user protocols, schema validation, lifecycle management
- ✅ **Harness**: six dimensions (loop/sandbox/oversight/observability/config/context-budget), runtime architecture
- ✅ **Cognitive artifact analysis**: how externalization transforms tasks (recall→recognition, generation→composition, ad-hoc→governed)
- ✅ **Primary source**: arXiv paper (2024-2026), GitHub repo with implementation, official technical documentation

**DROP** if matches ANY:
- ❌ **Benchmark/Evaluation focus**: SWE-Bench, HumanEval, MBPP, pass@k, solve rate, accuracy metrics
- ❌ **Pure evaluation methodology**: testing procedures, benchmark design (unless harness-related)
- ❌ **Performance comparison without architecture**: "Model X beats Model Y on benchmark Z"
- ❌ Social media, YouTube, paywalled content, SEO spam
- ❌ Duplicate of existing `raw/web/` content

**Special case**: Papers that mention benchmarks are OK IF they focus on harness architecture, memory systems, skill frameworks, or protocols. Example: "Meta-Harness" uses benchmarks to validate harness design — keep it because it's about harness engineering.

---

#### **NEW: Temporal Prioritization Strategy**

After quality filtering, **sort results by temporal priority** before downloading:

**Priority tiers** (download in this order):

1. **🔥 Recent & Hot** (download FIRST):
   - arXiv papers from **last 2 months** (Feb 2026 onwards for current date April 2026)
   - GitHub repos with **commits in last 8 weeks fast star growth** OR **100+ stars gained in last 2 months** 
   - Articles/docs published **in last 2 months**
   - **Rationale**: Captures emerging trends, latest methods, active development

2. **📈 Recent** (download SECOND):
   - arXiv papers from **2026** (this year, older than 2 months)
   - GitHub repos with **last commit in 2026**
   - Articles/docs from **2026**
   - **Rationale**: Recent but not bleeding-edge, likely stable and validated

3. **📚 Classic** (download THIRD):
   - arXiv papers from **2025** (last year)
   - GitHub repos with **1000+ stars** OR **last commit in 2025**
   - Seminal papers frequently cited in recent work
   - **Rationale**: Recent foundational work, well-established patterns

4. **🗂️ Foundational** (download LAST):
   - Papers **before 2025** (2024 and earlier - only if highly relevant)
   - Archived repos (no commits in 2025-2026, unless 5000+ stars)
   - **Rationale**: Historical context, only if no better recent source exists

**Implementation**:

Extract temporal signals from each result:

- **arXiv**: Parse paper ID (e.g., `2603.28052` = March 2026, `2504.19413` = April 2025)
- **GitHub**: Check snippet for "Updated X days/weeks/months ago" or last commit date
- **Articles**: Check publication date in metadata or snippet

Sort filtered results:
```python
def temporal_priority(result):
    date = extract_date(result)  # Returns datetime object
    year = date.year
    month = date.month
    current_year = 2026
    current_month = 4
    
    # Tier 1: Last 2 months (Feb 2026 onwards)
    if year == current_year and month >= current_month - 1:
        return 1  # Recent & Hot
    
    # Tier 2: This year (2026), older than 2 months
    elif year == current_year:
        return 2  # Recent
    
    # Tier 3: Last year (2025)
    elif year == current_year - 1:
        return 3  # Classic
    
    # Tier 4: Before 2025 (2024 and earlier)
    else:
        return 4  # Foundational

results_sorted = sorted(results_filtered, key=temporal_priority)
```

**Special boosting**:
- GitHub repos with **10+ commits in last month**: treat as tier 1 (even if repo is older)
- arXiv papers with **20+ citations in last 3 months**: boost to tier 2
- Papers explicitly labeled "survey", "review", "unified framework": boost by 1 tier (foundational → classic)

---

Present filtered AND sorted list:

```markdown
## Search Results — <Dimension> Dimension

**Topic:** <topic>
**Dimension:** <dimension>
**Queries executed:** N
**Raw results:** X → Y (after filtering) → Y (temporally sorted)

### 🔥 Recent & Hot (last 2 months: Feb 2026+)
| # | Source | Date | Title | URL |
|---|--------|------|-------|-----|
| 1 | arxiv  | 2026-04 | ... | ... |
| 2 | github | 2026-03 | ... | ... |

### 📈 Recent (2026, older than 2 months)
| # | Source | Date | Title | URL |
|---|--------|------|-------|-----|
| 3 | arxiv  | 2026-01 | ... | ... |

### 📚 Classic (2025)
| # | Source | Date | Title | URL |
|---|--------|------|-------|-----|
| 4 | arxiv  | 2025-08 | ... | ... |

### 🗂️ Foundational (before 2025)
| # | Source | Date | Title | URL |
|---|--------|------|-------|-----|
| 5 | arxiv  | 2024-06 | ... | ... |
```

**Download order**: Tier 1 (Recent & Hot) → Tier 2 (Recent) → Tier 3 (Classic) → Tier 4 (Foundational)

If `--limit=10` is set and there are 15 results, download **first 10 from sorted list** (prioritizing recent/hot).

Auto-proceed to download in temporal priority order.

---

### 5. Download content as markdown

**CRITICAL**: Preserve content verbatim. NO summarization, NO "Relevance" sections.

**Directory structure**:
- `raw/memory/` - Memory dimension sources
- `raw/skills/` - Skills dimension sources  
- `raw/protocols/` - Protocols dimension sources
- `raw/harness/` - Harness dimension sources
- `raw/web/` - Cross-cutting sources (no specific dimension)

#### 5a. arXiv papers — FULL TEXT as Markdown

**Step 1**: Fetch HTML version and convert to markdown:
```
web_fetch(
  url="https://arxiv.org/html/<paper-id>v1",
  prompt="Convert this arXiv paper to clean markdown format. 

REQUIREMENTS:
1. Include ALL sections verbatim: title, authors, abstract, introduction, method, experiments, results, discussion, conclusion, references
2. Convert all math equations to LaTeX syntax ($inline$ and $$display$$)
3. Preserve all tables as markdown tables
4. Include figure captions with [Figure N: caption text]
5. Keep all citations and references
6. Do NOT add summaries, do NOT add commentary
7. Output ONLY the markdown content, no preamble

Format the output as clean, readable markdown."
)
```

**Step 2**: Determine dimension from search context (memory/skills/protocols/harness)

**Step 3**: Save to `raw/<dimension>/YYYY-MM-DD_arxiv_<paper-id>_<slug>.md`:

```yaml
---
title: "Paper Title"
source_url: "https://arxiv.org/abs/<paper-id>"
source_type: paper
fetched: 2026-04-15
authors: ["Author 1", "Author 2"]
categories: ["cs.AI", "cs.SE"]
dimension: memory  # or skills, protocols, harness
---

[Full paper text verbatim]
```

**Fallback options** (in order):
1. Try `https://ar5iv.labs.arxiv.org/html/<paper-id>` (ar5iv mirror with better HTML)
2. Try PDF extraction: `https://arxiv.org/pdf/<paper-id>.pdf` (requires pdf2md conversion)
3. Use abstract page: `https://arxiv.org/abs/<paper-id>` (last resort - abstract only)

#### 5b. GitHub repos — Full README as Markdown

**Step 1**: Fetch README content:
```
web_fetch(
  url="https://raw.githubusercontent.com/owner/repo/main/README.md",
  prompt="Return the complete README.md content verbatim as markdown. Do NOT summarize, do NOT add commentary. Output ONLY the original markdown."
)
```

Fallback branches to try: `main` → `master` → `develop`

**Step 2**: Fetch metadata from repo page:
```
web_fetch(
  url="https://github.com/owner/repo",
  prompt="Extract repository metadata and return as YAML:
stars: <count>
forks: <count>  
language: <primary language>
license: <license type>
description: <repo description>

Return ONLY the YAML, no extra text."
)
```

**Step 3**: Determine dimension from search context

**Step 4**: Save to `raw/<dimension>/YYYY-MM-DD_github_<owner>-<repo>.md`:

```yaml
---
title: "owner/repo"
source_url: "https://github.com/owner/repo"
source_type: repo
fetched: 2026-04-15
stars: 1234
language: Python
description: "..."
dimension: harness  # based on content
---

[Full README verbatim]
```

#### 5c. Articles / Docs — Full Text as Markdown

**Step 1**: Fetch and convert to markdown:
```
web_fetch(
  url="https://example.com/article",
  prompt="Convert this webpage to clean markdown format.

REQUIREMENTS:
1. Include complete article content: title, all headings, all paragraphs, all code blocks, all tables
2. Preserve code blocks with proper language tags
3. Convert HTML tables to markdown tables
4. Keep all links as [text](url)
5. Exclude navigation, sidebar, ads, footer, comments
6. Do NOT summarize, do NOT add commentary
7. Output ONLY the markdown content

Format as clean, readable markdown."
)
```

**Step 2**: Determine dimension from search context

**Step 3**: Save to `raw/<dimension>/YYYY-MM-DD_<slug>.md`:

```yaml
---
title: "Article Title"
source_url: "https://..."
source_type: article | documentation | blog
fetched: 2026-04-15
author: "Author Name"
domain: "example.com"
dimension: protocols  # based on content
---

[Full article verbatim]
```

---

### 6. Save to dimension-specific directory

**Directory routing by dimension**:
- Memory dimension → `raw/memory/`
- Skills dimension → `raw/skills/`
- Protocols dimension → `raw/protocols/`
- Harness dimension → `raw/harness/`
- Cross-cutting / unknown → `raw/web/`

**Naming convention**: `YYYY-MM-DD_[source_]slug.md`
- Prefixes: `arxiv_<paper-id>_`, `github_<owner-repo>_`, (none for web articles)
- Slug: kebab-case from title, max 50 chars, `[a-z0-9-]` only
- Uniqueness: append `-2`, `-3` if file exists in target directory

**Example paths**:
```
raw/memory/2026-04-15_arxiv_2603_11768_ssgm-framework.md
raw/skills/2026-04-15_arxiv_2602_12430_agent-skills-llm.md
raw/protocols/2026-04-15_github_modelcontextprotocol-servers.md
raw/harness/2026-04-15_arxiv_2603_28052_meta-harness.md
```

**Frontmatter requirements** (all files):
```yaml
---
title: "Full Title"
source_url: "https://..."
source_type: paper | repo | article | documentation | blog
fetched: YYYY-MM-DD
dimension: memory | skills | protocols | harness  # REQUIRED
# Additional fields based on source type:
authors: [...]          # papers
categories: [...]       # arxiv papers
stars: N               # GitHub repos
language: "..."        # GitHub repos
---
```

Follow detailed conventions in [raw-web-conventions.md](raw-web-conventions.md).

---

### 7. Generate discovery report

```markdown
## Discovery Report — <Dimension> Dimension

**Topic:** <topic>
**Dimension:** <dimension>
**Date:** 2026-04-15
**Queries executed:** N
**Results:** X (raw) → Y (filtered) → Z (downloaded)

### Downloaded Files by Directory

#### raw/memory/ (N files)
| # | Type | Title | File | Size |
|---|------|-------|------|------|
| 1 | paper | SSGM Framework | `2026-04-15_arxiv_2603_11768_ssgm.md` | 45KB |

#### raw/skills/ (N files)
| # | Type | Title | File | Size |
|---|------|-------|------|------|
| 1 | paper | Agent Skills for LLMs | `2026-04-15_arxiv_2602_12430_agent-skills.md` | 52KB |

#### raw/protocols/ (N files)
| # | Type | Title | File | Size |
|---|------|-------|------|------|
| 1 | repo | MCP Servers | `2026-04-15_github_mcp-servers.md` | 18KB |

#### raw/harness/ (N files)
| # | Type | Title | File | Size |
|---|------|-------|------|------|
| 1 | paper | Meta-Harness | `2026-04-15_arxiv_2603_28052_meta-harness.md` | 67KB |

### Skipped / Failed

| # | Reason | URL |
|---|--------|-----|
| 1 | Benchmark-focused | arxiv.org/abs/... |
| 2 | Timeout | ... |

### Next Steps

Run `/wiki-ingest raw/web/` to process all downloaded sources.

**Expected entities**: Based on content, expect to create/update:
- Memory: <list entity types>
- Skills: <list entity types>
- Protocols: <list entity types>
- Harness: <list entity types>
```

---

### 8. Optional: auto-ingest

If user says "ingest" or "add to wiki", run:
```
/wiki-ingest raw/web/
```

This creates source summaries, updates entity/concept pages per CLAUDE.md taxonomy.

---

## Error Handling

| Error | Behavior |
|-------|----------|
| `web_fetch` timeout | Log as "Failed — timeout", continue |
| Paywall / auth required | Log as "Skipped — authentication required" |
| Empty extraction (< 100 chars) | Log as "Skipped — insufficient content" |
| Duplicate file | Log as "Skipped — duplicate" |
| 429 rate limit | Wait 10s, retry once, then skip |

---

## Dimension-Specific Filtering Examples

**Memory dimension** — KEEP:
- "MemGPT: Towards LLMs as Operating Systems" ✅
- "Hierarchical Memory Management for LLM Agents" ✅
- "Adaptive Retrieval Strategies for RAG" ✅

**Memory dimension** — DROP:
- "Evaluating Memory Systems on SWE-Bench" ❌ (benchmark focus)
- "Memory Benchmark for LLMs" ❌ (evaluation methodology)

**Skills dimension** — KEEP:
- "Tool Use Framework for LLM Agents" ✅
- "Skill Composition Patterns" ✅
- "Voyager: Open-Ended Skill Acquisition" ✅

**Skills dimension** — DROP:
- "Benchmarking Tool Use Capabilities" ❌
- "Tool Use Performance on HumanEval" ❌

**Protocols dimension** — KEEP:
- "Model Context Protocol Specification" ✅
- "Agent Communication Protocols" ✅
- "Schema Validation for Tool Invocation" ✅

**Harness dimension** — KEEP:
- "Meta-Harness: End-to-End Optimization" ✅
- "Agent Loop Design Patterns" ✅
- "Sandboxing Strategies for LLM Agents" ✅

**Harness dimension** — DROP:
- "Evaluating Agent Performance on SWE-Bench" ❌
- "Benchmark Harness Design" ❌ (unless it's about harness engineering itself)
