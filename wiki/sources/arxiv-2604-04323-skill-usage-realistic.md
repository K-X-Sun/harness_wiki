---
date: '2026-04-15'
source_type: paper
tags:
- type-paper
- arxiv-2604-04323
- topic-skill
- topic-agent
title: 'How Well Do Agentic Skills Work in the Wild: Benchmarking LLM Skill Usage
  in Realistic Settings'
---

# How Well Do Agentic Skills Work in the Wild: Benchmarking LLM Skill Usage in Realistic Settings

##### Report GitHub Issue
 ×
Title:
Content selection saved. Describe the issue below:
 Description:
 Submit without GitHub Submit in GitHub
[![arXiv logo](/static/browse/0.3.4/images/arxiv-logo-one-color-white.svg)
 Back to arXiv](/)
 TOC, dark mode, links

[License: CC BY 4.0](https://info.arxiv.org/help/license/index.html#licenses-available)
arXiv:2604.04323v1 [cs.CL] 06 Apr 2026



# How Well Do Agentic Skills Work in the Wild:
 Benchmarking LLM Skill Usage in Realistic Settings

Yujian Liu 1 Jiabao Ji 1∗ Li An 1 Tommi Jaakkola 2 Yang Zhang 3† Shiyu Chang 1†
 1 UC Santa Barbara 2 MIT CSAIL 3 MIT-IBM Watson AI Lab
 {yujianliu,jiabaoji,li_an,chang87}@ucsb.edu ,
 tommi@csail.mit.edu , yang.zhang2@ibm.com Equal contribution.Equal advising.


###### Abstract

Agent skills, which are reusable, domain-specific knowledge artifacts, have become a popular mechanism for extending LLM-based agents, yet formally benchmarking skill usage performance remains scarce. Existing skill benchmarking efforts focus on overly idealized conditions, where LLMs are directly provided with hand-crafted, narrowly-tailored task-specific skills for each task, whereas in many realistic settings, the LLM agent may have to search for and select relevant skills on its own, and even the closest matching skills may not be well-tailored for the task. In this paper, we conduct the first comprehensive study of skill utility under progressively challenging realistic settings, where agents must retrieve skills from a large collection of 34k real-world skills and may not have access to any hand-curated skills. Our findings reveal that the benefits of skills are fragile: performance gains degrade consistently as settings become more realistic, with pass rates approaching no-skill baselines in the most challenging scenarios. To narrow this gap, we study skill refinement strategies, including query-specific and query-agnostic approaches, and we show that query-specific refinement substantially recovers lost performance when the initial skills are of reasonable relevance and quality. We further demonstrate the generality of retrieval and refinement on Terminal-Bench 2.0 , where they improve the pass rate of Claude Opus 4.6 from 57.7% to 65.5%. Our results, consistent across multiple models, highlight both the promise and the current limitations of skills for LLM-based agents. Our code is available at [https://github.com/UCSB-NLP-Chang/Skill-Usage](https://github.com/UCSB-NLP-Chang/Skill-Usage) .



## 1 Introduction


LLM-based agents are rapidly transforming how people build software, analyze data, and automate complex workflows [(Anthropic, [2026b](#bib.bib14) ; OpenAI, [2026](#bib.bib13) ; Google DeepMind, [2026](#bib.bib12) )] . A key mechanism for extending agent capabilities beyond their training knowledge is the use of *skills* , reusable knowledge artifacts that encode domain-specific workflows, API usage patterns, coding conventions, and best practices in a structured format [(Anthropic, [2026a](#bib.bib17) )] . Skills have seen broad adoption across major agent platforms, including Claude Code, Codex, and a growing ecosystem of open-source repositories [(Anthropic, [2025](#bib.bib18) ; OpenAI, [2025](#bib.bib16) ; Steinberger and Contributors, [2025](#bib.bib15) )] , enabling users to transform general-purpose agents into specialists for tasks ranging from data engineering to web development.



Despite this widespread adoption, there is surprisingly little rigorous evaluation of whether skills actually help agents solve tasks more effectively. Recent benchmarks such as SkillsBench [(Li et al. , [2026](#bib.bib11) )] provide initial evidence that skills can improve agent performance. However, their evaluation setups are overly idealized in two important ways. First, the skills provided in SkillsBench are hand-crafted to overfit to each evaluation task, often encoding step-by-step guidance specific to the task rather than general-purpose, reusable knowledge. For example, as shown in Figure [1](#S1.F1) (left), one of SkillsBench ’s tasks requires identifying flooding days for USGS stations, and it is paired with three curated skills: one detailing how to download water level data from the USGS API, another specifying the exact URL for NWS flood threshold data, and a third containing code snippets for counting flooding days. These skills combined almost directly spell out the exact solution guide for the task. Second, the curated skills are directly placed in the agent’s context, bypassing the practical challenge of discovering the right skills from a large and noisy collection. These idealizations raise a fundamental question: *Do skills remain helpful under realistic conditions, where agents must retrieve relevant skills from a large, noisy pool and adapt general-purpose, non-task-specific skills to user queries?*



![Refer to caption](2604.04323v1/x1.png)



![Refer to caption](2604.04323v1/x2.png)

 *Figure 1: Left: A SkillsBench example where the task asks agents to identify flooding days at USGS stations. The three curated skills collectively provide the specific API to call, the data source URL for flood thresholds, and code snippets for flood detection (task-specific details are highlighted in blue), effectively forming a step-by-step solution guide. These skills are directly placed in the agent’s context without requiring retrieval. Right: Agent pass rates on SkillsBench degrade as evaluation settings become more realistic, from curated skills to settings where agents must retrieve skills from a large collection.*



In this work, we conduct a comprehensive study of skill utility under realistic conditions. To enable this study, we assemble a collection of 34k real-world skills from open-source repositories, filtered by permissive licenses, quality, and deduplicated. We explore various search methods for skill retrieval, including keyword, semantic, hybrid, and agentic search, and find that agentic hybrid search, where the agent iteratively formulates queries and evaluates candidate skills, significantly outperforms other approaches.



Building on this infrastructure, we evaluate skill utility on SkillsBench under progressively more realistic settings: from augmenting human-curated skills with distractors, to retrieving from the full skill collection (including the curated skills), to retrieving from a collection where the curated skills have been entirely removed. Among our findings, a key result is that skill benefits degrade consistently as settings become more realistic (Figure [1](#S1.F1) , right), with performance eventually approaching no-skill baselines in the most challenging scenario. This trend is observed across multiple models, including Claude Opus 4.6 [(Anthropic, [2026b](#bib.bib14) )] , Kimi K2.5 [(Kimi, [2026](#bib.bib10) )] , and Qwen3.5-397B-A17B [(Qwen, [2025](#bib.bib9) )] . Our analyses also reveal two bottlenecks limiting skill utility: ❶ Agents struggle to determine which skills are worth loading, leaving potentially helpful skills unused; and ❷ The content of retrieved skills is often noisy or lacks the precise information needed for the task.



To address these bottlenecks, we study skill refinement strategies to both improve skill selection and distill more useful content from noisy retrieved skills. Specifically, we compare query-specific refinement, where the agent explores and adapts retrieved skills to the target task, and query-agnostic refinement, where skills are improved offline without knowledge of the downstream task. We find that query-specific refinement is beneficial, substantially recovering lost performance when the initially retrieved skills are of reasonable quality, though gains are more limited when relevant skills are absent from the collection. Finally, to demonstrate the generality of our approach beyond benchmarks designed for skills, we further evaluate skill retrieval and refinement on Terminal-Bench 2.0 [(Merrill et al. , [2026](#bib.bib8) )] , a general-purpose agent benchmark without human-curated skills, and show that skill retrieval and refinement improve the pass rate from 57.7% to 65.5% with Claude Opus 4.6 .



To summarize, our contributions are as follows:

- •

We introduce a realistic evaluation framework for agent skills with progressively challenging settings that move beyond the idealized assumptions of prior works, and provide empirical evidence that skill benefits are fragile and degrade under realistic conditions.
- •

We conduct a comprehensive skill retrieval study, comparing keyword, semantic, hybrid, and agentic search strategies, and demonstrate the effectiveness of agentic hybrid search.
- •

We present an in-depth analysis of skill refinement strategies, including query-specific and query-agnostic approaches, revealing when and why refinement helps.



## 2 Related Work


#### Reusable knowledge for LLM agents.


A growing body of work explores how LLM agents can accumulate and reuse knowledge across tasks, taking various forms including programmatic tools and actions [(Cai et al. , [2024](#bib.bib6) ; Nguyen et al. , [2025](#bib.bib21) ; Wang et al. , [2025](#bib.bib22) )] , skill libraries built through exploration in embodied environments [(Wang et al. , [2023](#bib.bib20) ; Shi et al. , [2026](#bib.bib23) )] , structured instruction manuals [(Chen et al. , [2024](#bib.bib4) ; Liu et al. , [2025](#bib.bib1) )] , reusable workflows and procedural memory extracted from agent experience [(Zhao et al. , [2024](#bib.bib26) ; Wang et al. , [2024](#bib.bib24) ; Mi et al. , [2026](#bib.bib25) )] , and persistent agent memory that retains useful knowledge across sessions [(Hu et al. , [2026](#bib.bib5) )] . Several recent works further study how such knowledge can be automatically evolved and improved over time through self-improvement loops [(Zheng et al. , [2025](#bib.bib27) )] or reinforcement learning [(Xia et al. , [2026](#bib.bib30) ; Wang et al. , [2026](#bib.bib31) )] . While these works demonstrate broad interest in reusable knowledge, they each adopt different formats and definitions, and focus primarily on knowledge creation and evolution. Our work studies a standardized skill format and addresses the complementary question of whether retrieved skills actually help under realistic conditions.



#### Agentic skills.


A standardized notion of *agentic skills* has been recently proposed: file-system-based knowledge artifacts consisting of a skill file ( SKILL.md ) with structured metadata and content, optionally accompanied by helper files [(Anthropic, [2026a](#bib.bib17) )] . Following this, a rapidly growing ecosystem of work has emerged around agentic skills, spanning skill taxonomy and lifecycle analysis [(Jiang et al. , [2026b](#bib.bib32) )] , large-scale skill infrastructure [(Liang et al. , [2026](#bib.bib35) )] , automated skill discovery and evolution [(Yang et al. , [2026](#bib.bib28) ; Alzubi et al. , [2026](#bib.bib29) )] , skill routing at scale [(Zheng et al. , [2026](#bib.bib34) )] , skills as persistent evolving memory [(Zhou et al. , [2026](#bib.bib37) )] , and security risks of third-party skill files [(Schmotz et al. , [2026](#bib.bib36) )] . On the benchmarking side, [Li et al. ( [2026](#bib.bib11) )] introduces SkillsBench and [Han et al. ( [2026](#bib.bib33) )] studies skills in real-world software engineering, but both evaluate under idealized conditions where curated skills are directly provided. Our work is the first to systematically evaluate skill utility under progressively realistic conditions and to study refinement strategies for narrowing the resulting performance gap.



#### Agent self-improvement and test-time adaptation.


Our skill refinement strategies, where the agent explores and adapts retrieved knowledge to the target task, connect to work on agents that improve through experience and test-time adaptation. Foundational approaches enable agents to learn from task feedback through verbal self-reflection [(Shinn et al. , [2023](#bib.bib38) )] , policy gradient optimization [(Yao et al. , [2024](#bib.bib39) )] , and memory-based online reinforcement learning [(Zhou et al. , [2025](#bib.bib43) )] . More recent work accumulates reusable knowledge at inference time, including adaptive strategies and code snippets [(Suzgun et al. , [2025](#bib.bib40) )] , generalizable reasoning patterns [(Ouyang et al. , [2026](#bib.bib41) )] , and continuously evolving memory [(Zhang et al. , [2026b](#bib.bib42) ; [a](#bib.bib44) )] . [Yan et al. ( [2026](#bib.bib45) )] provides a diagnostic framework for evaluating test-time improvement in agents. We refer the reader to [Fang et al. ( [2025](#bib.bib46) )] and [Jiang et al. ( [2026a](#bib.bib3) )] for broader surveys of self-evolving agents and agent adaptation paradigms.



## 3 Skill Usage in Realistic Settings


As illustrated in Figure [1](#S1.F1) (left), prior evaluations provide agents with a small set of hand-curated, task-specific skills directly in context. In real-world usage, however, this idealized setup bypasses three challenges that agents typically face in practice:

1. 1.

Skill selection. Even when relevant skills are provided to the agent, it must correctly identify which ones are useful and decide to load them, particularly when they appear among many other available skills.
2. 2.

Skill retrieval. Users rarely provide pre-selected skills for every task. Instead, the agent must search through large skill repositories on its own to find potentially relevant ones.
3. 3.

Skill adaptation. When no skills have been specifically authored for the task at hand, the agent must work with retrieved skills that only partially align with the task requirements, extracting useful information from noisy or tangentially relevant content.

We design experiments that progressively introduce these challenges. To enable this, we first assemble a large-scale skill collection (§ [3.1](#S3.SS1) ) and build a retrieval system to search over it (§ [3.2](#S3.SS2) ), then evaluate agent performance under increasingly realistic settings on SkillsBench (§ [3.3](#S3.SS3) ).



### 3.1 Skill Collection


To simulate realistic conditions where agents need to search over a large pool and work with skills not narrowly tailored to user queries, we assemble a collection of real-world skills from open-source repositories. We source skill metadata from two skill aggregation platforms, skillhub.club and skills.sh 1 1 1 [https://www.skillhub.club/](https://www.skillhub.club/) and [https://skills.sh/](https://skills.sh/) . , then download the full skill folder including the SKILL.md file and other helper files from their original GitHub repositories. We filter by permissive licenses (MIT and Apache 2.0) to ensure redistribution rights, remove ill-formatted skills with empty names or descriptions, and deduplicate by file content. The resulting collection contains 34,198 skills spanning diverse domains, including web development, data engineering, development operations, scientific computing, etc.



### 3.2 Skill Search Engine


A critical challenge in realistic skill usage is retrieving relevant skills from a large collection. To facilitate the evaluation of the skill retrieval capabilities in LLMs, we build a skill engine tool with a skill index and compare multiple retrieval strategies of increasing sophistication.



#### Skill index.


Each skill is indexed with two representations: ① *metadata* , a concatenation of the skill’s name and description, and ② *full content* in SKILL.md . We use Qwen3-Embedding-4B [(Zhang et al. , [2025](#bib.bib7) )] for dense embeddings and BM25 for sparse keyword matching.



#### Search methods.


We compare two categories of retrieval approaches:

- •

Direct search : the task description is used as a query to retrieve the top- k k skills based on similarity of dense embeddings over the metadata index.
- •

Agentic search : the agent is given access to search tools and iteratively formulates queries, retrieves candidates, and evaluates their relevance before selecting a final set of skills. We evaluate four agentic variants: ① keyword: the agent has access to a BM25-based search tool only; ② semantic: the agent has access to a dense embedding search tool only; ③ hybrid w/o content: the agent has access to all three tools (keyword, semantic, and a hybrid tool that combines their scores), with similarity computed over the metadata index only; ④ hybrid w/ content: same as ③, but similarity is a weighted average over both the metadata and full skill content indices.

Further details on the index and search implementation are provided in Appendix [A](#A1) .



#### Results.


We measure retrieval quality using Recall@ k k : the fraction of ground-truth skills that appear in the top- k k retrieved results, averaged across all tasks. We consider the manually-curated skills in SkillsBench as the ground-truth for each task. For agentic search, we use Claude Opus 4.6 with Claude Code as the agent.



| Method | Recall@3 | Recall@5 | Recall@10 |
|---|---|---|---|
| Direct (semantic) | 38.1 | 47.0 | 52.3 |
| Agentic (keyword) | 24.1 | 26.6 | 27.5 |
| Agentic (semantic) | 56.8 | 63.1 | 66.5 |
| Agentic (hybrid) w/o content | 57.7 | 63.5 | 66.7 |
| Agentic (hybrid) w/ content | 57.3 | 65.5 | 68.3 |
 *Table 1: Skill retrieval performance of Claude Opus 4.6 with Claude Code on SkillsBench (Recall@ k k , %). The retrieval pool contains the curated skills among 34k total skills.*



Table [1](#S3.T1) reports the results. As shown, agentic search substantially outperforms direct search. With the same semantic search tool, agentic search outperforms direct search in Recall@3 by 18.7 points, as the agent can iteratively formulate queries, inspect returned candidates, and refine its search strategy beyond a single fixed query. Among the agentic variants, using semantic search tool greatly outperforms keyword search tool, indicating that semantic similarity is essential for skill retrieval. Adding the full skill content index provides a modest but consistent gain at higher k k values (Recall@5: 63.5% → \rightarrow 65.5%; Recall@10: 66.7% → \rightarrow 68.3%), as the full skill content captures information not covered by metadata alone, enabling broader search over the skill collection. Based on these results, we use agentic hybrid search with full skill content as the default retrieval method in subsequent experiments.



### 3.3 Progressive Evaluation Settings


We now evaluate skill utility on SkillsBench under progressively realistic settings that systematically vary three factors: whether the agent must select which skills to load on its own (forced vs. autonomous), how skills are discovered (user-provided vs. agent-retrieved), and what skills are available (human-curated vs. general-purpose).



#### Settings.


We define the following evaluation conditions, ordered from most idealized to most realistic. Each setting introduces one of the three challenges identified above.

- •

Curated + forced load : the original curated skills are placed in the agent’s environment, and the agent is explicitly instructed to load all of them. This represents an upper bound on curated skill utility, bypassing all three challenges.
- •

Curated : the original SkillsBench setup, where curated skills are placed in the agent’s environment, but whether and when to load them are deferred to the agent itself. This introduces the challenge of *skill selection* : the agent must recognize which available skills are worth loading.
- •

Curated + distractors : all curated skills remain available to the agent, but we add distracting skills retrieved via agentic search from the 34k collection, keeping the total number of skills at 5 for consistency with the retrieval settings. This intensifies the *selection* challenge, as the agent must identify curated skills among noise.
- •

Retrieved (w/ curated) : the agent retrieves top-5 skills from the 34k collection augmented with the curated skills. This introduces the challenge of *skill retrieval* : relevant skills are no longer directly provided, and the agent must search for skills on its own.
- •

Retrieved (w/o curated) : the agent retrieves top-5 skills from the 34k collection without curated skills. This further introduces the challenge of *skill adaptation* : no skills have been specifically authored for the tasks, and the agent must extract useful information from general-purpose skills that only partially align with the task requirements.
- •

No skills : the agent receives no skills, serving as the baseline.



#### Models and evaluation.


We evaluate with Claude Opus 4.6 , Kimi K2.5 , and Qwen3.5-397B-A17B , representing frontier proprietary and strong open-weight models. Each model is paired with its native agent harness: Claude Code for Claude, Terminus-2 [(Harbor Framework Team, [2026](#bib.bib19) )] for Kimi, 2 2 2 Terminus-2 was used by Kimi’s evaluation on Terminal-Bench 2.0. and Qwen-Code for Qwen. Each model independently runs the entire pipeline, including skill retrieval, task completion, and later refinement (§ [4](#S4) ), so that results reflect the end-to-end capability of each model and harness pair. We evaluate on 84 tasks from SkillsBench (excluding tasks with known issues), running each condition 3 times per task. Further details are provided in Appendix [B](#A2) .



#### Results.


Figure [2](#S3.F2) presents the main results. Panel (a) shows average pass rates, while panel (b) shows skill usage: the fraction of trajectories that load any skill (solid bars) and the fraction that load all curated skills (hatched bars). We highlight three key observations.


![Refer to caption](2604.04323v1/x3.png)
 *Figure 2: (a) Pass rates on SkillsBench under progressively realistic settings, including a force-loaded upper bound. Performance degrades consistently as settings become more realistic. (b) Skill usage across settings. Solid bars show the fraction of trajectories that load any skill; hatched bars show the fraction that load all curated skills. Agents often fail to load curated skills even when they are directly available, and the gap widens as distractors are added and retrieval is required.*



#### Skill Selection: Agents fail to select the right skills, even when they are directly available.


The first three settings all provide curated skills to the agent, yet performance drops substantially across them. Force-loading curated skills yields 55.4% for Claude, but simply letting the agent decide which to load reduces this to 51.2%, even though the same skills are available. Adding distractors causes a further drop to 43.5%. The skill usage panel reveals the reason: only 49% of Claude trajectories load all curated skills in the curated setting, falling to 31% with distractors. Qwen shows a similar performance pattern (41.2% → \rightarrow 31.6% → \rightarrow 33.7%). Interestingly, Kimi exhibits much higher skill loading rates even without forced loading (86% in the curated setting vs. 62% for Claude), indicating that the agent harness significantly influences skill loading behavior. However, this higher loading rate does not translate into better task performance (38.9% curated vs. 38.5% force-loaded), indicating that skill utility involves not just loading skills but also effectively utilizing their content.



#### Skill Retrieval: Requiring agents to retrieve skills further degrades performance.


When relevant skills are no longer directly provided and the agent must retrieve them, performance drops further: Claude falls to 40.1% and Kimi to 33.5% when curated skills remain in the retrieval pool. This compounds the selection challenge with imperfect retrieval (our best retrieval achieves 65.5% Recall@5 in Table [1](#S3.T1) ), meaning curated skills are not always among the candidates the agent sees. The skill usage panel also reflects this: Claude’s loading rate drops to 44% under retrieval, compared to 62% in the curated setting.



#### Skill Adaptation: Without curated skills, agents struggle to adapt general-purpose skills and approach the no-skill baseline.


When curated skills are removed from the retrieval pool entirely, the agent can only find general-purpose skills not tailored to the tasks. Claude drops to 38.4%, only 3.0 points above the no-skill baseline, and skill usage falls to just 16% of trajectories. The results are more severe for other models: both Kimi (19.8% vs. 21.8% baseline) and Qwen (19.7% vs. 20.5% baseline) drop below their no-skill baselines, indicating that irrelevant retrieved skills can actively mislead the agent, *e.g.,* by spending effort loading and following unhelpful instructions that would have been better ignored entirely. This contrast suggests that stronger models can better ignore irrelevant skills, while weaker models are more likely to be hurt by low-quality retrieved skills .



#### Summary.


The observed gap between the force-loaded upper bound and the most realistic setting motivates two directions for skill refinement (§ [4](#S4) ). First, the sharp drop in skill usage even when curated skills are available suggests that agents struggle to recognize relevant skills from their names and descriptions alone, and refining skill metadata may help agents better select which skills to load. Second, the difficulty of adapting general-purpose skills motivates refining skill content itself to improve clarity and relevance, making retrieved skills more useful in the absence of curated skills. These observations have motivated us to remove these bottlenecks with skill refinement, which is introduced in the next section.



## 4 Narrowing the Gap with Skill Refinement


We now investigate whether *skill refinement* , the process of transforming retrieved skills into more useful forms, can recover the lost performance. We describe two refinement strategies (§ [4.1](#S4.SS1) ) and evaluate them on both SkillsBench and Terminal-Bench 2.0 (§ [4.2](#S4.SS2) ).



### 4.1 Refinement Strategies


We study two strategies for improving skill quality before the agent attempts the task. Full details including prompts are provided in Appendix [C](#A3) .



#### Query-agnostic refinement.


The progressive evaluation in § [3.3](#S3.SS3) shows that high-quality curated skills substantially improve agent performance. A natural aspiration is therefore to improve the entire 34k skill collection offline to approximate curated-level quality. However, refining all 34k skills is cost-prohibitive, so we instead apply query-agnostic refinement only to the retrieved skills for each task, treating this as an approximation of what a fully improved collection would provide. To preserve this offline nature, each retrieved skill is refined independently, without knowledge of the target task or other retrieved skills.



We leverage Anthropic’s skill-creator , 3 3 3 [https://github.com/anthropics/skills/tree/main/skills/skill-creator](https://github.com/anthropics/skills/tree/main/skills/skill-creator) . a meta-skill that encodes best practices for writing effective skills, to drive the improvement process. For each skill, the model generates synthetic test queries that the skill might be used for, then runs an agent with and without the skill on these queries. The model compares the two agents’ outputs, self-evaluates whether the skill helped or hurt, and uses this feedback to iteratively improve the skill. Because this computation happens entirely offline, query-agnostic refinement is cheap at inference time and can be applied as a preprocessing step. However, it has two limitations: it cannot adapt skills to the specific needs of a given task, and because each skill is refined in isolation, it cannot compose information across multiple retrieved skills.



#### Query-specific refinement.


To address these limitations, query-specific refinement allows the agent to directly explore the target task before refining. The agent reads the task instruction, examines all retrieved skills, attempts an initial solution, and self-evaluates correctness (the agent *does not* have access to the ground-truth verifier). Based on this exploration, the agent reflects on which skills were useful and which were misleading, then composes a refined set of skills tailored to the specific task. The agent also has access to the skill-creator meta-skill as guidance for writing effective skill metadata and content. Crucially, unlike query-agnostic refinement, the agent can merge and synthesize across multiple retrieved skills, extracting the relevant portions from each and combining them into a single coherent skill while discarding irrelevant content. This strategy has high potential but is also more expensive, as it requires a full exploration pass per task at inference time.



### 4.2 Results


We evaluate both refinement strategies on SkillsBench under the retrieved (w/ curated) and retrieved (w/o curated) settings from § [3.3](#S3.SS3) . To assess generalizability, we additionally evaluate on Terminal-Bench 2.0 , a widely-used agent benchmark containing 89 tasks spanning system administration, file manipulation, programming challenges, etc. Unlike SkillsBench , Terminal-Bench 2.0 was not designed with skills in mind and has no curated skills, so the agent retrieves from our full skill collection. Table [2](#S4.T2) presents the results.



|  | Claude Opus 4.6 | Kimi K2.5 * | Qwen3.5-397B-A17B |
|---|---|---|---|
|  | Pass | Load | Pass | Load | Pass | Load |
| SkillsBench |
| Curated skills | 51.2 | 62.2 | 38.9 | 86.1 | 31.6 | 73.8 |
| No skills | 35.4 | 0.0 | 21.8 | 0.0 | 20.5 | 0.0 |
| Retrieved (w/ curated) | 40.1 | 44.4 | 33.5 | 69.7 | 26.7 | 65.5 |
| + Query-specific | 48.2 | 72.2 | 26.7 | 95.2 | 30.8 | 75.0 |
| + Query-agnostic | 42.0 | 32.9 | — | — | 26.2 | 68.3 |
| Retrieved (w/o curated) | 38.4 | 16.3 | 19.8 | 37.7 | 19.7 | 54.8 |
| + Query-specific | 37.9 | 61.1 | 23.1 | 90.9 | 21.5 | 69.4 |
| + Query-agnostic | 37.4 | 12.3 | — | — | 24.6 | 53.2 |
| Terminal-Bench 2.0 |
| No skills | 57.7 | 0.0 | 46.6 | 0.0 | 44.7 | 0.0 |
| Retrieved | 61.4 | 40.8 | 50.6 | 79.0 | 44.2 | 31.1 |
| + Query-specific | 65.5 | 74.9 | 56.2 | 93.6 | 49.1 | 42.3 |
| + Query-agnostic | 63.3 | 33.7 | — | — | 44.9 | 38.4 |
 *Table 2: Effect of skill refinement on pass rates (Pass, %) and skill loading rates (Load, % of trajectories that load any skill) across SkillsBench and Terminal-Bench 2.0 . Query-specific refinement substantially improves both performance and skill adoption when initially retrieved skills are of high relevance. *Kimi’s query-agnostic results are omitted because Terminus-2 does not support subagent operations that are needed.*



#### Query-specific refinement is broadly effective.


Query-specific refinement improves performance in 7 out of 9 cases in Table [2](#S4.T2) . On SkillsBench with curated skills in the retrieval pool, it improves Claude from 40.1% to 48.2%, recovering most of the gap to the curated setting. For Qwen, the gain is similar: 26.7% to 30.8%. On Terminal-Bench 2.0 , where no curated skills exist, query-specific refinement consistently improves all three models: +4.1 for Claude, +5.6 for Kimi, and +4.9 for Qwen, confirming that the benefits extend to a general-purpose benchmark not designed for skills. The one notable exception is Kimi on SkillsBench w/ curated, where the pass rate drops from 33.5% to 26.7%, suggesting that the exploration and self-evaluation process can be counterproductive when the model misjudges which skills are useful. Notably, skill loading rates also increase substantially with query-specific refinement ( *e.g.,* 44% to 72% for Claude on SkillsBench w/ curated), indicating that refinement produces skills that agents are more likely to use. Figure [3](#S4.F3) illustrates how query-specific refinement composes useful information scattered across multiple retrieved skills: the agent extracts tensor parallelism concepts from one skill and custom autograd patterns from another, synthesizing them into a single skill with differentiable collective operations that neither original skill provides on its own.


![Refer to caption](2604.04323v1/x4.png)
 *Figure 3: Example of query-specific refinement on a Terminal-Bench 2.0 tensor parallelism task. Top: Without refinement, the agent retrieves two partially relevant skills but only loads torch-tensor-parallel , ignoring pytorch-research . The loaded skill covers weight sharding but lacks differentiable collective wrappers, leading to wrong implementation for world_size > > 1. Bottom: After refinement, the agent synthesizes a new skill that merges tensor parallelism knowledge from the first skill with custom autograd.Function patterns from the second, producing an implementation that passes all tests.*



#### Query-agnostic refinement yields smaller gains.


Query-agnostic refinement provides moderate improvements in some settings ( *e.g.,* Claude rises from 40.1% to 42.0% on SkillsBench w/ curated and from 61.4% to 63.3% on Terminal-Bench 2.0 ), but the gains are inconsistent and sometimes negligible. Without access to the target task, the improvement process can clean up formatting and improve clarity, but cannot identify which parts of a skill are most relevant or synthesize information across multiple skills. Because query-agnostic refinement moves computation offline, it is cheap at inference time, but the limited and variable gains suggest that task awareness is important for effective refinement.



#### Refinement effectiveness depends on initial skill quality.


An interesting pattern in Table [2](#S4.T2) is that query-specific refinement yields large gains in some settings but not others. Under *retrieved (w/o curated)* on SkillsBench , query-specific refinement yields modest or even no gains for three models. To explain this asymmetry, we assess the relevance and coverage of the initially retrieved skills using an LLM judge ( GPT-5.4 ) that scores each task’s retrieved skill set on a 1-5 scale (a higher score means retrieved skills are more relevant and collectively cover different aspects of the target task).



| Setting | Claude | Kimi | Qwen |
|---|---|---|---|
| SB: w/ curated | 4.01 | 3.83 | 3.85 |
| SB: w/o curated | 3.49 | 3.31 | 3.39 |
| TB: Retrieved | 4.02 | 3.96 | 4.08 |
 *Table 3: Average coverage scores of initially retrieved skills, judged by an LLM. Higher scores indicate greater task relevance and coverage.*



Table [3](#S4.T3) reveals a clear pattern: the settings where query-specific refinement succeeds ( SkillsBench w/ curated, Terminal-Bench ) have high initial coverage scores ( ≥ \geq 3.83), while the setting where it fails ( SkillsBench w/o curated) has notably lower scores ( ≤ \leq 3.49). This confirms that refinement acts more like a *multiplier* on existing skill quality rather than a *generator* of new knowledge. When the retrieved skills contain relevant information, even if imperfectly matched, query-specific refinement can extract and amplify that signal through exploration and composition. When relevant skills are absent entirely, it struggles to synthesize useful information.



## 5 Conclusion


We presented a comprehensive study of agent skill utility under realistic conditions, showing that skill benefits degrade substantially as agents must retrieve from large collections and work with general-purpose skills not tailored to the task. Our further study shows that query-specific refinement can recover much of this lost performance when retrieved skills are of reasonable relevance, but cannot compensate when relevant skills are absent entirely, suggesting that refinement amplifies existing skill quality rather than generating new knowledge. These findings highlight the need for better skill retrieval, more effective offline refinement methods, and skill ecosystems that account for varying model capabilities.



## Ethics Statement


This work studies the effectiveness of agent skills under realistic conditions using publicly available benchmarks and open-source skills filtered by permissive licenses (MIT and Apache 2.0). Our skill collection is sourced from public GitHub repositories and does not contain private or sensitive data. All model evaluations are conducted on established coding benchmarks in isolated Docker containers, posing no risk to external systems.



## LLM Usage Disclosure


In accordance with COLM’s policy on LLM use, we disclose the following LLM usage. In research, LLMs were used to assist with modifying existing open-source repositories for the evaluation infrastructure, debugging code, and analyzing agent trajectories. In writing, LLMs assisted with revising and smoothing text drafted by the authors, proofreading, writing plotting scripts, and formatting tables and other LaTeX elements. All research ideas, experimental design, and analysis are the work of the authors.



## Acknowledgments


UCSB acknowledges the support from National Science Foundation(NSF) Grant IIS-2338252, NSF Grant IIS-2302730, and the Open Philanthropy Research Award. Tommi Jaakkola acknowledges the support from NSF Expeditions grant (award 1918839) Understanding the World Through Code.





## References

- S. Alzubi, N. Provenzano, J. Bingham, W. Chen, and T. Vu (2026) EvoSkill: automated skill discovery for multi-agent systems . External Links: 2603.02766 Cited by: [§2](#S2.SS0.SSS0.Px2.p1.1) .
- Anthropic (2025) Claude code documentation: overview . Note: [https://code.claude.com/docs/en/overview](https://code.claude.com/docs/en/overview) Accessed: 2026-03-31 Cited by: [§1](#S1.p1.1) .
- Anthropic (2026a) Agent skills: a simple, open format for giving agents new capabilities . Note: [https://agentskills.io/home](https://agentskills.io/home) Accessed: 2026-03-31 Cited by: [§1](#S1.p1.1) , [§2](#S2.SS0.SSS0.Px2.p1.1) .
- Anthropic (2026b) Claude opus 4.6 system card . Note: System card describing model capabilities, evaluations, and safety assessments External Links: [Link](https://www-cdn.anthropic.com/0dd865075ad3132672ee0ab40b05a53f14cf5288.pdf) Cited by: [1st item](#A2.I2.i1.p1.1) , [§1](#S1.p1.1) , [§1](#S1.p4.1) .
- T. Cai, X. Wang, T. Ma, X. Chen, and D. Zhou (2024) Large language models as tool makers . External Links: 2305.17126 Cited by: [§2](#S2.SS0.SSS0.Px1.p1.1) .
- M. Chen, Y. Li, Y. Yang, S. Yu, B. Lin, and X. He (2024) AutoManual: generating instruction manuals by LLM agents via interactive environmental learning . In The Thirty-eighth Annual Conference on Neural Information Processing Systems , Cited by: [§2](#S2.SS0.SSS0.Px1.p1.1) .
- J. Fang, Y. Peng, X. Zhang, Y. Wang, X. Yi, G. Zhang, Y. Xu, B. Wu, S. Liu, Z. Li, Z. Ren, N. Aletras, X. Wang, H. Zhou, and Z. Meng (2025) A comprehensive survey of self-evolving ai agents: a new paradigm bridging foundation models and lifelong agentic systems . External Links: 2508.07407 Cited by: [§2](#S2.SS0.SSS0.Px3.p1.1) .
- Google DeepMind (2026) Gemini 3.1 pro model card . Note: [https://storage.googleapis.com/deepmind-media/Model-Cards/Gemini-3-1-Pro-Model-Card.pdf](https://storage.googleapis.com/deepmind-media/Model-Cards/Gemini-3-1-Pro-Model-Card.pdf) Accessed: 2026-03-31 Cited by: [§1](#S1.p1.1) .
- T. Han, Y. Zhang, W. Song, C. Fang, Z. Chen, Y. Sun, and L. Hu (2026) SWE-skills-bench: do agent skills actually help in real-world software engineering? . External Links: 2603.15401 Cited by: [§2](#S2.SS0.SSS0.Px2.p1.1) .
- Harbor Framework Team (2026) Harbor: A framework for evaluating and optimizing agents and models in container environments External Links: [Link](https://github.com/harbor-framework/harbor) Cited by: [2nd item](#A2.I2.i2.p1.1) , [Appendix B](#A2.SS0.SSS0.Px3.p1.3) , [§3.3](#S3.SS3.SSS0.Px2.p1.1) .
- Y. Hu, S. Liu, Y. Yue, G. Zhang, B. Liu, F. Zhu, J. Lin, H. Guo, S. Dou, Z. Xi, S. Jin, J. Tan, Y. Yin, J. Liu, Z. Zhang, Z. Sun, Y. Zhu, H. Sun, B. Peng, Z. Cheng, X. Fan, J. Guo, X. Yu, Z. Zhou, Z. Hu, J. Huo, J. Wang, Y. Niu, Y. Wang, Z. Yin, X. Hu, Y. Liao, Q. Li, K. Wang, W. Zhou, Y. Liu, D. Cheng, Q. Zhang, T. Gui, S. Pan, Y. Zhang, P. Torr, Z. Dou, J. Wen, X. Huang, Y. Jiang, and S. Yan (2026) Memory in the age of ai agents . External Links: 2512.13564 Cited by: [§2](#S2.SS0.SSS0.Px1.p1.1) .
- P. Jiang, J. Lin, Z. Shi, Z. Wang, L. He, Y. Wu, M. Zhong, P. Song, Q. Zhang, H. Wang, X. Xu, H. Xu, P. Han, D. Zhang, J. Sun, C. Yang, K. Qian, T. Wang, C. Hu, M. Li, Q. Li, H. Peng, S. Wang, J. Shang, C. Zhang, J. You, L. Liu, P. Lu, Y. Zhang, H. Ji, Y. Choi, D. Song, J. Sun, and J. Han (2026a) Adaptation of agentic ai: a survey of post-training, memory, and skills . External Links: 2512.16301 Cited by: [§2](#S2.SS0.SSS0.Px3.p1.1) .
- Y. Jiang, D. Li, H. Deng, B. Ma, X. Wang, Q. Wang, and G. Yu (2026b) SoK: agentic skills – beyond tool use in llm agents . External Links: 2602.20867 Cited by: [§2](#S2.SS0.SSS0.Px2.p1.1) .
- T. Kimi (2026) Kimi k2.5: visual agentic intelligence . External Links: 2602.02276 Cited by: [2nd item](#A2.I2.i2.p1.1) , [§1](#S1.p4.1) .
- X. Li, W. Chen, Y. Liu, S. Zheng, X. Chen, Y. He, Y. Li, B. You, H. Shen, J. Sun, S. Wang, B. Li, Q. Zeng, D. Wang, X. Zhao, Y. Wang, R. B. Chaim, Z. Di, Y. Gao, J. He, Y. He, L. Jing, L. Kong, X. Lan, J. Li, S. Li, Y. Li, Y. Lin, X. Liu, X. Liu, H. Lyu, Z. Ma, B. Wang, R. Wang, T. Wang, W. Ye, Y. Zhang, H. Xing, Y. Xue, S. Dillmann, and H. Lee (2026) SkillsBench: benchmarking how well agent skills work across diverse tasks . External Links: 2602.12670 Cited by: [1st item](#A2.I1.i1.p1.1) , [§1](#S1.p2.1) , [§2](#S2.SS0.SSS0.Px2.p1.1) .
- Y. Liang, R. Zhong, H. Xu, C. Jiang, Y. Zhong, R. Fang, J. Gu, S. Deng, Y. Yao, M. Wang, S. Qiao, X. Xu, T. Wu, K. Wang, Y. Liu, Z. Bi, J. Lou, Y. E. Jiang, H. Zhu, G. Yu, H. Hong, L. Huang, H. Xue, C. Wang, Y. Wang, Z. Shan, X. Chen, Z. Tu, F. Xiong, X. Xie, P. Zhang, Z. Gui, L. Liang, J. Zhou, C. Wu, J. Shang, Y. Gong, J. Lin, C. Xu, H. Deng, W. Zhang, K. Ding, Q. Zhang, F. Huang, N. Zhang, J. Z. Pan, G. Qi, H. Wang, and H. Chen (2026) SkillNet: create, evaluate, and connect ai skills . External Links: 2603.04448 Cited by: [§2](#S2.SS0.SSS0.Px2.p1.1) .
- Y. Liu, Z. Wang, H. Chen, X. Sun, X. Yu, J. Wu, J. Liu, E. Barsoum, Z. Liu, and S. Chang (2025) Learning from online videos at inference time for computer-use agents . External Links: 2511.04137 Cited by: [§2](#S2.SS0.SSS0.Px1.p1.1) .
- M. A. Merrill, A. G. Shaw, N. Carlini, B. Li, H. Raj, I. Bercovich, L. Shi, J. Y. Shin, T. Walshe, E. K. Buchanan, J. Shen, G. Ye, H. Lin, J. Poulos, M. Wang, M. Nezhurina, J. Jitsev, D. Lu, O. M. Mastromichalakis, Z. Xu, Z. Chen, Y. Liu, R. Zhang, L. L. Chen, A. Kashyap, J. Uslu, J. Li, J. Wu, M. Yan, S. Bian, V. Sharma, K. Sun, S. Dillmann, A. Anand, A. Lanpouthakoun, B. Koopah, C. Hu, E. Guha, G. H. S. Dreiman, J. Zhu, K. Krauth, L. Zhong, N. Muennighoff, R. Amanfu, S. Tan, S. Pimpalgaonkar, T. Aggarwal, X. Lin, X. Lan, X. Zhao, Y. Liang, Y. Wang, Z. Wang, C. Zhou, D. Heineman, H. Liu, H. Trivedi, J. Yang, J. Lin, M. Shetty, M. Yang, N. Omi, N. Raoof, S. Li, T. Y. Zhuo, W. Lin, Y. Dai, Y. Wang, W. Chai, S. Zhou, D. Wahdany, Z. She, J. Hu, Z. Dong, Y. Zhu, S. Cui, A. Saiyed, A. Kolbeinsson, J. Hu, C. M. Rytting, R. Marten, Y. Wang, A. Dimakis, A. Konwinski, and L. Schmidt (2026) Terminal-bench: benchmarking agents on hard, realistic tasks in command line interfaces . External Links: 2601.11868 Cited by: [2nd item](#A2.I1.i2.p1.1) , [§1](#S1.p5.1) .
- Q. Mi, Z. Ma, M. Yang, H. Li, Y. Wang, H. Zhang, and J. Wang (2026) ProcMEM: learning reusable procedural memory from experience via non-parametric ppo for llm agents . External Links: 2602.01869 Cited by: [§2](#S2.SS0.SSS0.Px1.p1.1) .
- D. Nguyen, V. D. Lai, S. Yoon, R. A. Rossi, H. Zhao, R. Zhang, P. Mathur, N. Lipka, Y. Wang, T. Bui, F. Dernoncourt, and T. Zhou (2025) DynaSaur: large language agents beyond predefined actions . In Second Conference on Language Modeling , Cited by: [§2](#S2.SS0.SSS0.Px1.p1.1) .
- OpenAI (2025) OpenAI codex . Note: [https://openai.com/codex/](https://openai.com/codex/) Accessed: 2026-03-31 Cited by: [§1](#S1.p1.1) .
- OpenAI (2026) GPT-5.4 thinking system card . Note: [https://deploymentsafety.openai.com/gpt-5-4-thinking](https://deploymentsafety.openai.com/gpt-5-4-thinking) Accessed: 2026-03-31 Cited by: [§1](#S1.p1.1) .
- S. Ouyang, J. Yan, I. Hsu, Y. Chen, K. Jiang, Z. Wang, R. Han, L. T. Le, S. Daruki, X. Tang, V. Tirumalashetty, G. Lee, M. Rofouei, H. Lin, J. Han, C. Lee, and T. Pfister (2026) ReasoningBank: scaling agent self-evolving with reasoning memory . External Links: 2509.25140 Cited by: [§2](#S2.SS0.SSS0.Px3.p1.1) .
- T. Qwen (2025) Qwen3 technical report . External Links: 2505.09388 Cited by: [3rd item](#A2.I2.i3.p1.1) , [§1](#S1.p4.1) .
- D. Schmotz, L. Beurer-Kellner, S. Abdelnabi, and M. Andriushchenko (2026) Skill-inject: measuring agent vulnerability to skill file attacks . External Links: 2602.20156 Cited by: [§2](#S2.SS0.SSS0.Px2.p1.1) .
- H. Shi, X. Yuan, and B. Liu (2026) Evolving programmatic skill networks . External Links: 2601.03509 Cited by: [§2](#S2.SS0.SSS0.Px1.p1.1) .
- N. Shinn, F. Cassano, E. Berman, A. Gopinath, K. Narasimhan, and S. Yao (2023) Reflexion: language agents with verbal reinforcement learning . External Links: 2303.11366 Cited by: [§2](#S2.SS0.SSS0.Px3.p1.1) .
- P. Steinberger and O. Contributors (2025) OpenClaw: your own personal ai assistant . Note: [https://github.com/openclaw/openclaw](https://github.com/openclaw/openclaw) GitHub repository Cited by: [§1](#S1.p1.1) .
- M. Suzgun, M. Yuksekgonul, F. Bianchi, D. Jurafsky, and J. Zou (2025) Dynamic cheatsheet: test-time learning with adaptive memory . External Links: 2504.07952 Cited by: [§2](#S2.SS0.SSS0.Px3.p1.1) .
- G. Wang, Y. Xie, Y. Jiang, A. Mandlekar, C. Xiao, Y. Zhu, L. Fan, and A. Anandkumar (2023) Voyager: an open-ended embodied agent with large language models . External Links: 2305.16291 Cited by: [§2](#S2.SS0.SSS0.Px1.p1.1) .
- J. Wang, Q. Yan, Y. Wang, Y. Tian, S. S. Mishra, Z. Xu, M. Gandhi, P. Xu, and L. L. Cheong (2026) Reinforcement learning for self-improving agent with skill library . External Links: 2512.17102 Cited by: [§2](#S2.SS0.SSS0.Px1.p1.1) .
- Z. Z. Wang, A. Gandhi, G. Neubig, and D. Fried (2025) Inducing programmatic skills for agentic tasks . In Second Conference on Language Modeling , Cited by: [§2](#S2.SS0.SSS0.Px1.p1.1) .
- Z. Z. Wang, J. Mao, D. Fried, and G. Neubig (2024) Agent workflow memory . External Links: 2409.07429 Cited by: [§2](#S2.SS0.SSS0.Px1.p1.1) .
- P. Xia, J. Chen, H. Wang, J. Liu, K. Zeng, Y. Wang, S. Han, Y. Zhou, X. Zhao, H. Chen, Z. Zheng, C. Xie, and H. Yao (2026) SkillRL: evolving agents via recursive skill-augmented reinforcement learning . External Links: 2602.08234 Cited by: [§2](#S2.SS0.SSS0.Px1.p1.1) .
- H. Yan, X. Che, F. Xu, Q. Sun, Z. Ding, K. Cheng, J. Zhang, T. Qin, J. Liu, and Q. Lin (2026) TIDE: trajectory-based diagnostic evaluation of test-time improvement in llm agents . External Links: 2602.02196 Cited by: [§2](#S2.SS0.SSS0.Px3.p1.1) .
- Y. Yang, J. Li, Q. Pan, B. Zhan, Y. Cai, L. Du, J. Zhou, K. Chen, Q. Chen, X. Li, B. Zhang, and L. He (2026) AutoSkill: experience-driven lifelong learning via skill self-evolution . External Links: 2603.01145 Cited by: [§2](#S2.SS0.SSS0.Px2.p1.1) .
- W. Yao, S. Heinecke, J. C. Niebles, Z. Liu, Y. Feng, L. Xue, R. Murthy, Z. Chen, J. Zhang, D. Arpit, R. Xu, P. Mui, H. Wang, C. Xiong, and S. Savarese (2024) Retroformer: retrospective large language agents with policy gradient optimization . External Links: 2308.02151 Cited by: [§2](#S2.SS0.SSS0.Px3.p1.1) .
- H. Zhang, Q. Long, J. Bao, T. Feng, W. Zhang, H. Yue, and W. Wang (2026a) MemSkill: learning and evolving memory skills for self-evolving agents . External Links: 2602.02474 Cited by: [§2](#S2.SS0.SSS0.Px3.p1.1) .
- Y. Zhang, M. Li, D. Long, X. Zhang, H. Lin, B. Yang, P. Xie, A. Yang, D. Liu, J. Lin, F. Huang, and J. Zhou (2025) Qwen3 embedding: advancing text embedding and reranking through foundation models . External Links: 2506.05176 Cited by: [§3.2](#S3.SS2.SSS0.Px1.p1.1) .
- Y. Zhang, Y. Wu, Y. Yu, Q. Wu, and H. Wang (2026b) Live-evo: online evolution of agentic memory from continuous feedback . External Links: 2602.02369 Cited by: [§2](#S2.SS0.SSS0.Px3.p1.1) .
- A. Zhao, D. Huang, Q. Xu, M. Lin, Y. Liu, and G. Huang (2024) ExpeL: llm agents are experiential learners . External Links: 2308.10144 Cited by: [§2](#S2.SS0.SSS0.Px1.p1.1) .
- B. Zheng, M. Y. Fatemi, X. Jin, Z. Z. Wang, A. Gandhi, Y. Song, Y. Gu, J. Srinivasa, G. Liu, G. Neubig, and Y. Su (2025) SkillWeaver: web agents can self-improve by discovering and honing skills . External Links: 2504.07079 Cited by: [§2](#S2.SS0.SSS0.Px1.p1.1) .
- L. Zheng, L. Yin, Z. Xie, C. Sun, J. Huang, C. H. Yu, S. Cao, C. Kozyrakis, I. Stoica, J. E. Gonzalez, C. Barrett, and Y. Sheng (2024) SGLang: efficient execution of structured language model programs . External Links: 2312.07104 Cited by: [2nd item](#A2.I2.i2.p1.1) .
- Y. Zheng, Z. Zhang, C. Ma, Y. Yu, J. Zhu, Y. Wu, T. Xu, B. Dong, H. Zhu, R. Huang, and G. Yu (2026) SkillRouter: skill routing for llm agents at scale . External Links: 2603.22455 Cited by: [§2](#S2.SS0.SSS0.Px2.p1.1) .
- H. Zhou, Y. Chen, S. Guo, X. Yan, K. H. Lee, Z. Wang, K. Y. Lee, G. Zhang, K. Shao, L. Yang, and J. Wang (2025) Memento: fine-tuning llm agents without fine-tuning llms . External Links: 2508.16153 Cited by: [§2](#S2.SS0.SSS0.Px3.p1.1) .
- H. Zhou, S. Guo, A. Liu, Z. Yu, Z. Gong, B. Zhao, Z. Chen, M. Zhang, Y. Chen, J. Li, R. Yang, Q. Liu, X. Yu, J. Zhou, N. Wang, C. Sun, and J. Wang (2026) Memento-skills: let agents design agents . External Links: 2603.18743 Cited by: [§2](#S2.SS0.SSS0.Px2.p1.1) .



## Appendix A Skill Search Engine Details


#### Skill index construction.


We index the full collection of 34,198 skills with two complementary representations. For each skill, we extract: ① *metadata* , formed by concatenating the skill’s name and description, and ② *full content* , the body of the SKILL.md file. We filter the collection to skills with permissive licenses (MIT and Apache-2.0).



For sparse retrieval, we build an SQLite FTS5 full-text search index over the metadata fields. BM25 ranking uses field weights of 10 for name, 5 for description, and 5 for full content (when the content field is included in the index). The FTS5 index supports standard query syntax including prefix matching, phrase queries, and boolean operators.



For dense retrieval, we compute embeddings using Qwen3-Embedding-4B. At query time, we prepend the query instruction “ Find skills matching this query: ” before encoding.



#### Search tools.


We implement three search endpoints exposed to the agent via an HTTP server:

- •

Keyword search ( /keyword ): BM25-based retrieval over the FTS5 index.
- •

Semantic search ( /semantic ): Dense embedding cosine similarity.
- •

Hybrid search ( /hybrid ): Combines keyword and semantic results using Reciprocal Rank Fusion (RRF). Specifically, the RRF score for a skill is ∑ s w s / ( k + r s ) \sum_{s}w_{s}/(k+r_{s}) , where r s r_{s} is the rank in search method s s , w s w_{s} is the method weight (default 0.5 for both keyword and semantic), and k = 60 k=60 is the fusion constant. The keyword and semantic weights are configurable per query by the agent.

A separate /detail endpoint retrieves the full SKILL.md content for any skill given its identifier.



For agentic search variants that include the full content index ( *hybrid w/ content* in Table [1](#S3.T1) ), the semantic similarity score is computed as a weighted average of metadata and content embedding similarities: ( 1 − w ) ⋅ sim meta + w ⋅ sim content (1-w)\cdot\text{sim}_{\text{meta}}+w\cdot\text{sim}_{\text{content}} .



To select the content weight w w and BM25 content field weight, we sweep over candidate values using synthetic queries: we prompt a model to generate 1-3 short search queries per task from the task instruction, then use these queries for direct (non-agentic) search and measure Recall@5 against the curated skills. The best-performing configuration uses a BM25 content field weight of 5 and a semantic content weight of w = 0.05 w=0.05 .



#### Agentic search protocol.


In the agentic search setting, the agent is provided with a *finding-skills* skill that describes the search API and a structured workflow for discovering relevant skills. The full content of this skill is shown below.


Finding-Skills Skill (provided to the agent for retrieval) [⬇](data:text/plain;base64,IyBGaW5kaW5nIFNraWxscwoKU2VhcmNoZXMgYSBsb2NhbCBpbmRleCBvZiBhZ2VudCBza2lsbHMgdG8gZmluZCB0aGUgbW9zdCByZWxldmFudCBvbmVzIGZvciBhIGdpdmVuIHRhc2suIFNraWxscyBhcmUgcHJlLWRvd25sb2FkZWQgLSBubyBpbnN0YWxsYXRpb24gbmVlZGVkLgoKIyMgV2hlbiB0byBVc2UKCi0gU3RhcnRpbmcgYSBuZXcgdGFzayB0aGF0IG1heSBiZW5lZml0IGZyb20gc3BlY2lhbGl6ZWQgc2tpbGxzCi0gTG9va2luZyBmb3IgYmVzdCBwcmFjdGljZXMsIHBhdHRlcm5zLCBvciB3b3JrZmxvd3MgZm9yIGEgc3BlY2lmaWMgZG9tYWluCi0gV2FudGluZyB0byBmaW5kIHRvb2xzIG9yIHRlbXBsYXRlcyBmb3IgYSB0YXNrICh0ZXN0aW5nLCBkZXBsb3ltZW50LCBkZXNpZ24sIGV0Yy4pCgojIyBTZWFyY2ggQVBJCgpUaHJlZSBzZWFyY2ggZW5kcG9pbnRzIGFyZSBhdmFpbGFibGUuIFVzZSBgY3VybCAtc2AgdG8gcXVlcnkgdGhlbS4KCiMjIyBLZXl3b3JkIHNlYXJjaAoKQmVzdCBmb3IgZXhhY3QgdGVybSBtYXRjaGluZyB3aGVuIHlvdSBrbm93IHNwZWNpZmljIHNraWxsIG5hbWVzIG9yIHRlY2hub2xvZ2llcy4KCmBgYGJhc2gKY3VybCAtcyAiaHR0cDovL2xvY2FsaG9zdDo4NzQyL2tleXdvcmQ/cT1RVUVSWSZ0b3Bfaz0xMCIKYGBgCgpTdXBwb3J0cyBGVFM1IHN5bnRheDoKLSBQcmVmaXg6IGByZWFjdCpgCi0gUGhyYXNlOiBgImNvZGUgcmV2aWV3ImAKLSBCb29sZWFuOiBgcmVhY3QgT1IgdnVlYAoKIyMjIFNlbWFudGljIHNlYXJjaAoKQmVzdCBmb3IgY29uY2VwdHVhbCBxdWVyaWVzIHdoZXJlIHlvdSBkZXNjcmliZSB3aGF0IHlvdSBuZWVkIGluIG5hdHVyYWwgbGFuZ3VhZ2UuCgpgYGBiYXNoCmN1cmwgLXMgImh0dHA6Ly9sb2NhbGhvc3Q6ODc0Mi9zZW1hbnRpYz9xPVFVRVJZJnRvcF9rPTEwIgpgYGAKCkV4YW1wbGU6IGBxPWhlbHAgbWUgYnVpbGQgYW5kIGRlcGxveSBjb250YWluZXJpemVkIGFwcGxpY2F0aW9uc2AKCiMjIyBIeWJyaWQgc2VhcmNoCgpDb21iaW5lcyBrZXl3b3JkIGFuZCBzZW1hbnRpYyBzZWFyY2ggd2l0aCByZWNpcHJvY2FsIHJhbmsgZnVzaW9uLiBCZXN0IGdlbmVyYWwtcHVycG9zZSBvcHRpb24uCgpgYGBiYXNoCmN1cmwgLXMgImh0dHA6Ly9sb2NhbGhvc3Q6ODc0Mi9oeWJyaWQ/cT1RVUVSWSZ0b3Bfaz0xMCZrZXl3b3JkX3dlaWdodD0wLjUmc2VtYW50aWNfd2VpZ2h0PTAuNSIKYGBgCgotIGBrZXl3b3JkX3dlaWdodGA6IEhvdyBtdWNoIEJNMjUga2V5d29yZCBtYXRjaGVzIGNvbnRyaWJ1dGUgdG8gdGhlIGZpbmFsIHJhbmtpbmcgKGRlZmF1bHQ6IDAuNSkKLSBgc2VtYW50aWNfd2VpZ2h0YDogSG93IG11Y2ggc2VtYW50aWMgc2ltaWxhcml0eSBjb250cmlidXRlcyB0byB0aGUgZmluYWwgcmFua2luZyAoZGVmYXVsdDogMC41KQoKIyMjIFJlc3BvbnNlIGZvcm1hdAoKQWxsIHNlYXJjaCBlbmRwb2ludHMgcmV0dXJuIGEgSlNPTiBhcnJheS4gRWFjaCByZXN1bHQgY29udGFpbnM6CgotIGBuYW1lYDogc2tpbGwgbmFtZSAobWF5IGJlIGR1cGxpY2F0ZWQgYWNyb3NzIGF1dGhvcnMpCi0gYGRlc2NyaXB0aW9uYDogd2hhdCB0aGUgc2tpbGwgZG9lcwotIGBza2lsbF9tZF9zbmlwcGV0YDogZmlyc3QgMTAwIHdvcmRzIG9mIHRoZSBza2lsbCdzIGRvY3VtZW50YXRpb24KLSBgc2tpbGxfaWRgOiB1bmlxdWUgaWRlbnRpZmllciAoYXV0aG9yLS1uYW1lIGZvcm1hdCksIHVzZSB3aXRoIHRoZSBkZXRhaWwgZW5kcG9pbnQKLSBgZ2l0aHViX3N0YXJzYDogcG9wdWxhcml0eSBvZiB0aGUgc291cmNlIHJlcG9zaXRvcnkKLSBgc2NvcmVgOiByZWxldmFuY2Ugc2NvcmUuIEZvciBrZXl3b3JkIHNlYXJjaCwgbW9yZSBuZWdhdGl2ZSA9IGJldHRlciBtYXRjaC4gRm9yIHNlbWFudGljIHNlYXJjaCwgMC0xIHdoZXJlIGhpZ2hlciA9IGJldHRlciBtYXRjaC4gSHlicmlkIHNlYXJjaCByZXR1cm5zIGBycmZfc2NvcmVgIGluc3RlYWQgKGhpZ2hlciA9IGJldHRlciBtYXRjaCkuCgojIyMgU2tpbGwgZGV0YWlsCgpGZXRjaGVzIGZ1bGwgbWV0YWRhdGEgYW5kIGNvbXBsZXRlIFNLSUxMLm1kIGNvbnRlbnQgZm9yIGEgc2tpbGwuIFBhc3MgdGhlIGBza2lsbF9pZGAgZnJvbSBzZWFyY2ggcmVzdWx0cy4KCmBgYGJhc2gKY3VybCAtcyAiaHR0cDovL2xvY2FsaG9zdDo4NzQyL2RldGFpbC9TS0lMTF9JRCIKYGBgCgojIyBXb3JrZmxvdwoKIyMjIFN0ZXAgMTogQW5hbHl6ZSB0aGUgdGFzawoKQnJlYWsgdGhlIHRhc2sgaW50byBjb25jcmV0ZSBzdWItdGFza3MuIEZvciBleGFtcGxlLCAiYnVpbGQgYSBSRVNUIEFQSSB3aXRoIGF1dGggYW5kIHRlc3RzIiBiZWNvbWVzOgotIERlc2lnbiBBUEkgZW5kcG9pbnRzIGFuZCByb3V0aW5nCi0gSW1wbGVtZW50IGF1dGhlbnRpY2F0aW9uCi0gV3JpdGUgdGVzdHMKCiMjIyBTdGVwIDI6IFNlYXJjaCBmb3IgZWFjaCBzdWItdGFzawoKRm9yIGVhY2ggc3ViLXRhc2ssIHJ1biBzZWFyY2ggcXVlcmllcyB0byBmaW5kIHNraWxscy4KCmBgYGJhc2gKIyBTdWItdGFzazogaW1wbGVtZW50IGF1dGhlbnRpY2F0aW9uCmN1cmwgLXMgImh0dHA6Ly9sb2NhbGhvc3Q6ODc0Mi9oeWJyaWQ/cT1pbXBsZW1lbnQrYXV0aGVudGljYXRpb24rSldUJnRvcF9rPTEwIgojIEtleXdvcmQgc2VhcmNoCmN1cmwgLXMgImh0dHA6Ly9sb2NhbGhvc3Q6ODc0Mi9rZXl3b3JkP3E9SldUJnRvcF9rPTEwIgoKIyBTdWItdGFzazogd3JpdGUgdGVzdHMKY3VybCAtcyAiaHR0cDovL2xvY2FsaG9zdDo4NzQyL2h5YnJpZD9xPXdyaXRpbmcrdW5pdCt0ZXN0cyZ0b3Bfaz0xMCIKYGBgCgpSZWZpbmUgcXVlcmllcyBpZiBpbml0aWFsIHJlc3VsdHMgYXJlIHRvbyBicm9hZCBvciBtaXNzIHRoZSBtYXJrLiBUcnkgZGlmZmVyZW50IHBocmFzaW5nIG9yIHN3aXRjaCBiZXR3ZWVuIGtleXdvcmQgYW5kIHNlbWFudGljIHNlYXJjaC4KCiMjIyBTdGVwIDM6IFJldmlldyBhbmQgc2VsZWN0CgpGcm9tIHRoZSBzZWFyY2ggcmVzdWx0cywgc2VsZWN0IDEwIHNraWxscyB0b3RhbCBhY3Jvc3MgYWxsIHN1Yi10YXNrcy4gUHJpb3JpdGl6ZToKLSBIaWdoIHJlbGV2YW5jZSB0byB0aGUgdGFyZ2V0IHRhc2sKLSBIaWdoZXIgYGdpdGh1Yl9zdGFyc2Agd2hlbiBtdWx0aXBsZSBza2lsbHMgY292ZXIgdGhlIHNhbWUgdG9waWMKLSBTa2lsbHMgd2l0aCBpbmZvcm1hdGl2ZSBgc2tpbGxfbWRfc25pcHBldGAgY29udGVudAoKSWYgbmVlZGVkLCBmZXRjaCBmdWxsIGRldGFpbHMgb2YgYSBza2lsbCB0byBjb25maXJtIHJlbGV2YW5jZToKCmBgYGJhc2gKY3VybCAtcyAiaHR0cDovL2xvY2FsaG9zdDo4NzQyL2RldGFpbC9TS0lMTF9JRCIKYGBgCgojIyMgU3RlcCA0OiBSZWNvcmQgcmVzdWx0cwoKUmVjb3JkIHRoZSBzZWxlY3RlZCBza2lsbHMgYXMgYSBzdHJ1Y3R1cmVkIGxpc3Q6CgpgYGAKIyMgRm91bmQgU2tpbGxzCgotICoqW3NraWxsLW5hbWVdKiogKHNraWxsX2lkOiBbc2tpbGxfaWRdKSAtIFtvbmUtbGluZSBzdW1tYXJ5IGZyb20gZGVzY3JpcHRpb25dCi0gKipbc2tpbGwtbmFtZV0qKiAoc2tpbGxfaWQ6IFtza2lsbF9pZF0pIC0gW29uZS1saW5lIHN1bW1hcnkgZnJvbSBkZXNjcmlwdGlvbl0KLSAuLi4KYGBg) # Finding Skills Searches a local index of agent skills to find the most relevant ones for a given task . Skills are pre - downloaded - no installation needed . ## When to Use - Starting a new task that may benefit from specialized skills - Looking for best practices , patterns , or workflows for a specific domain - Wanting to find tools or templates for a task ( testing , deployment , design , etc .) ## Search API Three search endpoints are available . Use ‘ curl - s ‘ to query them . ### Keyword search Best for exact term matching when you know specific skill names or technologies . ‘‘‘ bash curl - s " http :// localhost :8742/ keyword ? q = QUERY & top_k =10" ‘‘‘ Supports FTS5 syntax : - Prefix : ‘ react *‘ - Phrase : ‘" code review "‘ - Boolean : ‘ react OR vue ‘ ### Semantic search Best for conceptual queries where you describe what you need in natural language . ‘‘‘ bash curl - s " http :// localhost :8742/ semantic ? q = QUERY & top_k =10" ‘‘‘ Example : ‘ q = help me build and deploy containerized applications ‘ ### Hybrid search Combines keyword and semantic search with reciprocal rank fusion . Best general - purpose option . ‘‘‘ bash curl - s " http :// localhost :8742/ hybrid ? q = QUERY & top_k =10& keyword_weight =0.5& semantic_weight =0.5" ‘‘‘ - ‘ keyword_weight ‘: How much BM25 keyword matches contribute to the final ranking ( default : 0.5) - ‘ semantic_weight ‘: How much semantic similarity contributes to the final ranking ( default : 0.5) ### Response format All search endpoints return a JSON array . Each result contains : - ‘ name ‘: skill name ( may be duplicated across authors ) - ‘ description ‘: what the skill does - ‘ skill_md_snippet ‘: first 100 words of the skill ’ s documentation - ‘ skill_id ‘: unique identifier ( author -- name format ), use with the detail endpoint - ‘ github_stars ‘: popularity of the source repository - ‘ score ‘: relevance score . For keyword search , more negative = better match . For semantic search , 0-1 where higher = better match . Hybrid search returns ‘ rrf_score ‘ instead ( higher = better match ). ### Skill detail Fetches full metadata and complete SKILL . md content for a skill . Pass the ‘ skill_id ‘ from search results . ‘‘‘ bash curl - s " http :// localhost :8742/ detail / SKILL_ID " ‘‘‘ ## Workflow ### Step 1: Analyze the task Break the task into concrete sub - tasks . For example , " build a REST API with auth and tests " becomes : - Design API endpoints and routing - Implement authentication - Write tests ### Step 2: Search for each sub - task For each sub - task , run search queries to find skills . ‘‘‘ bash # Sub - task : implement authentication curl - s " http :// localhost :8742/ hybrid ? q = implement + authentication + JWT & top_k =10" # Keyword search curl - s " http :// localhost :8742/ keyword ? q = JWT & top_k =10" # Sub - task : write tests curl - s " http :// localhost :8742/ hybrid ? q = writing + unit + tests & top_k =10" ‘‘‘ Refine queries if initial results are too broad or miss the mark . Try different phrasing or switch between keyword and semantic search . ### Step 3: Review and select From the search results , select 10 skills total across all sub - tasks . Prioritize : - High relevance to the target task - Higher ‘ github_stars ‘ when multiple skills cover the same topic - Skills with informative ‘ skill_md_snippet ‘ content If needed , fetch full details of a skill to confirm relevance : ‘‘‘ bash curl - s " http :// localhost :8742/ detail / SKILL_ID " ‘‘‘ ### Step 4: Record results Record the selected skills as a structured list : ‘‘‘ ## Found Skills - **[ skill - name ]** ( skill_id : [ skill_id ]) - [ one - line summary from description ] - **[ skill - name ]** ( skill_id : [ skill_id ]) - [ one - line summary from description ] - ... ‘‘‘



## Appendix B Experiment Details


#### Benchmarks.


We evaluate on two benchmarks:

- •

SkillsBench [(Li et al. , [2026](#bib.bib11) )] : We use 84 tasks, excluding 3 tasks with known environment or verifier issues: mhc-layer-impl , scheduling-email-assistant , and fix-visual-stability .
- •

Terminal-Bench 2.0 [(Merrill et al. , [2026](#bib.bib8) )] : We use all 89 tasks.



#### Models and agent harnesses.


We evaluate three models, each paired with its native agent harness:

- •

Claude Opus 4.6 [(Anthropic, [2026b](#bib.bib14) )] with Claude Code v2.1.19.
- •

Kimi K2.5 [(Kimi, [2026](#bib.bib10) )] with Terminus-2 [(Harbor Framework Team, [2026](#bib.bib19) )] (max input tokens: 253,952), served locally via SGLang [(Zheng et al. , [2024](#bib.bib2) )] .
- •

Qwen/Qwen3.5-397B-A17B-FP8 [(Qwen, [2025](#bib.bib9) )] with Qwen-Code v0.12.3, served locally via SGLang.



#### Evaluation protocol.


All experiments are run in isolated Docker containers provided by each task using the Harbor framework [(Harbor Framework Team, [2026](#bib.bib19) )] . Each task is run 3 times, and results are evaluated using the benchmark’s automated verifiers. On SkillsBench , we use a timeout multiplier of 1.5 × \times the default task timeout for all three models. On Terminal-Bench 2.0 , we use a 2 × \times timeout multiplier for Kimi K2.5 and Qwen3.5 to account for the lower inference speed of local serving, while keeping the original timeout (1 × \times ) for Claude Opus 4.6 .



## Appendix C Skill Refinement Details


### C.1 Query-Specific Refinement


Query-specific refinement runs inside the task’s own Docker environment, giving the agent access to the task’s data, libraries, and tools. However, the agent does not have access to the ground-truth verifier and needs to self-evaluate the correctness of a trajectory. We limit the refinement to a single iteration.



The full instruction prompt given to the refinement agent is shown below:


Query-Specific Refinement Prompt [⬇](data:text/plain;base64,WW91IGFyZSBhIHNraWxsIHJlZmluZW1lbnQgYWdlbnQuIFlvdXIgZ29hbCBpcyB0byBhdHRlbXB0IHRoZSB0YXJnZXQgdGFzayB1c2luZyB0aGUgcmV0cmlldmVkIHNraWxscywgb2JzZXJ2ZSB3aGljaCBwYXJ0cyBvZiB0aGUgc2tpbGxzIGhlbHAgYW5kIHdoaWNoIGRvbid0LCBhbmQgdGhlbiBjcmVhdGUgaW1wcm92ZWQgcmVmaW5lZCBza2lsbHMgYmFzZWQgb24gdGhhdCBleHBlcmllbmNlLgoKIyMgWW91ciBUYXNrCgojIyMgUGhhc2UgMTogVW5kZXJzdGFuZCB0aGUgdGFzayBhbmQgc2tpbGxzCgoxLiBSZWFkIHRoZSB0YXNrIGRlc2NyaXB0aW9uIGluIC9yb290L3Rhc2tfaW5zdHJ1Y3Rpb24ubWQgdG8gdW5kZXJzdGFuZCB3aGF0IHRoZSB0YXNrIHJlcXVpcmVzLgoyLiBSZWFkIEFMTCB0aGUgcmV0cmlldmVkIHNraWxscyBpbiAvcm9vdC9yZXRyaWV2ZWRfc2tpbGxzLy4gRWFjaCBzdWJkaXJlY3RvcnkgY29udGFpbnMgYSBza2lsbCB3aXRoIGEgU0tJTEwubWQgYW5kIHBvc3NpYmx5IHN1cHBvcnRpbmcgZmlsZXMgKHNjcmlwdHMsIHJlZmVyZW5jZXMsIGV0Yy4pLgoKIyMjIFBoYXNlIDI6IEF0dGVtcHQgdGhlIHRhc2sgdXNpbmcgdGhlIHJldHJpZXZlZCBza2lsbHMKCjMuIFRyeSB0byBzb2x2ZSB0aGUgdGFzayB3aGlsZSBhY3RpdmVseSBjb25zdWx0aW5nIHRoZSByZXRyaWV2ZWQgc2tpbGxzLiBUaGlzIGlzIHRoZSBtb3N0IGltcG9ydGFudCBzdGVwLiBBcyB5b3Ugd29yayB0aHJvdWdoIHRoZSB0YXNrOgogICAtIFJlZmVyIHRvIHRoZSByZXRyaWV2ZWQgc2tpbGxzIGZvciBndWlkYW5jZSwgY29kZSBzbmlwcGV0cywgQVBJIHBhdHRlcm5zLCBhbmQgZG9tYWluIGtub3dsZWRnZS4KICAgLSBXaGVuIGEgc2tpbGwgc3VnZ2VzdHMgYW4gYXBwcm9hY2gsIHRyeSBpdC4gTm90ZSB3aGV0aGVyIGl0IHdvcmtzLCBwYXJ0aWFsbHkgd29ya3MsIG9yIGlzIHdyb25nLgogICAtIFdoZW4geW91IGdldCBzdHVjaywgY2hlY2sgaWYgYW55IHNraWxsIGNvdmVycyB0aGUgaXNzdWUuIE5vdGUgZ2FwcyB3aGVyZSBubyBza2lsbCBoZWxwcy4KICAgLSBLZWVwIHRyYWNrIG9mIHdoaWNoIHNwZWNpZmljIHBhcnRzIG9mIHdoaWNoIHNraWxscyB3ZXJlIHVzZWZ1bCwgbWlzbGVhZGluZywgb3IgaXJyZWxldmFudC4KCiAgIElNUE9SVEFOVDogSWYgeW91IGRlbGVnYXRlIGFueSBwYXJ0IG9mIHRoZSBleHBsb3JhdGlvbiB0byBhIHN1YmFnZW50LCB5b3UgTVVTVCBnaXZlIHRoYXQgc3ViYWdlbnQgYWNjZXNzIHRvIHRoZSByZXRyaWV2ZWQgc2tpbGxzIGF0IC9yb290L3JldHJpZXZlZF9za2lsbHMvIGFuZCBpbnN0cnVjdCBpdCB0byBjb25zdWx0IHRoZW0gZHVyaW5nIGl0cyB3b3JrLiBUaGUgZ29hbCBpcyB0byB0ZXN0IHRoZSBza2lsbHMgaW4gcHJhY3RpY2UsIG5vdCB0byBzb2x2ZSB0aGUgdGFzayBmcm9tIHNjcmF0Y2ggaW5kZXBlbmRlbnRseS4KCiMjIyBQaGFzZSAzOiBSZWZsZWN0IGFuZCBjcmVhdGUgcmVmaW5lZCBza2lsbHMKCjQuIEJhc2VkIG9uIHlvdXIgZXhwZXJpZW5jZSBhdHRlbXB0aW5nIHRoZSB0YXNrIHdpdGggdGhlIHJldHJpZXZlZCBza2lsbHMsIHJlZmxlY3Qgb246CiAgIC0gV2hpY2ggc2tpbGxzIG9yIHBhcnRzIG9mIHNraWxscyB3ZXJlIGRpcmVjdGx5IHVzZWZ1bD8KICAgLSBXaGljaCBza2lsbHMgaGFkIGVycm9ycywgb3V0ZGF0ZWQgaW5mb3JtYXRpb24sIG9yIG1pc2xlYWRpbmcgZ3VpZGFuY2U/CiAgIC0gV2hhdCBrbm93bGVkZ2Ugd2FzIG1pc3NpbmcgdGhhdCB5b3UgaGFkIHRvIGZpZ3VyZSBvdXQgb24geW91ciBvd24/CiAgIC0gV2hhdCB3b3VsZCBoYXZlIG1hZGUgdGhlIHRhc2sgZWFzaWVyIGlmIHlvdSBoYWQga25vd24gaXQgdXBmcm9udD8KCjUuIFVzZSB0aGUgc2tpbGwtY3JlYXRvciBza2lsbCBhdCB7YWdlbnRfc2tpbGxzX3BhdGh9L3NraWxsLWNyZWF0b3IvIGFzIGd1aWRhbmNlIGZvciBjcmVhdGluZyBhbmQgd3JpdGluZyBza2lsbHMuCgo2LiBDcmVhdGUgcmVmaW5lZCBza2lsbHMgdGhhdCBpbmNvcnBvcmF0ZSB3aGF0IHlvdSBsZWFybmVkLiBUaGUgcmVmaW5lZCBza2lsbHMgc2hvdWxkOgogICAtIEtlZXAgdGhlIHBhcnRzIHRoYXQgYWN0dWFsbHkgd29ya2VkIHdoZW4geW91IHRyaWVkIHRoZW0uCiAgIC0gRml4IG9yIHJlbW92ZSBwYXJ0cyB0aGF0IHdlcmUgd3Jvbmcgb3IgbWlzbGVhZGluZy4KICAgLSBBZGQga25vd2xlZGdlIHlvdSBkaXNjb3ZlcmVkIGR1cmluZyBleHBsb3JhdGlvbiB0aGF0IHdhcyBtaXNzaW5nIGZyb20gdGhlIG9yaWdpbmFsIHNraWxscy4KICAgLSBDb21iaW5lIHJlbGF0ZWQgaW5mb3JtYXRpb24gZnJvbSBtdWx0aXBsZSBza2lsbHMgaW50byBjb2hlcmVudCwgdGFzay1hcHByb3ByaWF0ZSBndWlkZXMuCgojIyBJbXBvcnRhbnQgR3VpZGVsaW5lcwoKLSAqKkZvY3VzIG9uIHRoaXMgdGFzayBvbmx5LioqIFlvdSBhcmUgcHJlcGFyaW5nIHNraWxscyBzcGVjaWZpY2FsbHkgZm9yIHRoaXMgZ2l2ZW4gdGFzay4gVGhlcmUgaXMgbm8gbmVlZCB0byBjcmVhdGUgYWRkaXRpb25hbCB0ZXN0IHF1ZXJpZXMgLSBqdXN0IHRlc3QgYW5kIGV2YWx1YXRlIGFnYWluc3QgdGhlIHRhc2sgaW4gL3Jvb3QvdGFza19pbnN0cnVjdGlvbi5tZC4gWW91IGRvIG5vdCBoYXZlIGFjY2VzcyB0byB0aGUgZ3JvdW5kLXRydXRoIHZlcmlmaWVyOyBqdWRnZSBxdWFsaXR5IGJhc2VkIG9uIHlvdXIgb3duIGtub3dsZWRnZSBhbmQgZXhwbG9yYXRpb24gb2YgdGhlIHRhc2suCi0gKipTaW5nbGUgaXRlcmF0aW9uIG9mIGltcHJvdmVtZW50LioqIERvIG9uZSByb3VuZCBvZiBleHBsb3JhdGlvbiBhbmQgcmVmaW5lbWVudCAtIGRvIG5vdCBpdGVyYXRlIG11bHRpcGxlIHRpbWVzLgotICoqTm8gdXNlciBpbnRlcmFjdGlvbi4qKiBEbyBub3QgYXNrIGFueSBxdWVzdGlvbnMuIFNlbGYtZXhwbG9yZSB0aGUgdGFyZ2V0IHRhc2sgYW5kIGNyZWF0ZSBpbXByb3ZlZCBza2lsbHMgYmFzZWQgb24geW91ciBleHBsb3JhdGlvbiB0cmFqZWN0b3J5LgotICoqQ29tcG9zZSwgZG9uJ3QgY29weS4qKiBUaGUgcmVmaW5lZCBza2lsbHMgZG8gbm90IG5lZWQgdG8gY292ZXIgYWxsIGluZm9ybWF0aW9uIGluIHRoZSByZXRyaWV2ZWQgc2tpbGxzLiBJbnN0ZWFkLCBleHRyYWN0IGFuZCBjb21wb3NlIHRoZSB1c2VmdWwsIHJlbGV2YW50IHBhcnRzIGFuZCBjb21iaW5lIHRoZW0gaW50byBjb2hlcmVudCBza2lsbHMuIFRoZXJlIGlzIG5vIGxpbWl0IG9uIHRoZSBudW1iZXIgb2Ygc2tpbGxzIHlvdSBjcmVhdGUgLSB5b3UgY2FuIGNyZWF0ZSBtb3JlIG9yIGZld2VyIHRoYW4gdGhlIG51bWJlciBvZiByZXRyaWV2ZWQgc2tpbGxzLiBGb2N1cyBvbiBxdWFsaXR5IGFuZCByZWxldmFuY2UuCgojIyBPdXRwdXQKClNhdmUgeW91ciByZWZpbmVkIHNraWxscyB0byB7cmVmaW5lZF9za2lsbHNfcGF0aH0vLiBFYWNoIHNraWxsIHNob3VsZCBiZSBpbiBpdHMgb3duIHN1YmRpcmVjdG9yeSB3aXRoIGEgU0tJTEwubWQgZmlsZSAoYW5kIG9wdGlvbmFsIHN1cHBvcnRpbmcgZmlsZXMgbGlrZSBzY3JpcHRzIG9yIHJlZmVyZW5jZXMpOgoKYGBgCntyZWZpbmVkX3NraWxsc19wYXRofS8KKy0tIHNraWxsLW5hbWUtMS8KfCAgICstLSBTS0lMTC5tZAp8ICAgKy0tIChvcHRpb25hbCBzdXBwb3J0aW5nIGZpbGVzKQorLS0gc2tpbGwtbmFtZS0yLwp8ICAgKy0tIFNLSUxMLm1kCnwgICArLS0gKG9wdGlvbmFsIHN1cHBvcnRpbmcgZmlsZXMpCistLSAuLi4KYGBg) You are a skill refinement agent . Your goal is to attempt the target task using the retrieved skills , observe which parts of the skills help and which don ’ t , and then create improved refined skills based on that experience . ## Your Task ### Phase 1: Understand the task and skills 1. Read the task description in / root / task_instruction . md to understand what the task requires . 2. Read ALL the retrieved skills in / root / retrieved_skills /. Each subdirectory contains a skill with a SKILL . md and possibly supporting files ( scripts , references , etc .). ### Phase 2: Attempt the task using the retrieved skills 3. Try to solve the task while actively consulting the retrieved skills . This is the most important step . As you work through the task : - Refer to the retrieved skills for guidance , code snippets , API patterns , and domain knowledge . - When a skill suggests an approach , try it . Note whether it works , partially works , or is wrong . - When you get stuck , check if any skill covers the issue . Note gaps where no skill helps . - Keep track of which specific parts of which skills were useful , misleading , or irrelevant . IMPORTANT : If you delegate any part of the exploration to a subagent , you MUST give that subagent access to the retrieved skills at / root / retrieved_skills / and instruct it to consult them during its work . The goal is to test the skills in practice , not to solve the task from scratch independently . ### Phase 3: Reflect and create refined skills 4. Based on your experience attempting the task with the retrieved skills , reflect on : - Which skills or parts of skills were directly useful ? - Which skills had errors , outdated information , or misleading guidance ? - What knowledge was missing that you had to figure out on your own ? - What would have made the task easier if you had known it upfront ? 5. Use the skill - creator skill at { agent_skills_path }/ skill - creator / as guidance for creating and writing skills . 6. Create refined skills that incorporate what you learned . The refined skills should : - Keep the parts that actually worked when you tried them . - Fix or remove parts that were wrong or misleading . - Add knowledge you discovered during exploration that was missing from the original skills . - Combine related information from multiple skills into coherent , task - appropriate guides . ## Important Guidelines - ** Focus on this task only .** You are preparing skills specifically for this given task . There is no need to create additional test queries - just test and evaluate against the task in / root / task_instruction . md . You do not have access to the ground - truth verifier ; judge quality based on your own knowledge and exploration of the task . - ** Single iteration of improvement .** Do one round of exploration and refinement - do not iterate multiple times . - ** No user interaction .** Do not ask any questions . Self - explore the target task and create improved skills based on your exploration trajectory . - ** Compose , don ’ t copy .** The refined skills do not need to cover all information in the retrieved skills . Instead , extract and compose the useful , relevant parts and combine them into coherent skills . There is no limit on the number of skills you create - you can create more or fewer than the number of retrieved skills . Focus on quality and relevance . ## Output Save your refined skills to { refined_skills_path }/. Each skill should be in its own subdirectory with a SKILL . md file ( and optional supporting files like scripts or references ): ‘‘‘ { refined_skills_path }/ +-- skill - name -1/ | +-- SKILL . md | +-- ( optional supporting files ) +-- skill - name -2/ | +-- SKILL . md | +-- ( optional supporting files ) +-- ... ‘‘‘



### C.2 Query-Agnostic Refinement


Query-agnostic refinement improves each skill independently without knowledge of any target task. Each skill is refined in a minimal Docker container (Ubuntu 24.04 with Python).



The instruction prompt given to the refinement agent is:


Query-Agnostic Refinement Prompt [⬇](data:text/plain;base64,WW91IGFyZSBhIHNraWxsIGltcHJvdmVtZW50IGFnZW50LiBZb3VyIGpvYiBpcyB0byBpbXByb3ZlIGEgc2luZ2xlIHNraWxsLgoKVGhlIHNraWxsIHRvIGltcHJvdmUgaXMgYXQgL3Jvb3Qvc2tpbGxfdG9faW1wcm92ZS8gKGNvbnRhaW5zIFNLSUxMLm1kIGFuZCBwb3NzaWJseSBzdXBwb3J0aW5nIGZpbGVzKS4gQSBndWlkZSBvbiBob3cgdG8gY3JlYXRlIGFuZCBpbXByb3ZlIHNraWxscyAoc2tpbGwtY3JlYXRvcikgaXMgYXZhaWxhYmxlIGluIHlvdXIgc2tpbGxzLgoKUmVhZCB0aGUgc2tpbGwgdG8gaW1wcm92ZSBhbmQgdGhlIHNraWxsLWNyZWF0b3IgZ3VpZGUuIEZvbGxvdyB0aGUgc2tpbGwtY3JlYXRvciBtZXRob2RvbG9neSB0byBnZW5lcmF0ZSBzYW1wbGUgdGVzdCBxdWVyaWVzLCB0aGVuIGV2YWx1YXRlIHRoZSBza2lsbCB1c2luZyBBL0IgdGVzdGluZyBhcyBkZXNjcmliZWQgaW4gdGhlIGd1aWRlLiBGaW5hbGx5LCBpbXByb3ZlIHRoZSBza2lsbCBiYXNlZCBvbiB3aGF0IHlvdSBmaW5kLgoKIyMgSW1wb3J0YW50IEd1aWRlbGluZXMKCi0gKipObyB1c2VyIGludGVyYWN0aW9uLioqIFdvcmsgYXV0b25vbW91c2x5LgotICoqU2luZ2xlIGl0ZXJhdGlvbi4qKiBPbmUgcm91bmQgb2YgZXZhbHVhdGlvbiBhbmQgaW1wcm92ZW1lbnQgLSBkbyBub3QgbG9vcCBtdWx0aXBsZSB0aW1lcy4KCiMjIE91dHB1dAoKU2F2ZSB0aGUgaW1wcm92ZWQgc2tpbGwgdG8ge3JlZmluZWRfc2tpbGxfcGF0aH0vLiBUaGUgc2tpbGwgc2hvdWxkIGhhdmUgYSBTS0lMTC5tZCBmaWxlIGFuZCBvcHRpb25hbCBzdXBwb3J0aW5nIGZpbGVzOgoKYGBgCntyZWZpbmVkX3NraWxsX3BhdGh9LworLS0gU0tJTEwubWQKKy0tIChvcHRpb25hbCBzdXBwb3J0aW5nIGZpbGVzIGxpa2Ugc2NyaXB0cy8sIHJlZmVyZW5jZXMvLCBhc3NldHMvKQpgYGA=) You are a skill improvement agent . Your job is to improve a single skill . The skill to improve is at / root / skill_to_improve / ( contains SKILL . md and possibly supporting files ). A guide on how to create and improve skills ( skill - creator ) is available in your skills . Read the skill to improve and the skill - creator guide . Follow the skill - creator methodology to generate sample test queries , then evaluate the skill using A / B testing as described in the guide . Finally , improve the skill based on what you find . ## Important Guidelines - ** No user interaction .** Work autonomously . - ** Single iteration .** One round of evaluation and improvement - do not loop multiple times . ## Output Save the improved skill to { refined_skill_path }/. The skill should have a SKILL . md file and optional supporting files : ‘‘‘ { refined_skill_path }/ +-- SKILL . md +-- ( optional supporting files like scripts /, references /, assets /) ‘‘‘



## Appendix D LLM-as-Judge for Skill Coverage


To assess the relevance and coverage of retrieved skill sets (Table [3](#S4.T3) ), we use GPT-5.4 as an LLM judge. For each task, the judge receives the task instruction and the full content of all retrieved skills (including SKILL.md and helper files, truncated to 400K characters per skill and 2M characters total), and is asked to rate overall coverage. The system prompt is:


LLM Judge System Prompt [⬇](data:text/plain;base64,WW91IGFyZSBhbiBleHBlcnQgZXZhbHVhdG9yIGFzc2Vzc2luZyBob3cgd2VsbCBhIHNldCBvZiBza2lsbCBkb2N1bWVudHMgY29sbGVjdGl2ZWx5IGNvdmVycyBhIHNwZWNpZmljIHRhc2suIEEgInNraWxsIiBpcyBhIHJldXNhYmxlIGtub3dsZWRnZSBkb2N1bWVudCAod2l0aCBvcHRpb25hbCBoZWxwZXIgc2NyaXB0cy9yZWZlcmVuY2VzKSB0aGF0IGFuIEFJIGFnZW50IGNhbiBjb25zdWx0IHdoaWxlIHdvcmtpbmcgb24gYSB0YXNrLgoKWW91IHdpbGwgYmUgZ2l2ZW4gYSB0YXNrIGluc3RydWN0aW9uIGFuZCBhIHNldCBvZiBza2lsbHMuIEV2YWx1YXRlIGhvdyB3ZWxsIHRoZSBza2lsbHMgVE9HRVRIRVIgY292ZXIgd2hhdCBpcyBuZWVkZWQgdG8gY29tcGxldGUgdGhlIHRhc2suCgpSYXRlIG92ZXJhbGwgY292ZXJhZ2Ugb24gdGhpcyBzY2FsZToKICA1ID0gQ29tcGxldGUgY292ZXJhZ2UgLSB0aGUgc2tpbGxzIHRvZ2V0aGVyIGNvdmVyIGFsbCBzdGVwcyBhbmQgYXNwZWN0cyBuZWVkZWQgdG8gc29sdmUgdGhlIHRhc2suIEFuIGFnZW50IHdpdGggdGhlc2Ugc2tpbGxzIGhhcyBldmVyeXRoaW5nIGl0IG5lZWRzLgogIDQgPSBIaWdoIGNvdmVyYWdlIC0gdGhlIHNraWxscyBjb3ZlciBtb3N0IGFzcGVjdHMgb2YgdGhlIHRhc2ssIGJ1dCBtaW5vciBnYXBzIHJlbWFpbiB0aGF0IHRoZSBhZ2VudCB3b3VsZCBuZWVkIHRvIGZpZ3VyZSBvdXQgb24gaXRzIG93bi4KICAzID0gTW9kZXJhdGUgY292ZXJhZ2UgLSB0aGUgc2tpbGxzIGNvdmVyIHNvbWUga2V5IGFzcGVjdHMgYnV0IG1pc3Mgc2lnbmlmaWNhbnQgcGFydHMgb2YgdGhlIHRhc2suIFRoZSBhZ2VudCB3b3VsZCBuZWVkIHN1YnN0YW50aWFsIGluZGVwZW5kZW50IHdvcmsuCiAgMiA9IExvdyBjb3ZlcmFnZSAtIHRoZSBza2lsbHMgdG91Y2ggb24gdGhlIHRvcGljIGJ1dCBtaXNzIG1vc3Qgb2YgdGhlIHRhc2sncyBzcGVjaWZpYyBuZWVkcy4gT25seSBtYXJnaW5hbGx5IGhlbHBmdWwuCiAgMSA9IE5vIGNvdmVyYWdlIC0gbm90aGluZyBpbiB0aGUgc2tpbGxzIGlzIHJlbGV2YW50IHRvIHRoZSB0YXNrLgoKUmVzcG9uZCB3aXRoIE9OTFkgYSBKU09OIG9iamVjdCwgbm8gZXhwbGFuYXRpb246Cnsic2NvcmUiOiA8MXwyfDN8NHw1PiwgImNvdmVyZWQiOiAiPHdoYXQgdGhlIHNraWxscyBjb3Zlcj4iLCAiZ2FwcyI6ICI8d2hhdCBpcyBtaXNzaW5nPiJ9) You are an expert evaluator assessing how well a set of skill documents collectively covers a specific task . A " skill " is a reusable knowledge document ( with optional helper scripts / references ) that an AI agent can consult while working on a task . You will be given a task instruction and a set of skills . Evaluate how well the skills TOGETHER cover what is needed to complete the task . Rate overall coverage on this scale : 5 = Complete coverage - the skills together cover all steps and aspects needed to solve the task . An agent with these skills has everything it needs . 4 = High coverage - the skills cover most aspects of the task , but minor gaps remain that the agent would need to figure out on its own . 3 = Moderate coverage - the skills cover some key aspects but miss significant parts of the task . The agent would need substantial independent work . 2 = Low coverage - the skills touch on the topic but miss most of the task ’ s specific needs . Only marginally helpful . 1 = No coverage - nothing in the skills is relevant to the task . Respond with ONLY a JSON object , no explanation : {" score ": <1|2|3|4|5>, " covered ": "< what the skills cover >", " gaps ": "< what is missing >"}


Experimental support, please [view the build logs](./2604.04323v1/__stdout.txt) for errors. Generated by [L A T E xml ![[LOGO]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAsAAAAOCAYAAAD5YeaVAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9wKExQZLWTEaOUAAAAddEVYdENvbW1lbnQAQ3JlYXRlZCB3aXRoIFRoZSBHSU1Q72QlbgAAAdpJREFUKM9tkL+L2nAARz9fPZNCKFapUn8kyI0e4iRHSR1Kb8ng0lJw6FYHFwv2LwhOpcWxTjeUunYqOmqd6hEoRDhtDWdA8ApRYsSUCDHNt5ul13vz4w0vWCgUnnEc975arX6ORqN3VqtVZbfbTQC4uEHANM3jSqXymFI6yWazP2KxWAXAL9zCUa1Wy2tXVxheKA9YNoR8Pt+aTqe4FVVVvz05O6MBhqUIBGk8Hn8HAOVy+T+XLJfLS4ZhTiRJgqIoVBRFIoric47jPnmeB1mW/9rr9ZpSSn3Lsmir1fJZlqWlUonKsvwWwD8ymc/nXwVBeLjf7xEKhdBut9Hr9WgmkyGEkJwsy5eHG5vN5g0AKIoCAEgkEkin0wQAfN9/cXPdheu6P33fBwB4ngcAcByHJpPJl+fn54mD3Gg0NrquXxeLRQAAwzAYj8cwTZPwPH9/sVg8PXweDAauqqr2cDjEer1GJBLBZDJBs9mE4zjwfZ85lAGg2+06hmGgXq+j3+/DsixYlgVN03a9Xu8jgCNCyIegIAgx13Vfd7vdu+FweG8YRkjXdWy329+dTgeSJD3ieZ7RNO0VAXAPwDEAO5VKndi2fWrb9jWl9Esul6PZbDY9Go1OZ7PZ9z/lyuD3OozU2wAAAABJRU5ErkJggg==)
](https://math.nist.gov/~BMiller/LaTeXML/) .


## Instructions for reporting errors

We are continuing to improve HTML versions of papers, and your feedback helps enhance accessibility and mobile support. To report errors in the HTML that will help us improve conversion and rendering, choose any of the methods listed below:

- Click the "Report Issue" ( ) button, located in the page header.

**Tip:** You can select the relevant text first, to include it in your report.

Our team has already identified [the following issues](https://github.com/arXiv/html_feedback/issues) . We appreciate your time reviewing and reporting rendering errors we may not have found yet. Your efforts will help us improve the HTML versions for all readers, because disability should not be a barrier to accessing research. Thank you for your continued support in championing open access for all.

Have a free development cycle? Help support accessibility at arXiv! Our collaborators at LaTeXML maintain a [list of packages that need conversion](https://github.com/brucemiller/LaTeXML/wiki/Porting-LaTeX-packages-for-LaTeXML) , and welcome [developer contributions](https://github.com/brucemiller/LaTeXML/issues) .



BETA
 [!Font Awesome Free v7.1.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2026 Fonticons, Inc.](javascript:toggleReadingMode();)