---
title: "How Well Do Agentic Skills Work in the Wild: Benchmarking LLM Skill Usage in Realistic Settings"
source_url: "https://arxiv.org/abs/2604.04323"
source_type: paper
fetched: 2026-04-14
authors: ["Yujian Liu", "Jiabao Ji", "Li An", "Tommi Jaakkola", "Yang Zhang", "Shiyu Chang"]
categories: ["cs.CL"]
---

**Title:** HOW WELL DO AGENTIC SKILLS WORK IN THE WILD: BENCHMARKING LLM SKILL USAGE IN REALISTIC SETTINGS

**Authors:** Yujian Liu, Jiabao Ji, Li An, Tommi Jaakkola, Yang Zhang, Shiyu Chang

**Abstract:** Agent skills, which are reusable, domain-specific knowledge artifacts, have become a popular mechanism for extending LLM-based agents, yet formally benchmarking skill usage performance remains scarce. Existing skill benchmarking efforts focus on overly idealized conditions, where LLMs are directly provided with hand-crafted, narrowly-tailored task-specific skills for each task, whereas in many realistic settings, the LLM agent may have to search for and select relevant skills on its own, and even the closest matching skills may not be well-tailored for the task. In this paper, we conduct the first comprehensive study of skill utility under progressively challenging realistic settings, where agents must retrieve skills from a large collection of 34k real-world skills and may not have access to any hand-curated skills. Our findings reveal that the benefits of skills are fragile: performance gains degrade consistently as settings become more realistic, with pass rates approaching no-skill baselines in the most challenging scenarios. To narrow this gap, we study skill refinement strategies, including query-specific and query-agnostic approaches, and we show that query-specific refinement substantially recovers lost performance when the initial skills are of reasonable relevance and quality. We further demonstrate the generality of retrieval and refinement on Terminal-Bench 2.0, where they improve the pass rate of Claude Opus 4.6 from 57.7% to 65.5%. Our results, consistent across multiple models, highlight both the promise and the current limitations of skills for LLM-based agents.

**Submission Date:** 6 Apr 2026

**Categories:** Computation and Language (cs.CL)
