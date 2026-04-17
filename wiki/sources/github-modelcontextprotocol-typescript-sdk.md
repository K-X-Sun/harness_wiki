---
type: source
title: MCP TypeScript SDK
date: 2026-04-15
dimension: protocols
source_type: repo
tags:
- type-repo
- protocol-mcp
- framework-mcp
---

# MCP TypeScript SDK

Official Model Context Protocol SDK implementation in TypeScript.

- GitHub: https://github.com/modelcontextprotocol/typescript-sdk
- Stars: 3,000 | Language: TypeScript | License: MIT/Apache 2.0
- Dimension: Protocols
- Project Type: Protocol implementation

## Overview

The Model Context Protocol (MCP) allows applications to provide context for LLMs in a standardized way, separating the concerns of providing context from the actual LLM interaction.

This repository contains the TypeScript SDK implementation of the MCP specification.

## Current Status

- `main` branch contains v2 of the SDK (in development, pre-alpha)
- v1.x remains the recommended version for production use
- v1.x will receive bug fixes and security updates for 6 months after v2 ships

## Packages

- **`@modelcontextprotocol/server`**: Build MCP servers (tools/resources/prompts)
- **`@modelcontextprotocol/client`**: Build MCP clients (transports, helpers)
- **`@modelcontextprotocol/node`**: Node.js Streamable HTTP transport wrapper
- **`@modelcontextprotocol/express`**: Express helpers
- **`@modelcontextprotocol/hono`**: Hono helpers

## Features

- MCP server libraries (Streamable HTTP, stdio, auth helpers)
- MCP client libraries (transports, high-level helpers, OAuth helpers)
- Optional middleware packages for specific runtimes/frameworks
- Runnable examples under `examples/`
- Standard Schema for tool and prompt schemas (Zod, Valibot, ArkType compatible)

## Documentation

- Local SDK docs: `docs/server.md`, `docs/client.md`, `docs/faq.md`
- API documentation: https://ts.sdk.modelcontextprotocol.io/
- Model Context Protocol documentation: https://modelcontextprotocol.io
- MCP Specification: https://spec.modelcontextprotocol.io

## Installation

```bash
# Server
npm install @modelcontextprotocol/server
bun add @modelcontextprotocol/server
deno add npm:@modelcontextprotocol/server

# Client
npm install @modelcontextprotocol/client
bun add @modelcontextprotocol/client
deno add npm:@modelcontextprotocol/client
```

## License

Apache License 2.0 for new contributions, MIT for existing code.
