---
date: '2026-04-15'
source_type: paper
tags:
- type-paper
- arxiv-2601-04748
- topic-skill
- topic-agent
title: When Single-Agent with Skills Replace Multi-Agent Systems and When They Fail
---

# When Single-Agent with Skills Replace Multi-Agent Systems and When They Fail

# When Single-Agent with Skills Replace Multi-Agent Systems and When They Fail

Xiaoxiao Li
 Trusted and Efficient AI (TEA) Lab
 University of British Columbia | Vector Institute | CIFAR AI Chair
 xiaoxiao.li@ece.ubc.ca



###### Abstract

Multi-agent AI systems have proven effective for complex reasoning. These systems are compounded by specialized agents, which collaborate through explicit communication, but incur substantial computational overhead. A natural question arises: *can we achieve similar modularity benefits with a single agent that selects from a library of skills?* We explore this question by viewing skills as internalized agent behaviors. From this perspective, a multi-agent system can be compiled into an equivalent single-agent system, trading inter-agent communication for skill selection. Our preliminary experiments suggest this approach can substantially reduce token usage and latency while maintaining competitive accuracy on reasoning benchmarks. However, this efficiency raises a deeper question that has received little attention: *how does skill selection scale as libraries grow?* Drawing on principles from cognitive science, we propose that LLM skill selection exhibits bounded capacity analogous to human decision-making. We investigate the scaling behavior of skill selection and observe a striking pattern. Rather than degrading gradually, selection accuracy remains stable up to a critical library size, then drops sharply, indicating a phase transition reminiscent of capacity limits in human cognition. Furthermore, we find evidence that semantic confusability among similar skills, rather than library size alone, plays a central role in this degradation. This perspective suggests that hierarchical organization, which has long helped humans manage complex choices, may similarly benefit AI systems. Our initial results with hierarchical routing support this hypothesis. This work opens new questions about the fundamental limits of semantic-based skill selection in LLMs and offers a cognitive-grounded framework and practical guidelines for designing scalable skill-based agents.



![Refer to caption](x1.png)
 *(a) From multi-agent coordination to a single agent with skills.*





![Refer to caption](x2.png)
 *(b) Skill scaling law and its different stages.*

 *Figure 1 : Skill-based agents: efficiency gains and scaling limits. (a) Compiling multi-agent systems into single-agent skill libraries reduces communication overhead, cutting latency and token usage. (b) Skill selection accuracy degrades non-linearly as libraries grow, exhibiting a phase transition at a capacity threshold. As skill libraries grow, the increased size and semantic confusability among skills drive this degradation; hierarchical routing restores reliable selection by organizing skills into structured categories. Visualization modified from Nana Banana.*



> “The capacity of the human mind for formulating and solving complex problems is very small compared with the size of the problems whose solution is required for objectively rational behavior in the real world.”
> — Herbert A. Simon



## 1 Introduction


Large Language Models (LLMs) are increasingly deployed as general-purpose problem solvers that rely on modular decomposition to handle complex tasks. Recent progress has shown that multi-agent systems (MAS), where specialized agents collaborate via explicit communication, can substantially improve reasoning performance on challenging benchmarks [(Xia et al. , [2025](https://arxiv.org/html/2601.04748v1#bib.bib31) ; Wu et al. , [2025](https://arxiv.org/html/2601.04748v1#bib.bib32) , [2024](https://arxiv.org/html/2601.04748v1#bib.bib36) ; Chen et al. , [2024](https://arxiv.org/html/2601.04748v1#bib.bib39) ; Guo et al. , [2024](https://arxiv.org/html/2601.04748v1#bib.bib45) )] . However, these systems incur significant computational overhead due to repeated context exchange, multi-round coordination, and verbose natural language interactions [(Chen et al. , [2025](https://arxiv.org/html/2601.04748v1#bib.bib35) ; Yang et al. , [2025](https://arxiv.org/html/2601.04748v1#bib.bib34) ; Yue et al. , [2025](https://arxiv.org/html/2601.04748v1#bib.bib33) )] . A natural question arises: can we retain the benefits of modular reasoning while reducing the cost of explicit multi-agent coordination?



One promising direction is to replace distributed agent coordination with tool use —equipping a single LLM with external APIs that it can invoke as needed [(Schick et al. , [2023](https://arxiv.org/html/2601.04748v1#bib.bib22) ; Qin et al. , [2024b](https://arxiv.org/html/2601.04748v1#bib.bib24) ; Patil et al. , [2024](https://arxiv.org/html/2601.04748v1#bib.bib25) )] . While effective for atomic operations (calculators, search engines, code interpreters), tools typically lack the rich behavioral specifications needed for complex reasoning subtasks. In this work, we investigate skills (recently introduced by Anthropic [(Anthropic, [2025a](https://arxiv.org/html/2601.04748v1#bib.bib1) , [b](https://arxiv.org/html/2601.04748v1#bib.bib2) )] ) as a middle ground: a skill is a *schema-bounded operation* characterized by a semantic descriptor, a well-defined input-output signature, and an execution policy that specifies *how* to perform the operation. Unlike tools, which are automatically triggered, skills are chosen based on the meaning and content of user requests, thus encapsulating not just *what* to do but *how* to reason, making them suitable for internalizing the specialized roles that would otherwise require separate agents.



Skills offer a compelling alternative to multi-agent coordination. Where an MAS instantiates specialized reasoning as *distributed roles* communicating through natural language, a single-agent system with skills (SAS) internalizes these roles as *selectable actions* within a unified context. This perspective suggests a compilation view: a MAS can be transformed into an equivalent SAS by encoding each agent’s behavior as a skill, eliminating inter-agent communication overhead while preserving functional capability.



We first demonstrate that this compilation is both *faithful* and *efficient* . On representative reasoning benchmarks (GSM8K [(Cobbe et al. , [2021](https://arxiv.org/html/2601.04748v1#bib.bib3) )] , HumanEval [(Chen et al. , [2021](https://arxiv.org/html/2601.04748v1#bib.bib4) )] , HotpotQA [(Yang et al. , [2018](https://arxiv.org/html/2601.04748v1#bib.bib5) )] ), skill-based single-agent systems achieve similar accuracy of their multi-agent counterparts while reducing token consumption by 54% and latency by 50% on average. These results establish skills as a practical alternative to explicit agent decomposition (at least when skill libraries remain small).



However, expanding the skill repertoire introduces a fundamental challenge. As the number of available skills grows, the model must select the appropriate action from an increasingly large and semantically overlapping set. This raises a question that has received little systematic attention:



> *How does the size of the skill library affect an LLM’s ability to select the correct skill?*



To answer this question, we study the scaling behavior of skill selection in LLMs. Drawing on principles from cognitive science, we hypothesize that skill selection exhibits capacity-limited scaling analogous to human decision-making. Our experiments confirm this hypothesis. Across controlled skill libraries ranging from 5 to 200 skills, we find that selection accuracy degrades *non-linearly* , following a phase transition pattern: accuracy remains high when library size is below a critical threshold, then drops sharply beyond this capacity. This degradation is also driven by *semantic confusability* among skills, rather than by library size alone. This finding connects LLM behavior to similarity-based interference in human memory retrieval [(Shepard, [1987](https://arxiv.org/html/2601.04748v1#bib.bib12) ; Anderson, [1974](https://arxiv.org/html/2601.04748v1#bib.bib13) )] . We further show that *hierarchical routing* : decomposing skill selection into coarse-to-fine decisions can effectively mitigate this degradation when flat selection fails when skill set scales up. This mirrors findings from cognitive science on chunking [(Chase and Simon, [1973](https://arxiv.org/html/2601.04748v1#bib.bib17) )] and menu design [(Miller, [1981](https://arxiv.org/html/2601.04748v1#bib.bib19) )] .



##### Contributions.


This work makes three contributions:

1. 1.

We demonstrate that skill-based systems can approximate multi-agent performance with significantly lower token usage and latency and formalize the compilation process.
2. 2.

We characterize the non-linear scaling limits of skill selection, identifying a capacity threshold and establishing that semantic confusability, not library size alone, drives degradation.
3. 3.

We show that hierarchical routing mitigates scaling limits, providing cognitive-grounded design principles for scalable skill-based agents.



Our findings bridge agent skills, multi-agent systems, tool use, and cognitive science, offering both theoretical insights into LLM action selection and practical guidelines for building efficient, scalable agent systems.



## 2 Problem Formulation: Multi-Agent Systems to Single-Agent with Skills


To answer the question when “When Single-Agent with Skills Replace Multi-Agent Systems” , we formalize the relationship between Multi-Agent Systems (MAS) and Single-Agent with Skills (SAS), establishing the theoretical foundation for studying skill selection scaling. We try to use the simple definition as possible to keep only the notations related to our analysis.



### 2.1 Multi-Agent Systems


###### Definition 2.1 (Agent) .


An agent is a tuple a = ( ρ , ϕ ) a=(\rho,\phi) , where:

- •

Role description ( ρ \rho ): a semantic specification of the agent’s identity and expertise;
- •

Behavioral policy ( ϕ \phi ): instructions governing the agent’s reasoning and response generation.



###### Definition 2.2 (Multi-Agent System) .


A multi-agent system is a tuple ℳ = ⟨ 𝒜 , 𝒢 , Π ⟩ \mathcal{M}=\langle\mathcal{A},\mathcal{G},\Pi\rangle , where:

- •

𝒜 = { a 1 , … , a n } \mathcal{A}=\{a_{1},\ldots,a_{n}\} is a set of agents;
- •

𝒢 = ( 𝒜 , E ) \mathcal{G}=(\mathcal{A},E) is a communication graph specifying permissible mechannels;
- •

Π = ( Init , Route , Term ) \Pi=(\textsc{Init},\textsc{Route},\textsc{Term}) is a coordination protocol.


*Algorithm 1 Multi-Agent System Execution*


0: Task x x , Agent set 𝒜 \mathcal{A} , Communication graph 𝒢 \mathcal{G} , Protocol Π \Pi

1: Initialize history h ← x h\leftarrow x

2: Select initial agent a ( 0 ) ← Π . Init ​ ( 𝒜 , x ) a^{(0)}\leftarrow\Pi.\textsc{Init}(\mathcal{A},x)

3: t ← 0 t\leftarrow 0

4: while not Π . Term ​ ( h ) \Pi.\textsc{Term}(h) do

5: y ( t ) ← a ( t ) . Execute ​ ( h ) y^{(t)}\leftarrow a^{(t)}.\textsc{Execute}(h) {Agent generates response}

6: h ← h ⊕ y ( t ) h\leftarrow h\oplus y^{(t)} {Append to history}

7: a ( t + 1 ) ← Π . Route ​ ( h , a ( t ) , 𝒢 ) a^{(t+1)}\leftarrow\Pi.\textsc{Route}(h,a^{(t)},\mathcal{G}) {Route to next agent}

8: t ← t + 1 t\leftarrow t+1

9: end while

10: return h h



The coordination cost of solving task x x over T T rounds is:


|  | C mas ​ ( x ) = ∑ t = 1 T | y ( t ) | + T ⋅ c sync , C_{\textsc{mas}}(x)=\sum_{t=1}^{T}|y^{(t)}|+T\cdot c_{\text{sync}}, |  | (1) |
|---|---|---|---|


where | y ( t ) | |y^{(t)}| denotes messagelength and c sync c_{\text{sync}} captures synchronization overhead per round.



### 2.2 Single-Agent with Skills (SAS)


We now define an alternative paradigm that internalizes multi-agent capabilities within a single model.



###### Definition 2.3 (Skill) .


A skill is a tuple s = ( δ , π , ξ ) s=(\delta,\pi,\xi) , where:

- •

Skill descriptor ( δ \delta ): a semantic description used for skill selection;
- •

Execution policy ( π \pi ): instructions specifying how to perform the skill;
- •

Execution backend ( ξ ∈ 𝒯 ∪ { ∅ } \xi\in\mathcal{T}\cup\{\emptyset\} :) an external tool t ∈ 𝒯 t\in\mathcal{T} , or ∅ \emptyset for internal execution (e.g., a prompt template).



This formulation admits a spectrum of implementations:

- •

Internalized skills ( ξ = ∅ \xi=\emptyset ): Execution occurs entirely within the model’s reasoning process via prompt-based invocation.
- •

Externalized skills ( ξ = t \xi=t ): The model generates parameters for tool t t , and execution is delegated externally.



###### Remark 2.1 (Separation of Selection and Execution) .


The decomposition into ( δ , π , ξ ) (\delta,\pi,\xi) reflects a key insight: skill selection depends primarily on the intent signature δ \delta , while skill execution is governed by π \pi and ξ \xi . This separation allows us to isolate selection complexity from execution variability, which is a distinction critical to our scaling analysis.



###### Definition 2.4 (Single-Agent with Skills) .


A Single-Agent with Skills (SAS) is a tuple 𝒮 = ⟨ a , 𝐒 , σ ⟩ \mathcal{S}=\langle a,\mathbf{S},\sigma\rangle , where:

- •

a a is a base language model;
- •

𝐒 = { s 1 , … , s k } \mathbf{S}=\{s_{1},\ldots,s_{k}\} is a skill library;
- •

σ : ℋ × 𝐃 → 𝐒 \sigma:\mathcal{H}\times\mathbf{D}\rightarrow\mathbf{S} is a skill selector mapping context and skill descriptors 𝐃 = { δ 1 , … , δ k } \mathbf{D}=\{\delta_{1},\ldots,\delta_{k}\} to a skill.



Note that the selector σ \sigma operates over skill operations 𝐃 \mathbf{D} , not full skill specifications. This reflects the realistic constraint that selection decisions are based on semantic descriptors rather than complete procedural knowledge.


*Algorithm 2 Single-Agent with Skills Execution*


0: Task x x , Skill library 𝐒 \mathbf{S} , Selector σ \sigma

1: Initialize history h ← x h\leftarrow x

2: t ← 0 t\leftarrow 0

3: while not Term ​ ( h ) \textsc{Term}(h) do

4: s ( t ) ← σ ​ ( h , 𝐃 ) s^{(t)}\leftarrow\sigma(h,\mathbf{D}) {Select skill based on descriptors}

5: y ( t ) ← Execute ​ ( s ( t ) , h ) y^{(t)}\leftarrow\textsc{Execute}(s^{(t)},h) {Execute selected skill}

6: h ← h ⊕ y ( t ) h\leftarrow h\oplus y^{(t)}

7: t ← t + 1 t\leftarrow t+1

8: end while

9: return h h



The cost of single-agent using skills over T T round is:


|  | C SAS ​ ( x ) = ∑ t = 1 T ′ ( C select ​ ( σ , 𝐒 ) + C exec ​ ( s ( t ) ) ) . C_{\textsc{SAS}}(x)=\sum_{t=1}^{T^{\prime}}\Big(C_{\text{select}}(\sigma,\mathbf{S})+C_{\text{exec}}(s^{(t)})\Big). |  | (2) |
|---|---|---|---|



###### Remark 2.2 .


Comparing Algorithms [1](https://arxiv.org/html/2601.04748v1#alg1) and [2](https://arxiv.org/html/2601.04748v1#alg2) , the key structural difference is clear: multi-agent systems route between agents (Line 7 in Alg. [1](https://arxiv.org/html/2601.04748v1#alg1) ), while skillful single agents select among skills (Line 4 in Alg. [2](https://arxiv.org/html/2601.04748v1#alg2) ). Compilation transforms the former into the latter.



### 2.3 The Compilation Problem


We now formalize the transformation from MAS to SAS.



###### Definition 2.5 (Compilation) .


A compilation is a mapping Φ : ℳ → 𝒮 \Phi:\mathcal{M}\rightarrow\mathcal{S} that transforms a multi-agent system into a skillful single agent. Given ℳ = ⟨ 𝒜 , 𝒢 , Π ⟩ \mathcal{M}=\langle\mathcal{A},\mathcal{G},\Pi\rangle , the compilation produces 𝒮 = ⟨ a , 𝐒 Φ , σ Φ ⟩ \mathcal{S}=\langle a,\mathbf{S}_{\Phi},\sigma_{\Phi}\rangle , where each agent’s specialized function is distilled into one or more skills.



We formulate the transition from MAS to SAS as a Capability Compilation process. Our compiler Φ \Phi must disentangle the high-level reasoning capabilities embedded in an agent’s persona from its execution mechanism. We define the compilation function Φ : 𝒢 MAS → 𝐒 \Phi:\mathcal{G}_{\text{MAS}}\rightarrow\mathbf{S} as a composite of three distinct operations: Decomposition, Backend Assignment, and Topology Internalization. The MAS-to-SAS compliation algorithm is presented in Algorithm [3](https://arxiv.org/html/2601.04748v1#alg3) in the Appendix.



#### 2.3.1 Phase 1: Capability Decomposition


For each agent a i ∈ 𝒜 a_{i}\in\mathcal{A} defined by its system prompt ρ i \rho_{i} , we first apply a decomposition function f decomp f_{\text{decomp}} to extract a set of discrete atomic capabilities 𝒦 i \mathcal{K}_{i} :


|  | 𝒦 i = f decomp ​ ( ρ i ) = { κ i , 1 , κ i , 2 , … } \mathcal{K}_{i}=f_{\text{decomp}}(\rho_{i})=\{\kappa_{i,1},\kappa_{i,2},\dots\} |  | (3) |
|---|---|---|---|


Here, a capability κ \kappa represents a specific functional unit (e.g., “perform code review” or “fetch weather data”) derived from the agent’s role description, independent of how it is implemented.



#### 2.3.2 Phase 2: Backend Assignment


For each extracted capability κ \kappa , the compiler must determine its execution backend ξ \xi . Corresponding to internalized skills and externalized skills defined in Sec [2.2](https://arxiv.org/html/2601.04748v1#S2.SS2) . we define the assignment function f backend f_{\text{backend}} :



|  | s = ( δ , π , ξ ) where ξ = { t ∈ 𝒯 if ​ κ ​ requires external grounding (Externalized) ∅ if ​ κ ​ is purely cognitive (Internalized) s=(\delta,\pi,\xi)\quad\text{where}\quad\xi=\begin{cases}t\in\mathcal{T}&\text{if }\kappa\text{ requires external grounding (Externalized)}\\
\emptyset&\text{if }\kappa\text{ is purely cognitive (Internalized)}\end{cases} |  | (4) |
|---|---|---|---|


Here, the skill descriptor δ \delta is generated to semanticize κ \kappa for retrieval (e.g., Skill Name).



#### 2.3.3 Phase 3: Topology Internalization


The topology internalization operator transforms the explicit communication edges in 𝒢 MAS \mathcal{G}_{\text{MAS}} into implicit input/output constraints within the skill definitions. Let 𝒩 out ​ ( a i ) = { a j ∣ ( a i , a j ) ∈ E } \mathcal{N}_{\text{out}}(a_{i})=\{a_{j}\mid(a_{i},a_{j})\in E\} be the set of downstream dependencies for agent a i a_{i} .



We define the constraint injection function f inject f_{\text{inject}} :


|  | π k final = f inject ​ ( π k base , 𝒩 out ​ ( a i ) ) \pi_{k}^{\text{final}}=f_{\text{inject}}(\pi_{k}^{\text{base}},\mathcal{N}_{\text{out}}(a_{i})) |  | (5) |
|---|---|---|---|



Mathematically, this can be modeled as appending a constraint set 𝒞 \mathcal{C} to the natural language policy:


|  | π k final ← π k base ⊕ ( ⋃ a j ∈ 𝒩 out ​ ( a i ) Handover ​ ( a i → a j ) ) \pi_{k}^{\text{final}}\leftarrow\pi_{k}^{\text{base}}\oplus\left(\bigcup_{a_{j}\in\mathcal{N}_{\text{out}}(a_{i})}\text{Handover}(a_{i}\to a_{j})\right) |  | (6) |
|---|---|---|---|



where ⊕ \oplus denotes string concatenation or semantic fusion, and Handover ​ ( ⋅ ) \text{Handover}(\cdot) generates instructions ensuring the output format of tool t k t_{k} is compatible with the expected input of tools in agent a j a_{j} .



#### 2.3.4 Optimization Objective


The goal of the compilation is to produce a skill library 𝐒 \mathbf{S} that minimizes the Cognitive Load ℒ ​ ( 𝐒 ) \mathcal{L}(\mathbf{S}) while maintaining functional equivalence to the original MAS:


|  | min Φ ⁡ ℒ ​ ( Φ ​ ( 𝒢 MAS ) ) s.t. Perf ​ ( SAS ) ≈ Perf ​ ( MAS ) \min_{\Phi}\mathcal{L}(\Phi(\mathcal{G}_{\text{MAS}}))\quad\text{s.t.}\quad\text{Perf}(\text{SAS})\approx\text{Perf}(\text{MAS}) |  | (7) |
|---|---|---|---|


where ℒ \mathcal{L} accounts for both the retrieval complexity (selection noise) and the context consumption of the generated skills.



The final Single-Agent System is thus equipped with the compiled skill set:


|  | 𝐒 = ⋃ a i ∈ 𝒜 ⋃ t k ∈ τ i { ( t k , π k final ) } \mathbf{S}=\bigcup_{a_{i}\in\mathcal{A}}\bigcup_{t_{k}\in\tau_{i}}\left\{(t_{k},\pi_{k}^{\text{final}})\right\} |  | (8) |
|---|---|---|---|



### 2.4 Properties of MAS-to-SAS Compilation


###### Definition 2.6 (Behavioral Fidelity) .


A compilation Φ \Phi is behaviorally faithful if the output distributions are preserved:


|  | ∀ τ ∈ 𝒯 : P ℳ ( y ∣ τ ) = P Φ ​ ( ℳ ) ( y ∣ τ ) . \forall\tau\in\mathcal{T}:\quad P_{\mathcal{M}}(y\mid\tau)=P_{\Phi(\mathcal{M})}(y\mid\tau). |  |
|---|---|---|



###### Definition 2.7 (Cost Efficiency) .


A compilation Φ \Phi is cost-efficient if there exists a non-trivial subset 𝒯 ′ ⊆ 𝒯 \mathcal{T}^{\prime}\subseteq\mathcal{T} such that:


|  | ∀ τ ∈ 𝒯 ′ : C SAS ( τ ) < C mas ( τ ) . \forall\tau\in\mathcal{T}^{\prime}:\quad C_{\textsc{SAS}}(\tau)<C_{\textsc{mas}}(\tau). |  |
|---|---|---|



The central trade-off is clear: compilation eliminates inter-agent communication but introduces a selection bottleneck. Formally, the efficiency condition reduces to:


|  | ∑ t C select ​ ( σ , | 𝐒 | ) ⏟ selection overhead < ∑ t C comm ​ ( 𝒢 , Π ) ⏟ communication overhead . \underbrace{\sum_{t}C_{\text{select}}(\sigma,|\mathbf{S}|)}_{\text{selection overhead}}<\underbrace{\sum_{t}C_{\text{comm}}(\mathcal{G},\Pi)}_{\text{communication overhead}}. |  | (9) |
|---|---|---|---|



## 3 Experiments on MAS-to-SAS Compilation


First, we identify the compilable and uncompilable MAS. Then, we present results on the feasibility of compiling MAS to SAS, achieving similar performance at lower cost.



### 3.1 Conditions for Compilability


Not all multi-agent systems can be faithfully compiled into a single skillful agent. We characterize the boundary.



###### Definition 3.1 (Compilability) .


A multi-agent system ℳ \mathcal{M} is compilable if there exists a compilation Φ : ℳ → 𝒮 \Phi:\mathcal{M}\rightarrow\mathcal{S} satisfying:


|  | ∀ x ∈ 𝒳 : P ℳ ( y ∣ x ) = P Φ ​ ( ℳ ) ( y ∣ x ) . \forall x\in\mathcal{X}:\quad P_{\mathcal{M}}(y\mid x)=P_{\Phi(\mathcal{M})}(y\mid x). |  |
|---|---|---|



###### Proposition 3.1 (Compilability Conditions) .


A multi-agent system is compilable if and only if:

1. C1 .

Serializable Communication : 𝒢 \mathcal{G} admits a topological ordering—agent interactions can be sequenced without information loss.
2. C2 .

Shared History : Agent outputs depend only on shared history h h , with no private state.
3. C3 .

Homogeneous Backbone : All agents use the same underlying model.

Conversely, compilation fails when agents require true parallelism (independent sampling), private information, adversarial objectives, or heterogeneous capabilities.



Table [1](https://arxiv.org/html/2601.04748v1#S3.T1) summarizes common multi-agent architectures and their compilability.


*Table 1 : Compilability of common multi-agent architectures.*


| Architecture | Structure | Compilable |
|---|---|---|
| Pipeline | a 1 → a 2 → ⋯ → a n a_{1}\rightarrow a_{2}\rightarrow\cdots\rightarrow a_{n} | ✓ |
| Router-Workers | Router → \rightarrow {Workers} → \rightarrow Aggregator | ✓ |
| Iterative Refinement | Writer ↔ \leftrightarrow Critic (loop) | ✓ |
| Debate / Adversarial | Proponent ↔ \leftrightarrow Opponent | ✗ |
| Parallel Sampling | Independent agents, best-of- n n | ✗ |
| Private Information | Agents with hidden state | ✗ |



###### Remark 3.1 (Scope) .


This work focuses on compilable systems. We study when compilation is efficient —a question orthogonal to when it is possible .



### 3.2 Compilation Efficiency Experiments


Having established conditions under which multi-agent systems can be compiled into skillful single agents (Proposition [3.1](https://arxiv.org/html/2601.04748v1#S3.Thmtheorem1) ), we now empirically investigate whether such compilation is *efficient* , i.e., whether the compiled SAS achieves comparable performance while reducing computational cost.



#### 3.2.1 Experimental Setup


In both internalized and externalized skill cases, the selection of which skill to invoke remains an internal cognitive decision. In this studying, we focus on purely internalized skills to isolate the cognitive cost of action selection from external execution noise. We evaluate compilation efficiency on three benchmarks, each matched to a compilable MAS architecture, including GSM8K [(Cobbe et al. , [2021](https://arxiv.org/html/2601.04748v1#bib.bib3) )] — grad school math with problems, HumanEval [(Chen et al. , [2021](https://arxiv.org/html/2601.04748v1#bib.bib4) )] — a python code generation task, and HotpotQA [(Yang et al. , [2018](https://arxiv.org/html/2601.04748v1#bib.bib5) )] — multi-hop question answering. Their corresponding MAS architectures, workflows and their mapping are summarized in Table [2](https://arxiv.org/html/2601.04748v1#S3.T2) . The compiled SAS performs the equivalent computation in a single API call , with the model internally managing skill invocation through structured output sections (e.g., [DECOMPOSE] , [SOLVE] , [VERIFY] ).



We evaluate using GPT-4o-mini as the backbone model for all agents and the compiled SAS, ensuring a fair comparison under the homogeneous backbone condition (C3). We measure: Task Accuracy as correctness of final output (exact match for GSM8K/HotpotQA, syntax validity for HumanEval); Total Tokens as the sum of prompt and completion tokens across all API calls; Latency as the wall-clock time from task input to final output; and API Calls as the number of separate LLM invocations.


*Table 2 : Benchmark tasks, MAS architectures, and agent-to-skill mappings for compilation experiments. Each MAS is compiled into an equivalent SAS that performs the same computation in a single LLM call.*


| Benchmark | Architecture | MAS Agent | SAS Skill | Description | Calls |
|---|---|---|---|---|---|
| GSM8K | Pipeline | Decomposer | decompose | Break problem into steps | 3 → 1 3\to 1 |
| Solver | solve | Execute calculations |
| Verifier | verify | Validate solution |
| HumanEval | Iterative | Coder | code | Generate implementation | 3 → 1 3\to 1 |
| Critic | critique | Review for bugs |
| Refiner | refine | Fix identified issues |
| HotpotQA | Router-Workers | Router | analyze | Plan information needs | 4 → 1 4\to 1 |
| Retriever | retrieve | Extract relevant facts |
| Reasoner | reason | Chain logical steps |
| Aggregator | synthesize | Produce final answer |



#### 3.2.2 Results

*Table 3 : Performance and efficiency comparison between MAS and SAS after compilation. Token and latency reductions are computed as ( MAS − SAS ) / MAS × 100 % (\text{MAS}-\text{SAS})/\text{MAS}\times 100\% . Positive values indicate SAS is more efficient.*


| Task | Accuracy (%) | Avg. Tokens | Avg. Latency (ms) | Acc. Δ \Delta | Token ↓ \downarrow | Latency ↓ \downarrow | API Calls |
|---|---|---|---|---|---|---|---|
| MAS | SAS | MAS | SAS | MAS | SAS |
| GSM8K | 94.0 | 92.0 | 1407 | 616 | 10565 | 7537 | − 2.0 % -2.0\% | 56.2 % 56.2\% | 28.7 % 28.7\% | 3 → 1 3\rightarrow 1 |
| HumanEval | 100.0 | 100.0 | 1400 | 749 | 7227 | 2970 | 0.0 % 0.0\% | 46.5 % 46.5\% | 58.9 % 58.9\% | 3 → 1 3\rightarrow 1 |
| HotpotQA | 84.0 | 88.0 | 4359 | 1816 | 11671 | 4559 | + 4.0 % +4.0\% | 58.4 % 58.4\% | 60.9 % 60.9\% | 4 → 1 4\rightarrow 1 |
| Average | – | – | – | – | – | – | + 0.7 % \mathbf{+0.7\%} | 53.7 % \mathbf{53.7\%} | 49.5 % \mathbf{49.5\%} | – |



Table [3](https://arxiv.org/html/2601.04748v1#S3.T3) presents the main results comparing MAS and compiled SAS across all benchmarks.



Faithful Compilation. The compiled SAS achieves accuracy within − 2.0 % -2.0\% to + 4.0 % +4.0\% of the original MAS across all benchmarks, with an average improvement of + 0.7 % +0.7\% . This confirms that compilation is *faithful* in practice—the SAS preserves (and occasionally improves upon) MAS performance. Notably, on HotpotQA, the SAS outperforms the MAS by 4.0 % 4.0\% , likely because the unified context enables better information integration across the retrieval and reasoning steps.



Token Efficiency. Compilation reduces token consumption by 53.7% on average, with the largest savings on HotpotQA ( 58.4 % 58.4\% ) and GSM8K ( 56.2 % 56.2\% ). This reduction stems from eliminating redundant context repetition across agent calls—the SAS shares a single context window rather than re-encoding the task description, intermediate results, and instructions for each specialized agent. The effect is most pronounced for HotpotQA, where the multi-hop reasoning pipeline originally required passing retrieved passages between agents multiple times.



Latency Reduction. End-to-end latency decreases by 49.5% on average, with the most dramatic improvement on HotpotQA ( 60.9 % 60.9\% ) and HumanEval ( 58.9 % 58.9\% ). The primary factor is the reduction from 3–4 sequential API calls to a single call, eliminating inter-agent communication overhead and network round-trip delays. GSM8K shows a smaller latency reduction ( 28.7 % 28.7\% ) despite significant token savings, suggesting that the mathematical reasoning computation itself (rather than communication) dominates latency for this task.



API Call Reduction. API calls reduce from 3–4 calls (MAS) to exactly 1 call (SAS). This has direct cost implications, as API pricing typically includes per-call overhead beyond token costs. For HotpotQA, the reduction from 4 calls to 1 represents a 75 % 75\% decrease in per-request API overhead.



These results demonstrate that MAS-to-SAS compilation has the potential benefits of modular multi-agent architectures (reusable components) combined with the *runtime* efficiency of monolithic single-agent execution. Practitioners can develop and debug agent pipelines using intuitive multi-agent abstractions, then compile to SAS for production deployment without sacrificing accuracy.



The success of compilation rests on three factors: First, agent behaviors are successfully encoded as skills through descriptive prompts. The model can follow structured skill invocation patterns (e.g., “First decompose, then solve, finally verify”). Second, the sequential structure of agent interactions (C1) maps naturally to a single autoregressive generation. The model maintains coherent state across “skill invocations” within its context window. Third, there is no information loss under shared history (C2), as all information available to MAS agents is equally available to the SAS. No private state is lost in compilation.



In this version, we have not explored in depth when complications fail to help, even under Proposition [3.1](https://arxiv.org/html/2601.04748v1#S3.Thmtheorem1) . But we observe that compilation provides smaller benefits when tasks require very long outputs that approach context limits.



## 4 The Skill Scaling Hypothesis: A Cognitive Science Perspective


The preceding results establish that MAS → \to SAS compilation is both *possible* and *efficient* for compilable architectures. However, this raises a critical follow-up question: how does the compiled SAS scale as the skill library grows?



Equation ( [9](https://arxiv.org/html/2601.04748v1#S2.E9) ) reveals a critical dependency: the viability of compilation hinges on how selection cost scales with the skill library size | 𝐒 | |\mathbf{S}| . In the experiments above, each SAS operates with 3–4 skills—well below problematic thresholds. When compiling larger multi-agent systems (e.g., with 10+ specialized agents), the resulting skill library may trigger degradation in selection accuracy. This motivates our investigation into the *cognitive scaling* of skill selection.



### 4.1 Cognitive Foundations


Our scaling hypothesis draws on established principles from cognitive psychology and decision science. Three foundational theories are particularly relevant:



##### F1: Hick’s Law and Decision Complexity.


Hick’s Law [(Hick, [1952](https://arxiv.org/html/2601.04748v1#bib.bib6) ; Hyman, [1953](https://arxiv.org/html/2601.04748v1#bib.bib7) )] establishes that human choice reaction time scales logarithmically with the number of alternatives: RT = a + b ⋅ log 2 ⁡ ( n + 1 ) \text{RT}=a+b\cdot\log_{2}(n+1) , where n n is the number of equally probable options. This reflects a binary subdivision process in decision-making. Critically, [Longstreth ( [1988](https://arxiv.org/html/2601.04748v1#bib.bib21) )] demonstrated that this relationship breaks down beyond approximately 8 choices ( ∼ \sim 3 bits), becoming curvilinear as the subdivision strategy fails. We hypothesize that LLM skill selection exhibits analogous capacity-limited behavior, with accuracy (rather than reaction time) as the dependent measure.



##### F2: Cognitive Load Theory (Working Memory Capacity Limits).


Miller’s seminal “magical number seven” [(Miller, [1956](https://arxiv.org/html/2601.04748v1#bib.bib8) )] identified fundamental limits on immediate memory span. [Sweller ( [1988](https://arxiv.org/html/2601.04748v1#bib.bib10) )] ’s and [Sweller et al. ( [2011](https://arxiv.org/html/2601.04748v1#bib.bib11) )] ’s Cognitive Load Theory extend this to complex tasks, distinguishing *intrinsic load* (inherent task complexity) from *extraneous load* (unnecessary processing demands). When total cognitive load exceeds working memory capacity, performance degrades sharply—a threshold effect rather than gradual decline. We interpret the skill library size | 𝐒 | |\mathbf{S}| as imposing intrinsic load on the selection process, with a capacity threshold κ \kappa analogous to working memory limits.



##### F3: Similarity-Based Interference.


Shepard’s Universal Law of Generalization [(Shepard, [1987](https://arxiv.org/html/2601.04748v1#bib.bib12) )] establishes that confusion probability decays exponentially with psychological distance: g ​ ( d ) = e − d / λ g(d)=e^{-d/\lambda} . Anderson’s ACT-R model [(Anderson, [1974](https://arxiv.org/html/2601.04748v1#bib.bib13) , [1983](https://arxiv.org/html/2601.04748v1#bib.bib14) ; Anderson and Reder, [1999](https://arxiv.org/html/2601.04748v1#bib.bib15) )] provides a mechanistic account through the *fan effect* : as more facts share a cue, associative strength to each fact decreases, so each receives less activation, leading to slower retrieval and, in some tasks, reduced accuracy. The Generalized Context Model [(Nosofsky, [1986](https://arxiv.org/html/2601.04748v1#bib.bib16) )] formalizes how classification errors increase with both option count and inter-option similarity. These theories predict that semantically similar skills will interfere during selection, independent of total library size.



##### F4: Hierarchical Processing and Chunking.


Chase & Simon’s chunking theory [(Chase and Simon, [1973](https://arxiv.org/html/2601.04748v1#bib.bib17) )] demonstrates that experts manage complexity through hierarchical organization—chess masters perceive board positions as ∼ \sim 7 chunks rather than 32 pieces. Menu design research [(Miller, [1981](https://arxiv.org/html/2601.04748v1#bib.bib19) ; Lee and MacGregor, [1985](https://arxiv.org/html/2601.04748v1#bib.bib20) )] finds optimal breadth of 4–8 items per level, matching working memory capacity. Tversky’s Elimination-by-Aspects model [(Tversky, [1972](https://arxiv.org/html/2601.04748v1#bib.bib18) )] formalizes how stepwise narrowing of options can make large choice sets more manageable.



### 4.2 Problem Formulation


###### Problem 4.1 (Cognitive Scaling of Skill Selection) .


Let σ \sigma be a skill selector operating on a library 𝐒 = { s 1 , … , s N } \mathbf{S}=\{s_{1},\dots,s_{N}\} , where each skill s i = ( δ i , π i , ξ i ) s_{i}=(\delta_{i},\pi_{i},\xi_{i}) comprises a semantic descriptor δ \delta , an execution policy π \pi , and an execution backend ξ \xi . Define the selection accuracy for a task distribution 𝒯 \mathcal{T} as:


|  | Acc ​ ( σ , 𝐒 ) = 𝔼 τ ∼ 𝒯 ​ [ 𝟏 ​ [ σ ​ ( τ , { δ k } k = 1 N ) = s τ ∗ ] ] , \textsc{Acc}(\sigma,\mathbf{S})=\mathbb{E}_{\tau\sim\mathcal{T}}\left[\mathbf{1}\left[\sigma(\tau,\{\delta_{k}\}_{k=1}^{N})=s^{*}_{\tau}\right]\right], |  |
|---|---|---|


where s τ ∗ s^{*}_{\tau} is the optimal skill. The scaling problem investigates the degradation of Acc as | 𝐒 | → ∞ |\mathbf{S}|\to\infty , aiming to decouple the cost of search space expansion from semantic interference.



##### Why Study Selection Accuracy?


One might ask why we focus on skill selection accuracy rather than end-task performance. Task accuracy conflates multiple failure sources: action selection, execution fidelity, and external noise. Changes in selection reliability can be masked at the task level, particularly in error-tolerant settings. In contrast, selection accuracy isolates the intrinsic difficulty of choosing the correct skill from an expanding library. This upstream decision directly governs whether downstream execution is even invoked correctly. While task accuracy answers *whether* a system works, selection accuracy reveals *why* it works—and *when* it will fail.



### 4.3 The Scaling Law


Drawing on the cognitive foundations above, we hypothesize that selection accuracy follows a composite decay law governed by two factors: (1) an effective capacity threshold κ \kappa , analogous to working memory limits, and (2) semantic interference ℐ ​ ( 𝐒 ) \mathcal{I}(\mathbf{S}) among skills:


|  | Acc ​ ( σ , 𝐒 ) ≈ α 1 + ( | 𝐒 | / κ ) γ − ϵ ⋅ ℐ ​ ( 𝐒 ) , \textsc{Acc}(\sigma,\mathbf{S})\approx\frac{\alpha}{1+(|\mathbf{S}|/\kappa)^{\gamma}}-\epsilon\cdot\mathcal{I}(\mathbf{S}), |  | (10) |
|---|---|---|---|


where α ≤ 1 \alpha\leq 1 is asymptotic accuracy at small | 𝐒 | |\mathbf{S}| , κ \kappa is the capacity threshold, γ > 1 \gamma>1 controls the sharpness of the phase transition, and ϵ > 0 \epsilon>0 represents sensitivity to semantic interference.



This formulation has a clear cognitive interpretation:

- •

The first term captures Hick’s Law–style capacity limits. When | 𝐒 | ≪ κ |\mathbf{S}|\ll\kappa , accuracy remains near α \alpha ; when | 𝐒 | ≫ κ |\mathbf{S}|\gg\kappa , accuracy decays as O ​ ( | 𝐒 | − γ ) O(|\mathbf{S}|^{-\gamma}) . In our model, the exponent γ > 1 \gamma>1 is chosen to capture a super-linear decline in performance once cognitive load exceeds capacity, consistent with cognitive load theory’s assumption of substantial performance degradation under overload [(Sweller et al. , [2011](https://arxiv.org/html/2601.04748v1#bib.bib11) )] .
- •

The second term captures Shepard-style similarity interference. Even at fixed | 𝐒 | |\mathbf{S}| , high semantic overlap among skills (large ℐ ​ ( 𝐒 ) \mathcal{I}(\mathbf{S}) ) degrades accuracy through the ACT-R fan effect—competing skills share retrieval cues, reducing discriminability.



The additive structure reflects that capacity limits and similarity interference are *partially independent* failure modes: a small library of highly confusable skills can fail (high ℐ \mathcal{I} , low | 𝐒 | |\mathbf{S}| ), as can a large library of distinct skills (low ℐ \mathcal{I} , high | 𝐒 | |\mathbf{S}| ).



### 4.4 Scaling Hypotheses


The formulation in Eq. ( [10](https://arxiv.org/html/2601.04748v1#S4.E10) ) implies four testable predictions, each grounded in cognitive theory:



1. 1.

H1: Non-linear Phase Transition. Selection accuracy exhibits a critical regime governed by capacity threshold κ \kappa . The system maintains high accuracy when | 𝐒 | < κ |\mathbf{S}|<\kappa but suffers sharp, non-linear degradation once library size exceeds this threshold. This mirrors the breakdown of Hick’s Law [(Longstreth, [1988](https://arxiv.org/html/2601.04748v1#bib.bib21) )] (F1) and the threshold effects in Cognitive Load Theory when working memory is exceeded [(Sweller, [1988](https://arxiv.org/html/2601.04748v1#bib.bib10) )] (F2). The transition is *phase-like* rather than gradual: accuracy is relatively stable until | 𝐒 | ≈ κ |\mathbf{S}|\approx\kappa , then drops precipitously.
2. 2.

H2: Confusability-Driven Errors. Selection degradation is driven primarily by *semantic confusability* among skills, not mere library size. Adding semantically similar “competitor” skills degrades accuracy more than adding an equivalent number of distinct skills. This prediction follows directly from the interference term ϵ ⋅ ℐ ​ ( 𝐒 ) \epsilon\cdot\mathcal{I}(\mathbf{S}) in Eq. ( [10](https://arxiv.org/html/2601.04748v1#S4.E10) ) and related to similarity-based interference in cognitive science [(Shepard, [1987](https://arxiv.org/html/2601.04748v1#bib.bib12) ; Anderson, [1974](https://arxiv.org/html/2601.04748v1#bib.bib13) ; Nosofsky, [1986](https://arxiv.org/html/2601.04748v1#bib.bib16) )] (F3).
3. 3.

H3: Instructional Saturation. Skills encapsulate complex micro-policies π \pi that may consume processing bandwidth. We test whether policy complexity affects selection accuracy, specifically, whether verbose policies reduce effective capacity κ \kappa by increasing extraneous cognitive load [(Sweller, [1988](https://arxiv.org/html/2601.04748v1#bib.bib10) )] (F2).
4. 4.

H4: Mitigation via Hierarchy. When flat selection fails ( | 𝐒 | > κ |\mathbf{S}|>\kappa ), hierarchical organization can restore reliable scaling by ensuring each decision point involves | 𝐒 local | < κ |\mathbf{S}_{\text{local}}|<\kappa options. This transforms an intractable single decision into a sequence of tractable sub-decisions. As described above, chunking theory [(Chase and Simon, [1973](https://arxiv.org/html/2601.04748v1#bib.bib17) )] and Elimination-by-Aspects model [(Tversky, [1972](https://arxiv.org/html/2601.04748v1#bib.bib18) )] (F4) establish that hierarchical decomposition to coverts overwhelming choice sets to manageable decisions.



In the following sections, we empirically test each hypothesis.



## 5 Experiments for Scaling-law


We design a series of controlled experiments to empirically validate the three key predictions of our skill scaling hypothesis: (1) the existence of a non-linear phase transition in selection accuracy, (2) the effect of instructional complexity on effective capacity, (3) the impact of instructional saturation, and (4) the mitigation potential of hierarchical routing.



### 5.1 Experimental Setup


##### Synthetic Skill Library Construction.


To enable controlled experimentation with precise manipulation of skill library properties, we construct synthetic skill libraries rather than relying on existing benchmarks. This approach allows us to systematically vary library size | 𝐒 | |\mathbf{S}| while controlling for confounding factors such as semantic similarity distribution and policy complexity.



Our skill generation framework spans 8 domains: mathematics , coding , writing , analysis , translation , question-answering , formatting , and extraction . Each domain contains 5 subtypes, yielding 40 distinct skill categories. For each category, we define 5 skill templates with varying specificity, producing a pool of 200 unique skill templates. Each skill s i = ( δ i , π i , ξ i ) s_{i}=(\delta_{i},\pi_{i},\xi_{i}) is instantiated with:

- •

Skill descriptor δ i \delta_{i} : A natural language description following the pattern “ [Skill Name]: [Capability Description] ”, e.g., “ Calculate Sum: Calculate the sum of the given numbers ”.
- •

Execution policy π i \pi_{i} : Execution instructions with controlled complexity (detailed below).
- •

Execution backend ξ i \xi_{i} : Set to ∅ \emptyset (internalized) for all experiments unless otherwise specified.



##### Task Generation.


For each skill library configuration, we generate evaluation tasks by sampling skills uniformly and constructing queries that unambiguously map to the sampled skill. Tasks are generated using domain-specific templates with randomized parameters (e.g., numerical values for math tasks, variable names for coding tasks). Each task τ \tau is paired with a ground-truth skill label s τ ∗ s^{*}_{\tau} .



##### Similarity Distribution.


To control semantic overlap among skills, we define three similarity distributions for library construction:

- •

Low (Diverse) : Skills are sampled via round-robin across all 8 domains, maximizing semantic distance. Expected intra-library similarity is low.
- •

High (Similar) : Skills are sampled from 2–3 semantically related domains (e.g., mathematics , analysis , extraction ). Expected intra-library similarity is high.
- •

Mixed : Skills are sampled uniformly at random across all domains, producing a naturalistic distribution with both related and unrelated skills.

Unless otherwise specified, experiments use the mixed distribution to simulate realistic skill library composition.



##### Policy Complexity.


To study the effect of execution instruction verbosity, we define three levels of execution policy complexity:

- •

Simple ( ∼ \sim 30 tokens): Single-sentence instructions, e.g., “ Execute the calculation and return the result. ”
- •

Medium ( ∼ \sim 100 tokens): Structured 3–5 step instructions with input validation and formatting guidelines.
- •

Complex ( ∼ \sim 300 tokens): Detailed multi-section protocols including error handling, edge cases, output formatting requirements, and quality standards.

Unless otherwise specified, experiments use simple policies to isolate the effect of library size from instruction complexity.



##### Evaluation Protocal.


We evaluate skill selection performance on GPT-4o-mini and GPT-4o 1 1 1 Our ongoing work extends the evaluation to additional models. . The models are queried with temperature T = 0 T=0 to ensure deterministic outputs. The selection prompt presents the skill library as a formatted list and instructs the model to respond with only the skill identifier. For each experimental condition, we measure selection accuracy as defined in Eq. ( [4.1](https://arxiv.org/html/2601.04748v1#S4.Ex4) ). Each condition is repeated with 3 random seeds to compute standard errors.



### 5.2 H1: Non-linear Phase Transition


##### Experimental Design.


We evaluate selection accuracy across skill library sizes | 𝐒 | ∈ { 5 , 10 , 20 , 35 , 50 , 75 , 100 , 150 , 200 } |\mathbf{S}|\in\{5,10,20,35,50,75,100,150,200\} , holding similarity distribution (mixed) and policy complexity (simple) constant. This isolates the effect of search space size on selection performance. 2 2 2 Although increasing | 𝐒 | |\mathbf{S}| also increases prompt length, our goal is not to disentangle all context-length effects, but to characterize the end-to-end difficulty of selecting among an expanding set of semantically-described actions.



##### Results.

![Refer to caption](x3.png)
 *Figure 2 : Scaling law fit quality. The proposed functional form Acc ≈ α / ( 1 + ( | 𝐒 | / κ ) γ ) \textsc{Acc}\approx\alpha/(1+(|\mathbf{S}|/\kappa)^{\gamma}) achieves excellent fit ( R 2 > 0.97 R^{2}>0.97 ) for both models, validating the theoretical model.*



Figure [2](https://arxiv.org/html/2601.04748v1#S5.F2) presents selection accuracy as a function of skill library size across both evaluated models and demonstrates the quality of the scaling law fit. Both models exhibit a sharp decline in selection accuracy as library size increases. At small scales ( | 𝐒 | ≤ 20 |\mathbf{S}|\leq 20 ), accuracy remains above 95%, but degrades rapidly beyond | 𝐒 | = 50 |\mathbf{S}|=50 , falling to approximately 20% at | 𝐒 | = 200 |\mathbf{S}|=200 . The results support our hypothesis of non-linear phase transition. The accuracy curves exhibit a characteristic sigmoid decay, with the steepest decline occurring near | 𝐒 | ≈ 50 |\mathbf{S}|\approx 50 – 100 100 , aligning with the estimated κ \kappa values. The decay rate γ > 1 \gamma>1 (1.71 and 1.65) indicates faster-than-linear degradation beyond the capacity threshold, consistent with predictions from cognitive load theory and Hick’s Law from cognitive psychology, which predicts logarithmic increases in decision time (and by extension, error rates) with the number of choices. However, we expect to see that stronger models with larger κ \kappa but the fitted parameters contradict with this. We note the fitting itself contains error and the more models with different capcities need to be tested. There a slight increase in accuracy as | 𝐒 | |\mathbf{S}| grows from 5 to approximately 20. This likely reflects improved task-skill coverage: at very small library sizes, some tasks lack well-matched skills, while moderate expansion improves coverage before selection overload begins. This non-monotonic behavior at small | 𝐒 | |\mathbf{S}| does not affect our main findings, which concern the capacity-limited regime at | 𝐒 | ≫ 20 |\mathbf{S}|\gg 20 .



### 5.3 H2: Confusability-Driven Errors


##### Experimental Design.


To isolate the effect of confusability from library size, we design a controlled experiment with explicit competitor generation. For each *base skill* (e.g., calculate_sum : “Add all numbers together”), we generate 0, 1, or 2 *competitor skills* with similar descriptions but *different underlying operations* (e.g., compute_average : “Compute the mean of all values”). Ground truth is ensured by construction: each task is generated to require a specific operation (e.g., “compute the sum”), and only the base skill performs that operation. Competitors have similar *descriptions* but would produce incorrect *outputs* if selected. For instance, given input [3, 7, 2] and the task “compute the total,” only calculate_sum returns the correct answer ( 12 ), while compute_average would return wrong answer (e.g., 4 ). Thus, the mapping from task to base skill is unambiguous despite surface-level similarity among skill descriptions.



We define three confusability conditions:

- •

No Competitors ( n comp = 0 n_{\text{comp}}=0 ): Each skill is semantically distinct. Total library size | 𝐒 | = n base |\mathbf{S}|=n_{\text{base}} .
- •

Low Confusability ( n comp = 1 n_{\text{comp}}=1 ): Each base skill has one competitor. Total | 𝐒 | = 2 × n base |\mathbf{S}|=2\times n_{\text{base}} .
- •

High Confusability ( n comp = 2 n_{\text{comp}}=2 ): Each base skill has two competitors. Total | 𝐒 | = 3 × n base |\mathbf{S}|=3\times n_{\text{base}} .



We vary n base ∈ { 5 , 10 , 15 , 20 } n_{\text{base}}\in\{5,10,15,20\} and evaluate on GPT-4o-mini and GPT-4o with 3 random seeds per condition.



##### Results.

![Refer to caption](x4.png)
 *Figure 3 : Effect of skill competitors on selection accuracy. Green: no competitors (each skill unique). Orange: 1 competitor per skill. Red: 2 competitors per skill. At fixed total library size, higher confusability leads to lower accuracy, demonstrating that semantic similarity—not library size alone—drives selection errors.*



Figure [3](https://arxiv.org/html/2601.04748v1#S5.F3) presents selection accuracy across confusability conditions. With no competitors, selection accuracy remains at 100% even at | 𝐒 | = 20 |\mathbf{S}|=20 . This contrasts sharply with the ∼ \sim 95% accuracy observed in H1 at the same library size with mixed similarity, confirming that semantic overlap is the primary error source.



Adding just one competitor per skill reduces accuracy by 7–30% (Low condition). Adding two competitors causes 17–63% degradation (High condition), with GPT-4o-mini showing larger drops than GPT-4o. GPT-4o consistently outperforms GPT-4o-mini under high confusability (e.g., 70% vs. 37% at n base = 10 n_{\text{base}}=10 , n comp = 2 n_{\text{comp}}=2 ), suggesting that model capability provides partial mitigation against confusability. The confusability effect is consistent across all tested n base n_{\text{base}} values, indicating a fundamental challenge rather than a small-scale artifact. At identical | 𝐒 | = 20 |\mathbf{S}|=20 , replacing unique skills with base-competitor pairs causes a 18–30% accuracy drop. This demonstrates that *semantic structure* determines selection difficulty.



The results provide an important practical implication for skill library design: skill descriptors should emphasize *unique* characteristics. Avoid generic descriptions that could apply to multiple skills (e.g., “process data” → \rightarrow “compute rolling 7-day average”).



H1 and H2 together provide an important understanding of skill selection scaling. H1 establishes that accuracy degrades with library size, while H2 reveals that this degradation is mediated by semantic confusability. The phase transition observed in H1 likely reflects the accumulation of confusable skill pairs as libraries grow from mixed sampling. This explains why the no-competitor condition in H2 maintains 100% accuracy at | 𝐒 | = 20 |\mathbf{S}|=20 , a size where H1’s mixed-similarity libraries show measurable degradation.



### 5.4 H3: Instructional Saturation


##### Experimental Design.


To test whether execution policy complexity affects effective capacity, we compare selection accuracy across three policy complexity levels (simple, medium, complex) at fixed library sizes | 𝐒 | ∈ { 10 , 20 , 50 , 100 , 150 } |\mathbf{S}|\in\{10,20,50,100,150\} . In this experiment, the full execution policy π i \pi_{i} is included in the selection prompt alongside the descriptor δ i \delta_{i} , simulating scenarios where the selector must process detailed execution instructions.



##### Results.

![Refer to caption](x5.png)
 *Figure 4 : Effect of execution policy complexity on selection accuracy. Each panel shows results for one model. Contrary to expectations, the three complexity levels show largely overlapping performance curves.*



Figure [4](https://arxiv.org/html/2601.04748v1#S5.F4) visualizes the interaction between policy complexity and library size for both models. Contrary to our hypothesis, the three policy complexity levels (simple, medium, complex) show largely overlapping accuracy curves for both models. The differences between conditions fall within standard error bounds at most library sizes. All complexity levels follow the same phase transition pattern observed in H1, with accuracy declining sharply beyond | 𝐒 | = 50 |\mathbf{S}|=50 . The absence of a complexity effect is consistent across both GPT-4o-mini and GPT-4o, suggesting this is not a model-specific phenomenon.



The results do not support H2. We hypothesized that complex micro-policies would consume “cognitive bandwidth,” effectively lowering the capacity threshold κ \kappa . However, the empirical data shows no meaningful difference between simple and complex policies.



Several factors may explain this null result. First, we have to admit that our policy templates, while varying in length, may not have introduced sufficient semantic complexity to stress the selection mechanism. Future work could explore policies with more ambiguous or conflicting instructions. Given the template used, modern transformer architectures may efficiently filter relevant information from long contexts, mitigating the expected cognitive load from complex policies.



### 5.5 H4: Hierarchy Mitigation


##### Experimental Design.


We compare three selection strategies:



- •

Flat Selection : Direct selection from all | 𝐒 | |\mathbf{S}| skills (baseline).
- •

Naive Domain Hierarchy : Two-stage selection where Stage 1 selects a domain category and Stage 2 selects within that domain.
- •

Confusability-Aware Hierarchy : Two-stage selection where semantically similar skills (competitors) are explicitly grouped together. Stage 1 selects among distinct clusters; Stage 2 disambiguates within a small cluster of similar skills.



To properly test hierarchy at scale, we extend the library size range beyond the capacity threshold identified in H1. We construct skill libraries with n groups ∈ { 4 , 6 , 8 , 10 , 20 , 30 , 40 } n_{\text{groups}}\in\{4,6,8,10,20,30,40\} groups, each containing 3 semantically similar skills (1 base + 2 competitors), yielding total library sizes | 𝐒 | ∈ { 12 , 18 , 24 , 30 , 60 , 90 , 120 } |\mathbf{S}|\in\{12,18,24,30,60,90,120\} .



Each group represents a distinct functionality (e.g., “Summation”, “Averaging”, “Email Writing”), while skills within a group are near-synonyms (e.g., “Calculate Sum”, “Compute Total”, “Sum Numbers”). Tasks are generated to map to the base skill of each group, ensuring unambiguous ground truth.



##### Results.

![Refer to caption](x6.png)
 *Figure 5 : Effect of hierarchical routing on selection accuracy. Blue: flat selection. Red: naive domain hierarchy. Green: confusability-aware hierarchy. At large library sizes ( | 𝐒 | ≥ 60 |\mathbf{S}|\geq 60 ), hierarchy maintains ∼ \sim 72–85% accuracy while flat selection degrades to ∼ \sim 45–63%.*



Figure [5](https://arxiv.org/html/2601.04748v1#S5.F5) presents selection accuracy across library sizes for all three methods. When library size exceeds the capacity threshold ( | 𝐒 | ≥ 60 |\mathbf{S}|\geq 60 , approaching κ ≈ 90 \kappa\approx 90 ), hierarchical routing recovers substantial accuracy. For GPT-4o-mini, hierarchy improves accuracy by +37–40% absolute (from ∼ \sim 45% to ∼ \sim 83–85%). For GPT-4o, the improvement is +9–10% (from ∼ \sim 63% to ∼ \sim 72%). Flat selection accuracy drops precipitously as | 𝐒 | |\mathbf{S}| increases beyond 30, consistent with the phase transition identified in H1. Flat selection at | 𝐒 | = 120 |\mathbf{S}|=120 operates far beyond κ \kappa , yielding the observed ∼ \sim 45–63% accuracy. In contrast, hierarchical methods maintain relatively stable accuracy ( ∼ \sim 72–85%) across all tested sizes up to | 𝐒 | = 120 |\mathbf{S}|=120 . Both hierarchical methods perform similarly, as our experimental design naturally aligns domain boundaries with confusability clusters. In practice, the key factor is grouping skills such that first-stage routing involves distinct, easily-discriminable categories.GPT-4o shows higher flat accuracy than GPT-4o-mini (63% vs. 45% at large | 𝐒 | |\mathbf{S}| ), but also derives smaller benefit from hierarchy (+10% vs. +40%). Stronger models partially compensate for scaling challenges through better semantic discrimination. Both hierarchical methods perform similarly, as our experimental design naturally aligns domain boundaries with confusability clusters. In practice, the key factor is grouping skills such that first-stage routing involves distinct, easily-discriminable categories.



The results support H3 for library sizes exceeding the capacity threshold. The mechanism can be understood through the lens of H1 and H4.Connecting to H1, flat selection fails when | 𝐒 | > κ |\mathbf{S}|>\kappa due to cognitive overload. Hierarchy works by ensuring each selection stage operates within the reliable regime: Stage 1 involves ∼ \sim 10–40 distinct clusters (well below κ \kappa ), and Stage 2 involves only 3 skills per cluster. Connecting to H2, confusability-aware grouping ensures that first-stage categories are semantically distinct (low confusability → \rightarrow high accuracy), while confusable skills are handled together in a small second-stage pool (high confusability but small | 𝐒 | |\mathbf{S}| → \rightarrow manageable).



### 5.6 Practical Guidelines and Limitation Discussion


Based on our findings, we recommend the following guidelines for skill library design in LLM-based agents:


Design Guidelines Based on our findings, we recommend the following guidelines for skill library design in LLM-based agents: 1. Monitor library size : Track | 𝐒 | |\mathbf{S}| relative to the model’s capacity ( κ ≈ 50 \kappa\approx 50 – 100 100 for the tested GPT models). Performance degrades sharply beyond this threshold. 2. Minimize confusability : Before adding skills, audit semantic overlap. Merge or differentiate skills with similarity above threshold rather than accumulating near-duplicates. 3. Adopt hierarchy at scale : For large | 𝐒 | ≫ κ |\mathbf{S}|\gg\kappa , implement hierarchical routing with confusability-aware grouping. Each stage should involve < κ <\kappa options. 4. Invest in descriptors : Since selection relies on descriptors (H2), invest effort in crafting or optimizing distinctive, specific descriptions. 5. Match model to task : Stronger models show higher κ \kappa and better confusability resistance. For applications with inherently large or confusable skill sets, model capability investment yields direct accuracy benefits. 6. Consider alternative architectures : For large skill sets, the scaling limitations suggest that multi-agent architectures with specialized routers may outperform monolithic single-agent approaches.


##### Limitations.


We acknowledge several limitations. 1. Synthetic data: While enabling controlled experiments, synthetic skill libraries may not capture the full complexity of real-world skill distributions. 2. Selection-only evaluation: We measure selection accuracy but not end-to-end task performance. 3. Limited model coverage: Results are based on two OpenAI models; generalization to other architectures requires further study. 4. Hierarchy design: Designing the best solution to mitigate performance degration associated with scaling is not the focus of this work, so our hierarchical approaches were relatively simple; more sophisticated routing mechanisms may yield different results.



## 6 Conclusion and Future Directions


As LLM-based agents take on increasingly complex tasks, the design of their action spaces becomes a first-order concern. Our work suggests that skill-based modularity offers a promising middle ground between monolithic prompting and expensive multi-agent coordination, but that this approach has inherent scaling limits rooted in the nature of selection itself. Our preliminary experiments suggest this compilation can yield substantial efficiency gains while preserving task performance—at least when skill libraries remain small. More fundamentally, we investigate a question that has received limited attention: *how does skill selection scale?* Our experiments reveal a non-linear scaling pattern, where selection accuracy remains stable up to a critical threshold before degrading sharply. We find suggestive evidence that semantic confusability among skills also plays a central role in this degradation. Drawing on cognitive psychology, we propose that LLM skill selection may exhibit capacity limits analogous to human decision-making, and that hierarchical organization can help mitigate these limits.



We acknowledge several limitations that may temper the strength of our conclusions. Thus, we acknowledge several future directions worthy of further investigation:



- •

Broader model coverage : Extending experiments to diverse model families (open-source models, different scales, multimodal models) would clarify whether the capacity thresholds we observe are universal or architecture-specific.
- •

Real-world skill libraries : Evaluating on naturally-occurring skill distributions, such as those emerging from software development, long-horizon planning, or scientific workflows, would test the ecological validity of our findings.
- •

End-to-end evaluation : Measuring how selection errors propagate to final task outcomes would provide a more complete picture of when skill-based systems are viable alternatives to multi-agent approaches.
- •

Adaptive routing mechanisms : Exploring learned or dynamic routing strategies that adapt to task context and skill library structure may offer better scaling than fixed hierarchies.
- •

Theoretical foundations : Developing formal models that explain *why* capacity limits emerge and potentially connecting to information-theoretic or mechanistic interpretability perspectives would strengthen the scientific grounding of our observations.

We hope the questions and preliminary findings presented here will stimulate further investigation into the cognitive-like constraints that shape what AI agents can effectively do.



##### Acknowledgment.


This paper represents ongoing research, and we welcome feedback, corrections, and suggestions from the community. In accordance with emerging norms for transparency in academic writing, we disclose that AI writing assistants were used to support editing and literature organization during the preparation of this manuscript. We have carefully reviewed and verified the content. The author thanks Dr. Ruiyang Ge for valuable discussions on cognitive science foundations and for suggesting relevant literature connecting our findings to established theories in human decision-making and is grateful to Yushu Li for providing feedback on early drafts of this manuscript. This work was partially funded by the NSERC Discovery Grant RGPIN-2022-05316, NSERC Alliance Grant ALLRP 602633-24, Tri-Agency Canada IITP, and the Ministry of Science and ICT (No. RS-2024-00445087), CIFAR AI Chair Awards, and Canada Research Chair Fellowship.



## References

- J. R. Anderson and L. M. Reder (1999) The fan effect: new results and new theories. . Journal of Experimental Psychology: General 128 ( 2 ), pp. 186 . Cited by: [§4.1](https://arxiv.org/html/2601.04748v1#S4.SS1.SSS0.Px3.p1.1) .
- J. R. Anderson (1974) Retrieval of propositional information from long-term memory . Cognitive Psychology 6 ( 4 ), pp. 451–474 . Cited by: [§1](https://arxiv.org/html/2601.04748v1#S1.p7.1) , [item 2](https://arxiv.org/html/2601.04748v1#S4.I2.i2.p1.1) , [§4.1](https://arxiv.org/html/2601.04748v1#S4.SS1.SSS0.Px3.p1.1) .
- J. R. Anderson (1983) A spreading activation theory of memory . Journal of verbal learning and verbal behavior 22 ( 3 ), pp. 261–295 . Cited by: [§4.1](https://arxiv.org/html/2601.04748v1#S4.SS1.SSS0.Px3.p1.1) .
- Anthropic (2025a) Agent skills overview . Note: [https://docs.anthropic.com/en/docs/agents-and-tools/agent-skills/overview](https://docs.anthropic.com/en/docs/agents-and-tools/agent-skills/overview) Accessed: 2026-01-07 Cited by: [§1](https://arxiv.org/html/2601.04748v1#S1.p2.1) .
- Anthropic (2025b) Equipping agents for the real world with agent skills . Note: [https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills) Anthropic Engineering Blog. Accessed: 2026-01-07 Cited by: [§1](https://arxiv.org/html/2601.04748v1#S1.p2.1) .
- W. G. Chase and H. A. Simon (1973) Perception in chess . Cognitive Psychology 4 ( 1 ), pp. 55–81 . Cited by: [§1](https://arxiv.org/html/2601.04748v1#S1.p7.1) , [item 4](https://arxiv.org/html/2601.04748v1#S4.I2.i4.p1.2) , [§4.1](https://arxiv.org/html/2601.04748v1#S4.SS1.SSS0.Px4.p1.1) .
- M. Chen, J. Tworek, H. Jun, Q. Yuan, H. Ponde de Oliveira Pinto, J. Kaplan, H. Edwards, Y. Burda, N. Joseph, G. Brockman, et al. (2021) Evaluating large language models trained on code . arXiv preprint arXiv:2107.03374 . Cited by: [§1](https://arxiv.org/html/2601.04748v1#S1.p4.1) , [§3.2.1](https://arxiv.org/html/2601.04748v1#S3.SS2.SSS1.p1.1) .
- W. Chen, Y. Su, J. Zuo, C. Yang, C. Yuan, C. Chan, H. Yu, Y. Lu, Y. Hung, C. Qian, et al. (2024) AgentVerse: facilitating multi-agent collaboration and exploring emergent behaviors . In International Conference on Learning Representations (ICLR) , Cited by: [§A.2](https://arxiv.org/html/2601.04748v1#A1.SS2.p1.1) , [§1](https://arxiv.org/html/2601.04748v1#S1.p1.1) .
- W. Chen, J. Yuan, C. Qian, C. Yang, Z. Liu, and M. Sun (2025) Optima: optimizing effectiveness and efficiency for llm-based multi-agent system . In Findings of the Association for Computational Linguistics: ACL 2025 , pp. 11534–11557 . Cited by: [§1](https://arxiv.org/html/2601.04748v1#S1.p1.1) .
- K. Cobbe, V. Kosaraju, M. Bavarian, M. Chen, H. Jun, L. Kaiser, M. Plappert, J. Tworek, J. Hilton, R. Nakano, C. Hesse, and J. Schulman (2021) Training verifiers to solve math word problems . arXiv preprint arXiv:2110.14168 . Cited by: [§1](https://arxiv.org/html/2601.04748v1#S1.p4.1) , [§3.2.1](https://arxiv.org/html/2601.04748v1#S3.SS2.SSS1.p1.1) .
- T. Guo, X. Chen, Y. Wang, R. Chang, S. Pei, N. V. Chawla, O. Wiest, and X. Zhang (2024) Large language model based multi-agents: a survey of progress and challenges . In Proceedings of the Thirty-Third International Joint Conference on Artificial Intelligence (IJCAI) , pp. 8048–8057 . Cited by: [§1](https://arxiv.org/html/2601.04748v1#S1.p1.1) .
- W. E. Hick (1952) On the rate of gain of information . Quarterly Journal of Experimental Psychology 4 ( 1 ), pp. 11–26 . Cited by: [§A.3](https://arxiv.org/html/2601.04748v1#A1.SS3.p3.1) , [§4.1](https://arxiv.org/html/2601.04748v1#S4.SS1.SSS0.Px1.p1.3) .
- J. Hoffmann, S. Borgeaud, A. Mensch, E. Buchatskaya, T. Cai, E. Rutherford, D. de Las Casas, L. A. Hendricks, J. Welbl, A. Clark, et al. (2022) Training compute-optimal large language models . In Advances in Neural Information Processing Systems (NeurIPS) , Vol. 35 , pp. 30016–30030 . Cited by: [§A.3](https://arxiv.org/html/2601.04748v1#A1.SS3.p1.1) .
- S. Hong, M. Zhuge, J. Chen, X. Zheng, Y. Cheng, C. Zhang, J. Wang, Z. Wang, S. K. S. Yau, Z. Lin, et al. (2024) MetaGPT: meta programming for a multi-agent collaborative framework . In International Conference on Learning Representations (ICLR) , Cited by: [§A.2](https://arxiv.org/html/2601.04748v1#A1.SS2.p1.1) .
- R. Hyman (1953) Stimulus information as a determinant of reaction time . Journal of Experimental Psychology 45 ( 3 ), pp. 188–196 . Cited by: [§4.1](https://arxiv.org/html/2601.04748v1#S4.SS1.SSS0.Px1.p1.3) .
- J. Kaplan, S. McCandlish, T. Henighan, T. B. Brown, B. Chess, R. Child, S. Gray, A. Radford, J. Wu, and D. Amodei (2020) Scaling laws for neural language models . arXiv preprint arXiv:2001.08361 . Cited by: [§A.3](https://arxiv.org/html/2601.04748v1#A1.SS3.p1.1) .
- Y. Kim et al. (2025) Towards a science of scaling agent systems . arXiv preprint arXiv:2512.08296 . Cited by: [§A.3](https://arxiv.org/html/2601.04748v1#A1.SS3.p2.1) .
- E. Lee and J. MacGregor (1985) Minimizing user search time in menu retrieval systems . Human Factors 27 ( 2 ), pp. 157–162 . Cited by: [§4.1](https://arxiv.org/html/2601.04748v1#S4.SS1.SSS0.Px4.p1.1) .
- G. Li, H. A. A. K. Hammoud, H. Itani, D. Khizbullin, and B. Ghanem (2023) CAMEL: communicative agents for “mind” exploration of large language model society . In Advances in Neural Information Processing Systems (NeurIPS) , Vol. 36 , pp. 51991–52008 . Cited by: [§A.2](https://arxiv.org/html/2601.04748v1#A1.SS2.p1.1) .
- Y. Liang, C. Wu, T. Song, W. Wu, Y. Xia, Y. Liu, Y. Ou, S. Lu, L. Ji, S. Mao, et al. (2024) TaskMatrix.ai: completing tasks by connecting foundation models with millions of apis . Intelligent Computing 3 , pp. 0063 . Cited by: [§A.1](https://arxiv.org/html/2601.04748v1#A1.SS1.p2.1) .
- L. E. Longstreth (1988) Hick’s law: its limit is 3 bits . Bulletin of the Psychonomic Society 26 ( 1 ), pp. 8–10 . Cited by: [item 1](https://arxiv.org/html/2601.04748v1#S4.I2.i1.p1.3) , [§4.1](https://arxiv.org/html/2601.04748v1#S4.SS1.SSS0.Px1.p1.3) .
- I. R. McKenzie, A. Lyzhov, M. Pieler, A. Parrish, A. Mueller, A. Prabhu, et al. (2023) Inverse scaling: when bigger isn’t better . Transactions on Machine Learning Research (TMLR) . Cited by: [§A.3](https://arxiv.org/html/2601.04748v1#A1.SS3.p1.1) .
- E. J. Michaud, Z. Liu, U. Girit, and M. Tegmark (2023) The quantization model of neural scaling . In Advances in Neural Information Processing Systems (NeurIPS) , Vol. 36 , pp. 42540–42569 . Cited by: [§A.3](https://arxiv.org/html/2601.04748v1#A1.SS3.p1.1) .
- D. P. Miller (1981) The depth/breadth tradeoff in hierarchical computer menus . Proceedings of the Human Factors Society 25 ( 1 ), pp. 296–300 . Cited by: [§1](https://arxiv.org/html/2601.04748v1#S1.p7.1) , [§4.1](https://arxiv.org/html/2601.04748v1#S4.SS1.SSS0.Px4.p1.1) .
- G. A. Miller (1956) The magical number seven, plus or minus two: some limits on our capacity for processing information . Psychological Review 63 ( 2 ), pp. 81–97 . Cited by: [§4.1](https://arxiv.org/html/2601.04748v1#S4.SS1.SSS0.Px2.p1.2) .
- R. M. Nosofsky (1986) Attention, similarity, and the identification–categorization relationship . Journal of Experimental Psychology: General 115 ( 1 ), pp. 39–57 . Cited by: [item 2](https://arxiv.org/html/2601.04748v1#S4.I2.i2.p1.1) , [§4.1](https://arxiv.org/html/2601.04748v1#S4.SS1.SSS0.Px3.p1.1) .
- J. S. Park, J. C. O’Brien, C. J. Cai, M. R. Morris, P. Liang, and M. S. Bernstein (2023) Generative agents: interactive simulacra of human behavior . In Proceedings of the 36th Annual ACM Symposium on User Interface Software and Technology (UIST) , pp. 1–22 . Cited by: [§A.2](https://arxiv.org/html/2601.04748v1#A1.SS2.p2.1) .
- S. G. Patil, T. Zhang, X. Wang, and J. E. Gonzalez (2024) Gorilla: large language model connected with massive apis . In Advances in Neural Information Processing Systems (NeurIPS) , Vol. 37 . Cited by: [§A.1](https://arxiv.org/html/2601.04748v1#A1.SS1.p2.1) , [§1](https://arxiv.org/html/2601.04748v1#S1.p2.1) .
- Y. Qin, S. Hu, Y. Lin, W. Chen, N. Ding, G. Cui, Z. Zeng, Y. Huang, C. Xiao, C. Han, et al. (2024a) Tool learning with foundation models . ACM Computing Surveys . Cited by: [§A.1](https://arxiv.org/html/2601.04748v1#A1.SS1.p2.1) .
- Y. Qin, S. Liang, Y. Ye, K. Zhu, L. Yan, Y. Lu, Y. Lin, X. Cong, X. Tang, B. Qian, et al. (2024b) ToolLLM: facilitating large language models to master 16000+ real-world apis . In International Conference on Learning Representations (ICLR) , Note: Spotlight Cited by: [§A.1](https://arxiv.org/html/2601.04748v1#A1.SS1.p2.1) , [§1](https://arxiv.org/html/2601.04748v1#S1.p2.1) .
- C. Qu, S. Dai, X. Wei, H. Cai, S. Wang, D. Yin, J. Xu, and J. Wen (2025) Tool learning with large language models: a survey . Frontiers of Computer Science 19 ( 8 ), pp. 198343 . Cited by: [§A.1](https://arxiv.org/html/2601.04748v1#A1.SS1.p2.1) .
- R. Schaeffer, B. Miranda, and S. Koyejo (2023) Are emergent abilities of large language models a mirage? . In Advances in Neural Information Processing Systems (NeurIPS) , Vol. 36 , pp. 55565–55581 . Cited by: [§A.3](https://arxiv.org/html/2601.04748v1#A1.SS3.p1.1) .
- T. Schick, J. Dwivedi-Yu, R. Dessì, R. Raileanu, M. Lomeli, L. Zettlemoyer, N. Cancedda, and T. Scialom (2023) Toolformer: language models can teach themselves to use tools . In Advances in Neural Information Processing Systems (NeurIPS) , Vol. 36 , pp. 68539–68551 . Cited by: [§A.1](https://arxiv.org/html/2601.04748v1#A1.SS1.p1.1) , [§1](https://arxiv.org/html/2601.04748v1#S1.p2.1) .
- Y. Shen, K. Song, X. Tan, D. Li, W. Lu, and Y. Zhuang (2023) HuggingGPT: solving ai tasks with chatgpt and its friends in hugging face . In Advances in Neural Information Processing Systems (NeurIPS) , Vol. 36 , pp. 38154–38180 . Cited by: [§A.1](https://arxiv.org/html/2601.04748v1#A1.SS1.p2.1) .
- R. N. Shepard (1987) Toward a universal law of generalization for psychological science . Science 237 ( 4820 ), pp. 1317–1323 . Cited by: [§A.3](https://arxiv.org/html/2601.04748v1#A1.SS3.p3.1) , [§1](https://arxiv.org/html/2601.04748v1#S1.p7.1) , [item 2](https://arxiv.org/html/2601.04748v1#S4.I2.i2.p1.1) , [§4.1](https://arxiv.org/html/2601.04748v1#S4.SS1.SSS0.Px3.p1.1) .
- J. Sweller, P. Ayres, and S. Kalyuga (2011) Cognitive load theory . Springer . Cited by: [1st item](https://arxiv.org/html/2601.04748v1#S4.I1.i1.p1.5) , [§4.1](https://arxiv.org/html/2601.04748v1#S4.SS1.SSS0.Px2.p1.2) .
- J. Sweller (1988) Cognitive load during problem solving: effects on learning . Cognitive Science 12 ( 2 ), pp. 257–285 . Cited by: [§A.3](https://arxiv.org/html/2601.04748v1#A1.SS3.p3.1) , [item 1](https://arxiv.org/html/2601.04748v1#S4.I2.i1.p1.3) , [item 3](https://arxiv.org/html/2601.04748v1#S4.I2.i3.p1.2) , [§4.1](https://arxiv.org/html/2601.04748v1#S4.SS1.SSS0.Px2.p1.2) .
- A. Tversky (1972) Elimination by aspects: a theory of choice . Psychological Review 79 ( 4 ), pp. 281–299 . Cited by: [item 4](https://arxiv.org/html/2601.04748v1#S4.I2.i4.p1.2) , [§4.1](https://arxiv.org/html/2601.04748v1#S4.SS1.SSS0.Px4.p1.1) .
- G. Wang, Y. Xie, Y. Jiang, A. Mandlekar, C. Xiao, Y. Zhu, L. Fan, and A. Anandkumar (2023a) Voyager: an open-ended embodied agent with large language models . Transactions on Machine Learning Research (TMLR) . Cited by: [§A.2](https://arxiv.org/html/2601.04748v1#A1.SS2.p2.1) .
- Z. Wang, S. Cai, G. Chen, A. Liu, X. Ma, and Y. Liang (2023b) Describe, explain, plan and select: interactive planning with large language models enables open-world multi-task agents . In Advances in Neural Information Processing Systems (NeurIPS) , Vol. 36 , pp. 34153–34189 . Cited by: [§A.2](https://arxiv.org/html/2601.04748v1#A1.SS2.p2.1) .
- J. Wei, N. Kim, Y. Tay, and Q. V. Le (2022a) Inverse scaling can become u-shaped . arXiv preprint arXiv:2211.02011 . Cited by: [§A.3](https://arxiv.org/html/2601.04748v1#A1.SS3.p1.1) .
- J. Wei, Y. Tay, R. Bommasani, C. Raffel, B. Zoph, S. Borgeaud, D. Yogatama, M. Bosma, D. Zhou, D. Metzler, et al. (2022b) Emergent abilities of large language models . Transactions on Machine Learning Research (TMLR) . Cited by: [§A.3](https://arxiv.org/html/2601.04748v1#A1.SS3.p1.1) .
- J. Wu, J. Zhu, Y. Liu, M. Xu, and Y. Jin (2025) Agentic reasoning: a streamlined framework for enhancing llm reasoning with agentic tools . arXiv preprint arXiv:2502.04644 . Cited by: [§1](https://arxiv.org/html/2601.04748v1#S1.p1.1) .
- Q. Wu, G. Bansal, J. Zhang, Y. Wu, B. Li, E. Zhu, L. Jiang, X. Zhang, S. Zhang, J. Liu, et al. (2024) AutoGen: enabling next-gen llm applications via multi-agent conversation . In International Conference on Learning Representations (ICLR) , Cited by: [§A.2](https://arxiv.org/html/2601.04748v1#A1.SS2.p1.1) , [§1](https://arxiv.org/html/2601.04748v1#S1.p1.1) .
- P. Xia, J. Wang, Y. Peng, K. Zeng, X. Wu, X. Tang, H. Zhu, Y. Li, S. Liu, Y. Lu, et al. (2025) MMedAgent-rl: optimizing multi-agent collaboration for multimodal medical reasoning . arXiv preprint arXiv:2506.00555 . Cited by: [§1](https://arxiv.org/html/2601.04748v1#S1.p1.1) .
- T. Yang, P. Feng, Q. Guo, J. Zhang, J. Ning, X. Wang, and Z. Mao (2025) AutoHMA-llm: efficient task coordination and execution in heterogeneous multi-agent systems using hybrid large language models . IEEE Transactions on Cognitive Communications and Networking . Cited by: [§1](https://arxiv.org/html/2601.04748v1#S1.p1.1) .
- Z. Yang, P. Qi, S. Zhang, Y. Bengio, W. W. Cohen, R. Salakhutdinov, and C. D. Manning (2018) HotpotQA: a dataset for diverse, explainable multi-hop question answering . In Proceedings of the 2018 Conference on Empirical Methods in Natural Language Processing , pp. 2369–2380 . Cited by: [§1](https://arxiv.org/html/2601.04748v1#S1.p4.1) , [§3.2.1](https://arxiv.org/html/2601.04748v1#S3.SS2.SSS1.p1.1) .
- S. Yao, J. Zhao, D. Yu, N. Du, I. Shafran, K. Narasimhan, and Y. Cao (2023) ReAct: synergizing reasoning and acting in language models . In International Conference on Learning Representations (ICLR) , Cited by: [§A.1](https://arxiv.org/html/2601.04748v1#A1.SS1.p1.1) .
- Y. Yue, G. Zhang, B. Liu, G. Wan, K. Wang, D. Cheng, and Y. Qi (2025) Masrouter: learning to route llms for multi-agent systems . arXiv preprint arXiv:2502.11133 . Cited by: [§1](https://arxiv.org/html/2601.04748v1#S1.p1.1) .
- B. Zhang, Z. Liu, C. Cherry, and O. Firat (2024) When scaling meets llm finetuning: the effect of data, model and finetuning method . arXiv preprint arXiv:2402.17193 . Cited by: [§A.3](https://arxiv.org/html/2601.04748v1#A1.SS3.p2.1) .





## Appendix A Related Work


In addition to the related work discussion on cognitive science in Sec [4.1](https://arxiv.org/html/2601.04748v1#S4.SS1) , we also relate our work to the intersection of three research areas: tool use in LLMs, multi-agent systems, and scaling laws. Our contribution is distinguished by its focus on the *scaling behavior of skill selection* —a problem that has received limited systematic study despite its centrality to agent system design.



### A.1 Tool Use in LLMs


Recent work has dramatically expanded LLMs’ capabilities by augmenting them with external tools. [Schick et al. [ [2023](https://arxiv.org/html/2601.04748v1#bib.bib22) ]] introduced Toolformer, demonstrating that LLMs can learn to use tools (calculators, search engines, translation systems) in a self-supervised manner. ReAct [[Yao et al. , [2023](https://arxiv.org/html/2601.04748v1#bib.bib23) ]] established the influential paradigm of interleaving reasoning traces with tool-use actions, enabling dynamic decisions about when to invoke external capabilities versus rely on internal knowledge.



As tool ecosystems have grown, the challenge of tool selection has become increasingly prominent. ToolLLM [[Qin et al. , [2024b](https://arxiv.org/html/2601.04748v1#bib.bib24) ]] scaled to over 16,000 real-world APIs, introducing a neural retriever for tool selection and depth-first search for multi-step planning. Gorilla [[Patil et al. , [2024](https://arxiv.org/html/2601.04748v1#bib.bib25) ]] demonstrated retriever-aware training for API selection, while HuggingGPT [[Shen et al. , [2023](https://arxiv.org/html/2601.04748v1#bib.bib26) ]] and TaskMatrix.AI [[Liang et al. , [2024](https://arxiv.org/html/2601.04748v1#bib.bib27) ]] proposed architectures where LLMs orchestrate specialized models based on task descriptions. Comprehensive surveys [[Qin et al. , [2024a](https://arxiv.org/html/2601.04748v1#bib.bib28) , Qu et al. , [2025](https://arxiv.org/html/2601.04748v1#bib.bib29) ]] have formalized tool learning into stages: planning, selection, calling, and response generation.



Our work differs from this literature in two key respects. First, we distinguish *skills* from *tools* : while tools are typically atomic external APIs with minimal descriptive overhead, skills are *internalized capabilities* comprising rich semantic descriptors and execution policies. This distinction matters because skills impose greater cognitive load during selection. Second, rather than proposing new selection mechanisms, we characterize the fundamental scaling limits of selection accuracy by establishing capacity thresholds ( κ \kappa ) and identifying confusability as the primary driver of degradation.



### A.2 Multi-Agent LLM Systems


Multi-agent systems (MAS) have emerged as a prominent paradigm for complex task solving. AutoGen [[Wu et al. , [2024](https://arxiv.org/html/2601.04748v1#bib.bib36) ]] introduced flexible multi-agent conversation frameworks with customizable agent interactions. MetaGPT [[Hong et al. , [2024](https://arxiv.org/html/2601.04748v1#bib.bib37) ]] encodes Standardized Operating Procedures (SOPs) into agent workflows, demonstrating that structured role assignment enables effective coordination. CAMEL [[Li et al. , [2023](https://arxiv.org/html/2601.04748v1#bib.bib38) ]] pioneered role-playing frameworks for autonomous agent cooperation, while AgentVerse [[Chen et al. , [2024](https://arxiv.org/html/2601.04748v1#bib.bib39) ]] explored dynamic agent group composition with expert recruitment mechanisms.



A parallel line of work has focused on skill acquisition and management in agents. Voyager [[Wang et al. , [2023a](https://arxiv.org/html/2601.04748v1#bib.bib42) ]] introduced an ever-growing skill library for embodied agents, where skills are indexed by embeddings and retrieved compositionally. Generative Agents [[Park et al. , [2023](https://arxiv.org/html/2601.04748v1#bib.bib41) ]] established foundational architectures with memory, reflection, and planning modules. DEPS [[Wang et al. , [2023b](https://arxiv.org/html/2601.04748v1#bib.bib43) ]] addressed skill selection through interactive planning with sub-goal ranking.



Our work provides a theoretical bridge between MAS and single-agent skill-based systems. We show that certain types of MAS can be compiled into equivalent single-agent systems with skill libraries, and characterize when this compilation is beneficial versus when the resulting skill library exceeds cognitive capacity. This perspective reveals that hierarchical multi-agent organization is not merely an architectural choice but a necessary mitigation when skill libraries grow beyond the capacity threshold κ \kappa .



### A.3 Scaling Laws and Emergent Abilities


Neural scaling laws [[Kaplan et al. , [2020](https://arxiv.org/html/2601.04748v1#bib.bib46) , Hoffmann et al. , [2022](https://arxiv.org/html/2601.04748v1#bib.bib47) ]] have established power-law relationships between model size, data, compute, and loss. These findings have been extended to understand emergent abilities—capabilities that appear suddenly at specific scale thresholds rather than improving gradually [[Wei et al. , [2022b](https://arxiv.org/html/2601.04748v1#bib.bib48) ]] . The nature of these phase transitions remains debated. [Schaeffer et al. [ [2023](https://arxiv.org/html/2601.04748v1#bib.bib49) ]] argued that apparent emergent abilities may be artifacts of nonlinear metrics rather than fundamental behavioral changes. [Michaud et al. [ [2023](https://arxiv.org/html/2601.04748v1#bib.bib50) ]] proposed that network capabilities are “quantized” into discrete skills learned in order of decreasing frequency, with smooth aggregate scaling masking discrete phase transitions in individual capabilities. Recent work has documented U-shaped [[Wei et al. , [2022a](https://arxiv.org/html/2601.04748v1#bib.bib52) ]] and inverted-U scaling patterns [[McKenzie et al. , [2023](https://arxiv.org/html/2601.04748v1#bib.bib53) ]] , where performance can decrease before improving at larger scales.



Scaling laws for downstream tasks and agent systems have received growing attention. [Zhang et al. [ [2024](https://arxiv.org/html/2601.04748v1#bib.bib54) ]] studied how fine-tuning data scales with model size, while [Kim and others [ [2025](https://arxiv.org/html/2601.04748v1#bib.bib55) ]] derived quantitative principles for agent system scaling, examining trade-offs between agent quantity, coordination structure, and task properties.



Unlike prior work on emergent abilities that focuses on model scale, we study scaling with respect to *action space size* —the number of skills an agent must select among. We show that this scaling is mediated by semantic confusability, connecting LLM behavior to established principles from cognitive psychology [[Hick, [1952](https://arxiv.org/html/2601.04748v1#bib.bib6) , Shepard, [1987](https://arxiv.org/html/2601.04748v1#bib.bib12) , Sweller, [1988](https://arxiv.org/html/2601.04748v1#bib.bib10) ]] .



## Appendix B MAS-to-SAS Compilaton Algorithm

*Algorithm 3 MAS-to-SAS Compilation*


0: Multi-Agent Graph 𝒢 = ( 𝒜 , E ) \mathcal{G}=(\mathcal{A},E) , Compiler Model ℳ LLM \mathcal{M}_{\text{LLM}}

0: Unified Skill Library 𝐒 \mathbf{S}

1: Initialize 𝐒 ← ∅ \mathbf{S}\leftarrow\emptyset { Phase 1: Capability Extraction & Classification }

2: for all Agent a i ∈ 𝒜 a_{i}\in\mathcal{A} do

3: Let ρ i \rho_{i} be the system prompt (role definition)

4: Let τ i \tau_{i} be the set of explicitly assigned tools

5: Analyze Role: Decompose ρ i \rho_{i} into a set of discrete capabilities 𝒞 i = { c 1 , c 2 , … } \mathcal{C}_{i}=\{c_{1},c_{2},\dots\} .

6: for all Capability c k ∈ 𝒞 i c_{k}\in\mathcal{C}_{i} do

7: Determine Backend:

8: if c k c_{k} aligns with a tool t ∈ τ i t\in\tau_{i} then

9: Set ξ k ← t \xi_{k}\leftarrow t {Externalized Skill}

10: Generate π k \pi_{k} : “How to use t t to achieve c k c_{k} under role ρ i \rho_{i} ”

11: else

12: Set ξ k ← ∅ \xi_{k}\leftarrow\emptyset {Internalized Skill}

13: Generate π k \pi_{k} : “Reasoning steps to perform c k c_{k} ”

14: end if

15: Generate Skill Descriptor δ k \delta_{k} (Name + Description)

16: Store s ^ k = ( δ k , π k , ξ k , owner = a i ) \hat{s}_{k}=(\delta_{k},\pi_{k},\xi_{k},\text{owner}=a_{i})

17: end for

18: end for { Phase 2: Topology Internalization (Constraints) }

19: for all Skill s ^ k ∈ extracted skills \hat{s}_{k}\in\text{extracted skills} do

20: Let a src = s ^ k . owner a_{\text{src}}=\hat{s}_{k}.\text{owner}

21: Identify downstream agents: 𝒩 out = { a j ∣ ( a src , a j ) ∈ E } \mathcal{N}_{\text{out}}=\{a_{j}\mid(a_{\text{src}},a_{j})\in E\}

22: if 𝒩 out ≠ ∅ \mathcal{N}_{\text{out}}\neq\emptyset then

23: Generate Handoff Constraint:

24: “Output must be consumable by skills: [ skills of ​ 𝒩 out ] [\text{skills of }\mathcal{N}_{\text{out}}] ”

25: π k ← π k ⊕ Constraint \pi_{k}\leftarrow\pi_{k}\oplus\text{Constraint}

26: end if

27: Add ( δ k , π k , ξ k ) (\delta_{k},\pi_{k},\xi_{k}) to 𝐒 \mathbf{S}

28: end for

29: return 𝐒 \mathbf{S}



## Appendix C Experimental Details


### C.1 Skill Library Examples


Table [4](https://arxiv.org/html/2601.04748v1#A3.T4) presents example skills from each domain in our synthetic skill library. Each skill consists of a unique identifier, a natural language descriptor, and an execution policy.


*Table 4 : Example skills from different domains in our synthetic skill library.*


| Domain | Skill Name | Descriptor |
|---|---|---|
| Mathematics | Calculate Sum | Add all numbers together and return the total sum. |
|  | Calculate Average | Compute the arithmetic mean of the given numbers. |
|  | Calculate Percentage | Compute what percentage one number is of another. |
| Coding | Write Python Function | Write a Python function that implements the specified functionality. |
|  | Debug Code | Find and fix bugs in the provided code snippet. |
| Writing | Write Email | Compose a professional email based on the given requirements. |
|  | Write Summary | Create a concise summary of the provided text. |
| Analysis | Analyze Sentiment | Determine the emotional tone (positive/negative/neutral) of the text. |
|  | Analyze Trend | Identify patterns and trends in the provided data. |
| Extraction | Extract Names | Identify and extract all person names mentioned in the text. |
|  | Extract Dates | Identify and extract all dates mentioned in the text. |
| Translation | Translate to Spanish | Translate the given English text into Spanish. |
|  | Translate to French | Translate the given English text into French. |
| QA | Answer Question | Provide a direct answer to the given question. |
|  | Explain Concept | Explain the given concept in clear, simple terms. |
| Formatting | Convert to JSON | Convert the given data into JSON format. |
|  | Format as Markdown | Format the given content as Markdown. |



### C.2 Task Examples


Table [5](https://arxiv.org/html/2601.04748v1#A3.T5) shows example tasks with their ground-truth skill mappings. Tasks are generated using domain-specific templates with randomized parameters.


*Table 5 : Example tasks with ground-truth skill mappings.*


| Domain | Task Query | Ground Truth |
|---|---|---|
| Mathematics | What is the sum of 23, 45, and 67? | Calculate Sum |
| Mathematics | What is the average of 10, 20, 30, 40, 50? | Calculate Average |
| Mathematics | What is 25% of 200? | Calculate Percentage |
| Coding | Write a Python function to reverse a string. | Write Python Function |
| Coding | Debug this code: def add(a,b): return a-b | Debug Code |
| Writing | Write an email to my manager requesting a meeting. | Write Email |
| Writing | Summarize the following article: [text] | Write Summary |
| Analysis | What is the sentiment of: “I love this product!” | Analyze Sentiment |
| Extraction | Extract names from: “John met Mary at the park.” | Extract Names |
| Extraction | Extract dates from: “Meeting on Jan 15, 2024.” | Extract Dates |
| Translation | Translate to Spanish: “Hello, how are you?” | Translate to Spanish |



### C.3 Competitor Skill Examples


Table [6](https://arxiv.org/html/2601.04748v1#A3.T6) illustrates the base skill and competitor skill design used in H2 experiments. Competitors have near-identical functionality but different surface forms, creating semantic confusability.


*Table 6 : Examples of base skills and their semantic competitors (H2). Competitors have similar functionality but different phrasing.*


| Role | Skill Descriptor |
|---|---|
| Skill Group: Summation |
| Base | Calculate Sum: Add all numbers together and return the total. |
| Competitor 1 | Compute Total: Compute the total by adding all values together. |
| Competitor 2 | Sum Numbers: Sum up all the given numbers. |
| Skill Group: Email Writing |
| Base | Write Email: Compose a professional email. |
| Competitor 1 | Compose Email: Compose an email message. |
| Competitor 2 | Draft Email: Draft an email for the given purpose. |
| Skill Group: Sentiment Analysis |
| Base | Analyze Sentiment: Determine the sentiment of the text. |
| Competitor 1 | Sentiment Detector: Detect the emotional tone. |
| Competitor 2 | Evaluate Sentiment: Evaluate text sentiment. |
| Skill Group: Name Extraction |
| Base | Extract Names: Extract person names from text. |
| Competitor 1 | Find Names: Find all names in the text. |
| Competitor 2 | Name Extractor: Extract names from content. |



### C.4 Policy Complexity Examples


Figure [6](https://arxiv.org/html/2601.04748v1#A3.F6) illustrates the three levels of policy complexity used in H3 experiments, using the “Calculate Sum” skill as an example.



Simple Policy ( ∼ \sim 30 tokens) Execute the addition and return the result.



Medium Policy ( ∼ \sim 100 tokens) You are a mathematical computation assistant.
 1. Parse all numerical values from the input
 2. Validate that all values are valid numbers
 3. Compute the sum of all values
 4. Return the result as a single number



Complex Policy ( ∼ \sim 300 tokens) You are an expert mathematical computation agent.
 Input Processing
 1. Parse all numerical values from the input string
 2. Handle both integers and floating-point numbers
 3. Validate that all extracted values are valid numbers
 Computation
 4. Initialize accumulator to zero
 5. Iterate through all validated numbers
 6. Add each number to the accumulator
 Output Requirements
 7. Return the final sum as a formatted number
 8. Use appropriate decimal precision (2 decimal places)
 9. Handle edge cases: empty input returns 0
 Error Handling
 - If non-numeric values are found, report an error
 - If input is empty, return 0 with a note

 *Figure 6 : Examples of the three policy complexity levels for the “Calculate Sum” skill.*



### C.5 Prompt Templates


##### Flat Selection Prompt.


Figure [7](https://arxiv.org/html/2601.04748v1#A3.F7) shows the prompt template used for flat skill selection in all experiments.


Flat Selection Prompt Select the most appropriate skill for the given task.
 Task: {query}
 Available Skills:
 - skill_001: Calculate Sum: Add all numbers together and return the total.
 - skill_002: Calculate Average: Compute the arithmetic mean of the given numbers.
 - skill_003: Write Email: Compose a professional email.
 - skill_004: Extract Names: Identify and extract all person names from text.
 - skill_005: Translate to Spanish: Translate English text into Spanish.
 Respond with ONLY the skill ID (e.g., skill_001). Do not include any explanation. *Figure 7 : Example flat selection prompt with 5 skills.*



##### Hierarchical Selection Prompts.


Figure [8](https://arxiv.org/html/2601.04748v1#A3.F8) shows the two-stage prompts used for hierarchical selection in H4.



Stage 1: Category Selection Select the most appropriate skill category for this task.
 Task: What is the sum of 23, 45, and 67?
 Available Categories:
 - Summation: Adding numbers together
 - Averaging: Computing mean values
 - Email Writing: Composing emails
 - Sentiment Analysis: Analyzing emotional tone
 - Name Extraction: Extracting names from text
 Respond with ONLY the category name.



Stage 2: Skill Selection within Category Select the most appropriate skill for this task.
 Task: What is the sum of 23, 45, and 67?
 Available Skills in "Summation" category:
 - skill_001: Calculate Sum: Add all numbers together and return the total.
 - skill_002: Compute Total: Compute the total by adding all values.
 - skill_003: Sum Numbers: Sum up all the given numbers.
 Respond with ONLY the skill ID.

 *Figure 8 : Two-stage hierarchical selection prompts used in H4.*


Generated on Thu Jan 8 09:12:36 2026 by [L a T e XML ![Mascot Sammy](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAsAAAAOCAYAAAD5YeaVAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9wKExQZLWTEaOUAAAAddEVYdENvbW1lbnQAQ3JlYXRlZCB3aXRoIFRoZSBHSU1Q72QlbgAAAdpJREFUKM9tkL+L2nAARz9fPZNCKFapUn8kyI0e4iRHSR1Kb8ng0lJw6FYHFwv2LwhOpcWxTjeUunYqOmqd6hEoRDhtDWdA8ApRYsSUCDHNt5ul13vz4w0vWCgUnnEc975arX6ORqN3VqtVZbfbTQC4uEHANM3jSqXymFI6yWazP2KxWAXAL9zCUa1Wy2tXVxheKA9YNoR8Pt+aTqe4FVVVvz05O6MBhqUIBGk8Hn8HAOVy+T+XLJfLS4ZhTiRJgqIoVBRFIoric47jPnmeB1mW/9rr9ZpSSn3Lsmir1fJZlqWlUonKsvwWwD8ymc/nXwVBeLjf7xEKhdBut9Hr9WgmkyGEkJwsy5eHG5vN5g0AKIoCAEgkEkin0wQAfN9/cXPdheu6P33fBwB4ngcAcByHJpPJl+fn54mD3Gg0NrquXxeLRQAAwzAYj8cwTZPwPH9/sVg8PXweDAauqqr2cDjEer1GJBLBZDJBs9mE4zjwfZ85lAGg2+06hmGgXq+j3+/DsixYlgVN03a9Xu8jgCNCyIegIAgx13Vfd7vdu+FweG8YRkjXdWy329+dTgeSJD3ieZ7RNO0VAXAPwDEAO5VKndi2fWrb9jWl9Esul6PZbDY9Go1OZ7PZ9z/lyuD3OozU2wAAAABJRU5ErkJggg==)
](http://dlmf.nist.gov/LaTeXML/)