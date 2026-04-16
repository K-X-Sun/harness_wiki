---
type: concept
concept_type: security-model
title: Capability-Based Security
created: 2026-04-15
updated: 2026-04-15
tags: [security, permissions, architecture]
---

# Capability-Based Security

A security model where access rights are represented by unforgeable tokens (capabilities) rather than ambient authority.

## Core Principles

### 1. No Ambient Authority
In traditional systems, a process inherits permissions from the user who launched it. In capability-based systems:
- A process has **only** the capabilities explicitly granted to it
- No implicit access based on user identity
- Principle of least privilege by default

### 2. Capabilities as Unforgeable References
- A capability is both a reference to an object AND permission to access it
- Cannot be forged or guessed
- Can be passed between processes (delegation)

### 3. Fine-Grained Control
- Each resource can have its own capability
- Different capabilities for read vs write
- Easy to revoke: just invalidate the capability

## Example: Traditional vs Capability-Based

### Traditional (Ambient Authority)
```python
# Process runs as user "alice"
# Implicitly has access to all of alice's files
file = open("/home/alice/document.txt")  # Works!
file = open("/home/alice/secret.txt")    # Also works!
```

**Problem**: Process has access to ALL files user can access, not just what it needs.

### Capability-Based
```python
# Process receives only specific capabilities
file_cap = receive_capability()  # Given by parent process
file = file_cap.open()           # Can only access this file
```

**Benefit**: Process has access to ONLY the specific file it was granted.

## Applications in AI Coding Systems

### [[Model Context Protocol (MCP)]]
MCP implements capability-based security:

```python
# MCP Server cannot access filesystem by default
# Must receive explicit capability grants

@server.resource("file://{path}")
def read_file(path: str) -> str:
    # User must approve access to each path
    # Server cannot access arbitrary files
    with open(path) as f:  # Only works if user granted this path
        return f.read()
```

**Security properties**:
- Server runs in isolated process → [[Process Isolation]]
- No ambient filesystem access
- User approves each resource explicitly
- Easy to audit: "What capabilities did I grant?"

### Benefits for AI Agents

1. **Reduced attack surface**: Agent can't access resources it wasn't explicitly given
2. **Auditability**: Clear record of granted capabilities
3. **Composability**: Can safely combine agents with different capability sets
4. **Revocability**: Revoke capabilities without killing the agent

## Comparison with ACLs (Access Control Lists)

| Feature | ACLs | Capabilities |
|---------|------|--------------|
| Access based on | User identity | Possession of token |
| Delegation | Difficult | Natural |
| Revocation | Central authority | Invalidate token |
| Audit | "Who can access X?" | "What can Y access?" |
| Confused deputy problem | Vulnerable | Immune |

### Confused Deputy Problem

**ACL vulnerability**:
```
User asks privileged program to read file X
Program checks: "User has access to X" ✓
Program reads X using ITS privileges (can access more than X)
→ User can trick program into reading Y too!
```

**Capability immunity**:
```
User passes capability to file X
Program can ONLY access X (no ambient authority)
→ Cannot be tricked into accessing Y
```

## Challenges

1. **Bootstrapping**: How does a process get its first capability?
   - Usually: parent process grants initial capabilities
   
2. **Usability**: Users must explicitly grant capabilities
   - Can be tedious for many small operations
   - Need good UX to avoid "click-through fatigue"

3. **Revocation complexity**: If capabilities are passed around, revoking is hard
   - Solution: Proxy capabilities that can be centrally invalidated

## Implementations

### In MCP
- [[Model Context Protocol (MCP)]]: Servers receive capabilities, not ambient authority
- [[Claude Desktop]]: User approves resource access via UI prompts

### Other Systems
- Operating systems: seL4, EROS, Capsicum
- Languages: E language, Joe-E (Java subset)
- Browsers: Same-origin policy (URLs are capabilities)

## Related

**Protocols**: [[Model Context Protocol (MCP)]]  
**Concepts**: [[Process Isolation]], [[Permission Systems]]  
**Entities**: [[Anthropic]] (advocate for capability-based design)

## Sources

- [[MCP Technical Overview]] — MCP's implementation
- General capability-based security literature

## Further Reading

- Mark S. Miller: "Robust Composition" (capability-based design)
- Dennis and Van Horn (1966): Original capability paper
- Capsicum project: Capability-based OS extensions
