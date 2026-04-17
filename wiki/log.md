---
type: log
---

# Wiki Log

## [2026-04-14] reset | Domain refocus to AI coding systems engineering
- **Old focus**: Evaluation benchmarks, testing methodologies, metrics
- **New focus**: Memory systems, skill frameworks, protocols, harness engineering
- Removed all benchmark-focused content
- Updated CLAUDE.md with new entity types and concept categories
- Ready to ingest sources on Memory, Skills, Protocols, Harness Engineering

## [2026-04-15] ingest | Model Context Protocol (MCP) - Technical Overview
- Source: `raw/web/demo_mcp_article.md`
- Source type: web (article)
- URL: https://www.anthropic.com/mcp-technical-overview
- **Pages created**:
  - Sources: [[MCP Technical Overview]]
  - Entities: [[Model Context Protocol (MCP)]], [[Anthropic]]
  - Concepts: [[Capability-Based Security]]
- **Pages updated**: None
- **Key takeaway**: MCP is an open protocol using capability-based security to standardize AI-data source connections, achieving <50ms latency with stdio transport and 1000+ req/s throughput

## [2026-04-16] ingest | GitHub repositories (batch 2)

### Source 1: MemGPT (Letta)
- Source: `raw/web/2026-04-15_github_cpacker-MemGPT.md`
- Source type: repo (GitHub)
- Organization: Letta AI
- Stars: 22,000 | Language: Python | License: MIT
- Dimension: Memory
- **Pages created**:
  - Sources: [[MemGPT (Letta)]]
  - Entities: [[Letta]], [[Mem0]] (updated)
- **Pages updated**: wiki/index.md
- **Key takeaway**: Stateful agent framework with OS-style memory management through memory blocks. Supports skills and subagents for advanced memory and continual learning. Works with any LLM.

### Source 2: Mem0 - Universal Memory Layer for LLM Applications
- Source: `raw/web/2026-04-15_github_mem0ai-mem0.md`
- Source type: repo (GitHub)
- Organization: Mem0 AI (YC S24)
- Stars: 48,000 | Language: Python | License: Apache 2.0
- Paper: arXiv:2504.19413
- Dimension: Memory
- **Pages created**:
  - Sources: [[Mem0 - Universal Memory Layer]]
  - Entities: [[Mem0]] (updated)
- **Pages updated**: wiki/index.md
- **Key takeaway**: Production-ready memory layer implementing context-with-retrieval architecture. Hybrid search (semantic + BM25 + entity) achieves +26% accuracy over OpenAI Memory, 91% faster responses, 90% token reduction on LOCOMO benchmark. Multi-level memory (user/session/agent) with simple API and multiple storage backends.

### Source 3: AutoGen (Microsoft)
- Source: `raw/web/2026-04-15_github_microsoft-autogen.md`
- Source type: repo (GitHub)
- Organization: Microsoft
- Stars: 52,000 | Language: Python | License: MIT
- Dimension: Harness
- Status: Maintenance Mode (successor: Microsoft Agent Framework)
- **Pages created**:
  - Sources: [[AutoGen (Microsoft)]]
  - Entities: [[AutoGen]] (updated)
- **Pages updated**: wiki/index.md
- **Key takeaway**: Framework for creating multi-agent AI applications. Now in maintenance mode with community management. Successor is Microsoft Agent Framework with enterprise-grade support.

### Source 4: Voyager (MineDojo)
- Source: `raw/web/2026-04-15_github_minedojo-voyager.md`
- Source type: repo (GitHub)
- Paper: arXiv:2305.16291
- Stars: 15,000+ | Language: Python | License: MIT
- Dimension: Harness
- **Pages created**:
  - Sources: [[Voyager (MineDojo)]]
  - Entities: [[Voyager]]
- **Pages updated**: wiki/index.md
- **Key takeaway**: LLM-powered embodied lifelong learning agent in Minecraft with automatic curriculum, skill library, and iterative prompting. 3.3x more items, 2.3x longer distances than baselines.

### Source 5: MCP TypeScript SDK
- Source: `raw/web/2026-04-15_github_modelcontextprotocol-typescript-sdk.md`
- Source type: repo (GitHub)
- Organization: Model Context Protocol
- Stars: 3,000 | Language: TypeScript | License: MIT/Apache 2.0
- Dimension: Protocols
- **Pages created**:
  - Sources: [[MCP TypeScript SDK]]
  - Entities: [[Model Context Protocol (MCP)]] (updated)
- **Pages updated**: wiki/index.md
- **Key takeaway**: Official MCP SDK implementation in TypeScript. v2 in development, v1.x recommended for production. Includes server, client, and middleware packages.

### Source 6: OpenHands
- Source: `raw/web/2026-04-15_github_openhands-openhands.md`
- Source type: repo (GitHub)
- Organization: OpenHands
- Stars: 71.2K | Language: Python/TypeScript | License: MIT
- Paper: arXiv:2511.03690
- Dimension: Harness
- **Pages created**:
  - Sources: [[OpenHands]]
  - Entities: [[OpenHands]]
- **Pages updated**: wiki/index.md
- **Key takeaway**: AI-driven development framework with SDK, CLI, Local GUI, and Cloud deployment. Integrations with Slack, Jira, Linear. Multi-user support and RBAC.

### Source 7: SWE-agent
- Source: `raw/web/2026-04-15_github_princeton-nlp-swe-agent.md`
- Source type: repo (GitHub)
- Paper: arXiv:2405.15793
- Stars: 19,000 | Language: Python | License: MIT
- Dimension: Harness
- **Pages created**:
  - Sources: [[SWE-agent]]
  - Entities: [[SWE-agent]]
- **Pages updated**: wiki/index.md
- **Key takeaway**: Automated software engineering agent that fixes GitHub issues. State of the art on SWE-bench among open-source projects. Successor: mini-swe-agent.

### Source 8: AutoGPT
- Source: `raw/web/2026-04-15_github_significantgravitas-autogpt.md`
- Source type: repo (GitHub)
- Stars: 100,000+ | Language: Python | License: MIT
- Dimension: Harness
- **Pages created**:
  - Sources: [[AutoGPT]]
  - Entities: [[AutoGPT]]
- **Pages updated**: wiki/index.md
- **Key takeaway**: Experimental open-source autonomous AI agent built on LangChain. Inspired many downstream implementations. Foundational project in AI agent space.

### Source 9: CrewAI
- Source: `raw/web/2026-04-15_github_joaomdmoura-crewai.md`
- Source type: repo (GitHub)
- Organization: crewAI Inc
- Stars: 48.9K | Language: Python | License: MIT
- Dimension: Harness
- **Pages created**:
  - Sources: [[CrewAI]]
  - Entities: [[CrewAI]]
- **Pages updated**: wiki/index.md
- **Key takeaway**: Lean, lightning-fast Python framework for multi-agent orchestration. Built from scratch independent of LangChain. Features Crews (autonomous collaboration) and Flows (event-driven workflows). 100,000+ certified developers.

### Source 10: LangGraph
- Source: `raw/web/2026-04-15_github_langchain-ai-langgraph.md`
- Source type: repo (GitHub)
- Organization: LangChain
- Stars: 9,000 | Language: Python | License: MIT
- Dimension: Harness
- **Pages created**:
  - Sources: [[LangGraph]]
  - Entities: [[LangGraph]]
- **Pages updated**: wiki/index.md
- **Key takeaway**: Low-level orchestration framework for building stateful agents. Features durable execution, human-in-the-loop, comprehensive memory. Built on Pregel, Apache Beam, and NetworkX concepts.

### Source 11: LangGraph Multi-Agent Swarm
- Source: `raw/web/2026-04-15_github_langchain-ai-langgraph-swarm-py.md`
- Source type: repo (GitHub)
- Organization: LangChain
- Stars: 1.5K | Language: Python | License: MIT
- Dimension: Harness
- **Pages created**:
  - Sources: [[LangGraph Multi-Agent Swarm]]
  - Entities: [[LangGraph Swarm]] (new)
- **Pages updated**: wiki/index.md
- **Key takeaway**: Python library for creating swarm-style multi-agent systems using LangGraph. Agents dynamically hand off control based on specializations. Built on LangGraph with streaming, memory, and human-in-the-loop support.

### Source 12: Mem0 Documentation
- Source: `raw/web/2026-04-15_mem0-docs.md`
- Source type: doc
- Website: https://mem0.ai
- Dimension: Memory
- **Pages created**:
  - Sources: [[Mem0 Documentation]]
- **Pages updated**: wiki/index.md
- **Key takeaway**: Universal memory layer documentation for LLM applications. Platform with managed infrastructure and open source self-hosted option.

### Source 13: Voyager Project Website
- Source: `raw/web/2026-04-15_voyager-project-website.md`
- Source type: doc
- Website: https://voyager.minedojo.org/
- Paper: arXiv:2305.16291
- Dimension: Harness
- **Pages created**:
  - Sources: [[Voyager Project Website]]
- **Pages updated**: wiki/index.md
- **Key takeaway**: Voyager project documentation for LLM-powered embodied lifelong learning agent in Minecraft.

### Source 14: Hacker News Discussion
- Source: `raw/web/2026-04-15_hn-memgpt-discussion.md`
- Source type: web
- Dimension: Harness
- **Pages created**:
  - Sources: [[Hacker News Discussion - GPU Computing]]
- **Pages updated**: wiki/index.md
- **Key takeaway**: Community discussion about GPU computing and hardware acceleration.

**Total Sources Ingested**: 14
**Total Pages Created**: 14 source pages
**Total Entities Created**: 10 new/updated entities (Letta, Mem0, AutoGen, Voyager, MCP, OpenHands, SWE-agent, AutoGPT, CrewAI, LangGraph, LangGraph Swarm)
