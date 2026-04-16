---
title: "Introducing the Model Context Protocol"
source_url: "https://www.anthropic.com/news/model-context-protocol"
source_type: blog
fetched: 2026-04-15
dimension: protocols
author: "Anthropic Engineering Team"
domain: "anthropic.com"
---

Skip to main contentSkip to footer

[](/)

  * [Research](/research)
  * [Economic Futures](/economic-futures)
  * Commitments
  * Learn
  * [News](/news)

[Try Claude](https://claude.ai/)

Announcements

# Introducing the Model Context Protocol

Nov 25, 2024

Today, we're open-sourcing the [Model Context
Protocol](https://modelcontextprotocol.io) (MCP), a new standard for
connecting AI assistants to the systems where data lives, including content
repositories, business tools, and development environments. Its aim is to help
frontier models produce better, more relevant responses.

As AI assistants gain mainstream adoption, the industry has invested heavily
in model capabilities, achieving rapid advances in reasoning and quality. Yet
even the most sophisticated models are constrained by their isolation from
data—trapped behind information silos and legacy systems. Every new data
source requires its own custom implementation, making truly connected systems
difficult to scale.

MCP addresses this challenge. It provides a universal, open standard for
connecting AI systems with data sources, replacing fragmented integrations
with a single protocol. The result is a simpler, more reliable way to give AI
systems access to the data they need.

## Model Context Protocol

The Model Context Protocol is an open standard that enables developers to
build secure, two-way connections between their data sources and AI-powered
tools. The architecture is straightforward: developers can either expose their
data through MCP servers or build AI applications (MCP clients) that connect
to these servers.

Today, we're introducing three major components of the Model Context Protocol
for developers:

  * The Model Context Protocol [specification and SDKs](https://github.com/modelcontextprotocol)
  * Local MCP server support in the [Claude Desktop apps](https://claude.ai/redirect/website.v1.d7191ce8-6879-4e02-9f84-77118ceaaaec/download)
  * An [open-source repository](https://github.com/modelcontextprotocol/servers) of MCP servers

Claude 3.5 Sonnet is adept at quickly building MCP server implementations,
making it easy for organizations and individuals to rapidly connect their most
important datasets with a range of AI-powered tools. To help developers start
exploring, we’re sharing pre-built MCP servers for popular enterprise systems
like Google Drive, Slack, GitHub, Git, Postgres, and Puppeteer.

Early adopters like Block and Apollo have integrated MCP into their systems,
while development tools companies including Zed, Replit, Codeium, and
Sourcegraph are working with MCP to enhance their platforms—enabling AI agents
to better retrieve relevant information to further understand the context
around a coding task and produce more nuanced and functional code with fewer
attempts.

"At Block, open source is more than a development model—it’s the foundation of
our work and a commitment to creating technology that drives meaningful change
and serves as a public good for all,” said Dhanji R. Prasanna, Chief
Technology Officer at Block. “Open technologies like the Model Context
Protocol are the bridges that connect AI to real-world applications, ensuring
innovation is accessible, transparent, and rooted in collaboration. We are
excited to partner on a protocol and use it to build agentic systems, which
remove the burden of the mechanical so people can focus on the creative.”

Instead of maintaining separate connectors for each data source, developers
can now build against a standard protocol. As the ecosystem matures, AI
systems will maintain context as they move between different tools and
datasets, replacing today's fragmented integrations with a more sustainable
architecture.

## Getting started

Developers can start building and testing MCP connectors today. All
[Claude.ai](http://claude.ai/redirect/website.v1.d7191ce8-6879-4e02-9f84-77118ceaaaec)
plans support connecting MCP servers to the Claude Desktop app.

Claude for Work customers can begin testing MCP servers locally, connecting
Claude to internal systems and datasets. We'll soon provide developer toolkits
for deploying remote production MCP servers that can serve your entire Claude
for Work organization.

To start building:

  * Install pre-built MCP servers through the [Claude Desktop app](https://claude.ai/redirect/website.v1.d7191ce8-6879-4e02-9f84-77118ceaaaec/download)
  * Follow our [quickstart guide](https://modelcontextprotocol.io/quickstart) to build your first MCP server
  * Contribute to our [open-source repositories](https://github.com/modelcontextprotocol) of connectors and implementations

## An open community

We’re committed to building MCP as a collaborative, open-source project and
ecosystem, and we’re eager to hear your feedback. Whether you’re an AI tool
developer, an enterprise looking to leverage existing data, or an early
adopter exploring the frontier, we invite you to build the future of context-
aware AI together.

  

[](https://twitter.com/intent/tweet?text=https://www.anthropic.com/news/model-
context-
protocol)[](https://www.linkedin.com/shareArticle?mini=true&url=https://www.anthropic.com/news/model-
context-protocol)

## Related content

###  Anthropic’s Long-Term Benefit Trust appoints Vas Narasimhan to Board of
Directors

[Read more](/news/narasimhan-board)

### Anthropic expands partnership with Google and Broadcom for multiple
gigawatts of next-generation compute

[Read more](/news/google-broadcom-partnership-compute)

### Australian government and Anthropic sign MOU for AI safety and research

[Read more](/news/australia-MOU)

[](/)

### Products

  * [Claude](https://claude.com/product/overview)
  * [Claude Code](https://claude.com/product/claude-code)
  * [Claude Code Enterprise](https://claude.com/product/claude-code/enterprise)
  * [Claude Code Security](https://claude.com/claude-code-security)
  * [Claude Cowork](https://claude.com/product/cowork)
  * [Claude for Chrome](https://claude.com/chrome)
  * [Claude for Slack](https://claude.com/claude-for-slack)
  * [Claude for Excel](https://claude.com/claude-for-excel)
  * [Claude for PowerPoint](https://claude.com/claude-for-powerpoint)
  * [Claude for Word](https://claude.com/claude-for-word)
  * [Skills](https://www.claude.com/skills)
  * [Max plan](https://claude.com/pricing/max)
  * [Team plan](https://claude.com/pricing/team)
  * [Enterprise plan](https://claude.com/pricing/enterprise)
  * [Download app](https://claude.ai/download)
  * [Pricing](https://claude.com/pricing)
  * [Log in to Claude](https://claude.ai/)

### Models

  * [Mythos preview](https://www.anthropic.com/glasswing)
  * [Opus](https://www.anthropic.com/claude/opus)
  * [Sonnet](https://www.anthropic.com/claude/sonnet)
  * [Haiku](https://www.anthropic.com/claude/haiku)

### Solutions

  * [AI agents](https://claude.com/solutions/agents)
  * [Code modernization](https://claude.com/solutions/code-modernization)
  * [Coding](https://claude.com/solutions/coding)
  * [Customer support](https://claude.com/solutions/customer-support)
  * [Education](https://claude.com/solutions/education)
  * [Financial services](https://claude.com/solutions/financial-services)
  * [Government](https://claude.com/solutions/government)
  * [Healthcare](https://claude.com/solutions/healthcare)
  * [Life sciences](https://claude.com/solutions/life-sciences)
  * [Nonprofits](https://claude.com/solutions/nonprofits)
  * [Security](https://claude.com/solutions/security)

### Claude Platform

  * [Overview](https://claude.com/platform/api)
  * [Developer docs](https://platform.claude.com/docs)
  * [Pricing](https://claude.com/pricing#api)
  * [Marketplace](https://claude.com/platform/marketplace)
  * [Regional compliance](https://claude.com/regional-compliance)
  * [Amazon Bedrock](https://claude.com/partners/amazon-bedrock)
  * [Google Cloud’s Vertex AI](https://claude.com/partners/google-cloud-vertex-ai)
  * [Microsoft Foundry](https://claude.com/partners/microsoft-foundry)
  * [Console login](https://platform.claude.com/)

### Resources

  * [Blog](https://claude.com/blog)
  * [Claude partner network](https://claude.com/partners)
  * [Community](https://claude.com/community)
  * [Connectors](https://claude.com/connectors)
  * [Courses](/learn)
  * [Customer stories](https://claude.com/customers)
  * [Engineering at Anthropic](/engineering)
  * [Events](/events)
  * [Inside Claude Code](/product/claude-code)
  * [Inside Claude Cowork](/product/claude-cowork)
  * [Plugins](https://claude.com/plugins)
  * [Powered by Claude](https://claude.com/partners/powered-by-claude)
  * [Service partners](https://claude.com/partners/services)
  * [Startups program](https://claude.com/programs/startups)
  * [Tutorials](https://claude.com/resources/tutorials)
  * [Use cases](https://claude.com/resources/use-cases)

### Help and security

  * [Availability](https://www.anthropic.com/supported-countries)
  * [Status](https://status.anthropic.com/)
  * [Support center](https://support.claude.com/en/)

### Company

  * [Anthropic](/company)
  * [Careers](/careers)
  * [Economic Futures](/economic-index)
  * [Research](/research)
  * [News](/news)
  * [Claude’s Constitution](/constitution)
  * [Responsible Scaling Policy](https://www.anthropic.com/news/announcing-our-updated-responsible-scaling-policy)
  * [Security and compliance](https://trust.anthropic.com/)
  * [Transparency](/transparency)

### Terms and policies

  * [Privacy policy](https://www.anthropic.com/legal/privacy)
  * [Consumer health data privacy policy](https://www.anthropic.com/legal/consumer-health-data-privacy-policy)
  * [Responsible disclosure policy](https://www.anthropic.com/responsible-disclosure-policy)
  * [Terms of service: Commercial](https://www.anthropic.com/legal/commercial-terms)
  * [Terms of service: Consumer](https://www.anthropic.com/legal/consumer-terms)
  * [Usage policy](https://www.anthropic.com/legal/aup)

© 2026 Anthropic PBC

  * [](https://www.linkedin.com/company/anthropicresearch)
  * [](https://x.com/AnthropicAI)
  * [](https://www.youtube.com/@anthropic-ai)

Introducing the Model Context Protocol \ Anthropic

