---
date: '2026-04-15'
source_type: repo
tags:
- type-repo
- topic-agent
title: 'GitHub - langchain-ai/langgraphjs: Framework to build resilient language agents
  as graphs. · GitHub'
---

# GitHub - langchain-ai/langgraphjs: Framework to build resilient language agents as graphs. · GitHub

[Skip to content](#start-of-content)


## Navigation Menu
 Toggle navigation





 [](/)
[Sign in](/login?return_to=https%3A%2F%2Fgithub.com%2Flangchain-ai%2Flanggraphjs)
Appearance settings





 Search or jump to...



# Search code, repositories, users, issues, pull requests...


'"` </textarea></xmp>
Search



 Clear







[Search syntax tips](https://docs.github.com/search-github/github-code-search/understanding-github-code-search-syntax)





# Provide feedback




'"` </textarea></xmp>
We read every piece of feedback, and take your input very seriously.
 Include my email address so I can be contacted

Cancel Submit feedback


# Saved searches

## Use saved searches to filter your results more quickly






'"` </textarea></xmp>


Name

Query

To see all available qualifiers, see our [documentation](https://docs.github.com/search-github/github-code-search/understanding-github-code-search-syntax) .




Cancel Create saved search


[Sign in](/login?return_to=https%3A%2F%2Fgithub.com%2Flangchain-ai%2Flanggraphjs)
 [Sign up](/signup?ref_cta=Sign+up&ref_loc=header+logged+out&ref_page=%2F%3Cuser-name%3E%2F%3Crepo-name%3E&source=header-repo&source_repo=langchain-ai%2Flanggraphjs)
Appearance settings

 Resetting focus


You signed in with another tab or window. Reload to refresh your session. You signed out in another tab or window. Reload to refresh your session. You switched accounts on another tab or window. Reload to refresh your session. Dismiss alert





{{ message }}



[langchain-ai](/langchain-ai) / **[langgraphjs](/langchain-ai/langgraphjs)** Public



- [Notifications](/login?return_to=%2Flangchain-ai%2Flanggraphjs)  You must be signed in to change notification settings
- [Fork 460](/login?return_to=%2Flangchain-ai%2Flanggraphjs)
- [Star 2.8k](/login?return_to=%2Flangchain-ai%2Flanggraphjs)





[](/langchain-ai/langgraphjs)



# langchain-ai/langgraphjs








main




[Branches](/langchain-ai/langgraphjs/branches) [Tags](/langchain-ai/langgraphjs/tags)

[](/langchain-ai/langgraphjs/branches) [](/langchain-ai/langgraphjs/tags)




$! /$

Go to file

 Code
Open more actions menu




## Folders and files


| Name | Name | Last commit message | Last commit date |
|---|---|---|---|
| Latest commit History 2,795 Commits 2,795 Commits |
| .changeset | .changeset |  |  |
| .devcontainer | .devcontainer |  |  |
| .github | .github |  |  |
| .vscode | .vscode |  |  |
| .yarn/ patches | .yarn/ patches |  |  |
| docs | docs |  |  |
| examples | examples |  |  |
| internal | internal |  |  |
| libs | libs |  |  |
| scripts | scripts |  |  |
| .gitignore | .gitignore |  |  |
| .oxfmtrc.jsonc | .oxfmtrc.jsonc |  |  |
| .oxlintrc.jsonc | .oxlintrc.jsonc |  |  |
| CLAUDE.md | CLAUDE.md |  |  |
| CONTRIBUTING.md | CONTRIBUTING.md |  |  |
| LICENSE | LICENSE |  |  |
| README.md | README.md |  |  |
| deno.json | deno.json |  |  |
| int-test-deps-docker-compose.yml | int-test-deps-docker-compose.yml |  |  |
| package.json | package.json |  |  |
| pnpm-lock.yaml | pnpm-lock.yaml |  |  |
| pnpm-workspace.yaml | pnpm-workspace.yaml |  |  |
| tsconfig.json | tsconfig.json |  |  |
| turbo.json | turbo.json |  |  |
| View all files |



## Repository files navigation



# 🦜🕸️LangGraph.js
 [](#️langgraphjs)

[![Docs](https://camo.githubusercontent.com/b98c4ce4549448d09f2217965c7d6f2cf39ee6800b2b4c63dfd62080fb5533d8/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f646f63732d6c61746573742d626c7565)
](https://langchain-ai.github.io/langgraphjs/) [![Version](https://camo.githubusercontent.com/c17c8d80ef7d768ced29a792b70f6fd8cd58f543e373fc21878aea69b80ab22a/68747470733a2f2f696d672e736869656c64732e696f2f6e706d2f762f406c616e67636861696e2f6c616e6767726170683f6c6f676f3d6e706d)
](https://camo.githubusercontent.com/c17c8d80ef7d768ced29a792b70f6fd8cd58f543e373fc21878aea69b80ab22a/68747470733a2f2f696d672e736869656c64732e696f2f6e706d2f762f406c616e67636861696e2f6c616e6767726170683f6c6f676f3d6e706d)
 [![Downloads](https://camo.githubusercontent.com/c3917cd9a7cb0ecba5751eede1693310a2ce460fb33e726aa0f150697bb5eef2/68747470733a2f2f696d672e736869656c64732e696f2f6e706d2f646d2f406c616e67636861696e2f6c616e676772617068)
](https://www.npmjs.com/package/@langchain/langgraph) [![Open Issues](https://camo.githubusercontent.com/3bfeefed72c06706a06aad7375582dcc7e90b3cfa4fab42d2215079fc59a08a4/68747470733a2f2f696d672e736869656c64732e696f2f6769746875622f6973737565732d7261772f6c616e67636861696e2d61692f6c616e6767726170686a73)
](https://github.com/langchain-ai/langgraphjs/issues)


Note

Looking for the Python version? See the [Python repo](https://github.com/langchain-ai/langgraph) and the [Python docs](https://docs.langchain.com/oss/python/langgraph/overview) .


LangGraph — used by Replit, Uber, LinkedIn, GitLab and more — is a low-level orchestration framework for building controllable agents. While langchain provides integrations and composable components to streamline LLM application development, the LangGraph library enables agent orchestration — offering customizable architectures, long-term memory, and human-in-the-loop to reliably handle complex tasks.


```
npm install @langchain/langgraph @langchain/core
```


To learn more about how to use LangGraph, check out [the docs](https://langchain-ai.github.io/langgraphjs/) . We show a simple example below of how to create a ReAct agent.


```
// npm install @langchain -anthropic import { createReactAgent , tool } from "langchain" ; import { ChatAnthropic } from "@langchain/anthropic" ; import { z } from "zod" ; const search = tool ( async ( { query } ) => { if ( query . toLowerCase ( ) . includes ( "sf" ) || query . toLowerCase ( ) . includes ( "san francisco" ) ) { return "It's 60 degrees and foggy." ; } return "It's 90 degrees and sunny." ; } , { name : "search" , description : "Call to surf the web." , schema : z . object ( { query : z . string ( ) . describe ( "The query to use in your search." ) , } ) , } ) ; const model = new ChatAnthropic ( { model : "claude-3-7-sonnet-latest" , } ) ; const agent = createReactAgent ( { llm : model , tools : [ search ] , } ) ; const result = await agent . invoke ( { messages : [ { role : "user" , content : "what is the weather in sf" , } , ] , } ) ;
```



## Full-stack Quickstart
 [](#full-stack-quickstart)

Get started quickly by building a full-stack LangGraph application using the [`create-agent-chat-app`](https://www.npmjs.com/package/create-agent-chat-app) CLI:


```
npx create-agent-chat-app@latest
```


The CLI sets up a chat interface and helps you configure your application, including:

- 🧠 Choice of 4 prebuilt agents (ReAct, Memory, Research, Retrieval)
- 🌐 Frontend framework (Next.js or Vite)
- 📦 Package manager ( `npm` , `yarn` , or `pnpm` )


## Why use LangGraph?
 [](#why-use-langgraph)

LangGraph is built for developers who want to build powerful, adaptable AI agents. Developers choose LangGraph for:

- **Reliability and controllability.** Steer agent actions with moderation checks and human-in-the-loop approvals. LangGraph persists context for long-running workflows, keeping your agents on course.
- **Low-level and extensible.** Build custom agents with fully descriptive, low-level primitives – free from rigid abstractions that limit customization. Design scalable multi-agent systems, with each agent serving a specific role tailored to your use case.
- **First-class streaming support.** With token-by-token streaming and streaming of intermediate steps, LangGraph gives users clear visibility into agent reasoning and actions as they unfold in real time.

LangGraph is trusted in production and powering agents for companies like:

- [Klarna](https://blog.langchain.dev/customers-klarna/) : Customer support bot for 85 million active users
- [Elastic](https://www.elastic.co/blog/elastic-security-generative-ai-features) : Security AI assistant for threat detection
- [Uber](https://dpe.org/sessions/ty-smith-adam-huda/this-year-in-ubers-ai-driven-developer-productivity-revolution/) : Automated unit test generation
- [Replit](https://www.langchain.com/breakoutagents/replit) : Code generation
- And many more ( [see list here](https://www.langchain.com/built-with-langgraph) )


## LangGraph’s ecosystem
 [](#langgraphs-ecosystem)

While LangGraph can be used standalone, it also integrates seamlessly with any LangChain product, giving developers a full suite of tools for building agents. To improve your LLM application development, pair LangGraph with:

- [LangSmith](http://www.langchain.com/langsmith) — Helpful for agent evals and observability. Debug poor-performing LLM app runs, evaluate agent trajectories, gain visibility in production, and improve performance over time.
- [LangGraph Platform](https://langchain-ai.github.io/langgraphjs/concepts/#langgraph-platform) — Deploy and scale agents effortlessly with a purpose-built deployment platform for long running, stateful workflows. Discover, reuse, configure, and share agents across teams — and iterate quickly with visual prototyping in [LangGraph Studio](https://langchain-ai.github.io/langgraphjs/concepts/langgraph_studio/) .


## Pairing with LangGraph Platform
 [](#pairing-with-langgraph-platform)

While LangGraph is our open-source agent orchestration framework, enterprises that need scalable agent deployment can benefit from [LangGraph Platform](https://langchain-ai.github.io/langgraphjs/concepts/langgraph_platform/) .

LangGraph Platform can help engineering teams:

- **Accelerate agent development** : Quickly create agent UXs with configurable templates and [LangGraph Studio](https://langchain-ai.github.io/langgraphjs/concepts/langgraph_studio/) for visualizing and debugging agent interactions.
- **Deploy seamlessly** : We handle the complexity of deploying your agent. LangGraph Platform includes robust APIs for memory, threads, and cron jobs plus auto-scaling task queues & servers.
- **Centralize agent management & reusability** : Discover, reuse, and manage agents across the organization. Business users can also modify agents without coding.


## Additional resources
 [](#additional-resources)

- [LangChain Forum](https://forum.langchain.com/) : Connect with the community and share all of your technical questions, ideas, and feedback.
- [LangChain Academy](https://academy.langchain.com/courses/intro-to-langgraph) : Learn the basics of LangGraph in our free, structured course.
- [Tutorials](https://langchain-ai.github.io/langgraphjs/tutorials/) : Simple walkthroughs with guided examples on getting started with LangGraph.
- [Templates](https://langchain-ai.github.io/langgraphjs/concepts/template_applications/) : Pre-built reference apps for common agentic workflows (e.g. ReAct agent, memory, retrieval etc.) that can be cloned and adapted.
- [How-to Guides](https://langchain-ai.github.io/langgraphjs/how-tos/) : Quick, actionable code snippets for topics such as streaming, adding memory & persistence, and design patterns (e.g. branching, subgraphs, etc.).
- [API Reference](https://langchain-ai.github.io/langgraphjs/reference/) : Detailed reference on core classes, methods, how to use the graph and checkpointing APIs, and higher-level prebuilt components.
- [Built with LangGraph](https://www.langchain.com/built-with-langgraph) : Hear how industry leaders use LangGraph to ship powerful, production-ready AI applications.


## Acknowledgements
 [](#acknowledgements)

LangGraph is inspired by [Pregel](https://research.google/pubs/pub37252/) and [Apache Beam](https://beam.apache.org/) . The public interface draws inspiration from [NetworkX](https://networkx.org/documentation/latest/) . LangGraph is built by LangChain Inc, the creators of LangChain, but can be used without LangChain.





## About

Framework to build resilient language agents as graphs.

[docs.langchain.com/oss/javascript/langgraph/](https://docs.langchain.com/oss/javascript/langgraph/)

### Topics


[node](/topics/node) [typescript](/topics/typescript) [ai](/topics/ai) [artificial-intelligence](/topics/artificial-intelligence) [agents](/topics/agents) [llm](/topics/llm) [generative-ai](/topics/generative-ai)


### Resources

[Readme](#readme-ov-file)

### License

[MIT license](#MIT-1-ov-file)

### Code of conduct

[Code of conduct](#coc-ov-file)

### Contributing

[Contributing](#contributing-ov-file)

### Security policy

[Security policy](#security-ov-file)


### Uh oh!


There was an error while loading. Please reload this page .


[Activity](/langchain-ai/langgraphjs/activity)

[Custom properties](/langchain-ai/langgraphjs/custom-properties)

### Stars

[**2.8k** stars](/langchain-ai/langgraphjs/stargazers)

### Watchers

[**24** watching](/langchain-ai/langgraphjs/watchers)

### Forks

[**460** forks](/langchain-ai/langgraphjs/forks)

[Report repository](/contact/report-content?content_url=https%3A%2F%2Fgithub.com%2Flangchain-ai%2Flanggraphjs&report=langchain-ai+%28user%29)



## [Releases 289](/langchain-ai/langgraphjs/releases)
 [

@langchain/langgraph@1.2.8 Latest

Apr 7, 2026

](/langchain-ai/langgraphjs/releases/tag/%40langchain%2Flanggraph%401.2.8)
[+ 288 releases](/langchain-ai/langgraphjs/releases)



### Uh oh!


There was an error while loading. Please reload this page .



## [Contributors](/langchain-ai/langgraphjs/graphs/contributors)

-
-
-


### Uh oh!


There was an error while loading. Please reload this page .



## Languages



- [TypeScript 97.9%](/langchain-ai/langgraphjs/search?l=typescript)
- [Svelte 0.8%](/langchain-ai/langgraphjs/search?l=svelte)
- [JavaScript 0.8%](/langchain-ai/langgraphjs/search?l=javascript)
- [Python 0.2%](/langchain-ai/langgraphjs/search?l=python)
- [CSS 0.2%](/langchain-ai/langgraphjs/search?l=css)
- [Shell 0.1%](/langchain-ai/langgraphjs/search?l=shell)








## Footer


[](https://github.com) © 2026 GitHub, Inc.


You can’t perform that action at this time.