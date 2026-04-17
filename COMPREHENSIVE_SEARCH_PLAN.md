# Comprehensive Search Plan — All Four Dimensions

**Goal**: Build a complete knowledge base by searching arXiv papers, GitHub repos, official blogs, technical docs, and news across Memory, Skills, Protocols, and Harness dimensions.

**Date**: 2026-04-15

---

## 🎯 Search Strategy

For each dimension, we search **5 source types**:

1. **arXiv papers** — Novel methods, architectures, theoretical frameworks
2. **GitHub repos** — Implementations, frameworks, libraries
3. **Official blogs** — Anthropic, OpenAI, Microsoft, Google engineering posts
4. **Technical docs** — Specifications, API references, tutorials
5. **Tech news** — InfoQ, The New Stack, Hacker News discussions

**Target per dimension**: 
- 5-8 arXiv papers
- 3-5 GitHub repos
- 2-3 official blogs
- 1-2 technical docs/specs
- 1-2 news/discussion articles

**Total target**: 50-80 sources across all dimensions

---

## 📦 1. MEMORY DIMENSION

### arXiv Papers (5-8)
```
1. "SSGM Framework" - Stability and Safety Governed Memory
2. "A-Mem" - Agentic Memory with Zettelkasten
3. "A-MAC" - Adaptive Memory Admission Control
4. "Memory Management Impact" - Empirical study
5. "Privacy Risks in Agent Memory"
6. "Hierarchical Memory for LLM Agents"
7. "RAG architecture optimization"
```

### GitHub Repos (3-5)
```
Search queries:
- site:github.com MemGPT
- site:github.com MemoryBank
- site:github.com Mem0
- site:github.com "agent memory" Python stars:>100
- site:github.com "RAG framework" agent

Expected repos:
1. cpacker/MemGPT - OS-style memory management
2. mem0ai/mem0 - Hierarchical memory with lifecycle ops
3. MemoryBank - Multi-tiered memory system
4. LangChain memory modules
5. Chroma/Pinecone agent integrations
```

### Official Blogs (2-3)
```
Search queries:
- site:anthropic.com memory agent
- site:openai.com memory GPT
- site:microsoft.com agent memory architecture
- site:deepmind.google.com memory LLM

Expected articles:
1. Anthropic: "How Claude manages memory across sessions"
2. OpenAI: "Memory in ChatGPT" technical overview
3. Microsoft: "Agent memory patterns in production"
```

### Technical Docs (1-2)
```
Search queries:
- "vector database" agent memory documentation
- "RAG" retrieval augmented generation guide
- LangChain memory documentation

Expected docs:
1. Pinecone/Weaviate agent memory integration guide
2. LlamaIndex memory architecture docs
```

### Tech News/Discussions (1-2)
```
Search queries:
- site:news.ycombinator.com "agent memory"
- site:infoq.com "LLM memory architecture"
- site:thenewstack.io "agent state management"

Expected articles:
1. "The Evolution of LLM Agent Memory" - InfoQ
2. HN discussion on MemGPT architecture
```

---

## 🛠️ 2. SKILLS DIMENSION

### arXiv Papers (5-8)
```
1. "Agent Skills for LLMs" - Architecture, acquisition, security
2. "SoK: Agentic Skills" - Beyond tool use
3. "Voyager" - Lifelong skill learning
4. "Toolformer" - Self-taught tool use
5. "XSkill" - Continual learning from experience
6. "Skill composition patterns"
7. "Progressive disclosure in agent skills"
```

### GitHub Repos (3-5)
```
Search queries:
- site:github.com Voyager MinecraftAgent
- site:github.com Toolformer
- site:github.com "agent skills" framework
- site:github.com "tool orchestration" stars:>100
- site:github.com AutoGPT plugins

Expected repos:
1. MineDojo/Voyager - Skill acquisition in Minecraft
2. google-research/toolformer - Tool use learning
3. Significant-Gravitas/AutoGPT - Plugin/skill system
4. agent-skill-registry repos
5. LangChain Tools and Toolkits
```

### Official Blogs (2-3)
```
Search queries:
- site:anthropic.com skills tools MCP
- site:openai.com function calling agents
- site:microsoft.com semantic kernel skills
- "Claude Code skills" technical overview

Expected articles:
1. Anthropic: "Building skills for Claude Code"
2. OpenAI: "Function calling best practices"
3. Microsoft: "Semantic Kernel skills architecture"
```

### Technical Docs (1-2)
```
Search queries:
- "function calling" API documentation
- MCP tools specification
- LangChain tools documentation

Expected docs:
1. OpenAI Function Calling API reference
2. Anthropic Tool Use documentation
3. LangChain Tools & Toolkits guide
```

### Tech News/Discussions (1-2)
```
Search queries:
- site:infoq.com "agent tools" OR "agent skills"
- site:thenewstack.io "tool use" LLM
- HN "Voyager" OR "Toolformer"

Expected articles:
1. "The Rise of Agent Skill Systems" - InfoQ
2. "From Function Calling to Skills" - The New Stack
```

---

## 🔌 3. PROTOCOLS DIMENSION

### arXiv Papers (5-8)
```
1. "Agent Interoperability Survey" - MCP/ACP/A2A/ANP
2. "MCP Production Patterns" - Deployment at scale
3. "MCP Security" - Landscape and threats
4. "MCP-DPT" - Defense taxonomy
5. "MCP Enhancement" - Context-aware server
6. "Agent-tool protocol design"
7. "Schema validation for agents"
```

### GitHub Repos (3-5)
```
Search queries:
- site:github.com modelcontextprotocol
- site:github.com MCP server
- site:github.com "agent protocol" specification
- site:github.com LSP "language server protocol" AI
- site:github.com "tool schema" agent

Expected repos:
1. modelcontextprotocol/typescript-sdk - Official MCP SDK
2. modelcontextprotocol/servers - MCP server implementations
3. anthropics/anthropic-mcp-examples
4. LSP client/server for AI agents
5. Agent communication protocol implementations
```

### Official Blogs (2-3)
```
Search queries:
- site:anthropic.com "Model Context Protocol"
- site:microsoft.com "Language Server Protocol" AI
- "MCP announcement" OR "MCP launch"
- OpenAPI for agents

Expected articles:
1. Anthropic: "Introducing Model Context Protocol" ⭐
2. Microsoft: "LSP for AI Coding Assistants"
3. "Building MCP Servers" - Official guide
```

### Technical Docs (1-2)
```
Search queries:
- "Model Context Protocol specification"
- "MCP SDK documentation"
- LSP specification AI integration

Expected docs:
1. MCP Specification (modelcontextprotocol.io) ⭐⭐
2. LSP Specification (microsoft.github.io/language-server-protocol)
3. OpenAPI 3.x for agent tools
```

### Tech News/Discussions (1-2)
```
Search queries:
- site:news.ycombinator.com "Model Context Protocol"
- site:infoq.com MCP OR "agent protocol"
- "MCP adoption" OR "MCP ecosystem"

Expected articles:
1. HN: "Model Context Protocol Discussion"
2. "MCP: A New Standard for AI Agents" - Tech news
```

---

## ⚙️ 4. HARNESS DIMENSION

### arXiv Papers (5-8)
```
1. "Meta-Harness" - End-to-end optimization ⭐⭐
2. "NLAH" - Natural-language agent harnesses
3. "Building AI Coding Agents for Terminal"
4. "Multi-Agent Harness Generation"
5. "Agent Developer Practices" - Empirical study
6. "Agent loop design patterns"
7. "Sandboxing strategies for agents"
```

### GitHub Repos (3-5)
```
Search queries:
- site:github.com AutoGen microsoft
- site:github.com LangGraph langgraph
- site:github.com CrewAI
- site:github.com OpenHands
- site:github.com "agent runtime" OR "agent harness"
- site:github.com SWE-agent

Expected repos:
1. microsoft/autogen - Multi-agent framework ⭐
2. langchain-ai/langgraph - Agent orchestration ⭐
3. joaomdmoura/crewAI - Role-based agents
4. OpenHands/OpenHands - Coding agent platform
5. princeton-nlp/SWE-agent - Terminal agent harness
6. agent-runtime implementations
```

### Official Blogs (2-3)
```
Search queries:
- site:openai.com "Codex" harness OR runtime
- site:anthropic.com "Claude Code" architecture
- site:microsoft.com AutoGen OR "agent framework"
- LangGraph architecture blog

Expected articles:
1. OpenAI: "How Codex Works" - Harness engineering
2. Anthropic: "Claude Code Architecture Deep Dive"
3. Microsoft: "Building Multi-Agent Systems with AutoGen"
4. LangChain: "Introducing LangGraph"
```

### Technical Docs (1-2)
```
Search queries:
- AutoGen documentation architecture
- LangGraph documentation
- OpenHands developer guide
- "agent orchestration" framework docs

Expected docs:
1. AutoGen Documentation - Architecture section
2. LangGraph Conceptual Guide
3. OpenHands Developer Docs
```

### Tech News/Discussions (1-2)
```
Search queries:
- site:news.ycombinator.com AutoGen OR LangGraph
- site:infoq.com "agent orchestration"
- "agent runtime" trends

Expected articles:
1. HN: "AutoGen: Multi-Agent Framework Discussion"
2. "The State of Agent Orchestration in 2026" - InfoQ
```

---

## 🚀 EXECUTION PLAN

### Phase 1: Core Papers (Day 1)
Download priority ⭐⭐ and ⭐ arXiv papers across all dimensions (20-25 papers)

### Phase 2: GitHub Repos (Day 1-2)
Clone/fetch README + architecture docs from 12-20 key repos

### Phase 3: Official Content (Day 2)
Download official blogs, specs, and documentation (10-15 sources)

### Phase 4: Community Content (Day 2-3)
Fetch tech news, HN discussions, tutorials (5-10 sources)

### Phase 5: Ingest & Organize (Day 3)
Run `/wiki-ingest raw/web/` to create entities, concepts, and syntheses

---

## 📊 EXPECTED OUTPUT

**Total sources**: 50-80 across all categories

**Breakdown by type**:
- arXiv papers: 20-30
- GitHub repos: 12-20
- Official blogs: 8-12
- Technical docs: 4-8
- Tech news: 5-10

**Breakdown by dimension**:
- Memory: 12-20 sources
- Skills: 12-20 sources
- Protocols: 12-20 sources
- Harness: 12-20 sources

**Expected wiki entities** (after ingest):
- Memory systems: 5-8 (MemGPT, Mem0, A-Mem, etc.)
- Skill frameworks: 5-8 (Voyager, Toolformer, AutoGPT plugins, etc.)
- Protocols: 3-5 (MCP, LSP, custom protocols)
- Harnesses: 5-8 (Meta-Harness, AutoGen, LangGraph, etc.)
- Organizations: 10-15 (Anthropic, OpenAI, Microsoft, etc.)
- People: 30-50 (paper authors, framework creators)

**Expected wiki concepts**: 20-30
- Memory architectures, retrieval strategies
- Skill acquisition methods, composition patterns
- Protocol design principles
- Harness dimensions, loop patterns

---

## 🔍 SEARCH QUERIES SUMMARY

### By Source Type

**arXiv**:
```
site:arxiv.org "LLM agent memory" architecture 2025..2026
site:arxiv.org "tool use" OR "skill composition" agent 2025..2026
site:arxiv.org "Model Context Protocol" OR MCP 2025..2026
site:arxiv.org "Meta-Harness" OR "agent harness" 2025..2026
```

**GitHub**:
```
site:github.com MemGPT OR Mem0 OR MemoryBank
site:github.com Voyager OR Toolformer OR AutoGPT
site:github.com "Model Context Protocol" OR MCP
site:github.com AutoGen OR LangGraph OR CrewAI
```

**Official Blogs**:
```
site:anthropic.com memory OR skills OR MCP OR "Claude Code"
site:openai.com memory OR "function calling" OR Codex
site:microsoft.com AutoGen OR "Semantic Kernel"
```

**Technical Docs**:
```
"Model Context Protocol specification"
"AutoGen documentation"
"LangGraph documentation"
"vector database" agent integration
```

**Tech News**:
```
site:news.ycombinator.com "agent memory" OR AutoGen OR MCP
site:infoq.com "LLM agent" OR "agent orchestration"
site:thenewstack.io "AI agent" architecture
```

---

## 📝 BATCH SEARCH COMMANDS

Execute these searches in sequence (or parallel if you want speed):

```bash
# Memory dimension - all sources
websearch "site:arxiv.org LLM agent memory 2025..2026"
websearch "site:github.com MemGPT OR Mem0"
websearch "site:anthropic.com OR site:openai.com agent memory"
websearch "vector database agent memory documentation"

# Skills dimension - all sources
websearch "site:arxiv.org agent skills tool use 2025..2026"
websearch "site:github.com Voyager OR Toolformer"
websearch "site:anthropic.com skills tools OR site:openai.com function calling"
websearch "function calling API documentation"

# Protocols dimension - all sources
websearch "site:arxiv.org Model Context Protocol 2025..2026"
websearch "site:github.com modelcontextprotocol"
websearch "site:anthropic.com Model Context Protocol"
websearch "MCP specification modelcontextprotocol.io"

# Harness dimension - all sources
websearch "site:arxiv.org Meta-Harness agent harness 2025..2026"
websearch "site:github.com AutoGen OR LangGraph OR CrewAI"
websearch "site:microsoft.com AutoGen OR site:anthropic.com Claude Code"
websearch "AutoGen documentation architecture"
```

---

**Status**: Ready to execute comprehensive search  
**Next step**: Begin Phase 1 (Core Papers) or execute all in parallel?
