# Manual Download Guide — When WebFetch is Blocked

**Issue**: Enterprise network policies block WebFetch from accessing arxiv.org, github.com, etc.

**Solution**: Manual download + automated frontmatter addition

---

## Download Methods

### Option 1: Browser Download (Recommended)

**For arXiv papers**:
1. Open: https://arxiv.org/html/2603.28052v1
2. Right-click page → "Save As" → Save as HTML
3. Use browser extension or copy-paste to convert HTML to Markdown
4. Save to: `raw/harness/2026-04-15_arxiv_2603_28052_meta-harness.md`

**For GitHub repos**:
1. Open: https://github.com/microsoft/autogen
2. Scroll to README section
3. Click "Raw" button on README.md
4. Save page as: `raw/harness/2026-04-15_github_microsoft-autogen.md`

**For web articles**:
1. Open: https://www.anthropic.com/engineering/building-agents-with-the-claude-agent-sdk
2. Use Obsidian Web Clipper, MarkDownload extension, or copy-paste
3. Save to: `raw/harness/2026-04-15_anthropic-claude-agent-sdk.md`

### Option 2: External Tools

**Recommended tools**:
- **MarkDownload** (Chrome/Firefox extension) - Converts web pages to markdown
- **Obsidian Web Clipper** - Saves web content as markdown
- **Pandoc** - Converts HTML files to markdown
  ```bash
  pandoc input.html -o output.md
  ```
- **html2text** - Python tool for HTML→markdown
  ```bash
  pip install html2text
  html2text < input.html > output.md
  ```

### Option 3: Proxy/VPN

If you have access to a different network:
```bash
# Use curl through proxy
curl -x http://proxy:port https://arxiv.org/html/2603.28052v1 > paper.html

# Or download PDF and convert
curl https://arxiv.org/pdf/2603.28052.pdf -o paper.pdf
# Then use pdf2md tools
```

---

## Adding Frontmatter

Once you have the markdown file, add YAML frontmatter at the top.

### Template for arXiv Papers

```yaml
---
title: "Meta-Harness: End-to-End Optimization of Model Harnesses"
source_url: "https://arxiv.org/abs/2603.28052"
source_type: paper
fetched: 2026-04-15
dimension: harness
authors: ["Yoonho Lee", "Roshen Nair", "Qizheng Zhang", "Kangwook Lee", "Omar Khattab", "Chelsea Finn"]
categories: ["cs.AI"]
arxiv_id: "2603.28052"
---

# Meta-Harness: End-to-End Optimization of Model Harnesses

[Full paper content...]
```

### Template for GitHub Repos

```yaml
---
title: "microsoft/autogen"
source_url: "https://github.com/microsoft/autogen"
source_type: repo
fetched: 2026-04-15
dimension: harness
stars: 25000
language: Python
license: "MIT"
description: "A programming framework for agentic AI (now in maintenance mode)"
---

# AutoGen

[Full README content...]
```

### Template for Web Articles

```yaml
---
title: "Building agents with the Claude Agent SDK"
source_url: "https://www.anthropic.com/engineering/building-agents-with-the-claude-agent-sdk"
source_type: blog
fetched: 2026-04-15
dimension: harness
author: "Anthropic Engineering Team"
domain: "anthropic.com"
---

# Building agents with the Claude Agent SDK

[Full article content...]
```

---

## Automated Frontmatter Script

Save this as `add_frontmatter.sh`:

```bash
#!/bin/bash
# Usage: ./add_frontmatter.sh <file.md> <dimension> <source_type> <source_url> <title>

FILE=$1
DIMENSION=$2
SOURCE_TYPE=$3
SOURCE_URL=$4
TITLE=$5
DATE=$(date +%Y-%m-%d)

# Create temporary file with frontmatter
cat > temp_frontmatter.md <<EOF
---
title: "$TITLE"
source_url: "$SOURCE_URL"
source_type: $SOURCE_TYPE
fetched: $DATE
dimension: $DIMENSION
---

EOF

# Append original content
cat "$FILE" >> temp_frontmatter.md

# Replace original
mv temp_frontmatter.md "$FILE"

echo "✅ Added frontmatter to $FILE"
```

**Usage examples**:
```bash
# arXiv paper
./add_frontmatter.sh raw/harness/paper.md harness paper \
  "https://arxiv.org/abs/2603.28052" \
  "Meta-Harness: End-to-End Optimization of Model Harnesses"

# GitHub repo
./add_frontmatter.sh raw/harness/autogen.md harness repo \
  "https://github.com/microsoft/autogen" \
  "microsoft/autogen"

# Web article
./add_frontmatter.sh raw/harness/claude-sdk.md harness blog \
  "https://www.anthropic.com/engineering/building-agents-with-the-claude-agent-sdk" \
  "Building agents with the Claude Agent SDK"
```

---

## Batch Download Workflow

For the 57 sources in `SOURCES_TO_DOWNLOAD.md`:

### 1. Create download checklist

```bash
# Extract URLs from SOURCES_TO_DOWNLOAD.md
grep "https://" SOURCES_TO_DOWNLOAD.md | \
  grep -v "^#" | \
  awk '{print $NF}' > urls_to_download.txt
```

### 2. Download one by one

**Harness dimension example** (12 sources):

```bash
# arXiv papers (5)
# Open these URLs in browser, save as markdown:
https://arxiv.org/html/2603.28052v1  # Meta-Harness
https://arxiv.org/html/2603.25723v1  # NLAH
https://arxiv.org/html/2603.05344v1  # Building AI Coding Agents
https://arxiv.org/html/2603.08616v1  # Multi-Agent Harness
https://arxiv.org/html/2512.01939v1  # Agent Developer Practices

# GitHub repos (3)
# Click "Raw" on README.md, save:
https://github.com/microsoft/autogen
https://github.com/langchain-ai/langgraph
https://github.com/langchain-ai/langgraph-101

# Web articles (3)
# Use MarkDownload extension or copy:
https://www.infoq.com/articles/prompts-to-production-playbook-for-agentic-development/
https://www.infoq.com/news/2025/10/microsoft-agent-framework/
https://www.anthropic.com/engineering/building-agents-with-the-claude-agent-sdk

# Tech news (1)
https://www.infoq.com/news/2025/09/temporal-aiagent/
```

### 3. Organize files

Move downloaded files to dimension directories:
```bash
# Memory dimension
mv memgpt-paper.md raw/memory/2026-04-15_arxiv_2310_08560_memgpt.md
mv mem0-readme.md raw/memory/2026-04-15_github_mem0ai-mem0.md

# Skills dimension  
mv voyager-paper.md raw/skills/2026-04-15_arxiv_2305_16291_voyager.md
mv autogpt-readme.md raw/skills/2026-04-15_github_autogpt.md

# Protocols dimension
mv mcp-paper.md raw/protocols/2026-04-15_arxiv_2503_23278_mcp-landscape.md
mv mcp-spec.md raw/protocols/2026-04-15_mcp-specification.md

# Harness dimension
mv meta-harness-paper.md raw/harness/2026-04-15_arxiv_2603_28052_meta-harness.md
mv autogen-readme.md raw/harness/2026-04-15_github_microsoft-autogen.md
```

### 4. Batch add frontmatter

```bash
# Create frontmatter-adder.sh script (see above)
chmod +x add_frontmatter.sh

# Run on each file
for file in raw/harness/*.md; do
  # Parse filename to get metadata
  # Add frontmatter based on source type
  # ...
done
```

---

## Alternative: Download on Different Network

If you have access to another machine without network restrictions:

```bash
# On unrestricted machine:
wget https://arxiv.org/html/2603.28052v1 -O meta-harness.html
pandoc meta-harness.html -o meta-harness.md

# Transfer to this machine via:
# - USB drive
# - Email to yourself
# - Cloud storage (Dropbox, OneDrive)
# - Git (commit from other machine, pull here)
```

---

## Quality Check

After manual download, verify:

✅ **File size**: Should be 40-80KB for papers (not 1-3KB summaries)
✅ **Complete sections**: Has Introduction, Methods, Results, Conclusion
✅ **Frontmatter**: Has dimension, source_url, title, fetched date
✅ **Markdown quality**: Code blocks, tables, equations formatted correctly

```bash
# Check file sizes
ls -lh raw/harness/*.md

# Should see:
# 67K meta-harness.md
# 52K nlah.md
# 45K building-ai-agents.md
# NOT 1.5K, 2.3K, 3.1K
```

---

## Next Steps

After manual download and frontmatter addition:

```bash
# Verify directory structure
tree raw/

# Ingest all sources
/wiki-ingest raw/

# Check created entities
cat wiki/index.md
```

---

**Created**: 2026-04-15  
**Reason**: Enterprise network blocks WebFetch for arxiv.org, github.com  
**Status**: Manual download is reliable alternative to automated web-discovery
