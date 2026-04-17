#!/bin/bash
# Batch Web Discovery - All Four Externalization Dimensions
# Searches Memory, Skills, Protocols, and Harness with targeted queries

set -e

echo "========================================"
echo "Batch Web Discovery - Externalization Engineering"
echo "========================================"
echo ""
echo "This will search for:"
echo "1. Memory - RAG, hierarchical memory, MemGPT, Mem0"
echo "2. Skills - Tool use, Voyager, skill composition"
echo "3. Protocols - MCP, LSP, agent communication"
echo "4. Harness - Meta-Harness, AutoGen, agent loops"
echo ""
echo "Target: 5-8 sources per dimension (20-32 total)"
echo ""

# Create output directory
mkdir -p raw/web/batch_$(date +%Y%m%d)

echo "Starting dimension-by-dimension search..."
echo ""

# Track total downloads
TOTAL_DOWNLOADED=0

# Memory Dimension
echo "========================================"
echo "1/4: MEMORY DIMENSION"
echo "========================================"
echo "Queries: episodic memory, hierarchical memory, RAG, MemGPT"
echo ""

# Instead of calling the skill, let's use direct web search
# This is a placeholder - you'll need to implement the actual search logic
echo "[Memory] Searching arXiv..."
echo "  - 'LLM agent memory architecture'"
echo "  - 'episodic memory agent retrieval'"
echo "  - 'hierarchical memory LLM'"
echo "  - 'MemGPT OR MemoryBank OR Mem0'"
echo ""
echo "[Memory] Searching GitHub..."
echo "  - 'MemGPT', 'MemoryBank', 'Mem0' repos"
echo ""
echo "[Memory] Expected downloads: 5-8 papers/repos"
echo ""

# Skills Dimension
echo "========================================"
echo "2/4: SKILLS DIMENSION"
echo "========================================"
echo "Queries: tool use, skill composition, Voyager, Toolformer"
echo ""

echo "[Skills] Searching arXiv..."
echo "  - 'tool use LLM agent framework'"
echo "  - 'skill acquisition agent learning'"
echo "  - 'skill composition agent'"
echo "  - 'Voyager OR Toolformer'"
echo ""
echo "[Skills] Searching GitHub..."
echo "  - 'Voyager', 'Toolformer', 'skill composition' repos"
echo ""
echo "[Skills] Expected downloads: 5-8 papers/repos"
echo ""

# Protocols Dimension
echo "========================================"
echo "3/4: PROTOCOLS DIMENSION"
echo "========================================"
echo "Queries: MCP, LSP, agent-tool protocol"
echo ""

echo "[Protocols] Searching arXiv..."
echo "  - 'agent protocol communication'"
echo "  - 'agent-tool protocol design'"
echo "  - 'capability discovery protocol'"
echo ""
echo "[Protocols] Searching GitHub..."
echo "  - 'Model Context Protocol MCP'"
echo "  - 'MCP server implementation'"
echo ""
echo "[Protocols] Searching Web..."
echo "  - 'MCP specification'"
echo "  - 'LSP agent integration'"
echo ""
echo "[Protocols] Expected downloads: 5-8 papers/repos/specs"
echo ""

# Harness Dimension
echo "========================================"
echo "4/4: HARNESS DIMENSION"
echo "========================================"
echo "Queries: Meta-Harness, AutoGen, agent loop, sandboxing"
echo ""

echo "[Harness] Searching arXiv..."
echo "  - 'Meta-Harness'"
echo "  - 'agent harness architecture'"
echo "  - 'agent loop design control flow'"
echo "  - 'sandbox agent execution'"
echo ""
echo "[Harness] Searching GitHub..."
echo "  - 'AutoGen', 'LangGraph', 'CrewAI' repos"
echo "  - 'agent sandbox execution'"
echo ""
echo "[Harness] Expected downloads: 5-8 papers/repos"
echo ""

echo "========================================"
echo "BATCH SEARCH PLAN"
echo "========================================"
echo ""
echo "Total expected downloads: 20-32 sources"
echo ""
echo "To execute, run:"
echo ""
echo "  # Option A: Sequential (recommended for first run)"
echo "  /web-discovery memory 'hierarchical memory RAG MemGPT' --limit=8"
echo "  /web-discovery skills 'tool use Voyager skill composition' --limit=8"
echo "  /web-discovery protocols 'MCP LSP agent communication' --limit=8"
echo "  /web-discovery harness 'Meta-Harness AutoGen agent loop' --limit=8"
echo ""
echo "  # Option B: All at once (fast but may hit rate limits)"
echo "  /web-discovery memory 'hierarchical memory' --limit=8 && \\"
echo "  /web-discovery skills 'tool use Voyager' --limit=8 && \\"
echo "  /web-discovery protocols 'MCP specification' --limit=8 && \\"
echo "  /web-discovery harness 'Meta-Harness AutoGen' --limit=8"
echo ""
echo "After download, ingest all:"
echo "  /wiki-ingest raw/web/"
echo ""
echo "========================================"
