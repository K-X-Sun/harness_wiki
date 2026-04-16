---
date: '2026-04-15'
source_type: paper
tags:
- type-paper
- arxiv-2604-02547
- topic-agent
title: 'Beyond Resolution Rates: Behavioral Drivers of Coding Agent Success and Failure'
---

# Beyond Resolution Rates: Behavioral Drivers of Coding Agent Success and Failure

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
arXiv:2604.02547v1 [cs.SE] 02 Apr 2026



# Beyond Resolution Rates: Behavioral Drivers of Coding Agent Success and Failure

Tural Mehtiyev North Carolina State University Raleigh NC USA and Wesley Assunção North Carolina State University Raleigh NC USA


###### Abstract.

Coding agents represent a new paradigm in automated software engineering, combining the reasoning capabilities of Large Language Models (LLMs) with tool-augmented interaction loops. However, coding agents still have severe limitations. Top-ranked LLM-based coding agents still fail on over 20% of benchmarked problems. Yet, we lack a systematic understanding of *why* (i.e., the causes) agents fail, and *how* failure unfolds behaviorally. We present a large-scale empirical study analyzing 9,374 trajectories from 19 agents (8 coding agent frameworks, 14 LLMs) on 500 tasks. We organize our analysis around three research questions. First, we investigate why agents fail on specific tasks and find that patch complexity alone does not explain difficulty: 12 never-solved tasks require only simple patches and were considered easy by human annotators, yet all agents fail due to gaps in architectural reasoning and domain knowledge. Second, we examine how behavioral patterns differentiate success from failure. The widely reported correlation between trajectory length and failure reverses direction once task difficulty is controlled, revealing it as a confound. Instead, trajectory *structure* discriminates consistently: agents that gather context before editing and invest in validation succeed more often, and these strategies are agent-determined rather than task-adaptive. Third, we disentangle LLM capability from framework design and find that the LLM is the primary driver of both outcome and behavior: agents sharing the same LLM agree on far more tasks than agents sharing the same framework, and the framework performance gap shrinks with each generation of LLM improvement. Framework prompts do influence agent tactics, but this influence diminishes with stronger LLMs.

 † † conference: ; 2026; Raleigh, NC, USA † † copyright: none

## 1. Introduction


Coding agents represent a new paradigm in automated software engineering, combining the reasoning capabilities of Large Language Model (LLM) with tool-augmented interaction loops that allow them to operate directly on codebases [(Liu et al. , [2024](#bib.bib30) )] . Unlike traditional code generation systems that produce isolated snippets [(Chen et al. , [2021](#bib.bib37) ; Jiang et al. , [2024](#bib.bib38) )] , coding agents function as autonomous developers [(Yang et al. , [2024](#bib.bib5) ; Xia and others, [2025](#bib.bib4) )] : they interpret natural-language issue reports, explore repositories, execute code, run tests, and iteratively refine patches to resolve a task. Frameworks such as SWE-agent [(Yang et al. , [2024](#bib.bib5) )] , OpenHands [(Wang et al. , [2025](#bib.bib29) )] , and AutoCodeRover [(Zhang and others, [2024](#bib.bib16) )] have demonstrated the feasibility of this approach, leading to increasing adoption in real-world workflows. Ehsani et al. [(Ehsani et al. , [2026](#bib.bib12) )] report over 33k agent-authored pull requests on GitHub, and the SWE-bench leaderboard [(Jimenez et al. , [2024](#bib.bib7) )] tracks over 80 unique approaches across dozens of competing systems [(Martinez and Franch, [2025](#bib.bib13) )] . Despite this rapid progress and growing ecosystem, coding agents remain far from reliable. State-of-the-art agents still fail on more than 20% of SWE-bench Verified tasks [(SWE-bench Team, [2025](#bib.bib32) )] (as of February 2026), and failure rates increase sharply on harder benchmarks [(SWE-Bench Pro Team, [2025](#bib.bib11) )] , highlighting the need for a deeper understanding of their behavior.



To contribute to the construction of reliable agentic systems, understanding why and how coding agents fail is therefore critical. The “why” refers to the underlying causes of failure, namely whether failures arise from task characteristics (e.g., hidden dependencies, test requirements), limitations of the LLM (e.g., reasoning errors, poor generalization), or constraints imposed by the agent framework (e.g., tool orchestration, context management). Additionally, the “how” refers to the observable behavioral process through which failure unfolds, primarily captured in the agent’s trajectory as a sequence of actions such as exploration, editing, testing, and iteration [(Yao et al. , [2023](#bib.bib31) )] . While prior work has studied outcome-level metrics such as resolution rates and fault localization accuracy [(Meng et al. , [2024](#bib.bib41) )] , classified failure root causes through manual inspection [(Liu et al. , [2025](#bib.bib23) )] , or analyzed behavioral patterns such as trajectory length and action sequences in small agent samples [(Majgaonkar et al. , [2025](#bib.bib24) ; Bouzenia and Pradel, [2025](#bib.bib1) ; Chen and others, [2025](#bib.bib42) ; Liu et al. , [2026](#bib.bib33) )] , these studies rarely connect the why and how dimensions of failure while controlling for task difficulty on a large-scale dataset. As a consequence, there is a lack of systematic understanding of how specific behaviors lead to particular failure causes, and which aspects of agent design or capability should be improved. This gap limits both scientific insight and practical progress, as improving agents requires not just knowing that they fail, but understanding the mechanisms by which those failures occur.



In this paper, we address this gap by conducting a large-scale empirical study of coding agent behavior. We analyze 9,374 trajectories from 19 agents spanning 8 frameworks and 14 LLMs, all evaluated on the same 500 SWE-bench Verified tasks. In the studied dataset, every agent attempts every task, enabling within-task comparisons that control for task difficulty, an important confound that has undermined prior work. Our goal is to move beyond outcome-level benchmarking and instead understand the behavioral drivers of success and failure. We focus on three core research questions: RQ1. Why do coding agents fail on certain tasks? Prior work mainly approximates difficulty through proxy metrics such as patch size [(SWE-Bench Pro Team, [2025](#bib.bib11) )] or human-estimated solve time [(Ganhotra, [2025](#bib.bib26) ; Zan and others, [2025](#bib.bib25) )] . We test whether this holds across all 500 tasks and investigate edge cases in which some tasks are considered “easy” yet every agent fails. RQ2. How do the behavioral patterns differentiate success from failure? We use within-task paired comparisons to test whether the widely-reported length–failure correlation survives difficulty controls, and characterize how different agents fail on the same tasks. RQ3. Does LLM capability or framework design drive agent success? By leveraging natural variation in LLMs within the same frameworks, we disentangle the relative contributions of model capability and system architecture.


![Refer to caption](2604.02547v1/x1.png)
 *Figure 1. Contrasting agent trajectories on django-15863. Both agents use the SWE-agent framework. Claude 4 Sonnet (left) follows a structured workflow: browse the codebase, reproduce the bug, make one surgical edit, then run several verification cycles before submitting. GPT-4 (right) finds the correct file but then edits the code many times, producing 28 syntax errors, without ever running the project’s test suite.*



Through both quantitative and qualitative analysis, our large-scale, controlled study links coding agent behavior to outcomes across diverse systems. The results lead to several key findings: (i) simple-patch tasks can defeat every agent when they require architectural reasoning rather than complex edits; (ii) trajectory length is an ambiguous failure signal: its direction reverses depending on whether one controls for agent identity or task difficulty; (iii) trajectory structure distinguishes success from failure. Agents that gather context before editing and validate more succeed consistently, and these strategies are fixed across task complexity; and (iv) LLM capability dominates over framework design. As LLMs improve, framework differences shrink and agents converge.



## 2. Background and Motivation


Agents are built on top of a framework (also referred to as scaffold in this paper; e.g., SWE-agent [(Yang et al. , [2024](#bib.bib5) )] and OpenHands [(Wang et al. , [2025](#bib.bib29) )] ) that orchestrates tool use, manages context, and structures the problem-solving loop, wrapped around an LLM that generates each action in the trajectory [(Wang et al. , [2024](#bib.bib40) )] . To solve software development tasks, agents produce a *trajectory* , a step-by-step sequence of actions (file reads, edits, test executions, search queries) and the environment’s responses (compiler output, test results, error messages). Trajectories are the behavioral equivalent of a developer’s actions, capturing not just whether the agent succeeded, but *how* it approached the problem. This behavioral record is the primary data source for understanding agent strategies, failure modes, and intervention opportunities [(Majgaonkar et al. , [2025](#bib.bib24) ; Bouzenia and Pradel, [2025](#bib.bib1) )] .



Coding agents show promising results on several benchmarks [(Jimenez et al. , [2024](#bib.bib7) ; SWE-bench Team, [2025](#bib.bib32) )] , but they still present significant limitations. As of February 2026, the best submission on the SWE-bench Verified leaderboard [(SWE-bench Team, [2025](#bib.bib32) )] fails on more than 20%, meaning that even the strongest agent fails on nearly one in five tasks. When an agent fails, it wastes computing resources, developer review time, and organizational trust. In the SWE-bench Verified dataset we study, 12.4% of total compute is spent on the 55 tasks that no agent solves, resources with zero return. Thus, it is paramount to understand why and how coding agents fail.



To illustrate what can influence an agent’s success, we focus on the task django-15863 in SWE-bench Verified [(Jimenez et al. , [2024](#bib.bib7) ; OpenAI, [2024](#bib.bib6) )] : a 1-line fix that causes floatformat to drop precision on Decimal numbers. Three agents in the dataset failed to solve this task. This indicates that the task may be too complex for the same agents ( RQ1 : Task difficulty). Figure [1](#S1.F1) shows trajectories for two agents working on the task django-15863, one with Claude 4 Sonnet (on the left) and one with GPT-4 (on the right), but both using the same framework. The two agents produced similar numbers of actions in their trajectories: 37 for Claude 4 Sonnet and 36 for GPT-4. The agent with Claude 4 Sonnet makes one edit on the source code, has zero syntax errors, and solves the task successfully. GPT-4 makes many edits, with 28 syntax errors, and consequently fails. We observe in this example that, despite having similar numbers of steps in their trajectories, the actions differ significantly. The trajectory of the agent with Claude 4 Sonnet follows a ‘‘understand > reproduce > fix > verify’’ workflow, whereas the agent with GPT-4 follows ‘‘create > find > edit’’ . Thus, we conjecture that the success or failure of an agent may be related to the patterns of actions in its trajectory ( RQ2 : behavioral patterns). Finally, agents rely on a Framework and have an LLM , which produces the trajectories. Therefore, we hypothesize that both LLM and framework, and their interactions with the tasks, may contribute to success or failure in ways that existing work has not explored ( RQ3 : LLM capability and framework design).



## 3. Study Design


This section describes the data collection, trajectory encoding, feature-extraction pipeline, and analytical methods to answer the three RQs of our study.



### 3.1. Data Collection


Our study relies on 9,374 trajectories from 19 agents on the 500 SWE-bench Verified tasks [(Jimenez et al. , [2024](#bib.bib7) ; OpenAI, [2024](#bib.bib6) )] , which target real-world bugs across 12 open-source Python repositories. Agents represent 8 coding agent frameworks: SWE-agent, OpenHands, Trae, Skywork, CodeSweep, EPAM-AI, SAGE, and Sonar. Additionally, the dataset represents 14 LLMs: four Claude variants, three GPT variants, and seven others (e.g., Kimi-K2, Devstral, Qwen-32B, and Doubao). All trajectories are collected from submissions to the SWE-bench Verified leaderboard [(SWE-bench Team, [2025](#bib.bib32) )] , downloaded from the public experiment bucket maintained by the benchmark authors [(Jimenez et al. , [2024](#bib.bib7) )] . Each agent attempts all 500 tasks, yielding a complete a ​ g ​ e ​ n ​ t × t ​ a ​ s ​ k agent\times task matrix, with minor gaps: three agents have 443–499 runs due to timeouts or infrastructure failures. Since every task is attempted by every agent, this enables within-task comparisons that control for task difficulty, a confound that prior studies with 1–3 agents could not address.



### 3.2. Trajectory Encoding


Previous work classifies agent trajectories at varying granularity: Bouzenia and Pradel [(Bouzenia and Pradel, [2025](#bib.bib1) )] define eight action types (Explore, Locate, Search, Reproduce, Generate fix, Run tests, Refactor, Explain), while Graphectory [(Liu et al. , [2026](#bib.bib33) )] abstracts these into four steps (Localization, Patching, Validation, General). Both focus solely on the agent’s actions. We expand this by jointly encoding the agent action and the environment’s response. For example, a clean patch (i.e., edit) is encoded as P, while an edit that triggers a SyntaxError is encoded as Ps, and a test run that passes is Vp (i.e., Validation pass), while one that fails is Vf (i.e., Validation fail). Our encoding, shown in Table [1](#S3.T1) , comprises 13 sub-step symbols that capture execution quality and error type information while remaining compact and human-readable.


*Table 1. Enriched encoding: 13 sub-phase symbols. Each symbol is classified from the raw .traj data using deterministic regex rules on the action and observation fields.*


| Symbol | Meaning | Source in trajectory |
|---|---|---|
| Lb | Locate → \to browse whole file | view w/o --view_range |
| Lt | Locate → \to targeted read | view with --view_range , goto |
| Ls | Locate → \to with search | grep , search_dir , search_file |
| P | Patch (clean edit) | edit with no error in observation |
| Ps | Patch → \to syntax error | edit followed by SyntaxError |
| Pi | Patch → \to import error | edit followed by ImportError |
| Pr | Re-patch (same file) | edit on previously edited file |
| Vp | Validation passed | test run with no error |
| Vf | Validation → \to test failure | test run with test failure |
| Ve | Validation → \to runtime error | test run with RuntimeError |
| Vr | Reproduction script | reproduce_*.py or similar |
| E | Environment setup | pip, apt, conda, build |
| G | General / other | submit, cd, pwd, think |



### 3.3. Task-Level Feature Extraction


For each of the 500 tasks, we extract 90 features. Table [2](#S3.T2) summarizes the four categories and representative features. Our feature selection draws on established dimensions from prior work: (i) *Patch complexity* features follow the metrics used as difficulty proxies in prior SWE-bench studies [(Zan and others, [2025](#bib.bib25) ; Ganhotra, [2025](#bib.bib26) ; SWE-Bench Pro Team, [2025](#bib.bib11) )] ; (ii) *Test demand* features capture how demanding the task’s test infrastructure is, using the fail-to-pass test structure defined by SWE-bench [(Jimenez et al. , [2024](#bib.bib7) )] ; (iii) *Issue/prompt* features are informed by the bug report quality literature, which shows that steps to reproduce, stack traces, and code examples are the most impactful elements for bug resolution [(Bettenburg et al. , [2008](#bib.bib43) ; Weiss et al. , [2007](#bib.bib44) )] ; and (iv) *Metadata* features include repository, version, and issue age to control for project-level variation, as cross-project studies show that different projects have fundamentally different difficulty profiles [(Zimmermann et al. , [2009](#bib.bib45) )] . Features are computed deterministically using regex-based parsers on the issue text and diff-based analysis on the patches. The full list of features is in our supplementary material [(Mehtiyev and Assunção, [2026](#bib.bib46) )] .


*Table 2. Task-level features (90 total) extracted per task, organized by source.*


| Category | Count | Representative features |
|---|---|---|
| Patch complexity | 12 | lines added/deleted, hunks, files modified, multi-file flag, hunk size, directory depth |
| Test demand | 15 | fail-to-pass count, test assertions, parametrized tests, nesting depth |
| Issue / prompt | 53 | prompt length (words, sentences), has stacktrace, has repro code, code-to-text ratio, specificity score, lexical diversity |
| Metadata | 10 | repository, version, issue age, repo popularity, domain |



### 3.4. Analytical Design


#### 3.4.1. RQ1: Task difficulty and agent resolution analysis.


To answer RQ1, we conducted a quantitative and qualitative analysis of tasks considered “easy”, yet all agents failed to solve. We isolate 12 never-solved tasks that have simple patches (single file, ≤ \leq 10 changes) and compare them against 25 always-solved tasks with similar patch characteristics using Mann-Whitney U U tests and Cliff’s δ \delta across 90 task-level features. Where quantitative features do not fully explain the gap, we turn to qualitative trajectory analysis: for each of the 12 tasks, we examine the trajectories by the best-performing agents and compare their submitted patch against the gold patch to identify the failure mode.



#### 3.4.2. RQ2: Paired comparison of agent trajectories.


Comparing resolved and failed trajectories requires controlling for two confounds simultaneously: agent identity , since different agents have different capabilities; and task difficulty , since harder tasks produce more failures. Thus, we design the analysis around two approaches, formalized in Algorithm [1](#alg1) . *Approach A* fixes the agent and compares its resolved vs. failed trajectories across tasks, controlling for agent identity but confounded by task difficulty. *Approach B* fixes the task and compares resolved vs. failed trajectories from different agents, controlling for task difficulty but confounded by agent identity.



We apply this analytical design to answer RQ2, using trajectory length as the metric m m for RQ2a and per-symbol enriched encoding frequency (e.g., proportion of steps spent on validation) for RQ2b. We set n min = 5 n_{\min}=5 to ensure stable estimates. Prior studies [(Majgaonkar et al. , [2025](#bib.bib24) ; Bouzenia and Pradel, [2025](#bib.bib1) )] compare successes and failures without this control, so their findings are confounded by task difficulty. Our complete agent × \times task matrix makes both within-agent and within-task comparisons possible.



#### 3.4.3. RQ3: Agent framework vs. LLM capability.


We exploit a natural experiment: by holding the framework constant and varying the LLM, we isolate the LLM effect; by holding the LLM constant and varying the framework, we isolate the framework effect. We compare both factors using aggregate resolution rates and per-task outcome agreement. Finally, we analyze the prompt’s effect on overall agent strategy.


*Algorithm 1 Two-Approach Success/Failure Comparison*


1: Trajectories 𝒯 \mathcal{T} , contested tasks 𝒞 \mathcal{C} (tasks with both resolved and failed outcomes), behavioral metric m m , min. sample size n min n_{\min} , significance level α \alpha

2: Per-approach effect sizes and significance

3: A positive δ \delta or Δ \Delta indicates m m is higher for failed trajectories.

4:

5: — Approach A: fix agent, vary all tasks (one-sided) —

6: for each agent a ∈ Agents a\in\text{Agents} do

7: R a ← { t ∈ 𝒯 : t . agent = a , t . resolved } R_{a}\leftarrow\{t\in\mathcal{T}:t.\text{agent}=a,\;t.\text{resolved}\}

8: F a ← { t ∈ 𝒯 : t . agent = a , t . failed } F_{a}\leftarrow\{t\in\mathcal{T}:t.\text{agent}=a,\;t.\text{failed}\}

9: if | R a | < n min |R_{a}|<n_{\min} or | F a | < n min |F_{a}|<n_{\min} then skip

10: δ a , p a ← Mann-Whitney ​ U ​ (one-sided: ​ F > R ​ ) + Cliff’s ​ δ \delta_{a},p_{a}\leftarrow\text{Mann-Whitney }U\text{ (one-sided: }F>R\text{)}+\text{Cliff's }\delta on m ​ ( F a ) m(F_{a}) vs m ​ ( R a ) m(R_{a})

11: Aggregate: count agents with δ a > 0 \delta_{a}>0 ( p < α p<\alpha ) vs δ a < 0 \delta_{a}<0 ( p < α p<\alpha )

12:

13: — Approach B: fix task, vary agents (two-sided) —

14: for each task t ∈ 𝒞 t\in\mathcal{C} do

15: R t ← { τ ∈ 𝒯 : τ . task = t , τ . resolved } R_{t}\leftarrow\{\tau\in\mathcal{T}:\tau.\text{task}=t,\;\tau.\text{resolved}\}

16: F t ← { τ ∈ 𝒯 : τ . task = t , τ . failed } F_{t}\leftarrow\{\tau\in\mathcal{T}:\tau.\text{task}=t,\;\tau.\text{failed}\}

17: Δ ​ ( t ) ← mean ​ ( m ​ ( F t ) ) − mean ​ ( m ​ ( R t ) ) \Delta(t)\leftarrow\text{mean}(m(F_{t}))-\text{mean}(m(R_{t}))

18: p ← p\leftarrow Wilcoxon signed-rank (two-sided) on { Δ ​ ( t ) } t ∈ 𝒞 \{\Delta(t)\}_{t\in\mathcal{C}}

19: Report: Δ ¯ \bar{\Delta} , p p , fraction of tasks with Δ ​ ( t ) > 0 \Delta(t)>0



## 4. Results and Discussion


This section presents the results and discussion organized per RQ.



### 4.1. RQ1: Why do coding agents fail on certain tasks?


#### 4.1.1. Difficulty Landscape and Edge-Case Selection.


We classify each of the 500 tasks by its resolution rate across all agents. The distribution is bimodal (Figure [2](#S4.F2) ): 55 tasks (11%) are never solved by any agent, 416 (83%) are contested, and 29 (6%) are always solved.


![Refer to caption](2604.02547v1/x2.png)
 *Figure 2. Task difficulty distribution across 500 SWE-bench Verified tasks.*



Among the 55 never-solved tasks, 12 require only a single-file patch of ≤ \leq 10 total changes. Table [3](#S4.T3) presents these tasks. Focusing on patch complexity, as in prior work [(Zan and others, [2025](#bib.bib25) ; Ganhotra, [2025](#bib.bib26) ; SWE-Bench Pro Team, [2025](#bib.bib11) )] , these are considered simple tasks by humans and are expected to be solved at high rates across our dataset. Therefore, these edge cases invalidate the prior work’s conclusions that correlate patch complexity with difficulty, suggesting that something beyond patch size must also matter.



To further investigate these cases, we compare the 12 never-solved tasks with the 25 always-solved tasks that have similarly simple patches (single file, ≤ \leq 10 changes). The results show that patch complexity is statistically indistinguishable between the two groups (mean total changes: 4.75 vs. 3.76; with Mann-Whitney p = 0.24 p=0.24 , Cliff’s δ = 0.24 \delta=0.24 ). Of the 90 task-level features we investigated, 1 1 1 The complete list of features is available in our supplementary material [(Mehtiyev and Assunção, [2026](#bib.bib46) )] . Table [4](#S4.T4) presents the five ones with significant results ( p < 0.05 p<0.05 ), all of which are test-demand or issue-description features. However, three of the twelve never-solved tasks have the minimum possible test demand (FTP = 1), and when we restrict the comparison to very simple patches ( ≤ \leq 5 changes), the test-demand differences become non-significant. Quantitative features alone do not fully distinguish these edge cases, motivating a detailed manual qualitative analysis of the agent trajectories themselves.


*Table 3. Twelve never-solved tasks with simple patches. The *Human label* column shows the official difficulty annotation from SWE-bench Verified’s human annotators [(OpenAI, [2024](#bib.bib6) )] . By every prior difficulty metric and by human judgment, these are easy tasks. Zero of 19 agents solve any of them.*


| Task | Lines | Hunks | Files | Res. | Human label |
|---|---|---|---|---|---|
| django-11477 | 2 | 1 | 1 | 0/19 | 15 min–1 hr |
| django-15098 | 2 | 1 | 1 | 0/19 | 15 min–1 hr |
| django-16667 | 2 | 1 | 1 | 0/19 | 15 min–1 hr |
| sympy-20428 | 2 | 1 | 1 | 0/19 | 15 min–1 hr |
| matplotlib-23476 | 3 | 1 | 1 | 0/19 | < < 15 min |
| matplotlib-23299 | 5 | 2 | 1 | 0/19 | 15 min–1 hr |
| django-13794 | 6 | 1 | 1 | 0/19 | < < 15 min |
| sympy-21930 | 6 | 3 | 1 | 0/19 | 15 min–1 hr |
| django-10999 | 7 | 1 | 1 | 0/19 | < < 15 min |
| django-14792 | 7 | 1 | 1 | 0/19 | < < 15 min |
| matplotlib-21568 | 7 | 1 | 1 | 0/19 | 15 min–1 hr |
| django-15252 | 8 | 1 | 1 | 0/19 | 15 min–1 hr |


*Table 4. The 5 features (of 90 tested) reaching p < 0.05 p<0.05 between 12 never-solved and 25 always-solved simple-patch tasks. No patch or metadata feature is significant.*


| Feature | Never | Always | Cliff’s δ \delta | p p |
|---|---|---|---|---|
| Fail-to-pass count | 2.42 | 1.24 | +0.61 (L) | < < 0.001 |
| FTP test files | 2.17 | 1.20 | +0.55 (L) | 0.001 |
| Test patch files | 1.58 | 1.00 | +0.33 (M) | 0.003 |
| Test patch changes | 21.25 | 12.64 | +0.46 (M) | 0.025 |
| Has repro code | 0.67 | 0.24 | +0.43 (M) | 0.014 |



#### 4.1.2. Trajectory Analysis: The Architectural Reasoning Gap.


Figure [3](#S4.F3) illustrates what we mean by *architectural reasoning gap* through the task matplotlib-23476. On HiDPI screens (e.g., M1 Mac), matplotlib internally doubles the figure DPI for retina display but tracks the original value in a separate attribute ( _original_dpi ). The bug is that Figure.__getstate__() , the method Python’s pickle protocol calls during serialization, saves the doubled DPI instead of the original. Each pickle/unpickle cycle doubles the DPI (200 → \to 400 → \to 800 → … \to\ldots ). The 3-line gold patch resets _dpi to _original_dpi before serialization. The best agent (61 steps) correctly finds figure.py , understands the DPI doubling, but tries to prevent the doubling from happening by editing four backend files ( backend_macosx.py , backend_agg.py , backend_bases.py , _macosx.m ). It attacks the display scaling layer instead of the serialization layer. Both the agent and the gold patch address the same symptom, but at different architectural levels: the agent tries to stop the value from changing, while the fix ensures the changed value is not persisted. The qualitative analysis for all 12 edge cases is available in our supplementary material [(Mehtiyev and Assunção, [2026](#bib.bib46) )] .



The pattern observed in the example above is systematic. We examined the trajectories of the top-performing agents on all 12 never-solved simple-patch tasks (Table [3](#S4.T3) ), comparing their submitted patches against the gold patch. Table [5](#S4.T5) summarizes the results. In every case, the agent correctly localizes the bug, finding the gold-patch file in 12 of 12 tasks and editing it in 10 of 12. Yet it consistently intervenes at the wrong level. In 10 of 12 tasks, the failure traces back to architectural judgment: the agent patches the symptom (the caller, the consumer, the display layer) while the gold patch fixes the root cause (the callee, the producer, the serialization layer), or the agent cannot judge the right scope for its fix. The remaining two tasks involve a behavioral failure (abandoning a correct fix mid-trajectory) and a domain knowledge gap (TeX math-mode formatting). The agent’s fixes compile and pass its own tests; they fail because the SWE-bench test suite validates behavior at the root-cause level.


![Refer to caption](2604.02547v1/x3.png)
 *Figure 3. Representative case study: matplotlib-23476. The agent fixes DPI scaling in display backends (4 files); the gold patch fixes the serialization in __getstate__ (3 lines). Both address the same bug from different architectural levels.*


*Table 5. Architectural gap across all 12 never-solved simple-patch tasks. The best agent found the gold-patch file in 12/12 and edited it in 10/12, yet failed every time.*


| Task | Gap type | Root cause |
|---|---|---|
| django-11477 | Caller → \to Callee | Architectural judgment (10 tasks) |
| django-13794 | Symptom → \to Root cause |
| django-14792 | Consumer → \to Producer |
| mpl-23299 | Add → \to Remove behavior |
| mpl-23476 | Display → \to Serialization |
| sym-20428 | Operations → \to Type system |
| django-15252 | Components → \to Orchestrator |
| django-10999 | Issue’s fix → \to Redesign |
| sym-21930 | Local + general → \to Local only |
| django-16667 | Wrong control flow |
| django-15098 | Abandoned correct fix | Behavioral |
| mpl-21568 | Wrong TeX commands | Domain knowledge |


Answering RQ1 Patch complexity alone does not explain why agents fail. Twelve never-solved tasks require simple patches ( ≤ \leq 10 changes, single file) and were labeled easy by human annotators. Quantitative analysis shows test demand and issue-description features distinguish these from always-solved tasks, but the deeper cause is an *architectural reasoning gap* : agents correctly localize the bug and produce plausible fixes, but intervene at the wrong architectural layer (10/12 tasks). They patch symptoms rather than root causes.


##### Implications.


RQ1 reveals a ceiling that even top-performing agents may not overcome. The 12 never-solved simple-patch tasks fail not because agents lack the right tool or take too few steps, but because they intervene at the wrong architectural layer. Agents find the correct file and produce plausible fixes, yet consistently patch the symptom rather than the root cause. This architectural reasoning gap suggests that scaling model size or training on more code may not suffice; agents may need explicit mechanisms for reasoning about component boundaries, ownership, and the direction of causal dependencies in a codebase. For benchmark designers, this implies that test-demand metrics and architectural complexity indicators should complement patch size as difficulty measures.



### 4.2. RQ2: How do the behavioral patterns differentiate success from failure?


#### 4.2.1. RQ2a: Trajectory Length Shows a Confounding Reversal


Prior work reports that failed agent trajectories are substantially longer than successful ones. Majgaonkar et al. [(Majgaonkar et al. , [2025](#bib.bib24) )] find 12.6–82.5% longer failed trajectories across agents on SWE-bench. However, these comparisons pool trajectories across tasks of varying difficulty without controlling for it. We apply two approaches (see Section [3.4](#S3.SS4) ) to investigate whether this finding holds.



##### Approach A (fix agent, vary tasks).


We replicate the cross-task finding across all agents on SWE-bench Verified. Table [6](#S4.T6) shows that for every agent, failed trajectories are significantly longer ( p < 0.001 p<0.001 , one-sided Mann-Whitney U U ), with percentage gaps from + + 14.0% to + + 111.9%. The effect is universal: regardless of framework or LLM, when a given agent fails, it takes more steps than when it succeeds. However, Approach A is confounded by task difficulty. Figure [4](#S4.F4) shows the source: for every agent, trajectory length increases with task difficulty ( ρ \rho from − - 0.13 to − - 0.57, all p < 0.01 p<0.01 ). Tasks with a lower resolution rate produce longer trajectories regardless of outcome, so the within-agent “failures are longer” effect may partly reflect that agents fail on harder (and therefore longer) tasks.


*Table 6. Length–failure effect. Approach A (top): for each agent, mean steps of resolved vs. failed runs across all tasks; every agent shows failures are significantly longer ( p < 0.001 p<0.001 , one-sided Mann-Whitney U U ). Approach B (bottom): for each contested task, mean steps of resolved vs. failed agents; the effect *reverses* : resolved trajectories are longer on 63% of tasks ( p < 10 − 8 p<10^{-8} , two-sided Wilcoxon signed-rank).*


| Agent | LLM | Res. Rate | % Longer | Cliff’s δ \delta | Sig. |
|---|---|---|---|---|---|
| Approach A: fix agent, vary all tasks (one-sided Mann-Whitney U U ) |
| Sonar | claude-opus-4.5 | 79.2% | +30.5% | +0.434 | *** |
| Trae | doubao-seed-code | 78.5% | +65.1% | +0.316 | *** |
| OpenHands | claude-opus-4.5 | 78.3% | +29.6% | +0.403 | *** |
| EPAM-AI | claude-4-sonnet | 76.8% | +19.9% | +0.389 | *** |
| Trae | claude-4-sonnet+opus | 75.4% | +36.7% | +0.503 | *** |
| SAGE | claude-4.5+gpt-5 | 73.0% | +14.5% | +0.224 | *** |
| OpenHands | gpt-5 | 71.8% | +14.0% | +0.234 | *** |
| OpenHands | claude-4-sonnet | 70.4% | +16.0% | +0.264 | *** |
| SWE-agent | claude-4-sonnet | 66.6% | +17.5% | +0.297 | *** |
| OpenHands | kimi-k2 | 65.4% | +27.6% | +0.388 | *** |
| CodeSweep | kimi-k2 | 53.4% | +89.2% | +0.383 | *** |
| OpenHands | claude-3.5-sonnet | 53.0% | +82.2% | +0.393 | *** |
| OpenHands | devstral-small | 46.8% | +44.3% | +0.430 | *** |
| SWE-agent | lm-32b | 40.2% | +111.9% | +0.567 | *** |
| Skywork | qwen-32b | 38.1% | +18.9% | +0.173 | *** |
| SWE-agent | claude-3.5-sonnet | 33.6% | +35.2% | +0.364 | *** |
| SWE-agent | gpt-4o | 24.9% | +54.4% | +0.386 | *** |
| SWE-agent | gpt-4 | 22.6% | +59.9% | +0.506 | *** |
| SWE-agent | claude-3-opus | 15.1% | +20.4% | +0.506 | *** |
| Approach B: fix task, vary agents (416 contested tasks, paired Wilcoxon) |
| Within-task aggregate | — | − - 10.0% | — | *** |





*** p < 0.001 p<0.001 , ** p < 0.01 p<0.01 , * p < 0.05 p<0.05 .



##### Approach B (fix task, vary agents).


To control task difficulty, we compare resolved and failed trajectories *within each contested task* . For each of the 416 contested tasks, we compute the mean trajectory length for resolved and failed agents separately. Interestingly, the result reverses: resolved agents average 44.0 steps vs. 39.6 for failed agents (10.0% longer). On 263 of 416 tasks (63%), resolved trajectories are longer ( p = 1.9 × 10 − 9 p=1.9\times 10^{-9} , two-sided Wilcoxon signed-rank). On the same task, the agents that succeed take more steps than the agents that fail.


![Refer to caption](2604.02547v1/x4.png)
 *Figure 4. Trajectory length by task difficulty for all 19 agents. Every agent takes more steps on harder tasks (all Spearman ρ < 0 \rho<0 , all p < 0.01 p<0.01 ). This universal length–difficulty coupling explains the confounding reversal: length reflects task difficulty, not strategy quality.*



The two approaches give opposite answers, revealing that trajectory length simultaneously reflects task difficulty and agent capability. This ambiguity motivates RQ2b: we need behavioral dimensions that do not co-vary with task difficulty.



#### 4.2.2. RQ2b: Distinguishing Successful Strategies from Failed Ones.


We examine how agents allocate their first 10 steps between reading and patching, and how this relates to resolution rate.


![Refer to caption](2604.02547v1/x5.png)
 *Figure 5. Same task and length (32 steps), different agent, different outcome. Left: CodeSweep/kimi-k2 explores, struggles, breaks through (Vp), submits. Right: SWE-agent/gpt-4 skips exploration, enters an endless P → \to Ve spiral, never recovers.*



##### Context gathering and patch intensity.


Figure [6](#S4.F6) a shows that agents delaying their first edit succeed more ( ρ = + 0.68 \rho=+0.68 , p < 0.001 p<0.001 ): agents at the top-right (e.g., claude-opus-4.5 at step 9.4) resolve most tasks, while those at the bottom-left (e.g., claude-3-opus at step 0) fail most. To illustrate this trend, Figure [5](#S4.F5) presents two agents with the same number of steps (32 each) on astropy-13579 but diverge entirely: CodeSweep/kimi-k2 explores the codebase first (4 Lb steps), struggles through a patch-fail loop, and eventually breaks through to a passing test; SWE-agent/gpt-4 patches immediately on step 1 and enters a P → \to Ve spiral from which it never recovers. The inverse of context gathering is opening patch intensity (Figure [6](#S4.F6) b): agents that front-load patching in the first 10 steps succeed less ( ρ = − 0.78 \rho=-0.78 , p < 0.001 p<0.001 ). These results show how an agent spends its opening steps is strongly predictive of its overall success.



##### Validation effort.


We examine how much of the trajectory agents spend on validation and how this relates to success. Validation effort (Figure [6](#S4.F6) c) correlates positively with resolution rate ( ρ = + 0.50 \rho=+0.50 , p < 0.05 p<0.05 ), ranging from 0.1% (Trae/doubao) to 39.3% (Sonar/claude-opus-4.5). One outlier stands out: Trae/doubao achieves 78% resolution with near-zero validation, suggesting its LLM produces correct patches without test-driven iteration. At the other end, SWE-agent/gpt-4 validates only 13% of steps and resolves 23%. These results indicate that investing more trajectory steps in validation is associated with higher success, though sufficiently strong LLMs can bypass this need.



##### Task-agnostic agent strategies.


A natural question is whether agents adjust the three behavioral dimensions above (i.e., context gathering, patch intensity, and validation effort) based on task characteristics. Figure [7](#S4.F7) tests this by plotting each dimension against patch complexity (lines changed) for six representative agents. For context gathering (Figure [7](#S4.F7) a), the lines are flat: claude-3-opus edits at step 0 on every task regardless of complexity, while OpenHands/claude-4-sonnet waits until step 9.5 on every task. For opening patch intensity (Figure [7](#S4.F7) b), the same pattern holds: agents that patch aggressively do so on simple and complex tasks alike. For validation effort (Figure [7](#S4.F7) c), strong agents validate 35–37% of steps across all complexity bins, while weak agents stay at 12–19%. In all three figures, the vertical separation between agents (the level) is large, but the slope within each agent is near zero. This means the behavioral differences we observe are agent-determined rather than task-specific adaptations. Agents apply a fixed strategy regardless of what the task demands, suggesting that current agent designs lack mechanisms to assess task complexity and adjust their approach accordingly.


![Refer to caption](2604.02547v1/x6.png)
 *Figure 6. Three structural dimensions of RQ2b across all agents. (a) Context gathering: agents that delay their first edit succeed more ( ρ \rho = + + 0.68, p < 0.001 p<0.001 ). (b) Opening patch intensity: agents that spend more of their first 10 steps patching succeed less ( ρ \rho = − - 0.78, p < 0.001 p<0.001 ). (c) Validation effort: agents that spend more of their trajectory on validation succeed more ( ρ \rho = + + 0.50, p < 0.05 p<0.05 )*


![Refer to caption](2604.02547v1/x7.png)
 *Figure 7. Strategy stability across task complexity for 6 representative agents (3 SWE-agent in red, 3 OpenHands in blue). (a) Context gathering , (b) opening patch intensity , and (c) validation effort are plotted against patch complexity (lines changed).*


Answering RQ2 Trajectory length is an ambiguous discriminator: the direction reverses depending on whether agent identity or task difficulty is controlled. Trajectory *structure* discriminates consistently: agents that gather context before editing, avoid premature patching, and invest in validation succeed more. All three dimensions are agent-determined and stable across task complexity, indicating that agents employ fixed strategies that do not adapt to a given task.



##### Implications.


RQ2 has several practical implications. First, trajectory length should not be used as a standalone signal for failure detection and monitoring. Second, the structural dimensions we identify offer a more reliable alternative. The opening strategy (read-first vs patch-first) is observable within the first 10 steps and correlates with the outcome across all agents. A monitoring system that detects premature patching in the opening steps could flag runs unlikely to succeed before significant compute is spent. Finally, the strategy stability finding (Figure [7](#S4.F7) ) shows that agents use fixed strategies regardless of task complexity, suggesting that agent designers should focus on building adaptive strategies that adjust their approach to task requirements rather than adopting a one-size-fits-all workflow.



### 4.3. RQ3: Does LLM capability or framework design drive agent success?


To answer this question, we first compare resolution rates across LLMs and frameworks in our dataset. Figure [8](#S4.F8) presents the resolution rate for all 19 agents. Within the same framework, swapping the LLM produces large shifts: 51.5 pp across 6 LLMs in SWE-agent, 31.5 pp across 6 in OpenHands. Holding the LLM constant, the framework effect is smaller: 3.8 pp for claude-4-sonnet, 19.4 pp for claude-3.5-sonnet. This gap narrows as LLMs improve (19.4 pp → \to 3.8 pp → \to 0.9 pp across three generations), and at the frontier, agents from 5 different frameworks converge to within 10 pp of the best.


![Refer to caption](2604.02547v1/x8.png)
 *Figure 8. Resolution rate for 19 agents on SWE-bench Verified (500 tasks), colored by framework.*



##### Per-task agreement confirms LLM dominance.


To move beyond aggregate resolution rates, we measure per-task outcome agreement: for each pair of agents sharing the same LLM (or the same framework), the fraction of 500 tasks on which both agents produce the same outcome (both resolve or both fail). Figure [9](#S4.F9) shows the results. When the LLM is held constant, and the framework varies (Figure [9](#S4.F9) a), agreement is high and increases with LLM capability: 71% for claude-3.5-sonnet, 85–88% for claude-4-sonnet (3 pairs), and 93% for claude-opus-4.5. When the framework is held constant, and the LLM varies (Figure [9](#S4.F9) b), agreement drops substantially and spreads widely: 47–85% across 15 LLM pairs in SWE-agent and 66–88% in OpenHands. The density distributions in Figure [9](#S4.F9) b show that most LLM pairs agree on only 60–80% of tasks, far below the 85–93% seen when the same LLM is used across frameworks. This confirms that the LLM, not the framework, is the primary determinant of which tasks get solved.


![Refer to caption](2604.02547v1/x9.png)
 *Figure 9. Per-task outcome agreement. (a) Same LLM across frameworks: agreement increases with LLM capability. (b) Same framework across LLMs: agreement is lower and more variable, shown as density distributions over all LLM pairs.*


![Refer to caption](2604.02547v1/x10.png)
 *Figure 10. System prompt comparison for claude-4-sonnet on SWE-agent (top) vs. OpenHands (bottom). Quoted text extracted verbatim from trajectory files. Despite a 16 × \times difference in instruction length (350 vs. 5,602 characters), the LLM produces near-identical core behavioral metrics on both frameworks.*



##### Prompt influence diminishes with LLM capability.


We examine how much the framework’s system prompt shapes agent behavior by comparing the same LLM on SWE-agent vs. OpenHands (Figure [10](#S4.F10) ). These two prompts differ substantially: SWE-agent’s is 350 characters, OpenHands’ is 5,602. Each prompt does steer the agent toward different tool usage patterns (e.g., SWE-agent produces more reproduction scripts, OpenHands produces more search actions). However, the total amount of validation work is nearly identical across frameworks (18.2 vs. 20.0 actions per trajectory), indicating that the prompts change *which tools* the agent uses but not *how much work* it does. Crucially, this prompt influence is capability-dependent: for claude-3.5-sonnet, switching frameworks yields an additional 20 pp improvement in resolution, but for claude-4-sonnet, the same switch yields only a 4 pp improvement in resolution. Stronger LLMs develop their own strategy and are less susceptible to prompt-level steering.


Answering RQ3 The LLM is the primary driver of both outcome and behavior; the framework’s contribution shrinks with each LLM generation. Two agents sharing the same LLM agree on 85–93% of tasks regardless of framework, whereas two agents sharing the same framework but different LLMs agree on only 47–88% (Figure [9](#S4.F9) ). The framework performance gap narrows from 19.4 pp to 3.8 pp to 0.9 pp across 3 successive Claude generations. Framework prompts do shape tool choices but not overall effort, and this shaping effect diminishes as LLMs grow stronger.



##### Implications.


RQ3 shows that at the current frontier, investing in better LLM reasoning will yield larger returns than redesigning the orchestration scaffold. The convergence pattern reinforces this: as LLMs improve, the gaps in the framework shrink. Framework engineering is not irrelevant, but its marginal value diminishes with each generation of LLM. For practitioners selecting an agent, this finding suggests that the choice of LLM matters more than the choice of framework: allocating budget toward a stronger model is likely to produce larger gains than switching scaffolds. For researchers, this result implies that comparing two agents without controlling for the underlying LLM conflates model capability with system design. Future empirical studies should adopt factorial designs (LLM × \times framework) to isolate each factor’s contribution. Our results also challenge the assumption that more detailed system prompts lead to better agent performance. SWE-agent provides a minimal prompt (350 characters), while OpenHands prescribes an 8-phase workflow in 5,602 characters—a 16 × \times difference. Yet for claude-4-sonnet, both produce near-identical core behavioral metrics and only a 4% resolution difference (Figure [10](#S4.F10) ). The additional prompt detail adds overhead (60 vs. 56 median steps) without improving outcomes. Prior work has shown that LLMs are highly sensitive to prompt formatting [(Sclar et al. , [2024](#bib.bib34) )] and that longer inputs can degrade reasoning performance [(Levy et al. , [2024](#bib.bib35) )] , though larger models exhibit enhanced robustness to prompt variations [(Zhuo et al. , [2024](#bib.bib36) )] . Our finding extends this to the agent setting: for strong LLMs, lean prompts may be preferable, as the model’s own reasoning compensates for the lack of explicit guidance while verbose prompts add procedural overhead. The effect is capability-dependent, however: weaker LLMs (claude-3.5-sonnet) do benefit from richer prompts, gaining 19.4 pp from the same framework switch.



## 5. Limitations and Threats to Validity


##### Internal validity.


Our study uses observational data, which may introduce confounds. While within-task comparisons control for task difficulty, other factors, such as tool API differences (e.g., edit vs. str_replace) and framework prompting, may influence behavior. We mitigate this through cross-framework comparisons with shared LLMs and within-framework LLM variation, but cannot fully eliminate residual confounding. Our trajectory encoding relies on deterministic regex parsing, which may introduce minor classification errors (18/9,374 failures). Additionally, agent trajectories were collected at different points in time, so differences in API versions, hardware, or SWE-bench infrastructure could affect results. We mitigate this by analyzing only final submitted trajectories under identical evaluation conditions (the SWE-bench harness). Because we observe each agent on only a single run per task, we cannot measure the stochastic variance inherent in LLM-based agents. Prior work [(Brown et al. , [2024](#bib.bib27) )] shows that repeated runs can change outcomes; our single-run design may therefore over- or under-attribute failures to deterministic causes.



##### Construct validity.


Our 13-symbol trajectory encoding captures actions and outcomes but abstracts away finer-grained differences in reasoning and chain-of-thought quality. Metrics such as trajectory length and validation effort are proxies for strategy and may not fully capture underlying cognition. We mitigate this by combining multiple behavioral dimensions with qualitative analysis. The classification of tasks into “never-solved,” “contested,” and “always-solved” is population-dependent: a different set of agents could shift these categories. Similarly, our 90 task features are computed from observable artifacts (patches, issues, metadata) and may miss latent difficulty factors such as conceptual reasoning complexity or implicit domain knowledge not reflected in the issue text.



##### External validity.


Our results are based on 500 Python tasks across 12 open-source repositories from SWE-bench Verified and may not generalize to other programming languages, proprietary codebases, or development settings.



##### Conclusion validity.


We use non-parametric statistical tests (Mann-Whitney U U , Wilcoxon signed-rank) and effect sizes (Cliff’s δ \delta ) over a large dataset (9,374 trajectories), supporting robust comparisons. However, some analyses involve small samples: the 12 never-solved simple-patch tasks (RQ1) and the 25 always-solved tasks limit statistical power for subgroup comparisons. We complement these with qualitative analysis to strengthen conclusions. For RQ3, the number of same-LLM and same-framework pairs is constrained by the available leaderboard submissions, which limits the generalizability of the agreement analysis to specific LLM–framework combinations rather than all possible pairings.



## 6. Related Work


Three lines of work study aspects of coding agent performance:



##### Task difficulty characterization.


Prior work primarily defines task difficulty using patch-based metrics. Multi-SWE-bench [(Zan and others, [2025](#bib.bib25) )] categorizes tasks by human-estimated resolution time, showing that harder tasks involve larger patches. SWE-bench Pro [(SWE-Bench Pro Team, [2025](#bib.bib11) )] and Ganhotra [(Ganhotra, [2025](#bib.bib26) )] similarly rely on patch complexity, while Large Language Monkeys [(Brown et al. , [2024](#bib.bib27) )] highlights stochastic solvability without analyzing difficulty drivers. Although such metrics correlate with difficulty in our data ( ρ = − 0.380 \rho=-0.380 ), they fail to explain edge cases: 12 tasks requiring minimal edits (single-file, ≤ \leq 10 changes) are unsolved by all agents. Prior work does not investigate why these seemingly simple tasks remain unsolvable.



##### Behavioral analysis of coding agents.


Existing studies examine agent behavior but lack proper controls or scale. Majgaonkar et al. [(Majgaonkar et al. , [2025](#bib.bib24) )] report longer failed trajectories but do not control for task difficulty, leading to confounded conclusions. Bouzenia and Pradel [(Bouzenia and Pradel, [2025](#bib.bib1) )] identify repetitive loops and cascading errors, but analyze only 120 trajectories across three agents. Chen et al. [(Chen and others, [2025](#bib.bib42) )] propose a process-oriented error taxonomy but do not perform within-task paired comparisons. Chen et al. [(Chen and others, [2026](#bib.bib2) )] scale analysis across six LLMs but focus only on generated tests, finding that test-writing practices provide marginal utility rather than differentiating success from failure.



##### Decomposing agent performance.


Other work compares agents at the architecture or LLM level. Martinez and Franch [(Martinez and Franch, [2025](#bib.bib13) )] and Ceka et al. [(Ceka et al. , [2025](#bib.bib8) )] treat agents as monolithic, conflating LLM and framework effects. More recent studies begin to vary LLMs: SWE-bench Pro [(SWE-Bench Pro Team, [2025](#bib.bib11) )] categorizes failures using LLM summaries, SWE-Compass [(SWE-Compass Team, [2025](#bib.bib14) )] evaluates multiple LLMs across frameworks at the outcome level, and Ehsani et al. [(Ehsani et al. , [2026](#bib.bib12) )] analyze large-scale PRs without LLM-level breakdown. At the task level, DEI [(Zhang et al. , [2024](#bib.bib28) )] shows that different agents resolve different sets of tasks and achieves 34.3% resolution through ensembling open-source agents that individually score at most 27.3%, demonstrating that task-level agreement across agents is low. However, DEI treats each agent as monolithic and does not decompose whether the disagreement stems from the LLM or the framework. We address this gap by measuring per-task outcome agreement separately for same-LLM/different-framework pairs and same-framework/different-LLM pairs, showing that LLM identity predicts task-level outcomes more than framework identity.



Across all three lines of work, no prior study has combined within-task behavioral analysis with cross-framework LLM decomposition at scale, which shows the novelty of our study.



## 7. Conclusion


This study presents a large-scale behavioral analysis of LLM-based coding agents, connecting task characteristics, agent architecture, and trajectory dynamics to understand how and why agents fail. We find that standard difficulty metrics leave edge cases unexplained where the bottleneck is architectural reasoning and domain knowledge rather than patch complexity. Comparing success and failure trajectories under controlled paired designs shows that trajectory length is confounded by task difficulty, but structural properties of the trajectory, particularly how agents sequence reading, patching, and validation, distinguish success from failure consistently. Decomposing agent performance reveals that LLM capability drives both outcome and behavioral strategy, while framework design contributes surface-level variation that diminishes as models improve. Future work could extend this analysis to multilingual benchmarks, develop real-time monitoring tools that leverage behavioral signatures for early failure detection, and investigate whether the architectural reasoning gap can be addressed through retrieval-augmented or design-aware agent architectures.



## Data Availability


This paper includes supplementary artifacts available at [(Mehtiyev and Assunção, [2026](#bib.bib46) )] .



## References

- N. Bettenburg, S. Just, A. Schröter, C. Weiss, R. Premraj, and T. Zimmermann (2008) What makes a good bug report? . In Proceedings of the 16th ACM SIGSOFT International Symposium on Foundations of Software Engineering (FSE) , pp. 308–318 . External Links: [Document](https://dx.doi.org/10.1145/1453101.1453146) Cited by: [§3.3](#S3.SS3.p1.1) .
- I. Bouzenia and M. Pradel (2025) Understanding software engineering agents: a study of thought-action-result trajectories . In 40th IEEE/ACM International Conference on Automated Software Engineering (ASE) , Cited by: [§1](#S1.p2.1) , [§2](#S2.p1.1) , [§3.2](#S3.SS2.p1.1) , [§3.4.2](#S3.SS4.SSS2.p2.3) , [§6](#S6.SS0.SSS0.Px2.p1.1) .
- B. Brown, J. Juravsky, R. Ehrlich, R. Clark, Q. V. Le, C. Ré, and A. Mirhoseini (2024) Large language monkeys: scaling inference compute with repeated sampling . arXiv preprint arXiv:2407.21787 . Cited by: [§5](#S5.SS0.SSS0.Px1.p1.1) , [§6](#S6.SS0.SSS0.Px1.p1.2) .
- I. Ceka, S. Pujar, S. Ramji, et al. (2025) Understanding software engineering agents through the lens of traceability: an empirical study . arXiv preprint arXiv:2506.08311 . Cited by: [§6](#S6.SS0.SSS0.Px3.p1.1) .
- M. Chen, J. Tworek, H. Jun, Q. Yuan, H. P. d. O. Pinto, J. Kaplan, et al. (2021) Evaluating large language models trained on code . arXiv preprint arXiv:2107.03374 . Cited by: [§1](#S1.p1.1) .
- Z. Chen et al. (2025) Beyond final code: a process-oriented error analysis of software development agents in real-world GitHub scenarios . arXiv preprint arXiv:2503.12374 . Note: Accepted at ICSE 2026 Cited by: [§1](#S1.p2.1) , [§6](#S6.SS0.SSS0.Px2.p1.1) .
- Z. Chen et al. (2026) Rethinking the value of agent-generated tests for llm-based software engineering agents . arXiv preprint arXiv:2602.07900 . Cited by: [§6](#S6.SS0.SSS0.Px2.p1.1) .
- R. Ehsani, S. Pathak, S. Rawal, et al. (2026) Where do AI coding agents fail? an empirical study of failed agentic pull requests in GitHub . arXiv preprint arXiv:2601.15195 . Cited by: [§1](#S1.p1.1) , [§6](#S6.SS0.SSS0.Px3.p1.1) .
- J. Ganhotra (2025) Cracking the code: how difficult are SWE-bench-verified tasks really? . Note: [https://jatinganhotra.dev/blog/swe-agents/2025/04/15/swe-bench-verified-easy-medium-hard.html](https://jatinganhotra.dev/blog/swe-agents/2025/04/15/swe-bench-verified-easy-medium-hard.html) Blog post Cited by: [§1](#S1.p3.1) , [§3.3](#S3.SS3.p1.1) , [§4.1.1](#S4.SS1.SSS1.p2.1) , [§6](#S6.SS0.SSS0.Px1.p1.2) .
- J. Jiang, F. Wang, J. Shen, S. Kim, and S. Kim (2024) A survey on large language models for code generation . arXiv preprint arXiv:2406.00515 . Cited by: [§1](#S1.p1.1) .
- C. E. Jimenez, J. Yang, A. Wettig, S. Yao, K. Pei, O. Press, and K. Narasimhan (2024) SWE-bench: can language models resolve real-world GitHub issues? . In International Conference on Learning Representations (ICLR) , Cited by: [§1](#S1.p1.1) , [§2](#S2.p2.1) , [§2](#S2.p3.1) , [§3.1](#S3.SS1.p1.1) , [§3.3](#S3.SS3.p1.1) .
- M. Levy, A. Jacoby, and Y. Goldberg (2024) Same task, more tokens: the impact of input length on the reasoning performance of large language models . In 62nd Annual Meeting of the Association for Computational Linguistics (ACL) , Cited by: [§4.3](#S4.SS3.SSS0.Px3.p1.2) .
- J. Liu, K. Wang, Y. Chen, X. Peng, Z. Chen, L. Zhang, and Y. Lou (2024) Large language model-based agents for software engineering: a survey . arXiv preprint arXiv:2409.02977 . Cited by: [§1](#S1.p1.1) .
- S. Liu, Y. Chen, R. Krishna, et al. (2026) Process-centric analysis of agentic software systems . arXiv preprint arXiv:2512.02393 . Cited by: [§1](#S1.p2.1) , [§3.2](#S3.SS2.p1.1) .
- S. Liu, F. Liu, L. Li, X. Tan, Y. Zhu, X. Lian, and L. Zhang (2025) An empirical study on failures in automated issue solving . External Links: 2509.13941 , [Link](https://arxiv.org/abs/2509.13941) Cited by: [§1](#S1.p2.1) .
- O. Majgaonkar, Z. Fei, X. Li, F. Sarro, and H. Ye (2025) Understanding code agent behaviour: an empirical study of success and failure trajectories . arXiv preprint arXiv:2511.00197 . Cited by: [§1](#S1.p2.1) , [§2](#S2.p1.1) , [§3.4.2](#S3.SS4.SSS2.p2.3) , [§4.2.1](#S4.SS2.SSS1.p1.1) , [§6](#S6.SS0.SSS0.Px2.p1.1) .
- M. Martinez and X. Franch (2025) Dissecting the SWE-bench leaderboards: profiling submitters and architectures of LLM- and agent-based repair systems . arXiv preprint arXiv:2506.17208 . Cited by: [§1](#S1.p1.1) , [§6](#S6.SS0.SSS0.Px3.p1.1) .
- T. Mehtiyev and W. Assunção (2026) Supplementary material uploaded as part of the paper . Note: [https://zenodo.org/records/19351830?preview=1&token=eyJhbGciOiJIUzUxMiJ9.eyJpZCI6IjRhN2QwMzAwLTEwYWItNDJiYS1hMDgxLWVmZmI3MDI1ZjQwNyIsImRhdGEiOnt9LCJyYW5kb20iOiJlMDMyNThjYzQ5ZDc5MjkyNDdjODg2ZGU1YTJjZGUxMCJ9.DfDdG85SXug_ZUp1UbkhJuvzaHxWczC90r8esizwPmdZL-6h9xQ4gqIsFNmyX_S4krpEx0GuVa1TCHfqHjtjKA](https://zenodo.org/records/19351830?preview=1&token=eyJhbGciOiJIUzUxMiJ9.eyJpZCI6IjRhN2QwMzAwLTEwYWItNDJiYS1hMDgxLWVmZmI3MDI1ZjQwNyIsImRhdGEiOnt9LCJyYW5kb20iOiJlMDMyNThjYzQ5ZDc5MjkyNDdjODg2ZGU1YTJjZGUxMCJ9.DfDdG85SXug_ZUp1UbkhJuvzaHxWczC90r8esizwPmdZL-6h9xQ4gqIsFNmyX_S4krpEx0GuVa1TCHfqHjtjKA) External Links: [Document](https://dx.doi.org/10.5281/zenodo.19351830) Cited by: [§3.3](#S3.SS3.p1.1) , [§4.1.2](#S4.SS1.SSS2.p1.3) , [Data Availability](#Sx1.p1.1) , [footnote 1](#footnote1) .
- X. Meng, Z. Ma, P. Gao, and C. Peng (2024) An empirical study on LLM-based agents for automated bug fixing . arXiv preprint arXiv:2411.10213 . Cited by: [§1](#S1.p2.1) .
- OpenAI (2024) Introducing SWE-bench verified . Note: [https://openai.com/index/introducing-swe-bench-verified/](https://openai.com/index/introducing-swe-bench-verified/) 93 human annotators provided difficulty estimates for each of the 500 tasks. Annotation instructions: [https://cdn.openai.com/introducing-swe-bench-verified/swe-b-annotation-instructions.pdf](https://cdn.openai.com/introducing-swe-bench-verified/swe-b-annotation-instructions.pdf) Cited by: [§2](#S2.p3.1) , [§3.1](#S3.SS1.p1.1) , [Table 3](#S4.T3) .
- M. Sclar, Y. Choi, Y. Tsvetkov, and A. Suhr (2024) Quantifying language models’ sensitivity to spurious features in prompt design or: how I learned to start worrying about prompt formatting . In 12th International Conference on Learning Representations (ICLR) , Cited by: [§4.3](#S4.SS3.SSS0.Px3.p1.2) .
- SWE-Bench Pro Team (2025) SWE-bench pro: can AI agents solve long-horizon software engineering tasks? . arXiv preprint arXiv:2509.16941 . Cited by: [§1](#S1.p1.1) , [§1](#S1.p3.1) , [§3.3](#S3.SS3.p1.1) , [§4.1.1](#S4.SS1.SSS1.p2.1) , [§6](#S6.SS0.SSS0.Px1.p1.2) , [§6](#S6.SS0.SSS0.Px3.p1.1) .
- SWE-bench Team (2025) SWE-bench verified leaderboard . Note: [https://www.swebench.com](https://www.swebench.com) Accessed March 2026 Cited by: [§1](#S1.p1.1) , [§2](#S2.p2.1) , [§3.1](#S3.SS1.p1.1) .
- SWE-Compass Team (2025) SWE-compass: towards unified evaluation of agentic coding abilities . arXiv preprint arXiv:2511.05459 . Cited by: [§6](#S6.SS0.SSS0.Px3.p1.1) .
- L. Wang, C. Ma, X. Feng, et al. (2024) A survey on large language model based autonomous agents . Frontiers of Computer Science 18 ( 6 ), pp. 186345 . Cited by: [§2](#S2.p1.1) .
- X. Wang, B. Li, Y. Song, F. F. Xu, X. Tang, M. Zhuge, J. Pan, Y. Song, B. Li, et al. (2025) OpenHands: an open platform for AI software developers as generalist agents . In International Conference on Learning Representations (ICLR) , Cited by: [§1](#S1.p1.1) , [§2](#S2.p1.1) .
- C. Weiss, R. Premraj, T. Zimmermann, and A. Zeller (2007) How long will it take to fix this bug? . In Proceedings of the Fourth International Workshop on Mining Software Repositories (MSR) , External Links: [Document](https://dx.doi.org/10.1109/MSR.2007.13) Cited by: [§3.3](#S3.SS3.p1.1) .
- C. S. Xia et al. (2025) Agentless: demystifying LLM-based software engineering agents . In ACM International Conference on the Foundations of Software Engineering (FSE) , Cited by: [§1](#S1.p1.1) .
- J. Yang, C. E. Jimenez, et al. (2024) SWE-agent: agent-computer interfaces enable automated software engineering . In Advances in Neural Information Processing Systems (NeurIPS) , Cited by: [§1](#S1.p1.1) , [§2](#S2.p1.1) .
- S. Yao, J. Zhao, D. Yu, N. Du, I. Shafran, K. Narasimhan, and Y. Cao (2023) ReAct: synergizing reasoning and acting in language models . In International Conference on Learning Representations (ICLR) , Cited by: [§1](#S1.p2.1) .
- D. Zan et al. (2025) Multi-SWE-bench: a multilingual benchmark for issue resolving . Note: OpenReview, under review Cited by: [§1](#S1.p3.1) , [§3.3](#S3.SS3.p1.1) , [§4.1.1](#S4.SS1.SSS1.p2.1) , [§6](#S6.SS0.SSS0.Px1.p1.2) .
- K. Zhang, W. Yao, Z. Liu, et al. (2024) Diversity empowers intelligence: integrating expertise of software engineering agents . arXiv preprint arXiv:2408.07060 . Cited by: [§6](#S6.SS0.SSS0.Px3.p1.1) .
- Y. Zhang et al. (2024) AutoCodeRover: autonomous program improvement . In ACM SIGSOFT International Symposium on Software Testing and Analysis (ISSTA) , Cited by: [§1](#S1.p1.1) .
- J. Zhuo, S. Zhang, X. Fang, H. Duan, D. Lin, and K. Chen (2024) ProSA: assessing and understanding the prompt sensitivity of LLMs . In Findings of the Association for Computational Linguistics: EMNLP 2024 , pp. 1950–1976 . Cited by: [§4.3](#S4.SS3.SSS0.Px3.p1.2) .
- T. Zimmermann, N. Nagappan, H. Gall, E. Giger, and B. Murphy (2009) Cross-project defect prediction: a large scale experiment on data vs. domain vs. process . In Proceedings of the 7th Joint Meeting of the European Software Engineering Conference and the ACM SIGSOFT Symposium on the Foundations of Software Engineering (ESEC/FSE) , pp. 91–100 . External Links: [Document](https://dx.doi.org/10.1145/1595696.1595713) Cited by: [§3.3](#S3.SS3.p1.1) .


Experimental support, please [view the build logs](./2604.02547v1/__stdout.txt) for errors. Generated by [L A T E xml ![[LOGO]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAsAAAAOCAYAAAD5YeaVAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9wKExQZLWTEaOUAAAAddEVYdENvbW1lbnQAQ3JlYXRlZCB3aXRoIFRoZSBHSU1Q72QlbgAAAdpJREFUKM9tkL+L2nAARz9fPZNCKFapUn8kyI0e4iRHSR1Kb8ng0lJw6FYHFwv2LwhOpcWxTjeUunYqOmqd6hEoRDhtDWdA8ApRYsSUCDHNt5ul13vz4w0vWCgUnnEc975arX6ORqN3VqtVZbfbTQC4uEHANM3jSqXymFI6yWazP2KxWAXAL9zCUa1Wy2tXVxheKA9YNoR8Pt+aTqe4FVVVvz05O6MBhqUIBGk8Hn8HAOVy+T+XLJfLS4ZhTiRJgqIoVBRFIoric47jPnmeB1mW/9rr9ZpSSn3Lsmir1fJZlqWlUonKsvwWwD8ymc/nXwVBeLjf7xEKhdBut9Hr9WgmkyGEkJwsy5eHG5vN5g0AKIoCAEgkEkin0wQAfN9/cXPdheu6P33fBwB4ngcAcByHJpPJl+fn54mD3Gg0NrquXxeLRQAAwzAYj8cwTZPwPH9/sVg8PXweDAauqqr2cDjEer1GJBLBZDJBs9mE4zjwfZ85lAGg2+06hmGgXq+j3+/DsixYlgVN03a9Xu8jgCNCyIegIAgx13Vfd7vdu+FweG8YRkjXdWy329+dTgeSJD3ieZ7RNO0VAXAPwDEAO5VKndi2fWrb9jWl9Esul6PZbDY9Go1OZ7PZ9z/lyuD3OozU2wAAAABJRU5ErkJggg==)
](https://math.nist.gov/~BMiller/LaTeXML/) .


## Instructions for reporting errors

We are continuing to improve HTML versions of papers, and your feedback helps enhance accessibility and mobile support. To report errors in the HTML that will help us improve conversion and rendering, choose any of the methods listed below:

- Click the "Report Issue" ( ) button, located in the page header.

**Tip:** You can select the relevant text first, to include it in your report.

Our team has already identified [the following issues](https://github.com/arXiv/html_feedback/issues) . We appreciate your time reviewing and reporting rendering errors we may not have found yet. Your efforts will help us improve the HTML versions for all readers, because disability should not be a barrier to accessing research. Thank you for your continued support in championing open access for all.

Have a free development cycle? Help support accessibility at arXiv! Our collaborators at LaTeXML maintain a [list of packages that need conversion](https://github.com/brucemiller/LaTeXML/wiki/Porting-LaTeX-packages-for-LaTeXML) , and welcome [developer contributions](https://github.com/brucemiller/LaTeXML/issues) .



BETA
 [!Font Awesome Free v7.1.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2026 Fonticons, Inc.](javascript:toggleReadingMode();)