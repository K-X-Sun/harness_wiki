---
title: "Beyond Resolution Rates: Behavioral Drivers of Coding Agent Success and Failure"
source_url: "https://arxiv.org/abs/2604.02547"
source_type: paper
fetched: 2026-04-14
authors: ["Tural Mehtiyev", "Wesley Assunção"]
categories: ["cs.SE"]
---

**Title:** BEYOND RESOLUTION RATES: BEHAVIORAL DRIVERS OF CODING AGENT SUCCESS AND FAILURE

**Authors:** Tural Mehtiyev, Wesley Assunção

**Abstract:** Coding agents represent a new paradigm in automated software engineering, combining the reasoning capabilities of Large Language Models (LLMs) with tool-augmented interaction loops. However, coding agents still have severe limitations. Top-ranked LLM-based coding agents still fail on over 20% of benchmarked problems. Yet, we lack a systematic understanding of why (i.e., the causes) agents fail, and how failure unfolds behaviorally. We present a large-scale empirical study analyzing 9,374 trajectories from 19 agents (8 coding agent frameworks, 14 LLMs) on 500 tasks. We organize our analysis around three research questions. First, we investigate why agents fail on specific tasks and find that patch complexity alone does not explain difficulty: 12 never-solved tasks require only simple patches and were considered easy by human annotators, yet all agents fail due to gaps in architectural reasoning and domain knowledge. Second, we examine how behavioral patterns differentiate success from failure. The widely reported correlation between trajectory length and failure reverses direction once task difficulty is controlled, revealing it as a confound. Instead, trajectory structure discriminates consistently: agents that gather context before editing and invest in validation succeed more often, and these strategies are agent-determined rather than task-adaptive. Third, we disentangle LLM capability from framework design and find that the LLM is the primary driver of both outcome and behavior: agents sharing the same LLM agree on far more tasks than agents sharing the same framework, and the framework performance gap shrinks with each generation of LLM improvement. Framework prompts do influence agent tactics, but this influence diminishes with stronger LLMs.

**Submission Date:** Submitted on 2 Apr 2026 ([v1] Thu, 2 Apr 2026 21:56:23 UTC (483 KB))

**Categories:** COMPUTER SCIENCE > SOFTWARE ENGINEERING / Software Engineering (cs.SE)
