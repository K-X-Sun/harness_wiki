---
type: entity
entity_type: protocol
title: Model Context Protocol (MCP)
created: 2026-04-15
updated: 2026-04-15
tags: [protocol, mcp, context-sharing, anthropic]
organization: Anthropic
version: 1.x
spec_url: https://spec.modelcontextprotocol.io
github_url: https://github.com/anthropics/model-context-protocol
status: production
---

# Model Context Protocol (MCP)

An open protocol that standardizes how AI applications provide context to Large Language Models.

## Overview

MCP enables secure, two-way connections between AI models and data sources through a client-server architecture. Instead of each AI application building custom integrations with every data source, MCP provides a single protocol that any data source can implement.

## Architecture

```
┌─────────────┐         ┌─────────────┐         ┌─────────────┐
│   Claude    │  MCP    │  MCP Host   │  MCP    │  MCP Server │
│  (LLM Core) │◄───────►│  (Client)   │◄───────►│  (Resource) │
└─────────────┘         └─────────────┘         └─────────────┘
```

### Components

1. **MCP Hosts**: Applications like [[Claude Desktop]], IDEs that embed MCP clients
2. **MCP Clients**: Protocol client libraries that manage connections
3. **MCP Servers**: Lightweight programs that expose resources, tools, or prompts
4. **Transport Layer**: Communication channels (stdio, HTTP/SSE, WebSocket)

## Core Abstractions

### 1. Resource System
- Servers expose data via URI schemes (`file://`, `postgres://`, etc.)
- Clients discover resources via `resources/list` RPC call
- Supports CRUD operations
- See: [[Resource System]]

### 2. Tool System  
- Servers expose callable functions with [[JSON Schema]] definitions
- LLM can invoke tools during reasoning
- Automatic input validation
- See: [[Tool System]]

### 3. Prompt System
- Servers provide reusable prompt templates
- Prompts can reference dynamic resources
- Example: `@github_issues` template
- See: [[MCP Prompt System]]

## Security Model

Built on [[Capability-Based Security]] principles:

- **Process isolation**: Servers run in separate processes
- **Explicit permissions**: Users approve each resource access
- **No ambient authority**: All capabilities must be explicitly granted
- **Sandboxing**: Servers cannot access host system without permission

See: [[MCP Security Architecture]]

## Performance Characteristics

From [[MCP Technical Overview]]:

| Metric | Value | Context |
|--------|-------|---------|
| Latency | <50ms | stdio transport, local servers |
| Throughput | 1000+ req/s | Per server process |
| Memory | ~10MB | Per server process |
| Connection overhead | Negligible | stdio transport |

## Implementations

### Official

- [[Claude Desktop]] (v1.2+) — Full MCP support
- [[MCP Python SDK]] — Server implementation library
- [[MCP TypeScript SDK]] — Server implementation library
- VS Code Extension (beta)

### Community Servers

50+ open-source servers available:
- GitHub MCP Server (official)
- Postgres MCP Server
- Filesystem MCP Server
- Google Drive MCP Server

See: https://mcp.directory

## Comparison with Other Protocols

### vs [[Language Server Protocol (LSP)]]

| Feature | LSP | MCP |
|---------|-----|-----|
| Primary use | Code intelligence | Context provisioning |
| Data flow | Bidirectional | Server → Client (primary) |
| State | Stateful | Stateless-preferred |
| Domain | Code-specific | Data-source-agnostic |
| Transport | JSON-RPC over stdio/TCP | JSON-RPC (similar) |

### vs Custom Integrations

MCP solves the **N × M problem**:
- Without MCP: N apps × M data sources = N×M integrations
- With MCP: N apps + M servers + 1 protocol = N+M+1 components

## Key Advantages

1. **Standardization**: One protocol, many data sources
2. **Security**: Fine-grained permission model
3. **Composability**: Mix and match servers
4. **Language-agnostic**: Servers can be written in any language
5. **Backwards-compatible**: Protocol versioning built-in

## Open Questions

1. How does MCP handle streaming data from databases?
2. What are failure modes when servers become unresponsive?
3. How do multiple servers coordinate (e.g., file + git)?
4. What authentication patterns exist for remote servers?

## References

- Specification: https://spec.modelcontextprotocol.io
- GitHub: https://github.com/anthropics/model-context-protocol
- Community: https://mcp.directory
- Source: [[MCP Technical Overview]]

## Related

**Protocols**: [[Language Server Protocol (LSP)]], [[JSON-RPC]]  
**Concepts**: [[Capability-Based Security]], [[Process Isolation]], [[Resource System]], [[Tool System]]  
**Organizations**: [[Anthropic]]  
**Frameworks**: [[Claude Desktop]], [[MCP Python SDK]]
