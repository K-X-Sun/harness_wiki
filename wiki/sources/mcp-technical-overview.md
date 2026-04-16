---
type: source
title: Model Context Protocol (MCP) - Technical Overview
source_file: raw/web/demo_mcp_article.md
source_type: web
source_url: https://www.anthropic.com/mcp-technical-overview
ingested_date: 2026-04-15
tags: [protocol, mcp, anthropic]
---

# Model Context Protocol (MCP) - Technical Overview

**Original source**: [[../../raw/web/demo_mcp_article.md]]  
**Published**: 2026-03-15  
**Organization**: [[Anthropic]]

## Summary

The Model Context Protocol (MCP) is an open standard for connecting AI models to external data sources. It uses a client-server architecture where lightweight MCP servers expose resources, tools, and prompts to AI applications through a standardized JSON-RPC protocol.

## Key Contributions

### Protocol Design
- **Client-server architecture**: Hosts (IDEs, Claude Desktop) contain MCP clients; standalone servers expose data
- **Three primary abstractions**: Resources (readable data), Tools (executable functions), Prompts (reusable templates)
- **Transport flexibility**: stdio, HTTP/SSE, WebSocket support
- **Security model**: Process isolation, explicit permissions, capability-based access

### Technical Specifications
- **Latency**: <50ms for stdio transport (local servers)
- **Throughput**: 1000+ requests/sec per server
- **Memory footprint**: ~10MB per server process
- **Protocol versioning**: Backwards-compatible design

### Implementation Examples
- Python SDK with decorator-based API
- Server types: GitHub, Postgres, Filesystem, Google Drive
- 50+ community servers available

## Entities Extracted

### Protocols
- [[Model Context Protocol (MCP)]] — Core protocol

### Organizations
- [[Anthropic]] — Protocol creator

### Frameworks
- [[Claude Desktop]] — First implementation
- [[MCP Python SDK]] — Official SDK

### Concepts
- [[Resource System]] — URI-based data access
- [[Tool System]] — LLM-callable functions
- [[Capability-Based Security]] — Permission model

## Key Insights

1. **Standardization value**: MCP solves the "N × M problem" — instead of each AI app integrating with M data sources separately, we have N apps × 1 protocol × M servers

2. **Security-first design**: Unlike ambient authority models, MCP requires explicit capability grants, reducing attack surface

3. **Comparison with LSP**: While both use JSON-RPC, LSP is stateful and code-centric; MCP is stateless-preferred and data-source-agnostic

4. **Performance characteristics**: stdio transport achieves <50ms latency, making it suitable for interactive use

## Cross-References

- Related protocols: [[Language Server Protocol (LSP)]]
- Related concepts: [[Process Isolation]], [[JSON-RPC]]
- Related frameworks: [[VS Code Extension]]

## Questions Raised

1. How does MCP handle streaming data (e.g., database result sets)?
2. What are the failure modes when a server becomes unresponsive?
3. How do multiple servers coordinate (e.g., file + git + issue tracker)?
4. What are the authentication patterns for remote MCP servers?

## Follow-Up Sources

- MCP Specification (spec.modelcontextprotocol.io)
- MCP GitHub repository
- Community server implementations
- Security audit reports (if available)
