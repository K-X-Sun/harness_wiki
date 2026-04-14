---
title: "CodeVisionary: An Agent-Based Framework for Evaluating Large Language Models in Code Generation"
source_url: "https://arxiv.org/abs/2504.13472"
source_type: paper
fetched: 2026-04-14
authors: ["Xinchen Wang", "Pengfei Gao", "Chao Peng", "Ruida Hu", "Cuiyun Gao"]
categories: ["cs.SE", "cs.AI", "cs.CL", "cs.LG"]
---

**Title:** CODEVISIONARY: AN AGENT-BASED FRAMEWORK FOR EVALUATING LARGE LANGUAGE MODELS IN CODE GENERATION

**Authors:** Xinchen Wang, Pengfei Gao, Chao Peng, Ruida Hu, Cuiyun Gao

**Abstract:** Large language models (LLMs) have demonstrated strong capabilities in code generation, underscoring the critical need for rigorous and comprehensive evaluation. Existing evaluation approaches fall into three categories, including human-centered, metric-based, and LLM-based. Considering that human-centered approaches are labour-intensive and metric-based ones overly rely on reference answers, LLM-based approaches are gaining increasing attention due to their stronger contextual understanding capabilities. However, they generally evaluate the generated code based on static prompts, and tend to fail for complex code scenarios which typically involve multiple requirements and require more contextual information. In addition, these approaches lack fine-grained evaluation for complex code, resulting in limited explainability. To mitigate the limitations, we propose CodeVisionary, the first agent-based evaluation framework for complex code generation. CodeVisionary consists of two stages: (1) Requirement-guided multi-dimensional context distillation stage and (2) Fine-grained scoring and summarization stage. A comprehensive evaluation report is also generated for enhanced explainability. For validation, we construct a new benchmark consisting of 363 samples spanning 37 coding scenarios and 23 programming languages. Extensive experiments demonstrate that CodeVisionary achieves the best performance among three baselines for evaluating complex code generation, outperforming the best baseline with average improvements of 0.217, 0.163, and 0.141 in Pearson, Spearman, and Kendall-Tau coefficients, respectively.

**Submission Date:** Submitted on 18 Apr 2025 (v1), last revised 20 Oct 2025 (this version, v2)

**Categories:** Software Engineering (cs.SE); Artificial Intelligence (cs.AI); Computation and Language (cs.CL); Machine Learning (cs.LG)
