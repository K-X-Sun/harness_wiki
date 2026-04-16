##### Report GitHub Issue

×

Title:

Content selection saved. Describe the issue below:

Description:

Submit without GitHub Submit in GitHub

[ ![arXiv logo](/static/browse/0.3.4/images/arxiv-logo-one-color-white.svg)
Back to arXiv ](/)

[Why HTML?](https://info.arxiv.org/about/accessible_HTML.html) Report Issue [
Back to Abstract ](/abs/2603.20405v1 "Back to abstract page") [ Download
PDF](/pdf/2603.20405v1 "Download PDF") [ ](javascript:toggleNavTOC\(\);
"Toggle navigation") [ ](javascript:toggleReadingMode\(\); "Disable reading
mode, show header and footer") [ ](javascript:toggleColorScheme\(\); "Toggle
dark/light mode")

    1. Abstract
    2. 1 Introduction
       1. Contamination risk.
       2. Outline.
    3. 2 Background and Experimental Setup
       1. 2.1 The rocq-mcp Toolchain
       2. 2.2 Tool Design from miniF2F Analysis
       3. 2.3 Experimental Protocol
    4. 3 Results
    5. 4 Analysis
       1. 4.1 How effective are the MCP tools?
       2. 4.2 How does the multi-agent architecture perform?
       3. 4.3 How do costs scale with problem difficulty?
    6. 5 Discussion
    7. 6 Conclusion
    8. References

[ License: CC BY 4.0
](https://info.arxiv.org/help/license/index.html#licenses-available)

arXiv:2603.20405v1 [cs.LG] 20 Mar 2026

# Putnam 2025 Problems in Rocq  
using Opus 4.6 and Rocq-MCP

Guillaume Baudart  
IRIF, Université Paris Cité, Inria, CNRS  
&Marc Lelarge  
DI ENS, PSL University, Inria  
Tristan Stérin  
PRGM DEV &Jules Viennot  
IRIF, Université Paris Cité, Inria, CNRS  

###### Abstract

We report on an experiment in which Claude Opus 4.6, equipped with a suite of
Model Context Protocol (MCP) tools for the Rocq proof assistant, autonomously
proved 10 of 12 problems from the 2025 Putnam Mathematical Competition. The
MCP tools, designed with Claude by analyzing logs from a prior experiment on
miniF2F-Rocq, encode a _compile-first, interactive-fallback_ strategy. Running
on an isolated VM with no internet access, the agent deployed 141 subagents
over 17.7 hours of active compute (51.6h wall-clock), consuming approximately
1.9 billion tokens. All proofs are publicly
available.111<https://github.com/LLM4Rocq/Putnam2025-Rocq>

##  1 Introduction

The Putnam Mathematical Competition is one of the most prestigious
undergraduate mathematics contests in North America. Until recently, LLM-based
theorem proving relied primarily on models specialized for a single proof
assistant. DeepMind’s AlphaProof [AlphaProof and AlphaGeometry teams,
DeepMind, 2024] pioneered this formal approach, reaching silver-medal level at
the 2024 IMO using reinforcement learning in Lean. Since then, specialized
provers, e.g., DeepSeek-Prover [Xin et al., 2024; Ren et al., 2025], Kimina-
Prover [Wang et al., 2025], Goedel-Prover [Lin et al., 2025], SeedProver [Chen
et al., 2025], and Aristotle [Achim et al., 2025], have pushed performance
further, with Aristotle achieving gold-medal level at the 2025 IMO. All these
systems target Lean and rely on fine-tuning or reinforcement learning. A
striking recent shift is the emergence of _agentic_ approaches built on
general-purpose frontier models: Numina-Lean-Agent [Project Numina, 2025]
solved all 12 Putnam 2025 problems in Lean by pairing Claude with an MCP-based
tool server. This pivot from specialized models to tool-augmented frontier
agents has an important consequence for proof-assistant diversity. Unlike
fine-tuned provers that are heavily trained on Lean code, general-purpose
frontier models have no strong bias toward any single proof language, and
their mathematical reasoning is largely decoupled from the target formalism.
The gap between proof assistants therefore narrows considerably. Our
experiment tests this hypothesis on Rocq (formerly Coq), a proof assistant
that has received far less attention from the LLM community than Lean.

We present a case study in which Claude Opus 4.6 [Anthropic, 2025b],
orchestrated by Claude Code [Anthropic, 2025a], formally verified Putnam 2025
problems in Rocq using _rocq-mcp_ [team, ], a set of eight MCP tools
[Anthropic, 2024] developed with Claude using feedback from a prior experiment
on the miniF2F-Rocq dataset [Viennot et al., 2025]. The Putnam statements were
autoformalized from Numina’s [Project Numina, 2025] and Axiom’s [Axiom Math,
2025] Lean versions, combined with natural-language statements from the Putnam
archive [Kedlaya, ].

#### Contamination risk.

The experiment ran on an isolated VM with web search disabled. Although Lean
solutions exist on GitHub, they were released in December 2025, after the
model’s training cutoff of May 2025.

#### Outline.

In Section 2, we describe the design of rocq-mcp tools, motivated by empirical
analysis of miniF2F logs. In Section 3, we report quantitative results on
Putnam 2025: 10/12 solved, with per-problem breakdowns. In Section 4, we use
Claude to perform an in-depth analysis of the experiment logs, covering tool
use, multi-agent orchestration, scaling, and failure modes.

##  2 Background and Experimental Setup

###  2.1 The rocq-mcp Toolchain

The rocq-mcp server [team, ] exposes eight MCP tools organized in two tiers.

Compilation tools (require only coqc):

    * •

rocq_compile: Full-file compilation with structured error reporting, including
source-line annotations and caret underlines for error positions. This is the
primary verification method: 81% of miniF2F proofs succeeded via direct
compilation alone.

    * •

rocq_verify: Since LLM-generated code cannot be trusted, the proof is wrapped
inside a Rocq module, isolating it from the rest of the file. The tool then
attempts to prove the original theorem statement by applying the theorem
proved inside the module. This sandboxing prevents the LLM from silently
redefining the problem statement or using Admitted. A whitelist of standard
axioms filters out proofs that rely on custom axioms.

    * •

rocq_auto_solve: Attempts standard automation tactics (auto, lia, lra, ring,
field, etc.) as a quick check before manual construction.

Interactive tools (require pet from coq-lsp [Contributors, ]):

    * •

rocq_query: Run Search, Check, Print, or About commands for library
exploration.

    * •

rocq_step / rocq_step_multi: Execute tactics interactively; step_multi tests
up to 20 tactics in parallel without advancing the session.

    * •

rocq_toc / rocq_notations: File structure and notation resolution queries.

These tools encode a _compile-first, interactive-fallback_ strategy identified
through miniF2F log analysis: the agent writes a complete proof file, compiles
it, iterates on errors, and only falls back to interactive stepping for
debugging specific subgoals.

###  2.2 Tool Design from miniF2F Analysis

Prior to the Putnam experiment, we ran Claude Opus 4.6 on the miniF2F-Rocq
benchmark [Viennot et al., 2025] (244 test theorems) with only the Rocq
compiler as a tool. Of the 244 theorems, 198 (81%) were correctly proved: the
agent wrote a complete proof file that compiled and passed manual
verification. The remaining 46 failures fell into categories that each
motivated a specific tool:

    * •

_Invalid proofs_ (20/46): 14 proofs used Admitted and 6 exploited type
redefinition to bypass the theorem statement. These compiled without errors
but were mathematically invalid, motivating a sandboxing mechanism and an
axiom whitelist in rocq_verify.

    * •

_Incomplete proofs_ (15/46): Proofs with open subgoals that the agent could
not detect from compiler output alone, motivating the interactive rocq_step
tool for goal inspection.

    * •

_Other failures_ (11/46): Timeouts, type errors, and import issues. Across all
failures, the agent struggled to locate errors from raw coqc output, often
compiling entire .v files just to run Search commands, motivating rocq_query.
Scope ambiguity (e.g., + in nat_scope vs Z_scope) caused silent type errors,
motivating rocq_notations.

###  2.3 Experimental Protocol

The Putnam 2025 problems were autoformalized from Numina’s [Project Numina,
2025] and Axiom’s [Axiom Math, 2025] Lean versions, combined with natural-
language statements from the Putnam archive [Kedlaya, ]. Each problem is a
standalone .v file containing definitions and a Theorem putnam_2025_XX : ...
Admitted. stub.

The experiment ran on a Docker container with Rocq 9.0, the rocq-mcp server,
and large math libaries (Coquelicot [Contributors, ], math-comp [Contributors,
], and math-comp-analysis [MathComp Analysis Contributors, ]) installed. Web
search was disabled. The user prompt was:

> _Launch an agent team with an expert mathematician, an expert computer
> scientist, an expert in formal verification (Coq/Rocq), and a devil’s
> advocate. Your goal is to solve the 12 theorems in this directory._

Claude Code (orchestrating Claude Opus 4.6) ran autonomously for approximately
3 days, with human intervention limited to resuming sessions after container
crashes and rate-limit pauses.

##  3 Results

Table 1: Per-problem results. Lines = lines of Rocq code. Time = wall-clock from experiment start to successful compilation. ✓ = exploited a loophole in the A3 formalization (later fixed by the agent). Bold None = fully constructive (zero axioms). Problem | Status | Lines | Time | Axioms | Domain  
---|---|---|---|---|---  
A1 | ✓ | 305 | 51m | classical | Number theory  
A2 | ✓ | 308 | 1h 33m | Reals | Real analysis  
A3 | ✓ | 110 | 1h 07m | None | Combinatorics  
A4 | ✓ | 531 | 4h 58m | Reals | Linear algebra  
A5 | ✗ | 2294 | – | – | Enum. combinatorics  
A6 | ✓ | 897 | 19h 56m | None | Number theory  
B1 | ✓ | 570 | 1h 48m | Reals | Geometry  
B2 | ✓ | 513 | 5h 13m | Reals | Real analysis  
B3 | ✓ | 439 | 15h 21m | None | Number theory  
B4 | ✓ | 414 | 3h 46m | None | Combinatorics  
B5 | ✓ | 1455 | 46h 01m | None | Number theory  
B6 | ✗ | 1160 | – | – | Analysis  
  
The agent solved 10 of 12 problems, producing a total of 5,542 lines of
verified Rocq code (Table 1). However, the A3 proof exploited a loophole in
the problem formalization rather than proving the intended mathematical
statement; it was later fixed by the agent in a separate session (see Section
5). Five proofs are fully constructive (A3, A6, B3, B4, B5): they use no
axioms. The remaining solved proofs use standard mathematical axioms
(classical logic, Dedekind Reals).

![Refer to caption](2603.20405v1/x1.png) Figure 1: Cumulative problems solved
over wall-clock time. Solid green segments indicate active compute; dashed red
segments indicate inactivity (API rate limits or user absence). Shaded regions
mark the 7 detected gaps (>>30 min). The first 4 problems were solved within 2
hours; B5 was not solved until 46 hours into the experiment. ![Refer to
caption](2603.20405v1/x2.png) Figure 2: Cumulative problems solved vs.
cumulative tokens consumed (log scale). The first 5 problems required
∼\sim100M tokens; the last 5 required ∼\sim10×\times more, illustrating sharp
diminishing returns on harder problems.

##  4 Analysis

###  4.1 How effective are the MCP tools?

Across the experiment, the agent made 12,427 tool calls. The MCP tools
accounted for approximately 30% of all calls, with rocq_compile being the
dominant verification method (Table 2).

Table 2: MCP tool usage. Tool | Calls | Role  
---|---|---  
rocq_compile |  ∼\sim3,100 | Compilation  
rocq_verify |  ∼\sim120 | Axiom checking  
rocq_auto_solve |  ∼\sim20 | Quick automation  
rocq_query |  ∼\sim80 | Library search  
rocq_step |  ∼\sim450 | Interactive debug  
  
Compile-first confirmed. Every successful proof was ultimately verified via
rocq_compile or direct coqc invocation. The compile-iterate loop (write proof
→\to compile →\to fix errors →\to repeat) was the universal workflow. Across
all problems, compile success rates ranged from 46% (A1) to 58% (A3), with a
median of ∼\sim50%, meaning roughly half of compilation attempts produced
errors that the agent then fixed.

rocq_auto_solve is insufficient for Putnam. Standard automation never solved a
Putnam problem: these require non-trivial mathematical insight, not tactic
search. However, rocq_auto_solve remains useful for simpler problems because
it provides a fast, zero-cost baseline before engaging the LLM: it solves
53/244 (22%) of miniF2F-Rocq test problems.

All proofs were double-checked with rocq_verify. All 10 solved proofs pass
verification with only standard axioms (classical logic, Dedekind Reals,
functional extensionality). However, the module sandbox caused false negatives
on two problems (A3, B1) where custom inductive types could not unify across
the module boundary. A two-phase strategy was later added to rocq-mcp [team, ]
to handle this case.

Interactive tools see targeted use. rocq_step was used almost exclusively on
the three hardest problems (A5, B5, B6), where the agent needed to understand
specific proof states. For the other nine problems, compile-first sufficed.

###  4.2 How does the multi-agent architecture perform?

The orchestrator launched 4 parallel teams of 3 problems each, then spawned a
total of 141 subagents over the experiment. The architecture was strictly two-
level: one orchestrator managing worker subagents (no sub-subagent spawning
observed).

Initial burst. The parallel dispatch was highly effective: 4 problems solved
in 1.8h, 7 in 5.2h (Figure 1).

Specialized follow-up. After the initial teams completed, the orchestrator
spawned targeted agents classified by role (Table 3). Lemma Provers (55
agents, 738M tokens) dominated, reflecting the proof-by-subgoal strategy: once
an overall structure was established, the hard work was proving specific
lemmas. Bug Fixers (36 agents) handled compile-error repair, while Proof
Completers (13 agents) filled in incomplete proof skeletons. Verifiers (15
agents) were used to check axiom-freeness and eliminate unnecessary Admitted
stubs.

Table 3: Subagent roles. Roles are inferred from each agent’s initial prompt. Role | Agents | Tokens | Tool calls  
---|---|---|---  
Lemma Prover | 55 | 738M | 4,845  
Bug Fixer | 36 | 538M | 3,409  
General | 21 | 253M | 1,588  
Verifier | 15 | 65M | 639  
Proof Completer | 13 | 185M | 1,257  
Compiler | 1 | 1M | 14  
Total | 141 | 1,780M | 11,752  
  
Diminishing returns on hard problems. B5 received 82+ subagents and B6
received 91, yet many agents attempted the same core mathematical difficulty
without fundamentally new approaches. An early-termination strategy that
detects when multiple agents fail at the same bottleneck could save
substantial resources.

![Refer to caption](2603.20405v1/x3.png) Figure 3: Subagent efficiency. Each
bubble represents one subagent (141 total, filtered to those with >>10 tool
calls). Position: tokens consumed vs. tool calls (both log scale). Size:
duration. Color: problem assignment.

Mathematical hints matter. Each subagent received multi-paragraph mathematical
proof strategies in its prompt. These hints (e.g., the two-region strategy for
A2’s upper bound, the equilateral triangle construction for B1) were critical
for directing the search. Notably, these hints were generated by the
orchestrator LLM itself, not by a human.

###  4.3 How do costs scale with problem difficulty?

The experiment consumed approximately 1.9 billion tokens at an estimated API
cost of $5,279 (Table 4).

Table 4: Token economics. Category | Tokens | % | Cost | % Cost  
---|---|---|---|---  
Input |  <<1M | 0.0% | $3 | 0.1%  
Output | 16M | 0.9% | $1,217 | 23.1%  
Cache creation | 72M | 3.8% | $1,345 | 25.5%  
Cache read | 1,809M | 95.4% | $2,714 | 51.4%  
Total | 1,897M | 100% | $5,279 | 100%  
  
Output tokens dominate cost. Despite being only 0.9% of token volume, output
tokens account for 23.1% of cost at $75/M, reflecting hundreds of lines of
proof code and extended mathematical reasoning per problem. Cache reads
account for the largest share of cost (51.4%) despite their low per-token
price ($1.50/M), simply due to volume: 95.4% of all tokens are cache reads.

Sharp diminishing returns. The first 5 problems consumed a small fraction of
total tokens; the remaining 5 consumed the vast majority (Figure 2). Table 5
details the budget distribution across difficulty groups.

Table 5: Scaling behavior by problem difficulty. The unsolved problems consumed the most resources. Group | Problems | Active time | Est. tokens  
---|---|---|---  
Easy (A1, A2, A3, B4) | 4 |  << 2h |  ∼\sim100M  
Medium (A4, B1, B2, B3) | 4 |  ∼\sim5h |  ∼\sim400M  
Hard (A6, B5) | 2 |  ∼\sim11h |  ∼\sim600M  
Unsolved (A5, B6) | 2 | – |  ∼\sim800M  
  
Active time vs. wall-clock. Only 17.7h of the 51.6h wall-clock was active
compute. The remaining 33.8h consisted of 7 inactivity gaps caused by API rate
limits and user absence.

##  5 Discussion

The compile-first paradigm. On the Putnam 2025 problems considered here, the
compile-first strategy was sufficient: the compiler provides precise error
messages, and the agent can write and revise complete proof files in a single
pass. Interactive stepping was only useful for debugging specific subgoals,
not for proof discovery. This aligns with our miniF2F findings: 81% of proofs
succeeded without any interactive tools. Whether this holds for more complex
formalization tasks involving large libraries remains an open question.

Cost efficiency. Prompt caching reduced costs by 5.6×5.6\times. The sharp
scaling wall, where unsolved problems consume disproportionate resources,
suggests that better difficulty estimation and early termination could
significantly improve cost efficiency.

Formalization quality matters: the A3 case. Problem A3 is a combinatorial
game: two players alternate moves and the player with no legal move loses. The
initial autoformalization modeled strategies as partial functions (option
state). This encoding had a loophole: the strategy “never move” is vacuously
compatible with any game, so the agent proved Bob wins with a mathematically
trivial argument in 1 h 07 m. When asked to close this loophole, the agent
spent ∼{\sim}9 h attempting to prove the strengthened statement before
concluding the encoding was fundamentally flawed. We then pointed the agent to
an alternative formalization from AxiomProver [Axiom Math, 2025], where the
current player must exhibit a valid move, which closes the loophole by
construction. The agent translated the formalization from Lean to Rocq and
found a correct, fully constructive proof in ∼{\sim}1 h. This episode
illustrates both a strength and a risk of the agentic approach: agents can
detect and exploit formalization gaps, but closing them may require human
guidance on the problem encoding.

##  6 Conclusion

Claude Opus 4.6, equipped with empirically designed MCP tools and a compile-
first multi-agent workflow, solved 10 of 12 Putnam 2025 problems in Rocq. This
result, achieved with a proof assistant that has received far less LLM
attention than Lean, suggests that tool-augmented frontier agents can operate
effectively across proof systems without language-specific training. The A3
episode highlights that formalization quality is a first-class concern in
agentic proving: agents can exploit gaps in problem encodings, and closing
those gaps sometimes requires human guidance. All proofs and the rocq-mcp
toolchain are publicly available [team, 2026, ].

## References

    * T. Achim, A. Best, K. Der, M. Fédérico, S. Gukov, D. Halpern-Leister, K. Henningsgard, Y. Kudryashov, A. Meiburg, M. Michelsen, R. Patterson, E. Rodriguez, L. Scharff, V. Shanker, V. Sicca, H. Sowrirajan, A. Swope, M. Tamas, V. Tenev, J. Thomm, H. Williams, and L. Wu (2025) Aristotle: IMO-level automated theorem proving.  arXiv preprint arXiv:2510.01346.  Cited by: §1. 
    * AlphaProof and AlphaGeometry teams, DeepMind (2024) AI achieves silver-medal standard solving International Mathematical Olympiad problems.  Note: <https://deepmind.google/discover/blog/ai-solves-imo-problems-at-silver-medal-level/> Cited by: §1. 
    * Anthropic (2024) Model context protocol.  Note: <https://modelcontextprotocol.io/> Cited by: §1. 
    * Anthropic (2025a) Claude code: Anthropic’s agentic coding tool.  Note: <https://docs.anthropic.com/en/docs/claude-code> Cited by: §1. 
    * Anthropic (2025b) Claude Opus 4.6.  Note: <https://docs.anthropic.com/en/docs/about-claude/models> Cited by: §1. 
    * Axiom Math (2025) AxiomProver at Putnam 2025.  Note: <https://github.com/AxiomMath/Putnam2025> Cited by: §1, §2.3, §5. 
    * L. Chen, J. Gu, L. Huang, W. Huang, Z. Jiang, A. Jie, X. Jin, X. Jin, C. Li, K. Ma, C. Ren, J. Shen, W. Shi, T. Sun, H. Sun, J. Wang, S. Wang, Z. Wang, C. Wei, S. Wei, Y. Wu, Y. Wu, Y. Xia, H. Xin, F. Yang, H. Ying, H. Yuan, Z. Yuan, T. Zhan, C. Zhang, Y. Zhang, G. Zhang, T. Zhao, J. Zhao, Y. Zhou, and T. H. Zhu (2025) Seed-prover: deep and broad reasoning for automated theorem proving.  arXiv preprint arXiv:2507.23726.  Cited by: §1. 
    * [8] C. Contributors Coq-lsp: language server protocol for rocq.  Note: <https://github.com/ejgallego/coq-lsp> Cited by: §2.1. 
    * [9] C. Contributors Coquelicot: a user-friendly library of real analysis for Coq.  Note: <https://gitlab.inria.fr/coquelicot/coquelicot> Cited by: §2.3. 
    * [10] M. Contributors Mathematical components.  Note: <https://github.com/math-comp/math-comp> Cited by: §2.3. 
    * [11] K. S. Kedlaya The William Lowell Putnam mathematical competition archive.  Note: <https://kskedlaya.org/putnam-archive/> Cited by: §1, §2.3. 
    * Y. Lin, S. Tang, B. Lyu, J. Wu, H. Lin, K. Yang, J. Li, M. Xia, D. Chen, S. Arora, and C. Jin (2025) Goedel-Prover: a frontier model for open-source automated theorem proving.  Cited by: §1. 
    * [13] MathComp Analysis Contributors Mathematical components analysis.  Note: <https://github.com/math-comp/analysis> Cited by: §2.3. 
    * Project Numina (2025) Numina putnam 2025 lean formalization.  Note: <https://github.com/project-numina/Numina-Putnam2025> Cited by: §1, §1, §2.3. 
    * Z. Z. Ren, Z. Shao, J. Song, H. Xin, H. Wang, W. Zhao, L. Zhang, Z. Fu, Q. Zhu, D. Yang, Z. F. Wu, Z. Gou, S. Ma, H. Tang, Y. Liu, W. Gao, D. Guo, and C. Ruan (2025) DeepSeek-Prover-V2: advancing formal mathematical reasoning via reinforcement learning for subgoal decomposition.  arXiv preprint arXiv:2504.21801.  Cited by: §1. 
    * [16] L. team Rocq-mcp: MCP server for Rocq proof development.  Note: <https://github.com/LLM4Rocq/rocq-mcp> Cited by: §1, §2.1, §4.1, §6. 
    * L. team (2026) Putnam 2025 formal proofs in Rocq.  Note: <https://github.com/LLM4Rocq/Putnam2025-Rocq> Cited by: §6. 
    * J. Viennot, G. Baudart, E. J. Gallego Arias, and M. Lelarge (2025) MiniF2F in Rocq: automatic translation between proof assistants.  arXiv preprint arXiv:2503.04763.  Cited by: §1, §2.2. 
    * H. Wang, M. Unsal, X. Lin, M. Baksys, J. Liu, M. Dos Santos, F. Sung, M. Vinyes, Z. Ying, Z. Zhu, J. Lu, H. de Saxcé, B. Bailey, C. Song, C. Xiao, D. Zhang, E. Zhang, F. Pu, H. Zhu, J. Liu, J. Bayer, J. Michel, L. Yu, L. Dreyfus-Schmidt, L. Tunstall, L. Pagani, M. Machado, P. Bourigault, R. Wang, S. Polu, T. Barroyer, W. Li, Y. Niu, Y. Fleureau, Y. Hu, Z. Yu, Z. Wang, Z. Yang, Z. Liu, and J. Li (2025) Kimina-Prover Preview: towards large formal reasoning models with reinforcement learning.  arXiv preprint arXiv:2504.11354.  Cited by: §1. 
    * H. Xin, D. Guo, Z. Shao, Z. Ren, Q. Zhu, B. Liu, C. Ruan, W. Li, and X. Liang (2024) DeepSeek-Prover: advancing theorem proving in LLMs through large-scale synthetic data.  In NeurIPS 2024 Workshop on Mathematical Reasoning,  Cited by: §1. 

Experimental support, please [view the build
logs](./2603.20405v1/__stdout.txt) for errors. Generated by [ L A T E xml
![\[LOGO\]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAsAAAAOCAYAAAD5YeaVAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9wKExQZLWTEaOUAAAAddEVYdENvbW1lbnQAQ3JlYXRlZCB3aXRoIFRoZSBHSU1Q72QlbgAAAdpJREFUKM9tkL+L2nAARz9fPZNCKFapUn8kyI0e4iRHSR1Kb8ng0lJw6FYHFwv2LwhOpcWxTjeUunYqOmqd6hEoRDhtDWdA8ApRYsSUCDHNt5ul13vz4w0vWCgUnnEc975arX6ORqN3VqtVZbfbTQC4uEHANM3jSqXymFI6yWazP2KxWAXAL9zCUa1Wy2tXVxheKA9YNoR8Pt+aTqe4FVVVvz05O6MBhqUIBGk8Hn8HAOVy+T+XLJfLS4ZhTiRJgqIoVBRFIoric47jPnmeB1mW/9rr9ZpSSn3Lsmir1fJZlqWlUonKsvwWwD8ymc/nXwVBeLjf7xEKhdBut9Hr9WgmkyGEkJwsy5eHG5vN5g0AKIoCAEgkEkin0wQAfN9/cXPdheu6P33fBwB4ngcAcByHJpPJl+fn54mD3Gg0NrquXxeLRQAAwzAYj8cwTZPwPH9/sVg8PXweDAauqqr2cDjEer1GJBLBZDJBs9mE4zjwfZ85lAGg2+06hmGgXq+j3+/DsixYlgVN03a9Xu8jgCNCyIegIAgx13Vfd7vdu+FweG8YRkjXdWy329+dTgeSJD3ieZ7RNO0VAXAPwDEAO5VKndi2fWrb9jWl9Esul6PZbDY9Go1OZ7PZ9z/lyuD3OozU2wAAAABJRU5ErkJggg==)
](https://math.nist.gov/~BMiller/LaTeXML/).

## Instructions for reporting errors

We are continuing to improve HTML versions of papers, and your feedback helps
enhance accessibility and mobile support. To report errors in the HTML that
will help us improve conversion and rendering, choose any of the methods
listed below:

    * Click the "Report Issue" ( ) button, located in the page header.

**Tip:** You can select the relevant text first, to include it in your report.

Our team has already identified [the following
issues](https://github.com/arXiv/html_feedback/issues). We appreciate your
time reviewing and reporting rendering errors we may not have found yet. Your
efforts will help us improve the HTML versions for all readers, because
disability should not be a barrier to accessing research. Thank you for your
continued support in championing open access for all.

Have a free development cycle? Help support accessibility at arXiv! Our
collaborators at LaTeXML maintain a [list of packages that need
conversion](https://github.com/brucemiller/LaTeXML/wiki/Porting-LaTeX-
packages-for-LaTeXML), and welcome [developer
contributions](https://github.com/brucemiller/LaTeXML/issues).

BETA

[ ](javascript:toggleReadingMode\(\); "Disable reading mode, show header and
footer")

