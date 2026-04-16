---
title: "Coverage-Guided Multi-Agent Harness Generation"
source_url: "https://arxiv.org/abs/2603.08616"
source_type: paper
fetched: 2026-04-15
dimension: harness
authors: []
categories: ["cs.AI"]
arxiv_id: "2603.08616"
---

##### Report GitHub Issue

×

Title:

Content selection saved. Describe the issue below:

Description:

Submit without GitHub Submit in GitHub

[ ![arXiv logo](/static/browse/0.3.4/images/arxiv-logo-one-color-white.svg)
Back to arXiv ](/)

[Why HTML?](https://info.arxiv.org/about/accessible_HTML.html) Report Issue [
Back to Abstract ](/abs/2603.08616v1 "Back to abstract page") [ Download
PDF](/pdf/2603.08616v1 "Download PDF") [ ](javascript:toggleNavTOC\(\);
"Toggle navigation") [ ](javascript:toggleReadingMode\(\); "Disable reading
mode, show header and footer") [ ](javascript:toggleColorScheme\(\); "Toggle
dark/light mode")

  1. Abstract.
  2. 1 Introduction
  3. 2 Preliminaries
     1. Harness Design for Coverage-Guided Fuzzing
     2. Tool-Augmented Reasoning
     3. Multi-Agent LLM Architectures
     4. Model Context Protocol
  4. 3 Agent-Based Harness Generation
     1. 3.1 Static Analysis and Instrumentation
     2. 3.2 Tool-Augmented Exploration
     3. 3.3 Target Research
     4. 3.4 Harness Generation
     5. 3.5 Coverage-Guided Refinement
  5. 4 Evaluation
     1. 4.1 Experimental Setup
     2. 4.2 Coverage Effectiveness
     3. 4.3 Bug Discovery
     4. 4.4 Generation Costs and Agent Behavior
  6. 5 Related Work
     1. Classical Harness Generation
     2. LLM-based Harness Synthesis
  7. 6 Conclusion
     1. Acknowledgements
  8. References

[ License: arXiv.org perpetual non-exclusive license
](https://info.arxiv.org/help/license/index.html#licenses-available)

arXiv:2603.08616v1 [cs.SE] 09 Mar 2026

\setcctype

by

# Coverage-Guided Multi-Agent Harness Generation for Java Library Fuzzing

Nils Loose  [n.loose@uni-luebeck.de](2603.08616v1/mailto:n.loose@uni-
luebeck.de) [0009-0003-6243-1623](https://orcid.org/0009-0003-6243-1623 "ORCID
identifier") University of LübeckInstitute for IT SecurityLübeckGermany ,
Nico Winkel  [nico.winkel@student.uni-
luebeck.de](2603.08616v1/mailto:nico.winkel@student.uni-luebeck.de)
[0009-0008-8538-6892](https://orcid.org/0009-0008-8538-6892 "ORCID
identifier") University of LübeckInstitute for IT SecurityLübeckGermany ,
Kristoffer Hempel  [k.hempel@uni-luebeck.de](2603.08616v1/mailto:k.hempel@uni-
luebeck.de) [0009-0008-9159-4268](https://orcid.org/0009-0008-9159-4268 "ORCID
identifier") University of LübeckInstitute for IT SecurityLübeckGermany ,
Felix Mächtle  [f.maechtle@uni-luebeck.de](2603.08616v1/mailto:f.maechtle@uni-
luebeck.de) [0009-0009-2431-0322](https://orcid.org/0009-0009-2431-0322 "ORCID
identifier") University of LübeckInstitute for IT SecurityLübeckGermany ,
Julian Hans  [julian.hans@student.uni-
luebeck.de](2603.08616v1/mailto:julian.hans@student.uni-luebeck.de)
[0000-0003-0763-3241](https://orcid.org/0000-0003-0763-3241 "ORCID
identifier") University of LübeckInstitute for IT SecurityLübeckGermany and
Thomas Eisenbarth  [thomas.eisenbarth@uni-
luebeck.de](2603.08616v1/mailto:thomas.eisenbarth@uni-luebeck.de)
[0000-0003-1116-6973](https://orcid.org/0000-0003-1116-6973 "ORCID
identifier") University of LübeckInstitute for IT SecurityLübeckGermany

(2026)

###### Abstract.

Coverage-guided fuzzing has proven effective for software testing, but
targeting library code requires specialized fuzz harnesses that translate
fuzzer-generated inputs into valid API invocations. Manual harness creation is
time-consuming and requires deep understanding of API semantics,
initialization sequences, and exception handling contracts. We present a
multi-agent architecture that automates fuzz harness generation for Java
libraries through specialized LLM-powered agents. Five ReAct agents decompose
the workflow into research, synthesis, compilation repair, coverage analysis,
and refinement. Rather than preprocessing entire codebases, agents query
documentation, source code, and callgraph information on demand through the
Model Context Protocol, maintaining focused context while exploring complex
dependencies. To enable effective refinement, we introduce method-targeted
coverage that tracks coverage only during target method execution to isolate
target behavior, and agent-guided termination that examines uncovered source
code to distinguish productive refinement opportunities from diminishing
returns. We evaluated our approach on seven target methods from six widely-
deployed Java libraries totaling 115,000+ Maven dependents. Our generated
harnesses achieve a median 26% improvement over OSS-Fuzz baselines and
outperform Jazzer AutoFuzz by 5% in package-scope coverage. Generation costs
average $3.20 and 10 minutes per harness, making the approach practical for
continuous fuzzing workflows. During a 12-hour fuzzing campaign, our generated
harnesses discovered 3 bugs in projects that are already integrated into OSS-
Fuzz, demonstrating the effectiveness of the generated harnesses.

fuzzing, harness generation, large language models, multi-agent systems,
coverage-guided testing, program analysis, Java

††journalyear: 2026††copyright: cc††ccs: Software and its engineering Software
testing and debugging††ccs: Security and privacy Software security
engineering††ccs: Computing methodologies Machine learning

##  1\. Introduction

Figure 1. Schematic overview of the harness generation workflow. Agents are
ReAct agents with specialized tool access. Schematic overview of the harness
generation workflow. Agents are ReAct agents with specialized tool access. The
Research Agent gathers information about the target method using the javadoc
MCP and code MCP. The generation agent generates an initial harness using the
gathered information with additional query capability. The patching agent
attempts to repair the harness if compilation fails, using compiler error
messages and the code and javadoc MCP to fix any issues. The coverage analysis
agent runs after fuzzing to analyze method-targeted coverage results using the
callgraph MCP. Finally, the refinement agent uses coverage reports and
uncovered code locations to iteratively improve the harness.

Coverage-guided fuzzing has become a fundamental technique for discovering
bugs and vulnerabilities in software systems. When applied to library code,
its effectiveness depends on the availability of high-quality fuzz harnesses.
A harness serves as an adapter between the fuzzer and the target library,
transforming unstructured byte sequences into valid API invocations that
exercise library logic. Manual harness creation remains a significant obstacle
to widespread fuzzing adoption. Developers must understand API contracts,
construct valid object states, synthesize realistic call sequences, and
implement appropriate exception handling. This time-intensive process limits
the number of library APIs that receive comprehensive fuzzing coverage. This
challenge is particularly acute for Java libraries, which remain
underrepresented in continuous fuzzing infrastructure and research, despite
the widespread deployment of Java applications in production systems (LLC,
2025).

Existing automated harness generation approaches face distinct and
complementary limitations. Usage-based methods mine API interaction patterns
from consumer code (Babic et al., 2019; Jeong et al., 2023) but require access
to substantial client corpora that may be unavailable for specialized or newly
released libraries. Structure-based approaches derive harnesses from type
signatures and interface specifications (Green and Avgerinos, 2022; Sherman
and Nagy, 2025) but struggle with implicit preconditions and often rely on
domain-specific heuristics that limit generalizability. Feedback-driven
methods employ iterative refinement based on runtime signals (Zhang et al.,
2023) but typically apply fixed termination thresholds without semantic
interpretation of coverage gaps. Recent LLM-based systems demonstrate progress
through coverage-guided prompt evolution (Lyu et al., 2024) and knowledge
graph augmentation (Xu et al., 2025a). However, these approaches lack
mechanisms for iterative, query-driven exploration during generation.

Large language models (LLMs) present new opportunities for automated harness
generation by combining code synthesis capabilities with domain specific
knowledge. However, directly applying LLMs to this task introduces distinct
challenges. Preprocessing entire API surfaces exhausts available context
windows, particularly for large library ecosystems with extensive dependency
graphs. One-shot generation fails on complex libraries requiring multi-step
initialization sequences or non-obvious preconditions. Coverage-based
refinement risks semantic drift when agents lack mechanisms to interpret what
the coverage gaps represent and whether they indicate addressable deficiencies
or fundamental limitations. These observations suggest that effective harness
generation requires an approach that integrates LLM reasoning with targeted
program analysis, retrieves information on demand rather than preprocessing
entire codebases, and interprets coverage feedback semantically rather than
applying fixed numerical thresholds.

We address these challenges through a multi-agent architecture that decomposes
harness generation into specialized reasoning tasks. Five ReAct (Yao et al.,
2023) agents handle distinct phases of the workflow. The research agent
explores API documentation and source code to understand target method
semantics. The synthesis agent transforms this understanding into initial
harness implementations. The compilation agent diagnoses and repairs build
errors through iterative refinement. The coverage analysis agent interprets
coverage gaps by examining uncovered source code to determine whether further
refinement is worthwhile. The refinement agent modifies harnesses to address
identified coverage deficiencies. Rather than preprocessing entire API
surfaces into static knowledge graphs, agents query information on demand
through the Model Context Protocol (Community, 2025) (MCP). This query-driven
approach retrieves documentation for specific methods, source code for
particular classes, and callgraph fragments rooted at selected invocations.
The design maintains a focused context while exploring large dependency
graphs, enabling autonomous handling of complex build configurations and
iterative compilation repair.

Two technical mechanisms enable effective coverage-guided refinement. First,
we introduce method-targeted coverage instrumentation that activates coverage
tracking (Team, 2025) only during target method execution. Standard
instrumentation measures all executed code, creating misaligned incentives
where harnesses invoke unrelated utility methods to inflate coverage metrics.
Our approach ensures that coverage measurements reflect target behavior rather
than incidental framework initialization. Second, we implement agent-guided
termination that interprets coverage gaps through source code analysis. The
coverage analysis agent examines uncovered methods to distinguish addressable
deficiencies such as missing input variants or unexplored API paths from
fundamental limitations. This interpretation enables the system to stop
refinement when it yields diminishing returns while continuing when concrete
improvement strategies exist.

We evaluate our approach on seven target methods from six widely deployed Java
libraries spanning parsers, JSON processors, and core utilities. The selected
libraries total over 115,000 Maven dependents and represent real-world fuzzing
targets. All targets have existing harnesses in OSS-Fuzz (Serebryany, 2017),
providing strong baselines for comparison. Our generated harnesses achieve a
median improvement of 26% in method-targeted coverage over OSS-Fuzz baselines
and outperform both OSS-Fuzz and Jazzer AutoFuzz (Intelligence, 2025) by 6%
and 5% respectively under full package-scope coverage. Generation costs
average $3.20 and approximately 10 minutes per harness, demonstrating
practical feasibility for integration into continuous fuzzing workflows.
During 12-hour fuzzing campaigns with our harnesses, we discovered 3
previously unreported bugs. These discoveries occurred in methods already
covered by existing OSS-Fuzz harnesses, underlining the harnesses
effectiveness.

In summary, this work makes the following contributions.

  * •

A multi-agent architecture that integrates LLM reasoning with program analysis
to automate harness generation for Java library APIs without requiring
consumer code corpora or manual intervention.

  * •

A query-driven tool interface using the Model Context Protocol that retrieves
precisely scoped and preanalysed program information on demand, preventing
context saturation while enabling exploration of large codebases.

  * •

Method-targeted coverage information with agent-guided termination that
interprets coverage gaps through source code analysis rather than applying
fixed thresholds.

  * •

Empirical validation on widely deployed libraries demonstrating competitive
coverage with manually written baselines, practical generation costs, and
discovery of three previously unreported bugs.

Figure 2. Overview of exposed tools through the model context protocol (MCP).
Overview of exposed tools through the model context protocol (MCP). Three MCP
Servers expose documentation search (Javadoc MCP) using BeautifulSoup, call
graph analysis (Call Graph MCP) using SootUp, and source code search (Code
MCP) using GNU Global. Each MCP exposes a list of tools that can be queried by
agents to retrieve relevant information on demand.

##  2\. Preliminaries

#### Harness Design for Coverage-Guided Fuzzing

Coverage-guided fuzzers generate test inputs by mutating input sequences based
on code coverage feedback. When fuzzing library APIs, a _fuzz harness_ serves
as the entry point that translates fuzzer-generated bytes into valid API
invocations. An effective harness must parse input bytes into appropriate data
types, construct required object states to satisfy API preconditions, invoke
target methods with derived arguments, and handle exceptions appropriately to
distinguish expected error conditions from genuine bugs. The harness design
directly impacts fuzzing effectiveness. A harness that exercises diverse API
paths and satisfies complex preconditions enables the fuzzer to reach deeper
code and discover latent bugs.

#### Tool-Augmented Reasoning

Tool-augmented reasoning equips LLMs with external capabilities they can
invoke during generation (Schick et al., 2023). The ReAct (Reasoning and
Acting) paradigm (Yao et al., 2023) formalizes tool use as an interleaved
process where the model alternates between reasoning steps that generate
natural language explanations of its strategy and action steps that invoke
tools and observe outputs. For code generation, tools typically include
documentation search, source code retrieval, compilation, and test execution.
Rather than providing all information upfront in a single prompt, ReAct agents
query information on demand as their reasoning progresses.

#### Multi-Agent LLM Architectures

Recent work has demonstrated that LLMs can be organized into multi-agent
systems where distinct instances specialize in complementary subtasks (Huang
et al., 2023). Rather than relying on a single monolithic prompt, multi-agent
architectures decompose complex objectives into stages handled by specialized
agents that communicate through structured message passing or a shared state.
This decomposition enables separation of concerns which has been shown to
improve both generation quality and success rates on challenging software
benchmarks (Liu et al., 2024).

#### Model Context Protocol

The Model Context Protocol (Community, 2025) standardizes how LLM agents
access external resources through structured tool interfaces. MCP defines a
client-server architecture where agents act as clients that invoke tools
exposed by servers managing data sources. Each tool accepts structured
parameters and returns formatted responses optimized for LLM consumption. MCP
enables query-driven information retrieval where agents request precisely
scoped information as needed.

##  3\. Agent-Based Harness Generation

We present an agent-based approach to automated fuzzing harness generation
that addresses several fundamental challenges of generating effective
harnesses for complex library APIs. Our approach combines LLM-powered agents
with static analysis and dynamic coverage feedback to iteratively construct
and refine harnesses that achieve deep code coverage. Figure 1 illustrates our
workflow as a sequence of transformations that progressively refine a fuzzing
harness. After initializing the environment by downloading library artifacts
and preparing analysis infrastructure, the workflow proceeds through three
phases: target research to understand API semantics, harness construction
through code generation and compilation, and iterative coverage-guided
refinement. Specialized ReAct agents (Yao et al., 2023) orchestrate each
phase, querying documentation and source code on demand to maintain focused
context while exploring large dependency graphs.

Listing 1: Harness showing selective coverage instrumentation through runtime
control of JaCoCo’s recording state.

[⬇](data:text/plain;base64,cHVibGljIHN0YXRpYyB2b2lkIGZ1enplclRlc3RPbmVJbnB1dCgKICAgICAgRnV6emVkRGF0YVByb3ZpZGVyIGRhdGEpIHsKICAgUlQuZ2V0QWdlbnQoKS5zZXRSZWNvcmRpbmcoZmFsc2UpOwogICAvLyBQYXJhbWV0ZXIvIEluc3RhbmNlIHByZXBhcmF0aW9uCiAgIE9wdGlvbnMgbyA9IHByZXBhcmVPcHRpb25zKGRhdGEpOwogICB0cnl7CiAgICAgIFJULmdldEFnZW50KCkuc2V0UmVjb3JkaW5nKHRydWUpOwogICAgICBQYXJzZXIucGFyc2Uobyk7CiAgICAgIFJULmdldEFnZW50KCkuc2V0UmVjb3JkaW5nKGZhbHNlKTsKICAgfSBjYXRjaCAoSWxsZWdhbEFyZ3VtZW50RXhjZXB0aW9uIHZhcjE1KSB7CiAgICAgICAgUlQuZ2V0QWdlbnQoKS5zZXRSZWNvcmRpbmcoZmFsc2UpOwogICAgICAgIC8vIEV4cGVjdGVkIGV4Y2VwdGlvbgogICAgICB9Cn0=)

1public static void fuzzerTestOneInput(

2 FuzzedDataProvider data) {

3 RT.getAgent().setRecording(false);

4 // Parameter/ Instance preparation

5 Options o = prepareOptions(data);

6 try{

7 RT.getAgent().setRecording(true);

8 Parser.parse(o);

9 RT.getAgent().setRecording(false);

10 } catch (IllegalArgumentException var15) {

11 RT.getAgent().setRecording(false);

12 // Expected exception

13 }

14}

###  3.1. Static Analysis and Instrumentation

Our approach requires three preprocessing artifacts that enable efficient
agent exploration and accurate coverage measurement. First, we extract API
documentation from Javadoc HTML archives distributed with Maven artifacts,
parsing method signatures and parameter descriptions using Beautiful Soup
(Richardson, 2025) to provide agents with concise API contracts indexed for
query-based retrieval. Second, we index the source code using GTAGs (GNU
Project, ), enabling efficient symbol resolution and context retrieval during
agent reasoning. Lastly, we compute a static callgraph rooted at the target
method using SootUp’s Class Hierarchy Analysis (Karakaya et al., 2024),
traversing method invocations to depth 10 (depth 5 for large libraries). Each
node records the method signature, enclosing class, and distance from the
target, serving to scope coverage analysis to reachable methods and provide
agents with structural context about call dependencies. Additionally, we
implement method-targeted coverage instrumentation. Standard coverage
instrumentation measures all executed code, creating a misaligned incentive
for agents to invoke unrelated utility methods. We address this by extending
JaCoCo (Team, 2025) with runtime toggling of coverage tracking, accessible
through the runtime API. Using ASM (Bruneton and the OW2 ASM Team, 2025) for
offline bytecode instrumentation, we wrap target method invocations to enable
coverage recording only during target execution (Listing 1), ensuring metrics
reflect the target’s behavior rather than incidental framework initialization.

Figure 3. Sequence diagram showing initial tool interactions during the
research phase for Jsoup.parse(String). Sequence diagram showing initial tool
interactions during the research phase for Jsoup.parse(String). The research
agent iteratively requests information for the relevant classes and requests
specific method implementations from the relevant MCP servers throughout the
REPL loop.

###  3.2. Tool-Augmented Exploration

We expose preprocessing artifacts to agents through a query-based interface
using the Model Context Protocol (MCP) (Community, 2025), enabling on-demand
retrieval of tailored information as reasoning progresses. We provide three
tool categories: documentation queries, source code retrieval, and callgraph
queries. Figure 2 illustrates the MCP initialization process. Each tool
accepts structured parameters (e.g., class name, method signature) and returns
responses optimized for LLM consumption: concise method signatures, minimal
code snippets, and depth-limited callgraph fragments. To prevent exploration
drift, we restrict tool access based on agent role. Table 1 summarizes tool
availability across the five ReAct agents. All agents have access to
documentation and source code tools for foundational API understanding, while
callgraph tools are restricted to the coverage analysis agent for interpreting
coverage gaps. This role-based access control prevents agents from pursuing
information irrelevant to their current task.

Table 1. Tool availability across agents. MCP tools are provided by three
Model Context Protocol servers.

| Tool | ReAct Agents  
---|---|---  
| RSH | GEN | PAT | CVA | REF  
Docs | method_doc | ✓ | ✓ | ✓ | ✓ | ✓  
class_doc | ✓ | ✓ | ✓ | ✓ | ✓  
package_doc | ✓ | ✓ | ✓ | ✓ | ✓  
list_packages | ✓ | ✓ | ✓ | ✓ | ✓  
list_classes | ✓ | ✓ | ✓ | ✓ | ✓  
list_methods | ✓ | ✓ | ✓ | ✓ | ✓  
Code | get_method_code | ✓ | ✓ | ✓ | ✓ | ✓  
get_class_code | ✓ | ✓ | ✓ | ✓ | ✓  
find_definition | ✓ | ✓ | ✓ | ✓ | ✓  
find_refs | ✓ | ✓ | ✓ | ✓ | ✓  
grep | ✓ | ✓ | ✓ | ✓ | ✓  
| find_symbol | ✓ | ✓ | ✓ | ✓ | ✓  
CG | reach_methods | – | – | – | (✓) | –  
path_to_method | – | – | – | ✓ | –  
Exec | compiler | – | – | (✓) | – | –  
jazzer | – | – | – | (✓) | –  
  
Agents: RSH (Research), GEN (Generation), PAT (Patching), CVA (Coverage
Analysis), REF (Refinement). ✓ = Available, (✓) = Static invocation (not
queryable), – = No access. Categories: Docs (Javadoc API documentation); Code
(source code indexing); CG (call graph analysis); Exec (compiler and fuzzer).

###  3.3. Target Research

Following environment initialization (Maven download, documentation
extraction, callgraph construction), the research agent transforms the target
method signature into contextual knowledge about API semantics. The agent is
initialized with the target method’s signature, documentation, and source
code. Then, the agent can iteratively query additional documentation and
source code through the provided tools. Figure 3 illustrates this query-driven
exploration pattern. Rather than exhaustively extracting all available
information, the agent follows its reasoning to identify relevant patterns:
required initialization sequences, factory method usage, and implicit
preconditions. The agent produces a structured, natural language research
report with predefined markdown sections that organize findings without
constraining content to rigid schemas, accommodating diverse API designs and
model outputs.

Table 2. Benchmark library characteristics. All libraries are widely-deployed in the Maven ecosystem and represent real-world fuzzing targets. Library | Version | Dependents | Class Name | Target Method | Category | Rank  
---|---|---|---|---|---|---  
commons-cli | 1.10.0 | 5K+ | DefaultParser | parse(Options, String[]) | CLI Parser | #1  
gson | 2.13.1 | 27K+ | JsonParser | parseString(String) | JSON Library | #2  
guava | 33.4.8-jre | 42K+ | HostAndPort | fromString(String) | Core Utilities | #1  
jackson-databind | 2.20.0 | 36K+ | ObjectMapper | readTree(String) | JSON Library | #1  
jsoup | 1.21.1 | 4K+ | Jsoup | parse(String) | HTML Parser | #1  
antlr4 | 4.13.2 | 1K+ | Grammar | Grammar(String) | Parser Generator | #1  
Grammar | createParserInterpreter(TokenStream)  
  
###  3.4. Harness Generation

The research report is transformed into compilable code through two sequential
steps: generation and compilation. The generation agent synthesizes initial
harness code that instantiates the target method with fuzzer-generated inputs.
The agent has access to the Jazzer API documentation and queries additional
source code to resolve ambiguities in constructor signatures or factory method
usage. A critical aspect of harness synthesis is exception handling: the agent
must determine which exceptions represent expected API behavior (e.g.,
IllegalArgumentException for invalid inputs) that should be caught to continue
fuzzing, versus unexpected exceptions that indicate bugs and must propagate to
Jazzer’s crash detection. The agent analyzes API documentation and method
signatures to infer expected exception contracts, synthesizing appropriate
try-catch blocks that preserve bug-finding capability. The agent outputs
harness source code and a list of Maven dependencies. Separating research from
generation prevents context saturation: research explores broadly without
committing to code structure, while generation focuses narrowly on producing
syntactically valid harness code.

If the compile step fails, a compilation agent iteratively resolves build
errors by analyzing compiler diagnostics, querying source code and
documentation to understand the root cause, and producing corrected code until
compilation succeeds or an iteration limit is reached. Common error patterns
include missing imports, incorrect method signatures, and improper exception
handling.

###  3.5. Coverage-Guided Refinement

Once compilation succeeds, the compiled harness is instrumented and executed
under fuzzing to collect initial coverage data. An iterative refinement loop
then uses this coverage feedback to improve harness effectiveness through two
collaborative agents: a coverage analysis agent that interprets coverage gaps
and decides whether refinement is worthwhile, and a refinement agent that
modifies the harness.

To seed the coverage analysis, we merge method-level coverage data with the
static callgraph to produce an annotated view showing coverage status for each
reachable method, grouped by call depth from the target. The coverage analysis
agent explores uncovered or partially covered methods by querying their source
code and documentation to determine whether gaps reflect addressable harness
deficiencies (missing input diversity, unexplored API paths) or fundamental
limitations (unreachable defensive code, external I/O dependencies). The agent
then makes a termination decision: stop if further refinement yields
diminishing returns, or continue with a strategy targeting specific uncovered
methods.

If refinement continues, the refinement agent receives the current harness
code, the coverage analysis strategy (priority methods and improvement
rationale), and annotated coverage data. The agent modifies the harness to
exercise uncovered code paths through strategies such as diversifying input
generation, invoking alternative API paths, or triggering exception handlers
through edge-case inputs. The refined harness re-enters compilation and
fuzzing, creating a feedback loop that continues until the coverage agent
determines that the refinement yields diminishing returns or an iteration
limit is reached. Convergence detection through code hashing prevents
oscillation between semantically equivalent harness variants.

##  4\. Evaluation

We evaluate our harness generation approach on widely used Maven libraries,
examining achieved coverage, computational costs, and agent behavior patterns.
Our evaluation demonstrates that the approach produces competitive harnesses
to existing baselines and techniques while maintaining practical generation
costs. Additionally, during the 12-hour fuzzing campaigns with the generated
harnesses, we uncovered multiple previously unknown bugs in mature libraries,
validating their effectiveness in real-world scenarios.

###  4.1. Experimental Setup

Method-Targeted Coverage  

Full Target-Scope Coverage  
commons-cli gson guava jackson-databind jsoup

Figure 4. Coverage comparison across five Java libraries with three runs over
8-hour fuzzing campaigns. Top row: Method-targeted coverage for our generated
harnesses, focusing exclusively on target method execution. Bottom row: Full
target-scope coverage enabling fair comparison with AutoFuzz baseline. Each
plot shows average branch coverage percentage over time with min and max
coverage shown as shaded regions. Coverage comparison across five Java
libraries with three runs over 8-hour fuzzing campaigns. Top row: Method-
targeted coverage for our generated harnesses, focusing exclusively on target
method execution. Bottom row: Full target-scope coverage enabling fair
comparison with AutoFuzz baseline. Each plot shows average branch coverage
percentage over time with min and max coverage shown as shaded regions. In
most cases the generated harnesses outperform both the OSS-Fuzz and AutoFuzz
baselines.

We evaluate on seven target methods from six widely-deployed Java libraries
(Table 2). The selected targets span parsers (commons-cli, jsoup, antlr4),
JSON libraries (gson, jackson-databind), and core utilities (guava). We
compare our generated harnesses against two baselines. OSS-Fuzz (Serebryany,
2017) is Google’s continuous fuzzing service for open source software. All
selected target methods have existing harnesses in OSS-Fuzz. These harnesses
serve as our primary baseline. We additionally compare against Jazzer AutoFuzz
(Intelligence, 2025), an automated harness generation mode built into the
Jazzer coverage-guided fuzzer for the JVM. AutoFuzz leverages Java reflection
to automatically generate harnesses by discovering accessible constructors and
methods, recursively building required objects through structure-aware type
instantiation. Unlike our approach, AutoFuzz operates without program analysis
or coverage feedback, relying solely on runtime reflection to explore the API
surface. For LLM-based comparison, we attempted to use OSS-Fuzz-Gen (LLC,
2025), but encountered implementation issues, primarily in model output
parsing, that prevented successful harness generation for our Java targets
despite several attempts at fixing the underlying issues.

We implement our approach using LangGraph (LangChain, 2025) for workflow
orchestration and Claude 4.5 Sonnet (2025-09-29) as the underlying model.
Harnesses are compiled using Gradle and executed using Jazzer with
instrumented coverage collection.

To measure the effectiveness of fuzzing the targeted method, we measure
coverage under two configurations: (1) method-targeted coverage activates only
during target method execution (Section 3.1), focusing metrics on target
behavior; (2) full target-scope coverage uses standard JaCoCo instrumentation
across the entire library for a fair baseline comparison. All campaigns are
run for 12 hours per target with a single fuzzing thread and an empty seed
corpus.

###  4.2. Coverage Effectiveness

|  
---|---  
(a) Grammar(String) | (b) createParserInterpreter  
Figure 5. Method-targeted coverage for ANTLR4’s two target methods. Method-
targeted coverage for ANTLR4’s two target methods, comparing OSS-Fuzz harness
variants against our generated harnesses.

Figure 4 shows line coverage over time across five Java libraries. The top row
compares method-targeted coverage for our generated harnesses against the OSS-
Fuzz baseline, evaluating focused execution of target method logic. The bottom
row shows full package-scope coverage allowing comparison against AutoFuzz.
Under method-targeted coverage the generated harnesses have a median
improvement of 2626% over the OSS-Fuzz harnesses, demonstrating the
effectiveness of our system in generating harnesses for specific methods. The
temporal dynamics reveal that the primary difference is observable early into
the fuzzing campaign, suggesting that the harness provides better structural
input diversity. Comparing under full target-scope coverage, our generated
harnesses outperform the AutoFuzz and OSS-Fuzz baseline by a median of 55% and
66% respectively. The only target the generated harness does not outperform
the baselines on is jackson-databind, where the OSS-Fuzz harness contains
additional fuzzing logic after the execution of the target method that causes
an increase in the overall coverage.

To demonstrate the benefits of targeted harness generation, we evaluate
ANTLR4, which has two target methods in our benchmark. The existing OSS-Fuzz
harness 111https://github.com/google/oss-
fuzz/blob/master/projects/antlr4-java/GrammarFuzzer.java exercises both
methods sequentially. It creates a Grammar object from fuzzed input, then
invokes createParserInterpreter on the resulting grammar. This sequential
dependency means the parser interpreter is only reached when grammar creation
succeeds without throwing exceptions. We compare our automatically generated
harnesses (each targeting one method individually) against the OSS-Fuzz
harness measured with method-targeted coverage scoped to each target method.
For the Grammar constructor (Figure 5(a)), we evaluate both the unmodified
OSS-Fuzz harness and a manually edited variant that only creates the grammar
without invoking the parser interpreter. For createParserInterpreter (Figure
5(b)), we evaluate only the unmodified OSS-Fuzz harness. Our generated
harnesses outperform the OSS-Fuzz baseline in both scenarios. Most notably,
the OSS-Fuzz harness achieves 0% coverage for createParserInterpreter
throughout the campaign, indicating that grammar creation consistently throws
exceptions before reaching the parser interpreter call. In contrast, our
generated harness successfully exercises this method by synthesizing inputs
that satisfy the grammar constructor’s preconditions. Note that both ANTLR4
campaigns encountered a Jazzer timeout at 30 minutes that terminates Jazzer
execution. However, the coverage trends before termination demonstrate the
performance difference.

###  4.3. Bug Discovery

Beyond coverage metrics, we examine whether our generated harnesses discovers
novel bugs during fuzzing campaigns. Jazzer reports crashes through its
exception handling infrastructure, distinguishing between genuine crashes
(uncaught exceptions indicating bugs) and caught exceptions that represent
normal control flow. This represents a core challenge for the harness
generation, as the generated harnesses must avoid over-catching exceptions
that would mask real bugs while also separating spurious crashes from expected
error handling. Across a single 12-hour fuzzing campaign, the generated
harnesses triggered a total of 14 crashes in two libraries. After manual
investigation, we determined that all reported crashes represent genuine bugs
in the target library. The harnesses correctly identified uncaught exceptions
rather than reporting false positives from expected exception handling. Manual
triage revealed 3 unique bugs:

  * •

commons-cli: Two distinct null pointer exceptions in option parsing logic,
triggered by edge-case combinations of option configurations and malformed
arguments. The crashes manifest in both long-option and short-option code
paths, with 12 total crash artifacts reducing to 2 unique root causes.

  * •

jsoup: One index-out-of-bounds exception in HTML tree building logic,
triggered by complex malformed HTML input (∼1​K​B\sim 1KB). This crash
represents a potential denial-of-service vector, as attackers could craft HTML
to crash the parser. Two crash artifacts correspond to the same underlying
bug.

These results demonstrate that our automatically-generated harnesses achieve
sufficient input diversity and API coverage to discover real bugs in mature,
widely-deployed libraries that already have existing harnesses in the OSS-Fuzz
ecosystem. The fact that Jazzer reported zero false positives highlights the
effectiveness of the harness generation in handling exceptions precisely to
expose genuine bugs without over-catching.

Table 3. Harness generation cost and agent activity across target libraries.
Agent rows show iterations and tool calls, with multiple values indicating
successive refinement rounds.

| Metric | commons-cli | gson | guava | jackson | jsoup | Avg  
---|---|---|---|---|---|---|---  
Total | Tokens | 1896K | 557K | 395K | 1285K | 1039K | 982K  
Cost | $6.25 | $1.81 | $1.34 | $4.13 | $3.32 | $3.20  
Time | 1200s | 337s | 417s | 684s | 551s | 599s  
RES | Iter | 17 | 17 | 16 | 17 | 19 | 17.7  
Tools | 44 | 27 | 23 | 24 | 28 | 30.7  
GEN | Iter | 3 | 2 | 3 | 3 | 4 | 3.1  
Tools | 5 | 2 | 2 | 3 | 4 | 3.4  
PAT | Iter | 5/0/0/0 | 0 | 0/0 | 6/0 | 0/0 | 0.9  
Tools | 11/0/0/0 | 0 | 0/0 | 6/0 | 0/0 | 1.2  
CVA | Iter | 16/14/13/14 | 17 | 4/4 | 18/14 | 14/18 | 12.5  
Tools | 28/22/16/28 | 31 | 4/5 | 21/16 | 24/21 | 18.3  
REF | Iter | 10/7/15 | – | 5 | 8 | 10 | 8.9  
Tools | 19/15/23 | – | 5 | 13 | 22 | 16.1  
  
Agents: RES (Research), GEN (Generation), PAT (Patching), CVA (Coverage
Analysis), REF (Refinement). Iter = ReAct Iterations, Tools = Tool Calls.

###  4.4. Generation Costs and Agent Behavior

Table 3 details the computational costs and agent activity patterns across the
five main targets. Harness generation costs range from $1.34 (guava) to $6.25
(commons-cli), with an average of $3.20 per harness. Generation completes in
an average of 599 seconds, making the approach practical for integration into
iterative fuzzing workflows. Token consumption directly correlates with
workflow complexity. The observed diversity in workflow iterations and agent
loops indicates effective adaptation to target-specific characteristics, with
more complex APIs requiring additional research and refinement cycles while
simpler targets lead to quicker convergence.

Comparing usage patterns between the research agent and the generation agent
reveals that the initial report contains most of the necessary information for
synthesis requiring on average only 3.13.1 iterations until the first harness
is synthesized. Additionally, the patching agent invocation pattern reveals
that, in most cases, the initial synthesis is already correct and only few
targets require repair iterations with all evaluated harnesses compiling
successfully after at most 66 iterations. The coverage analysis and refinement
agents show high variance reflecting target-specific characteristics. This
adaptive behavior demonstrates that our agent-based termination successfully
distinguishes between targets where refinement yields benefits and those where
additional iteration would waste resources.

##  5\. Related Work

#### Classical Harness Generation

Different traditions of program analysis have shaped how fuzzing harnesses are
constructed. Usage-based generation mines valid API calls from existing
consumer code or unit tests, as demonstrated by systems that slice client code
into reusable API snippets (Babic et al., 2019), construct harness stubs from
API dependence graphs (Ispoglou et al., 2020), or inject fuzzed inputs into
test cases (Jeong et al., 2023). While this captures realistic interaction
patterns, it remains dependent on the availability of suitable consumer code.
In contrast, structure-based generation derives harnesses directly from type
signatures and interface specifications, building dataflow graphs to capture
API interactions (Green and Avgerinos, 2022) or introducing intermediate
representations for large-scale libraries (Toffalini et al., 2025; Sherman and
Nagy, 2025). These approaches offer broader applicability but often lack
iterative refinement, leaving adaptation to new targets largely manual.
Feedback-driven generation refines harnesses iteratively using runtime
signals, employing automaton learning on API usage patterns (Zhang et al.,
2023) or validating candidates using compile-time and runtime oracles (Sherman
and Nagy, 2025). While promising, such systems frequently rely on domain-
specific heuristics or fixed coverage thresholds for termination decisions.

#### LLM-based Harness Synthesis

With the availability of large language models, harness generation has been
explored from a learning perspective. Early feasibility studies evaluate
prompting strategies (Zhang et al., 2024) and identify obstacles such as
semantic drift (Jiang et al., 2024). Recent systems demonstrate automatic
synthesis through coverage-guided prompt mutation for iterative refinement
(Lyu et al., 2024), which mutates prompts based on coverage feedback but lacks
semantic interpretation of coverage gaps. CKGFuzzer (Xu et al., 2025a)
augments LLM reasoning with knowledge graphs of API relations, preprocessing
entire API surfaces into static graphs before generation. Other approaches
integrate LLM reasoning into static analysis pipelines (Xu et al., 2025b) or
combine LLM-based repair with solver-driven scheduling (Li et al., 2025).
However, most approaches either preprocess all information upfront (risking
context saturation and prioritizing breadth over target-specific depth) or
lack mechanisms for agents to iteratively query documentation and source code
as reasoning progresses. Our work provides agents with query-based access to
documentation, source code, and callgraph information through the Model
Context Protocol (Community, 2025), enabling on-demand retrieval as reasoning
needs emerge. While practical tools like OSS-Fuzz-Gen (LLC, 2025) employ
comparable multi-agent workflows with generic source access and fixed
iteration counts, we provide specialized static analysis (callgraph
construction, method-targeted coverage) and adaptive orchestration where
coverage analysis agents determine iteration budgets dynamically. We extend
feedback-driven refinement (Lyu et al., 2024; Zhang et al., 2023) by
delegating termination decisions to agents that interpret coverage gaps,
rather than applying fixed thresholds or heuristics.

##  6\. Conclusion

We presented a multi-agent architecture that automates fuzzing harness
generation for Java libraries through specialized ReAct agents and query-
driven code analysis. Five agents decompose the workflow into research,
synthesis, compilation repair, coverage analysis, and refinement, querying
documentation and source code on demand through the Model Context Protocol.
Method-targeted coverage instrumentation and agent-guided termination enable
effective refinement without context saturation.

Evaluation on seven target methods from six widely deployed libraries
demonstrates competitive coverage with OSS-Fuzz baselines at practical costs
of $3.20 and 10 minutes per harness. Our harnesses discovered 3 bugs in
production libraries already integrated into OSS-Fuzz, validating that
automated generation achieves sufficient quality for real vulnerability
discovery. Future work includes extending to the system stateful APIs,
identifying minimal method sets that maximize library coverage to reduce
generation costs, and adapting the approach to synthesize property-based
security harnesses that verify invariants beyond crash detection.

###### Acknowledgements.

This work has been supported by funding from the Agentur für Innovation in der
Cybersicherheit GmbH (Cyberagentur, project SOVEREIGN)

## References

  * D. Babic, S. Bucur, Y. Chen, F. Ivancic, T. King, M. Kusano, C. Lemieux, L. Szekeres, and W. Wang (2019) FUDGE: fuzz driver generation at scale.  In Proceedings of the ACM Joint Meeting on European Software Engineering Conference and Symposium on the Foundations of Software Engineering, ESEC/SIGSOFT FSE 2019,  pp. 975–985.  External Links: [Document](https://dx.doi.org/10.1145/3338906.3340456) Cited by: §1, §5. 
  * É. Bruneton and the OW2 ASM Team (2025) ASM: a java bytecode manipulation and analysis framework Note: Accessed: 10/25 External Links: [Link](https://asm.ow2.io/) Cited by: §3.1. 
  * M. C. P. Community (2025) Model context protocol (mcp): an open protocol for seamless integration between llm applications and external data sources and tools Note: Accessed: 10/25 External Links: [Link](https://github.com/modelcontextprotocol) Cited by: §1, §2, §3.2, §5. 
  * [4] GNU Global Source Code Tagging System Note: Accessed: 10/25 External Links: [Link](https://www.gnu.org/software/global/) Cited by: §3.1. 
  * H. Green and T. Avgerinos (2022) GraphFuzz: library API fuzzing with lifetime-aware dataflow graphs.  In 44th IEEE/ACM 44th International Conference on Software Engineering, ICSE 2022,  pp. 1070–1081.  External Links: [Document](https://dx.doi.org/10.1145/3510003.3510228) Cited by: §1, §5. 
  * D. Huang, Q. Bu, J. M. Zhang, M. Luck, and H. Cui (2023) AgentCoder: multi-agent-based code generation with iterative testing and optimisation.  CoRR abs/2312.13010.  External Links: [Document](https://dx.doi.org/10.48550/ARXIV.2312.13010), 2312.13010 Cited by: §2. 
  * C. Intelligence (2025) Jazzer: fuzz testing for the jvm Note: Accessed: 10/25 External Links: [Link](https://github.com/CodeIntelligenceTesting/jazzer) Cited by: §1, §4.1. 
  * K. K. Ispoglou, D. Austin, V. Mohan, and M. Payer (2020) FuzzGen: automatic fuzzer generation.  In 29th USENIX Security Symposium, USENIX Security 2020,  pp. 2271–2287.  Cited by: §5. 
  * B. Jeong, J. Jang, H. Yi, J. Moon, J. Kim, I. Jeon, T. Kim, W. Shim, and Y. H. Hwang (2023) UTopia: automatic generation of fuzz driver using unit tests.  In 44th IEEE Symposium on Security and Privacy, SP 2023,  pp. 2676–2692.  External Links: [Document](https://dx.doi.org/10.1109/SP46215.2023.10179394) Cited by: §1, §5. 
  * Y. Jiang, J. Liang, F. Ma, Y. Chen, C. Zhou, Y. Shen, Z. Wu, J. Fu, M. Wang, S. Li, and Q. Zhang (2024) When fuzzing meets llms: challenges and opportunities.  In Companion Proceedings of the 32nd ACM International Conference on the Foundations of Software Engineering, FSE 2024,  pp. 492–496.  External Links: [Document](https://dx.doi.org/10.1145/3663529.3663784) Cited by: §5. 
  * K. Karakaya, S. Schott, J. Klauke, E. Bodden, M. Schmidt, L. Luo, and D. He (2024) SootUp: A redesign of the soot static analysis framework.  In Tools and Algorithms for the Construction and Analysis of Systems \- 30th International Conference, TACAS 2024,  Lecture Notes in Computer Science, Vol. 14570,  pp. 229–247.  External Links: [Document](https://dx.doi.org/10.1007/978-3-031-57246-3%5F13) Cited by: §3.1. 
  * LangChain (2025) LangGraph Note: Accessed: 10/25 External Links: [Link](https://github.com/langchain-ai/langgraph) Cited by: §4.1. 
  * Y. Li, W. Yang, Y. Wang, J. Gao, S. Wang, Y. Xue, and L. Zhang (2025) Scheduzz: constraint-based fuzz driver generation with dual scheduling.  CoRR abs/2507.18289.  External Links: [Document](https://dx.doi.org/10.48550/ARXIV.2507.18289), 2507.18289 Cited by: §5. 
  * X. Liu, H. Yu, H. Zhang, Y. Xu, X. Lei, H. Lai, Y. Gu, H. Ding, K. Men, K. Yang, S. Zhang, X. Deng, A. Zeng, Z. Du, C. Zhang, S. Shen, T. Zhang, Y. Su, H. Sun, M. Huang, Y. Dong, and J. Tang (2024) AgentBench: evaluating llms as agents.  In The Twelfth International Conference on Learning Representations, ICLR 2024, Vienna, Austria, May 7-11, 2024,  Cited by: §2. 
  * G. LLC (2025) Oss-fuzz-gen: a framework for fuzz target generation and evaluation Note: Accessed: 10/25 External Links: [Link](https://github.com/google/oss-fuzz-gen) Cited by: §1, §4.1, §5. 
  * Y. Lyu, Y. Xie, P. Chen, and H. Chen (2024) Prompt fuzzing for fuzz driver generation.  In Proceedings of the 2024 on ACM SIGSAC Conference on Computer and Communications Security, CCS 2024,  pp. 3793–3807.  External Links: [Document](https://dx.doi.org/10.1145/3658644.3670396) Cited by: §1, §5. 
  * L. Richardson (2025) Beautiful soup Note: Accessed: 10/25 External Links: [Link](https://www.crummy.com/software/BeautifulSoup/) Cited by: §3.1. 
  * T. Schick, J. Dwivedi-Yu, R. Dessì, R. Raileanu, M. Lomeli, E. Hambro, L. Zettlemoyer, N. Cancedda, and T. Scialom (2023) Toolformer: language models can teach themselves to use tools.  In Advances in Neural Information Processing Systems 36: Annual Conference on Neural Information Processing Systems 2023, NeurIPS 2023, A. Oh, T. Naumann, A. Globerson, K. Saenko, M. Hardt, and S. Levine (Eds.),  Cited by: §2. 
  * K. Serebryany (2017) OSS-Fuzz – google’s continuous fuzzing service for open source software.  In USENIX Security Symposium,  Vancouver, BC.  Cited by: §1, §4.1. 
  * G. Sherman and S. Nagy (2025) No harness, no problem: oracle-guided harnessing for auto-generating C API fuzzing harnesses.  In 47th IEEE/ACM International Conference on Software Engineering, ICSE 2025,  pp. 165–177.  External Links: [Document](https://dx.doi.org/10.1109/ICSE55347.2025.00239) Cited by: §1, §5. 
  * E. Team (2025) JaCoCo: java code coverage library Note: Accessed: 10/25 External Links: [Link](https://github.com/jacoco/jacoco) Cited by: §1, §3.1. 
  * F. Toffalini, N. Badoux, Z. Tsinadze, and M. Payer (2025) Liberating libraries through automated fuzz driver generation: striking a balance without consumer code.  Proc. ACM Softw. Eng. 2 (FSE),  pp. 2123–2145.  External Links: [Document](https://dx.doi.org/10.1145/3729365) Cited by: §5. 
  * H. Xu, W. Ma, T. Zhou, Y. Zhao, K. Chen, Q. Hu, Y. Liu, and H. Wang (2025a) CKGFuzzer: llm-based fuzz driver generation enhanced by code knowledge graph.  In 47th IEEE/ACM International Conference on Software Engineering, ICSE 2025 - Companion Proceedings,  pp. 243–254.  External Links: [Document](https://dx.doi.org/10.1109/ICSE-COMPANION66252.2025.00079) Cited by: §1, §5. 
  * H. Xu, Y. Zhao, and H. Wang (2025b) Directed greybox fuzzing via large language model.  CoRR abs/2505.03425.  External Links: [Document](https://dx.doi.org/10.48550/ARXIV.2505.03425), 2505.03425 Cited by: §5. 
  * S. Yao, J. Zhao, D. Yu, N. Du, I. Shafran, K. R. Narasimhan, and Y. Cao (2023) ReAct: synergizing reasoning and acting in language models.  In The Eleventh International Conference on Learning Representations, ICLR 2023,  Cited by: §1, §2, §3. 
  * C. Zhang, Y. Li, H. Zhou, X. Zhang, Y. Zheng, X. Zhan, X. Xie, X. Luo, X. Li, Y. Liu, and S. M. Habib (2023) Automata-guided control-flow-sensitive fuzz driver generation.  In 32nd USENIX Security Symposium, USENIX Security 2023,  pp. 2867–2884.  Cited by: §1, §5, §5. 
  * C. Zhang, Y. Zheng, M. Bai, Y. Li, W. Ma, X. Xie, Y. Li, L. Sun, and Y. Liu (2024) How effective are they? exploring large language model based fuzz driver generation.  In Proceedings of the 33rd ACM SIGSOFT International Symposium on Software Testing and Analysis, ISSTA 2024,  pp. 1223–1235.  External Links: [Document](https://dx.doi.org/10.1145/3650212.3680355) Cited by: §5. 

Experimental support, please [view the build
logs](./2603.08616v1/__stdout.txt) for errors. Generated by [ L A T E xml
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

