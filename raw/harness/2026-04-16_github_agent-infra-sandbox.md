---
title: "AIO Sandbox - All-in-One Agent Sandbox Environment"
source_url: "https://github.com/agent-infra/sandbox"
source_type: github
fetched: 2026-04-16
dimension: harness
stars: 2843
forks: 372
license: Apache 2.0
primary_language: TypeScript
github_owner: agent-infra
github_repo: sandbox
---

# AIO Sandbox - All-in-One Agent Sandbox Environment

**Source**: GitHub - agent-infra/sandbox  
**Stars**: 2,843 | **Forks**: 372 | **License**: Apache 2.0  
**Primary Language**: TypeScript  
**Published**: 2025-2026

---

## Overview

AIO Sandbox is an **all-in-one** agent sandbox environment that combines Browser, Shell, File, MCP operations, and VSCode Server in a single Docker container. Built on cloud-native lightweight sandbox technology, it provides a unified, secure execution environment for AI agents and developers.

**Quick Start**: `docker run --security-opt seccomp=unconfined --rm -it -p 8080:8080 ghcr.io/agent-infra/sandbox:latest`

---

## Key Features

### Unified Environment

| Component | Description |
|-----------|-------------|
| **Browser Automation** | Full browser control through VNC, CDP, MCP |
| **VSCode Server** | Full IDE experience in browser |
| **Jupyter Notebook** | Interactive Python environment |
| **Terminal** | WebSocket-based terminal access |
| **File Operations** | Unified file system across all components |
| **MCP Servers** | Pre-configured Model Context Protocol servers |

### Security

- **Sandboxed Python and Node.js execution** - Safety guarantees
- **Seccomp profiles** - System call restrictions
- **Volume isolation** - Container-based isolation

---

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    🌐 Browser + VNC                        │
├─────────────────────────────────────────────────────────────┤
│  💻 VSCode Server  │  🐚 Shell Terminal  │  📁 File Ops   │
├─────────────────────────────────────────────────────────────┤
│              🔗 MCP Hub + 🔒 Sandbox Fusion               │
├─────────────────────────────────────────────────────────────┤
│         🚀 Preview Proxy + 📊 Service Monitoring          │
└─────────────────────────────────────────────────────────────┘
```

### MCP Servers

| Server | Tools Available |
|--------|----------------|
| `browser` | `navigate`, `screenshot`, `click`, `type`, `scroll` |
| `file` | `read`, `write`, `list`, `search`, `replace` |
| `shell` | `exec`, `create_session`, `kill` |
| `markitdown` | `convert`, `extract_text`, `extract_images` |

---

## SDKs

### Python

```bash
pip install agent-sandbox
```

```python
from agent_sandbox import Sandbox

client = Sandbox(base_url="http://localhost:8080")
result = client.shell.exec_command(command="ls -la")
content = client.file.read_file(file="/home/gem/.bashrc")
screenshot = client.browser.screenshot()
```

### TypeScript/JavaScript

```bash
npm install @agent-infra/sandbox
```

```typescript
import { Sandbox } from '@agent-infra/sandbox';

const sandbox = new Sandbox({ baseURL: 'http://localhost:8080' });
const result = await sandbox.shell.exec({ command: 'ls -la' });
const content = await sandbox.file.read({ path: '/home/gem/.bashrc' });
```

### Go

```bash
go get github.com/agent-infra/sandbox-sdk-go
```

---

## Integration Examples

### Browser Use Integration

```python
from agent_sandbox import Sandbox
from browser_use import Agent, Tools
from browser_use.browser import BrowserProfile, BrowserSession
from browser_use.llm import ChatOpenAI

sandbox = Sandbox(base_url="http://localhost:8080")
cdp_url = sandbox.browser.get_info().data.cdp_url

browser_session = BrowserSession(
    browser_profile=BrowserProfile(cdp_url=cdp_url, is_local=True)
)
tools = Tools()

agent = Agent(
    task='Visit https://duckduckgo.com and search for "browser-use founders"',
    llm=ChatOpenAI(model="gcp-claude4.1-opus"),
    tools=tools,
    browser_session=browser_session,
)
```

### LangChain Integration

```python
from langchain.tools import BaseTool
from agent_sandbox import Sandbox

class SandboxTool(BaseTool):
    name = "sandbox_execute"
    description = "Execute commands in AIO Sandbox"

    def _run(self, command: str) -> str:
        client = Sandbox(base_url="http://localhost:8080")
        result = client.shell.exec_command(command=command)
        return result.data.output
```

### OpenAI Assistant Integration

```python
from openai import OpenAI
from agent_sandbox import Sandbox

client = OpenAI(api_key="your_api_key")
sandbox = Sandbox(base_url="http://localhost:8080")

def run_code(code, lang="python"):
    if lang == "python":
        return sandbox.jupyter.execute_code(code=code).data
    return sandbox.nodejs.execute_nodejs_code(code=code).data

response = client.chat.completions.create(
    model="gpt-4",
    messages=[{"role": "user", "content": "calculate 1+1"}],
    tools=[{
        "type": "function",
        "function": {
            "name": "run_code",
            "parameters": {"type": "object", "properties": {
                "code": {"type": "string"},
                "lang": {"type": "string"},
            }},
        },
    }],
)
```

---

## Deployment

### Docker Compose

```yaml
version: '3.8'
services:
  sandbox:
    container_name: aio-sandbox
    image: ghcr.io/agent-infra/sandbox:latest
    volumes:
      - /tmp/gem/vite-project:/home/gem/vite-project
    security_opt:
      - seccomp:unconfined
    ports:
      - "8080:8080"
    environment:
      PROXY_SERVER: "host.docker.internal:7890"
```

### Kubernetes

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: aio-sandbox
spec:
  replicas: 2
  selector:
    matchLabels:
      app: aio-sandbox
  template:
    spec:
      containers:
      - name: aio-sandbox
        image: ghcr.io/agent-infra/sandbox:latest
        ports:
        - containerPort: 8080
        resources:
          limits:
            memory: "2Gi"
            cpu: "1000m"
```

---

## API Reference

| Endpoint | Description |
|----------|-------------|
| `/v1/sandbox` | Get sandbox environment information |
| `/v1/shell/exec` | Execute shell commands |
| `/v1/file/read` | Read file contents |
| `/v1/file/write` | Write file contents |
| `/v1/browser/screenshot` | Take browser screenshot |
| `/v1/jupyter/execute` | Execute Jupyter code |

---

## Cross-References

**Related**: [[Agent Memory]], [[GoClaw]] (sandbox integration)  
**Similar Systems**: [[DeerFlow]] (sandbox mode)
