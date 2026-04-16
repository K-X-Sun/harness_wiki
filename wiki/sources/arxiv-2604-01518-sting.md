---
date: '2026-04-15'
source_type: paper
tags:
- type-paper
- arxiv-2604-01518
title: Are Benchmark Tests Strong Enough? Mutation-Guided Diagnosis and Augmentation
  of Regression Suites
---

# Are Benchmark Tests Strong Enough? Mutation-Guided Diagnosis and Augmentation of Regression Suites

##### Report GitHub Issue
 ×
Title:
Content selection saved. Describe the issue below:
 Description:
 Submit without GitHub Submit in GitHub
[![arXiv logo](/static/browse/0.3.4/images/arxiv-logo-one-color-white.svg)
 Back to arXiv](/)
 TOC, dark mode, links

[License: arXiv.org perpetual non-exclusive license](https://info.arxiv.org/help/license/index.html#licenses-available)
arXiv:2604.01518v1 [cs.SE] 02 Apr 2026



# Are Benchmark Tests Strong Enough? Mutation-Guided Diagnosis and Augmentation of Regression Suites

Chenglin Li SPEAR Lab, Concordia University Montreal Quebec Canada [chenglin.li@mail.concordia.ca](2604.01518v1/mailto:chenglin.li@mail.concordia.ca) , Yisen Xu SPEAR Lab, Concordia University Montreal Quebec Canada [yisen.xu@mail.concordia.ca](2604.01518v1/mailto:yisen.xu@mail.concordia.ca) , Zehao Wang SPEAR Lab, Concordia University Montreal Quebec Canada [w˙zeha@encs.concordia.ca](2604.01518v1/mailto:w%CB%99zeha@encs.concordia.ca) , Shin Hwei Tan Concordia University Montreal Quebec Canada [shinhwei.tan@concordia.ca](2604.01518v1/mailto:shinhwei.tan@concordia.ca) and Tse-Hsun (Peter) Chen SPEAR Lab, Concordia University Montreal Quebec Canada [peterc@encs.concordia.ca](2604.01518v1/mailto:peterc@encs.concordia.ca)

(5 June 2009)


###### Abstract.

Benchmarks driven by test suites, notably SWE-bench, have become the de facto standard for measuring the effectiveness of automated issue-resolution agents: a generated patch is accepted whenever it passes the accompanying regression tests. In practice, however, insufficiently strong test suites can admit plausible yet semantically incorrect patches, inflating reported success rates. We introduce STING, a framework for targeted test augmentation that uses semantically altered program variants as diagnostic stressors to uncover and repair weaknesses in benchmark regression suites. Variants of the ground-truth patch that still pass the existing tests reveal under-constrained behaviors; these gaps then guide the generation of focused regression tests. A generated test is retained only if it (i) passes on the ground-truth patch, (ii) fails on at least one variant that survived the original suite, and (iii) remains valid under behavior-preserving transformations designed to guard against overfitting. Applied to SWE-bench Verified, STING finds that 77% of instances contain at least one surviving variant. STING produces 1,014 validated tests spanning 211 instances and increases patch-region line and branch coverage by 10.8 and 9.5 percentage points, respectively. Re-assessing the top-10 repair agents with the strengthened suites lowers their resolved rates by 4.2%–9.0%, revealing that a substantial share of previously passing patches exploit weaknesses in the benchmark tests rather than faithfully implementing the intended fix. These results underscore that reliable benchmark evaluation depends not only on patch generation, but equally on test adequacy.


Automated program repair, Benchmark evaluation, Test augmentation, Large language models, SWE-bench
 † † copyright: acmlicensed † † journalyear: 2018 † † doi: XXXXXXX.XXXXXXX † † conference: Make sure to enter the correct conference title from your rights confirmation email; June 03–05, 2018; Woodstock, NY † † isbn: 978-1-4503-XXXX-X/2018/06 † † ccs: Software and its engineering Software maintenance tools † † ccs: Software and its engineering Software testing and debugging

## 1. Introduction


Large language models (LLMs) have recently driven rapid progress in automated issue-resolution agents [(Xia et al. , [2025](#bib.bib36) ; Sonar, [2025](#bib.bib38) ; Gao et al. , [2025](#bib.bib37) ; Dev, [2025](#bib.bib39) ; epam, [2025](#bib.bib40) ; ACoder-AI, [2025](#bib.bib41) ; Warp-dev, [2025](#bib.bib42) ; harness, [2025](#bib.bib43) )] , with benchmarks such as SWE-bench [(Jimenez et al. , [2023](#bib.bib29) )] serving as a primary yardstick. In this evaluation paradigm, a generated patch is accepted whenever it passes a provided set of regression tests. Because of its scalability and reproducibility, this test-based protocol has become the standard basis on which advances in issue resolution are reported.



The reliability of this protocol, however, hinges on a key presupposition: that the regression tests encode the intended behavior of the fix with sufficient completeness. In practice, this assumption seldom holds. Benchmark regression tests are typically authored to confirm the symptoms reported in an issue, not to comprehensively specify the full behavioral intent of the corresponding fix. Consequently, patches that are plausible yet semantically incomplete can still satisfy every test. This phenomenon, often called test-suite overfitting [(Qi et al. , [2015](#bib.bib17) ; Smith et al. , [2015](#bib.bib18) )] , systematically inflates reported agent performance.



Several recent investigations [(Wang et al. , [2025](#bib.bib19) ; Aleithan et al. , [2024](#bib.bib20) ; Yu et al. , [2025](#bib.bib16) )] confirm that even carefully vetted benchmarks such as SWE-bench Verified [(Verified, [August 13, 2024](#bib.bib9) )] accept a non-trivial fraction of behaviorally incorrect patches. As a result, current benchmarks risk equating test passage with semantic correctness, yielding misleading assessments of agent capabilities and potentially misdirecting future research.



Despite growing awareness of this issue, existing countermeasures suffer from three notable shortcomings. First, some studies [(Aleithan et al. , [2024](#bib.bib20) )] depend on manual inspection of patches, identifying incorrect fixes retroactively rather than proactively strengthening the evaluation harness. Second, certain test-generation efforts targeting SWE-bench [(Wang et al. , [2025](#bib.bib19) )] are designed to separate AI-generated patches from human-written ones—a goal that does not directly improve test-suite adequacy. Third, augmentation approaches such as UTBoost [(Yu et al. , [2025](#bib.bib16) )] treat gap detection and test generation as independent steps, omitting a diagnostic phase that would pinpoint which behaviors remain under-specified. Without such diagnosis, newly generated tests risk re-exercising already well-covered functionality while leaving critical behavioral gaps unaddressed. Unifying test-inadequacy diagnosis with targeted test synthesis in a single framework remains an open challenge.



In this work, we contend that more reliable evaluation of issue-resolution agents demands a shift from passively relying on existing test suites to actively strengthening them through adequacy-driven augmentation. We present STING , a framework that uses semantically modified program variants as diagnostic stressors to systematically uncover and repair weaknesses in regression test suites. The central idea is that a variant of the reference patch that passes every existing test yet deviates from the intended semantics reveals an under-constrained behavior in the suite.



STING combines two complementary variant-generation strategies: (1) operator-based mutation, which introduces fine-grained, localized changes via predefined transformation rules, and (2) LLM-based mutation, which produces context-aware modifications that fixed operators alone are unlikely to reach. Variants that survive the original tests then serve as contrastive signals for synthesizing targeted regression tests. Each candidate test must meet three acceptance criteria before being added to the augmented suite: it must (i) pass on the reference patch, (ii) fail on at least one surviving variant, and (iii) remain robust under behavior-preserving transformations and LLM-based screening, thereby avoiding overfitting to implementation-specific details. By tightly integrating diagnosis with augmentation, STING directly addresses the root cause of unreliable benchmark evaluation.



We evaluate STING on SWE-bench Verified, examining both test-suite adequacy and its downstream effect on agent assessment. Our experiments reveal pervasive under-constraining of test suites, with a large majority of benchmark instances accepting incorrect yet test-passing variants. By injecting targeted behavioral checks, the framework produces measurable drops in reported success rates and alters the relative ordering of leading agents. These findings highlight that strengthening evaluation is indispensable for drawing trustworthy conclusions about repair capabilities.



Contributions. This paper makes the following contributions:

- •

Approach. We introduce STING , a variant-guided framework that diagnoses behavioral gaps through surviving program variants and synthesizes targeted tests to eliminate those gaps.
- •

Empirical Study. We carry out a large-scale evaluation on SWE-bench Verified, providing quantitative evidence of widespread test-suite inadequacy and its consequences for evaluation reliability. Our analysis shows that 77% of instances admit at least one surviving variant and identifies four recurring patterns of test weakness: Insufficient Input Space Exploration, Partial Patch Path Coverage, Weak Assertions, and Missing Environmental Context.
- •

Impact on Evaluation. We demonstrate that the augmented tests produced by STING yield more discriminative evaluation: resolved rates of the top-10 repair agents drop by 4.2% to 9.0% on SWE-bench Verified, and the relative ranking of agents on the leaderboard shifts accordingly.
- •

Insights. We analyze the categories of behavioral checks that the generated tests introduce, offering practical guidance on how targeted augmentation improves the detection of incorrect patches.



## 2. Background and Related Work


### 2.1. Background


We study this problem in the context of SWE-bench [(Jimenez et al. , [2023](#bib.bib29) )] , a repository-level benchmark in which each instance pairs an issue description with a reference patch and regression tests drawn from the corresponding pull request. Benchmark construction pipelines generally adopt these developer-submitted tests as-is, without additional review or augmentation of their behavioral coverage. Recent studies have found that a substantial fraction of patches accepted on SWE-bench Verified are behaviorally incorrect [(Wang et al. , [2025](#bib.bib19) ; Aleithan et al. , [2024](#bib.bib20) ; Yu et al. , [2025](#bib.bib16) )] , confirming that this lack of test scrutiny has practical consequences. This raises our central question: *To what extent do SWE-bench regression test suites behaviorally constrain intended fixes, and can we systematically strengthen them?*



Figure [1](#S2.F1) illustrates this problem with a real example from SWE-bench Verified ( django-11276 [(project, [2019](#bib.bib45) )] ). The issue modifies how escape() formats its output. Although this change targets a single function, the new output format also affects urlize() , a downstream function that consumes and reverses the escaped text before processing URLs. The oracle patch updates both functions to keep them consistent. In contrast, the patch submitted by Trae [(Gao et al. , [2025](#bib.bib37) )] updates only escape() , leaving urlize() expecting the old format. This patch passes all existing tests because the developer tests check only the local escape output—no test exercises the downstream URL-processing path.



This example highlights a recurring test weakness: existing tests may accept patches that fix the visible symptom while omitting semantically necessary downstream changes. STING addresses this gap in two steps. First, it generates a surviving variant that mutates the urlize() logic yet still passes all original tests, confirming that the downstream path is unconstrained. Second, guided by this variant, STING generates a test that checks the end-to-end pipeline, feeding an entity through both escape() and urlize() and asserting on the final URL output. This test passes on the oracle patch but fails on the plausible patch, exposing the missing downstream update. By automatically generating targeted tests from surviving variants, STING provides a practical, fully automated mechanism for improving benchmark reliability without requiring manual test authoring or domain-specific knowledge.



(a.) Oracle patch: updates both functions





def escape(text): ... # developer patch modified it to change text’s format
 def urlize(text): ... # developer patch modified it to reverse the format change





(b). Plausible patch (by Trae): patch provided only for escape()





def escape(text): ✓ patch provided
 def urlize(text): × NO patch provided





(c). Developer test: checks escape() output only





assert escape(input) == expected_entity ✓ passes on both patches





(d). Generated test (by STING ): checks both functions





assert escape(input) == expected_entity ✓ passes on both patches
 assert urlize(url_with_entity) == expected_url
 ✓ passes on oracle patch × fails on Trae’s plausible patch

 *Figure 1. Motivating example (simplified django-11276 for easier understanding). The output of escape() is consumed by urlize() . The oracle patch updates both functions, but the plausible patch modifies only escape() . The developer test checks only the local output and passes on both patches, missing the incomplete fix. STING ’s generated test instead exercises the end-to-end pipeline and reveals the missing update in urlize() .*



### 2.2. Related Work


Test Suite Weakness in Coding Benchmarks. The reliability of benchmark-based evaluation is bounded by the strength of its test oracles, a problem first characterized as test-suite overfitting in the APR literature [(Qi et al. , [2015](#bib.bib17) ; Smith et al. , [2015](#bib.bib18) )] , and several countermeasures have been proposed, including anti-pattern filtering [(Tan et al. , [2016](#bib.bib7) )] and differential test generation [(Xin and Reiss, [2017](#bib.bib5) ; Yang et al. , [2017](#bib.bib6) )] . Recent studies confirm that this risk persists at scale. On SWE-bench Verified, 29.6% of plausible patches are behaviorally incorrect [(Wang et al. , [2025](#bib.bib19) )] , and resolution rates drop significantly after filtering weak tests [(Aleithan et al. , [2024](#bib.bib20) ; Yu et al. , [2025](#bib.bib16) )] . Beyond issue benchmarks, EvalPlus [(Liu et al. , [2023](#bib.bib21) )] reveals 15–20% pass-rate drops on HumanEval [(Chen et al. , [2021](#bib.bib22) )] and MBPP [(Austin et al. , [2021](#bib.bib23) )] under strengthened tests. These findings establish that weak test oracles are a systemic bottleneck across benchmark paradigms, motivating automated approaches to strengthen them.



Mutation Testing. Mutation testing assesses test suite adequacy by injecting small syntactic faults and checking whether tests detect them [(Jia and Harman, [2010](#bib.bib10) ; Ojdanic et al. , [2023](#bib.bib11) )] . Classical operator-based tools such as Mutpy [(Hałas, [2014](#bib.bib2) )] , Mutmut [(Hovmöller, [2018](#bib.bib1) )] , and Cosmic Ray [(Bingham and Smallshire, [2016](#bib.bib3) )] apply predefined operators to individual constructs, while higher-order mutation composes multiple operators to approximate real faults [(Langdon et al. , [2010](#bib.bib13) )] . More recently, LLM-based approaches such as μ \mu BERT [(Degiovanni and Papadakis, [2022](#bib.bib14) )] and LLMorpheus [(Tip et al. , [2025](#bib.bib15) )] generate context-sensitive, naturalistic mutants that extend the behavioral space beyond what fixed operators can reach. STING leverages both strategies but shifts the role of mutation from assessment to targeted diagnosis and augmentation: surviving variants serve as diagnostic signals that drive focused test generation.



Test Augmentation and Oracle Improvement. Approaches to strengthening test suites can be broadly grouped by their generation strategy. Search-based tools, such as EvoSuite [(Fraser and Arcuri, [2011](#bib.bib27) )] and Pynguin [(Lukasczyk and Fraser, [2022](#bib.bib26) )] , optimize for structural coverage criteria. LLM-based approaches generate semantically richer tests by conditioning on code context and natural-language specifications [(Lemieux et al. , [2023](#bib.bib28) ; Yuan et al. , [2024](#bib.bib25) )] . In the APR context, Xin and Reiss [(Xin and Reiss, [2017](#bib.bib5) )] generate tests via symbolic execution to distinguish correct patches from overfitted ones, and Yang et al. [(Yang et al. , [2017](#bib.bib6) )] use specification-guided generation for patch assessment. For oracle quality specifically, Jahangirova et al. [(Jahangirova et al. , [2016](#bib.bib48) )] use mutation testing to identify false positives and false negatives in existing oracles, and Xie [(Xie, [2006](#bib.bib49) )] augments test suites with regression oracle checking by capturing object states and asserting on observer methods. EvalPlus [(Liu et al. , [2023](#bib.bib21) )] augments function-level benchmarks with LLM- and mutation-based test input generation.



Three recent works are most closely related to STING . Wang et al. [(Wang et al. , [2025](#bib.bib19) )] identify behaviorally incorrect patches on SWE-bench Verified through retrospective empirical analysis, but do not generate stronger tests to prevent such patches from being accepted. Meta’s ACH [(Harman et al. , [2025](#bib.bib53) )] combines mutation and LLM-based test generation, but targets production-level regression hardening where fault classes are provided by engineers rather than discovered automatically. UTBoost [(Yu et al. , [2025](#bib.bib16) )] is most directly comparable, generating tests from code context and issue descriptions to strengthen SWE-bench evaluation. Unlike STING , however, its weakness detection and test validation are both coupled to the availability of agent-generated patches, making adequacy assessment dependent on the particular agents under evaluation rather than an independent property of the benchmark.



All prior approaches share an important intuition: additional tests can reveal errors missed by the original suite. What they do not address is where the existing test suite is behaviorally insufficient, which semantic regions remain under-constrained, and which of those regions would benefit most from additional testing. Without this diagnostic step, generated tests may redundantly exercise already well-tested behaviors while leaving critical gaps untouched. STING addresses this limitation by decoupling weakness identification from test generation. It first uses program variants to diagnose under-constrained behaviors, then uses the resulting surviving variants as contrastive signals for targeted test synthesis. Finally, it validates generated tests through behavior-preserving transformations to guard against overfitting to the oracle patch. This end-to-end process, from diagnosis to generation to validation, distinguishes STING from prior work that treats test generation and oracle assessment as separate concerns.


![Refer to caption](2604.01518v1/x1.png)
 *Figure 2 . Overview of the STING framework.*



## 3. Approach


To address under-constrained regression test suites in real-world issue benchmarks, we propose STING : a diagnostic-driven test augmentation framework. Given a verified reference patch P g ​ t P_{gt} and its associated regression test suite T T , STING produces an augmented suite T ′ ⊇ T T^{\prime}\supseteq T that more tightly constrains the intended behavior of the fix. A strong test suite should not only accept the correct fix, but also *reject* plausible yet incorrect alternatives. STING operationalizes this intuition by using semantically modified variants of P g ​ t P_{gt} as diagnostic stressors: if a variant passes all tests in T T despite deviating from P g ​ t P_{gt} , it reveals a behavioral gap in the suite. STING then generates targeted tests to close that gap.



Figure [2](#S2.F2) illustrates the overall workflow of STING . Given P g ​ t P_{gt} and T T , STING proceeds through four stages: (1) Program Variant Generation produces semantically modified variants of P g ​ t P_{gt} that are syntactically valid and interface-compatible (§ [3.1](#S3.SS1) ); (2) Assessing Test Adequacy via Program Variants executes T T against each variant, collecting those that pass as evidence of behavioral gaps (§ [3.2](#S3.SS2) ); (3) Program Variant-Guided Test Generation generates new tests guided by the surviving variants as contrastive signals (§ [3.3](#S3.SS3) ); and (4) Test Validation and Selection ensures generated tests pass on P g ​ t P_{gt} while rejecting at least one surviving variant, admitting only behaviorally meaningful additions to T ′ = T ∪ T n ​ e ​ w T^{\prime}=T\cup T_{new} (§ [3.4](#S3.SS4) ).


*Table 1. Mutation operators derived from established testing tools and research.*


| Category | Operator | Transformation Example | Source |
|---|---|---|---|
| Predicate & Boolean Logic | condfalse | condition → \rightarrow False | ( Hovmöller , 2018 ) |
| condtrue | condition → \rightarrow True | ( Hovmöller , 2018 ) |
| condflip | negate predicate | ( Bingham and Smallshire , 2016 ) |
| boolswap | and ↔ \leftrightarrow or | ( Hovmöller , 2018 ; Bingham and Smallshire , 2016 ; Hałas , 2014 ) |
| boollit | replace boolean literal | ( Hovmöller , 2018 ; Bingham and Smallshire , 2016 ; Hałas , 2014 ) |
| eqflip | == ↔ \leftrightarrow != | ( Hovmöller , 2018 ; Bingham and Smallshire , 2016 ; Hałas , 2014 ) |
| cmpbound | ¿ ↔ \leftrightarrow ¿= | ( Hovmöller , 2018 ; Bingham and Smallshire , 2016 ; Hałas , 2014 ) |
| Arithmetic & Numeric | numlit | modify numeric literal | ( Hovmöller , 2018 ; Bingham and Smallshire , 2016 ; Hałas , 2014 ) |
| strlit | modify string literal | ( Hovmöller , 2018 ) |
| arithop | change arithmetic operator | ( Bingham and Smallshire , 2016 ; Hałas , 2014 ) |
| none2zero | None → \rightarrow 0 | ( Hałas , 2014 ) |
| len2zero | len(x) → \rightarrow 0 | ( Hałas , 2014 ) |
| len2one | len(x) → \rightarrow 1 | ( Hałas , 2014 ) |
| Return & Default | retNone | return x → \rightarrow return None | ( Bingham and Smallshire , 2016 ; Hałas , 2014 ) |
| pass2none | pass → \rightarrow return None | ( Hałas , 2014 ) |
| Loop & Iteration | reverseloop | reverse iteration order | ( Bingham and Smallshire , 2016 ) |
| brkcont | break ↔ \leftrightarrow continue | ( Hovmöller , 2018 ; Bingham and Smallshire , 2016 ; Hałas , 2014 ) |
| oneloop | limit loop to single iteration | ( Bingham and Smallshire , 2016 ) |
| zeroloop | skip loop body | ( Bingham and Smallshire , 2016 ) |
| rangepp | modify range bounds | ( Hałas , 2014 ) |
| Data Access & Slicing | listidx | modify list indexing | ( Hałas , 2014 ) |
| dictget | dict[k] → \rightarrow dict.get(k) | ( Hałas , 2014 ) |
| slicedel | remove slice operation | ( Hałas , 2014 ) |
| sliceleft | modify slice start | ( Bingham and Smallshire , 2016 ; Hałas , 2014 ) |
| sliceright | modify slice end | ( Bingham and Smallshire , 2016 ; Hałas , 2014 ) |
| Exception Handling | exctype | change exception type | ( Bingham and Smallshire , 2016 ) |
| excswallow | raise E → \rightarrow pass | ( Bingham and Smallshire , 2016 ) |
| Structural Transformations | decdel | delete decorator | ( Bingham and Smallshire , 2016 ; Hałas , 2014 ) |
| compfilterdel | [x for x in L if p] → \rightarrow [x for x in L] | ( Bingham and Smallshire , 2016 ; Hałas , 2014 ) |
| unaryop | modify unary operator | ( Bingham and Smallshire , 2016 ; Hałas , 2014 ) |
| bitwiseop | modify bitwise operator | ( Bingham and Smallshire , 2016 ; Hałas , 2014 ) |
| augassign | modify augmented assignment | ( Hovmöller , 2018 ; Bingham and Smallshire , 2016 ; Hałas , 2014 ) |



### 3.1. Program Variant Generation


STING generates a set of *program variants* by applying controlled mutations to the reference patch P g ​ t P_{gt} . These variants act as behavioral probes: variants that pass all tests in T T but differ from P g ​ t P_{gt} reveal gaps in the test suite. To focus on behavior introduced by the fix, STING restricts all transformations to the *patch region* , defined by the location of the modified lines in P g ​ t P_{gt} . If the modified lines fall inside a function body, the patch region is defined as the enclosing function, allowing access to relevant surrounding logic (e.g., branches and return paths). If the patch spans multiple functions, each function is treated as a separate patch region. For patches outside any function (e.g., module-level statements), the patch region consists of the modified lines.


![Refer to caption](2604.01518v1/x2.png)
 *Figure 3 . Simplified Prompt template used in LLM-based Mutation*



STING generates program variants using two complementary strategies and filters them to retain only valid and informative ones, yielding the final set V V .



(i) Operator-based Mutation. STING applies 32 predefined mutation operators to the patch region to produce fine-grained, interpretable variations (Table [1](#S3.T1) ), spanning seven categories. These operators are adapted from widely used Python mutation testing tools, Mutmut [(Hovmöller, [2018](#bib.bib1) )] Mutpy [(Hałas, [2014](#bib.bib2) )] and Cosmic Ray [(Bingham and Smallshire, [2016](#bib.bib3) )] . Prior empirical studies have shown that these operators can effectively induce meaningful semantic changes in Python programs [(Guerino et al. , [2024](#bib.bib52) )] . For each patch and each transformation type, STING performs 10 independent mutation attempts. In each attempt, the transformation is applied only if the patch region contains at least one compatible code location (e.g., eqflip requires a comparison expression). When multiple compatible locations are available, STING randomly selects one and applies the transformation, producing one variant per attempt. Each run produces one variant with a single-site modification.



(ii) LLM-based Mutation. To explore higher-level behavioral in addition to operator-based mutation, STING prompts an LLM with the issue description, P g ​ t P_{gt} , and the existing tests T T . As shown in Figure [3](#S3.F3) , the prompt instructs the model to generate interface-compatible program variants that differ in behavior from P g ​ t P_{gt} , such as altering conditional logic, adjusting boundary handling, or restructuring control flow. The existing tests T T are provided so that the model can reason about which behaviors are already constrained and target deviations more likely to survive the current suite. The prompt further excludes trivial bypass patterns (e.g., unconditional returns) and pure refactoring, as such changes do not represent meaningful behavioral deviations. Unlike operator-based mutation, LLM-based mutation can introduce coordinated changes across multiple program elements, such as jointly modifying a predicate and its corresponding return value. For each instance, we query the LLM 10 times with the same prompt. If a response duplicates a previously generated variant, it is discarded and re-queried to ensure diversity.


*Algorithm 1 Identifying Surviving Variants*


1: Program variant set V V , regression test suite T T

2: Surviving variant set V s V_{s}

3: V s ← ∅ V_{s}\leftarrow\emptyset

4: for all v ∈ V v\in V do

5: 𝑟𝑒𝑠𝑢𝑙𝑡 ← RunTests ​ ( T , v ) \mathit{result}\leftarrow\textsc{RunTests}(T,v)

6: if 𝑟𝑒𝑠𝑢𝑙𝑡 \mathit{result} contains environment errors or timeouts then

7: continue

8: end if

9: if 𝑟𝑒𝑠𝑢𝑙𝑡 \mathit{result} passes all tests in T T then

10: V s ← V s ∪ { v } V_{s}\leftarrow V_{s}\cup\{v\}

11: end if

12: end for

13: return V s V_{s}



#### Post-processing.


Although our mutation operators are designed to induce genuine semantic changes, and our LLM-based guidelines explicitly encourage behaviorally divergent program variants, it is still difficult to guarantee that all generated variants represent meaningful behavioral deviations. Some may be syntactically different but semantically equivalent to the oracle patch, which would create false signals of test weakness and introduce noise into downstream test generation. To ensure that only genuinely divergent variants guide test synthesis, we apply three layers of filtering. First, duplicates and variants that modify only superficial elements,such as comments, formatting, docstrings, and logging messages, are discarded. Second, following Tian et al. [(Tian et al. , [2024](#bib.bib31) )] , who demonstrated that LLMs can effectively distinguish equivalent from non-equivalent mutants, we use their prompting template to screen each variant and remove those classified as equivalent rewrites. Third, a structural diff filter retains only variants whose modifications align with the oracle patch in scope (same modified files, no additional hunks) and whose normalized code changes are not reducible to identifier renaming, message reformatting, or code motion. After these steps, the remaining variants form V V .



### 3.2. Assessing Test Adequacy via Program Variants


STING assesses the adequacy of T T by executing each program variant v ∈ V v\in V against the full regression test suite and identifying those that pass. A variant that passes all tests in T T but violates the intended behavior of P g ​ t P_{gt} is a *surviving variant* , indicating that T T could not distinguish it from the reference patch.



Algorithm [1](#alg1) describes this procedure. For each variant v ∈ V v\in V , STING executes T T and records the result (Lines 2–3). Executions that fail due to environment errors or timeouts are discarded (Lines 4–6), as they are not attributable to program logic. Variants that fail at least one test are excluded, since their behavioral deviation is already detected by T T . Finally, variants that pass all tests are collected into the *surviving variant set* V s V_{s} (Lines 7–9).



V s V_{s} highlights the potential behavioral gaps in T T , which are the program behavior that the existing tests fail to constrain. STING uses these surviving variants as diagnostic signals to guide targeted test generation in the next stage.


![Refer to caption](2604.01518v1/x3.png)
 *Figure 4 . Simplified prompt template used in targeted test generation.*



### 3.3. Program Variant-Guided Test Generation


STING generate additional test cases to address the behavioral gaps revealed by V s V_{s} . STING uses surviving program variants as guidance: each variant identifies a concrete behavioral difference that T T fails to detect, providing a target for test generation.



STING employs an LLM-based test generator that takes as input P g ​ t P_{gt} , a surviving variant v s v_{s} , the existing tests T T , and project test file snippets for style alignment. We adopt a *contrastive reasoning* strategy [(Chia et al. , [2023](#bib.bib4) )] , implemented through a structured prompt (Figure [4](#S3.F4) ). The test generator first analyzes how v s v_{s} deviates from the intended behavior of P g ​ t P_{gt} , then identifies scenarios where existing tests fail to distinguish them, and finally produces targeted regression tests for those scenarios.



To reduce the risk that generated tests depend on implementation artifacts rather than behavioral differences, STING restricts all generated tests to interact only through the program’s public methods. This design choice encourages generated tests to validate externally observable behavior instead of superficial implementation details. By targeting such inputs or execution conditions, the generated tests are more likely to reveal behaviors that are not sufficiently constrained by the current test suite.



To ensure the generated tests are meaningful and consistent with the intended behavior, we enforce the following two principles:



(1) Behavioral Differentiation. Each generated test must produce different observable outcomes when executed on P g ​ t P_{gt} and at least one surviving variant in V s V_{s} , thereby exposing semantic discrepancies.



(2) Intent Alignment. P g ​ t P_{gt} serves as the authoritative oracle: a generated test is accepted only if it passes on P g ​ t P_{gt} , ensuring consistency with the intended behavior of the fix.



Because a single v s v_{s} may expose multiple behavioral differences from P g ​ t P_{gt} , STING allows the LLM to produce multiple test cases per contrastive query, each targeting a different aspect of the deviation. Finally, STING produces a candidate test set T c ​ a ​ n ​ d ​ i ​ d ​ a ​ t ​ e T_{candidate} that targets behavioral regions previously overlooked by T T .



### 3.4. Test Validation and Selection


Before incorporating any candidate test into the augmented suite, STING validates it against three criteria. This validation is designed to ensure that retained tests are consistent with the intended behavior of P g ​ t P_{gt} , add genuinely new behavioral constraints, and do not overfit superficial implementation details. Each test must therefore satisfy three criteria:



Correctness. A generated test must pass on P g ​ t P_{gt} , ensuring consistency with the intended behavior of the fix. Tests that fail on P g ​ t P_{gt} are discarded.



Effectiveness. STING retains a test only if it exposes new behavioral discrepancies. It executes each candidate test on the surviving variants V s V_{s} and keeps the test only if it fails on at least one variant, indicating that it constrains behavior not covered by T T .



Robustness to Test Overfitting. Prior studies have shown that LLM-generated code can be sensitive to superficial features of the input context, such as identifier names and code structure [(Gao et al. , [2023](#bib.bib51) ; Wang et al. , [2023](#bib.bib50) )] . In the test generation setting, this means generated tests may inadvertently encode implementation-specific properties, such as specific variable names or control-flow patterns, rather than observable program behavior. As a result, they may incorrectly reject semantically equivalent implementations. To detect such overfitting tests, STING applies behavior-preserving transformations to P g ​ t P_{gt} , including identifier renaming, operand swapping, and control-flow restructuring (Table [2](#S3.T2) ). Because these transformations preserve semantics, a valid test should pass on all transformed variants. Tests that fail on any such variant are discarded, as they likely depend on superficial artifacts rather than program behavior. In addition to transformation-based filtering, STING uses an LLM-based screening step that classifies each retained test as either a valid behavioral strengthening or an implementation-specific check tied to the oracle patch. Tests classified as implementation-specific are discarded.


*Table 2 . Behavior-preserving transformations used in robustness validation [(Hort et al. , [2025](#bib.bib47) )] .*


| Transform | Description |
|---|---|
| Replace names | Consistently renames functions, classes, variables, parameters, etc. while preserving scope. |
| Swap operands | Swaps the operands of simple binary comparisons, e.g. a < b → \to b > a , x == y → \to y == x . |
| Reorder statements (*) | Reorders independent local statements that have no data dependencies. |
| Split if-conditions | Splits compound conditions into nested if-statements while preserving short-circuit semantics. |
| Combine if-statements | Merges consecutive if-statements into a single compound condition, preserving evaluation order. |
| ConExpr ↔ \leftrightarrow If-else | Converts ternary conditional expressions into multi-line if-else blocks and vice versa. |
| For ↔ \leftrightarrow While (*) | Transforms for-loops into equivalent while-loops and vice versa. |
| Arithmetic transform | Converts augmented assignments to expanded form and vice versa, e.g. x += 1 ↔ \leftrightarrow x = x + 1 . |
| ListComp ↔ \leftrightarrow ForLoop (*) | Rewrites list comprehensions into equivalent explicit for-loops and vice versa. |
| Boolean simplify (*) | Simplifies boolean expressions, e.g. x is True → \to x , not (x > y) → \to x <= y . |
| FString ↔ \leftrightarrow Format | Converts f-strings into equivalent .format() calls and vice versa. |



## 4. Evaluation


In this section, we evaluate STING by answering four research questions (RQs).



Benchmark. We conduct our evaluation on SWE-bench Verified [(Verified, [August 13, 2024](#bib.bib9) )] , a curated benchmark of 500 real-world software issues collected from widely used open-source Python repositories. We select this benchmark for two reasons. First, its evaluation relies entirely on the provided regression tests T T . The strength of T T directly determines whether benchmark results faithfully reflect patch correctness, making test adequacy a first-class concern. Second, its official evaluation harness executes tests in isolated Docker environments, enabling reproducible experimentation at scale.



Implementation. All LLM-based components (variant generation and test synthesis) use GPT-5-mini ( gpt-5-mini-2025-08-07 , reasoning level: medium), chosen for its balance of code reasoning ability and cost at scale. For operator-based mutation, all 32 operators are applied to compatible sites within the patch region, with each operator executed for 10 attempts using randomly sampled transformation sites. For LLM-based mutation, 10 independent variants are generated per instance; duplicate responses are discarded and re-queried.



### RQ1: What behavioral gaps exist in SWE-bench regression tests?


Motivation. Regression test suites may fail to fully constrain the intended behavior of a fix: a program variant can pass all tests while still violating the intended semantics of the reference patch. Such cases indicate that the benchmark silently accepts incorrect implementations. In this RQ, we study how often this occurs and which behavioral gaps enable such variants to survive, which is critical for assessing the reliability of existing benchmarks.



Approach. We apply both operator-based and LLM-based mutation (§ [3.1](#S3.SS1) ) to all 500 instances in SWE-bench Verified. For each instance, we execute the existing regression tests T T against each generated variant and collect the surviving variant set V s V_{s} .



First, to measure how often test suites fail to fully constrain program behavior in SWE-bench Verified, we count the number of program variants that survive the existing tests. Specifically, we report the number of surviving variants and the number of affected issues for each variant generation method, including operator-based mutation, LLM-based mutation, and their combination after deduplication.



Second, to understand why program variants survive , we analyze the types of behavioral gaps that allow them to pass existing tests. We first examine the distribution of surviving operator-based variants across mutation categories (Table [4](#S4.T4) ) to identify which mutations are most likely to evade detection. For LLM-based surviving variants, whose changes are not constrained to predefined operators, we instead classify each surviving variant by its top-level modified AST node type following the previous method [(Pan et al. , [2009](#bib.bib46) )] (Table [5](#S4.T5) ), to characterize the structural nature of changes that evade existing tests. We then conduct a qualitative analysis on a random 20% sample of instances with surviving variants, following prior mutation-testing studies [(Straubinger et al. , [2024](#bib.bib35) )] . For each instance, two authors independently examine representative surviving variants, the reference patch, and the corresponding tests, and categorize the underlying behavioral gap. Disagreements are resolved through discussion, and we report Cohen’s κ \kappa to assess inter-rater agreement.


*Table 3. Surviving program variants and affected instances by the two mutation strategies on SWE-bench Verified (500 instances total).*


|  | Operator-based | LLM-based |
|---|---|---|
| Affected SWE-bench instances | 50 / 500 (10.0%) | 380 / 500 (76.0%) |
| Surviving program variants | 209 | 1,915 |
| Avg. variants per instance | 4.2 | 5.0 |
| Combined unique instances | 385 / 500 (77.0%) |



Results and Discussions. 77% of SWE-bench Verified instances have at least one surviving program variant that passes all existing regression tests. Table [3](#S4.T3) reports the number of surviving program variants and affected instances for each mutation strategy. 385 of 500 instances (77.0%) contain at least one surviving program variant, showing that under-constrained tests are widespread in the benchmark rather than limited to a few edge cases. LLM-based mutation accounts for the majority, affecting 380 instances with 1,915 variants. Meanwhile, operator-based mutation affects 50 instances with 209 variants, of which 5 are not covered by LLM-based variants. LLM-based mutation also produces more variants per affected instance (5.0 vs 4.2), suggesting that it explores a broader space of behavioral deviation per issue.


*Table 4. Surviving variants not killed by developer-written tests, grouped by semantic category with their contributing operators.*


| Semantic Category | Operator | # Surviving |
|---|---|---|
| Predicate & Boolean Logic (52.2%) | condfalse | 55 |
| condtrue | 16 |
| eqflip | 13 |
| boollit | 9 |
| cmpbound | 7 |
| condflip | 5 |
| boolswap | 4 |
| Arithmetic & Numeric (32.1%) | len2zero | 17 |
| numlit | 14 |
| strlit | 14 |
| len2one | 13 |
| arithop | 6 |
| none2zero | 3 |
| Loop & Iteration (6.7%) | reverseloop | 11 |
| brkcont | 3 |
| Exception Handling (4.3%) | exctype | 9 |
| Return & Default (3.3%) | retNone | 7 |
| Structural Transfromations (1.4%) | decdel | 3 |
| Total |  | 209 |



Conditional logic is the dominant source of surviving program variants in both strategies (52.2% operator-based, 54.3% LLM-based). Table [4](#S4.T4) breaks down the 209 surviving operator-based variants by mutation category. Predicate and Boolean Logic mutations are the most common types of operators, accounting for 109 of 209 variants (52.2%), with condfalse alone contributing 55. The finding indicates that many conditional branches in patch regions are not exercised by any test input. Arithmetic and Numeric mutations follow at 67 variants (32.1%). Together, these two categories account for over 84% of all surviving variants. The remaining categories contribute 33 variants combined (15.7%).



Table [5](#S4.T5) shows LLM-based surviving variants by classifying each change according to the top-level modified AST node type, following prior taxonomy of bug fix patterns [(Pan et al. , [2009](#bib.bib46) )] . Condition Modification is the most frequent pattern (54.3%), consistent with the dominance of conditional mutations observed in operator-based variants. The results indicate that test suites often fail to constrain branch behavior. Moreover, LLM-based mutations introduce more complex changes, including Function Modification (16.9%) and Assignment Modification (11.9%), which typically span several statements or broader code regions. These patterns are difficult to capture with first-order mutants, suggesting that LLM-based mutations can expose higher-level behavioral gaps beyond localized changes.


*Table 5. Change patterns in LLM-based surviving variants, classified by the top-level modified AST node following prior taxonomy of bug fix patterns [(Pan et al. , [2009](#bib.bib46) )] .*


| Change Pattern | AST Node Types | # Surviving |
|---|---|---|
| Condition Modification (54.3%) | If, Compare | 1,040 |
| Function Modification (16.9%) | FunctionDef, ClassDef | 324 |
| Assignment Modification (11.9%) | Assign, AugAssign | 228 |
| Return Modification (6.9%) | Return | 132 |
| Expression/Call Modification (4.0%) | Call, Expr | 77 |
| Loop Modification (2.8%) | For, While | 53 |
| Exception Handling Modification (1.7%) | Try, Raise | 33 |
| Other (1.5%) | – | 28 |
| Total |  | 1,915 |



Based on the manual analysis result by two authors (Cohen’s k = 0.94 k=\textbf{0.94} ), we identify four recurring patterns in how existing tests fail to constrain surviving variants . Insufficient Input Space Exploration is the most common (55.8%), and Missing Environmental Context is the least (7.8%). We discuss each pattern in detail below:



Pattern 1: Insufficient Input Space Exploration (43, 55.8%). Tests check only a small set of inputs and miss other valid cases, such as boundary values or alternative configurations. For example, in django-11239 , the fix ensures that each SSL parameter is passed correctly to the subprocess. However, the test checks only one configuration, sslmode=verify-ca , and does not cover other SSL settings. This is the most common pattern, showing that many tests verify only a few representative inputs.



Pattern 2: Partial Patch Path Coverage (15, 19.5%). Tests cover the primary execution path but skip alternative paths that the patch also modifies, such as fallback logic or default implementations. For example, in django-11095 , the fix supports both a custom get_inlines() implementation and the default behavior when no custom implementation is provided. The test checks only the custom case and does not cover the default one. This pattern is common when a fix changes both the default behavior and an overridden behavior, but the test exercises only one path.



Pattern 3: Weak Assertions (13, 16.9%). Tests verify only the visible output and miss deeper properties of the expected behavior, such as type, metadata, or structure. For example, in django-9296 , the fix ensures that iterating over Paginator yields Page objects rather than raw lists. However, the test only converts the result to a list and checks its contents, so it cannot detect whether the returned values are actually Page objects. This results in three incorrect variants that return raw data still pass. This pattern allows a patch to satisfy the test at the output level while violating the interface that downstream code relies on.



Pattern 4: Missing Environmental Context (6, 7.8%). Tests execute in a clean setup and fail to capture behaviors that depend on existing environment context. For example, in django-10973 , the test uses a mocked subprocess with no pre-existing PGPASSWORD and always assumes success. A surviving variant fails when PGPASSWORD is already present and also skips error checking, but the test fails to detect issues in both variants. Although this is the least common pattern, it is particularly risky in practice because the patch may pass in CI yet fail silently in production.


Under-constrained tests are widespread: 77% of instances admit at least one incorrect variant that still passes all tests. Most gaps come from insufficient input space exploration (55.8%) and missing execution paths (19.5%). Overall, tests tend to validate the immediate fix rather than the full behavior it affects.



### RQ2: How do the augmented tests improve the coverage of the regression test suite?


Motivation. RQ1 shows that many SWE-bench Verified instances remain under-constrained: program variants can still pass the original regression suite. We therefore investigate whether the augmented tests generated by STING improve coverage of the fix-relevant behavior that the original suite fails to exercise.


![Refer to caption](2604.01518v1/x4.png)
 *Figure 5. Coverage comparison between original and augmented test suites.*



Approach. We compare the original test suite T T with the augmented suite T ′ = T ∪ T n ​ e ​ w T^{\prime}=T\cup T_{new} , where T n ​ e ​ w T_{new} contains validated generated tests. Our evaluation focuses on whether T ′ T^{\prime} better constrains the fix-relevant behavior that allowed variants to survive under T T . We measure this along two complementary dimensions: (1) structural coverage and (2) assertion strength. For structural coverage, we report line coverage and branch coverage over the patch region, computed as the percentage of executed lines and branches within the modified code. These metrics quantify whether the augmented suite exercises additional execution paths introduced or affected by the fix [(Namin and Andrews, [2009](#bib.bib32) )] .



For assertion strength, we report three metrics: (i) assertions per test, defined as the average number of assertion statements in each test suite; (ii) assertion density, defined as the ratio of assertion statements to total statements within a test suite, capturing how much of the test is devoted to behavioral checking rather than setup or execution; and (iii) assertion type diversity, defined as the number of distinct assertion types used (e.g., equality, exception, membership), reflecting the variety of behavioral properties being validated. Together, these metrics characterize how thoroughly the tests check the executed behavior, beyond simply increasing coverage [(Zhang and Mesbah, [2015](#bib.bib33) ; Catolino et al. , [2019](#bib.bib34) )] . We further use paired Wilcoxon signed-rank tests and rank-biserial correlation to assess statistical significance and effect size across issues.



Results and Discussions. STING generates 1,316 candidate test cases across 236 test-weak instances. After removing tests that depend on implementation-specific behavior ( Robustness validation inSection [3.4](#S3.SS4) ), 1,014 tests across 211 instances are retained for augmentation. For each issue, we compare these retained tests with the developer-written test suite, including both newly added tests and modifications to existing ones. The augmented test suites substantially expand coverage over the patch region (i.e., fix-relevant code). As shown in Figure [5](#S4.F5) , across the 211 instances, average line coverage increases from 40.8% to 51.6%, and branch coverage from 41.7% to 51.2%. The improvements are statistically significant under paired Wilcoxon signed-rank tests ( p < 0.001 p<0.001 and p ≈ 0.02 p\approx 0.02 , respectively), and all non-zero paired differences favor augmentation. This indicates that the generated tests exercise previously untested execution paths.



More importantly, the improvement is not limited to executing more code. The generated tests also strengthen behavioral constraints through richer assertions. Prior work has shown that a richer assertion structure is associated with stronger fault-detection capability [(Zhang and Mesbah, [2015](#bib.bib33) ; Catolino et al. , [2019](#bib.bib34) )] . To characterize the checking strength contributed by the generated tests themselves, we further compare their assertion structure with that of the developer-written tests. As shown in Table [6](#S4.T6) , they contain more than twice as many assertions per test suite (5.18 vs. 2.31), higher assertion density (0.30 vs. 0.22), and greater assertion type diversity (3.14 vs. 1.56 unique types). These differences are statistically significant under paired Wilcoxon signed-rank tests (all p ¡ 0.001), with medium-to-large effect sizes r r ​ b = 0.55 , 0.48 r_{rb}=0.55,0.48 and 0.52 0.52 , respectively. Together, these results indicate that the additional coverage is accompanied by richer behavioral checks, rather than superficial execution alone.


*Table 6 . Per-issue static characteristics of developer-written tests versus generated tests.*


| Metric | Original | Generated | Delta |
|---|---|---|---|
| Assertion Number | 2.31 | 5.18 | +124.2% |
| Assertion Density | 0.22 | 0.30 | +36.4% |
| Assertion Types | 1.56 | 3.14 | +101.2% |


STING improves coverage of under-constrained regression suites by targeting fix-relevant code paths missed by developer-written tests. The augmented suite increases patch-region line coverage by 10.8% and branch coverage by 9.5%, while also providing richer assertions over the covered code paths.

*Table 7. Impact of augmented tests on repair agent evaluation. A patch is counted as *killed* if it originally passed T T but fails at least one test in T n ​ e ​ w T_{new} . Δ \Delta denotes the change in resolved rate.*


| Repair Agents | Resolved% Orig. → \rightarrow Post. ( Δ \Delta ) | Killed | Killed by T o ​ p ′ T^{\prime}_{op} | Killed by T l ​ l ​ m ′ T^{\prime}_{llm} | Adjusted Rank |
|---|---|---|---|---|---|
| live-SWE-agent (Claude 4.5 Opus medium) ( Xia et al. , 2025 ) | 79.20% → \rightarrow 75.00% ( - 4.20% ) | 21 | 3 | 20 | 1st |
| Sonar Foundation Agent (Claude 4.5 Opus) ( Sonar , 2025 ) | 79.20% → \rightarrow 75.00% ( - 4.20% ) | 21 | 3 | 21 | 1st |
| Trae Doubao Seed Code ( Gao et al. , 2025 ) | 78.80% → \rightarrow 71.40% ( - 6.40% ) | 32 | 5 | 31 | 3rd |
| live-SWE-agent (Gemini 3 Pro Preview) ( Xia et al. , 2025 ) | 77.40% → \rightarrow 71.40% ( - 6.00% ) | 30 | 3 | 30 | 4th |
| Atlassian Rovo Dev ( Dev , 2025 ) | 76.80% → \rightarrow 68.80% ( - 8.00% ) | 40 | 5 | 39 | 8th ↓ \downarrow |
| EPAM AI (Claude 4 Sonnet) ( epam , 2025 ) | 76.80% → \rightarrow 69.40% ( - 7.40% ) | 37 | 4 | 35 | 5th ↑ \uparrow |
| ACoder ( ACoder-AI , 2025 ) | 76.40% → \rightarrow 69.00% ( - 7.40% ) | 37 | 5 | 35 | 7th |
| Warp ( Warp-dev , 2025 ) | 75.60% → \rightarrow 69.40% ( - 6.20% ) | 31 | 4 | 30 | 5th ↑ \uparrow |
| TRAE ( Gao et al. , 2025 ) | 75.20% → \rightarrow 66.20% ( - 9.00% ) | 45 | 6 | 43 | 10th ↓ \downarrow |
| Harness AI ( harness , 2025 ) | 74.80% → \rightarrow 67.80% ( - 7.00% ) | 35 | 5 | 33 | 9th ↑ \uparrow |
| Total. | – | 329 | 38 | 317 | – |



### RQ3: How does stronger testing change repair agent evaluation?


Motivation. RQ1 and RQ2 show that STING exposes test gaps and generates targeted tests that improve coverage. In this RQ, we examine how these stronger tests affect the evaluation of repair agents. Specifically, we re-run patches produced by these agents on the augmented test suite to determine whether incorrect patches that previously passed are now detected.



Approach. We re-evaluate the top-10 repair agents on the SWE-bench Verified leaderboard [(Team, [2025](#bib.bib44) )] whose submitted patches are publicly available. For each agent-generated patch, we execute both the original tests T T and the augmented suite T ′ = T ∪ T n ​ e ​ w T^{\prime}=T\cup T_{new} produced by STING . A patch is counted as killed if it originally passed T T but fails at least one test in T n ​ e ​ w T_{new} . We then compute each agent’s resolved rate under T ′ T^{\prime} and compare it against the original rate. To understand the contribution of each mutation strategy, we further report kills separately for tests derived from the operator-based mutation pipeline ( T o ​ p ′ T^{\prime}_{op} ) and the LLM-based mutation pipeline ( T l ​ l ​ m ′ T^{\prime}_{llm} ).



Results. Table [7](#S4.T7) shows that the augmented tests consistently change evaluation outcomes for all ten repair agents. Resolved-rate drops range from 4.2% to 9.0%, with 21 to 45 previously accepted patches per agent now rejected. The two mutation strategies are complementary: LLM-based tests account for most of the detected failures, while operator-based tests contribute an additional 3 to 6 unique failures per agent that LLM-based tests do not catch. These corrections also change the leaderboard. Atlassian Rovo Dev , ACoder , and TRAE drop in rank, while EPAM AI , Warp , and Harness AI move up. This change indicates that the original test suites accepted a non-trivial number of incorrect patches, inflating the reported performance of some agents. Overall, the results show that stronger tests provide a more reliable comparison between repair agents.


Findings: STING ’s augmented tests reduce resolved rates by 4.2% to 9.0% across all 10 agents, with some repair agents experiencing larger drops.



### RQ4: What behavioral checks do the augmented tests introduce?


Motivation. RQ3 shows that the augmented tests reject many previously accepted patches. To understand what makes these tests effective, we analyze the behavioral checks they add and how each exposes flaws missed by original tests.



Approach. We randomly sample 66 (20%) newly rejected patches in RQ3 for manual analysis. For each sample, we examine the original tests, the oracle patch, and the augmented tests that cause the rejection to understand why the patch fails. By comparing the assertions, inputs, and execution paths introduced by the augmented tests against those in the original suite, we identify the behavioral property that the augmented tests newly constrain. Two authors independently analyze the sampled patches. The first author develops an initial set of categories by open-coding all samples, identifying recurring types of behavioral checks that the augmented tests introduce. The second author then independently assigns each sample to one of the proposed categories. Disagreements are resolved through discussion, after which the category definitions are finalized. We report Cohen’s κ \kappa on the independent assignments to assess inter-rater agreement. Both authors also assess whether each rejection reflects genuine semantic incompleteness or overfitting to the oracle patch.



Results. After manual inspection, we find that all agent-generated patches killed by our generated tests are indeed invalid. We further identify three common types 1 1 1 Detailed examples for all three patterns are available in our replication package under artifact_packages/result/analysis/rq4-behavioral-checks of behavioral checks in the augmented tests that expose gaps in agent-generated patches, achieving Cohen’s κ = 0.92 \kappa=0.92 .



Input Selection for Behavioral Differentiation (36, 54.5%). The augmented tests introduce inputs that differentiate correct behavior from plausible approximations. For example, in django-14017 , the original tests confirm that valid expression types are accepted but do not check that invalid types are rejected. The augmented tests add cases with values that evaluate to True but should be rejected, covering both acceptance and rejection behavior. As another example, in scikit-learn-14496 , the original inputs produce identical results under both truncation and rounding. The augmented tests introduce values for which the two operations yield different outputs, making the behavioral difference observable.



End-to-End Behavioral Validation (27, 40.9%). The augmented tests extend validation from partial and local checks to end-to-end behavior across dependent code paths. For example, in django-11276 , the original tests check only that escape() produces the updated entity format. The augmented tests instead assert on the final URL output after the data flows through both escape() and urlize() , catching patches that fix the local function but leave downstream behavior incorrect.



State Transition Validation (3, 4.6%). The augmented tests verify that the fix holds after state transitions, not just in the initial object state. For example, in django-12965 , the original tests validate a deletion optimization only on a freshly created queryset. The augmented tests first evaluate the queryset and then perform the deletion, exposing patches that work on fresh objects but fail after prior state changes.


The augmented tests expose flaws in previously accepted agent-generated patches through three types of behavioral checks: input selection for behavioral differentiation (54.5%), end-to-end behavioral validation (40.9%), and state transition validation (4.6%). These checks generalize across agents while introducing minimal overfitting to the oracle patch.



## 5. Threats to Validity


We discuss the main threats to internal, external, and construct validity below.



Internal Validity. Some surviving variants may be semantically equivalent to the oracle patch, which would overstate the prevalence of test gaps. We mitigate this through AST-level normalization, deduplication, and a validation stage that filters generated tests which fail to generalize across behavior-preserving variants. Residual equivalent variants may remain, but they would primarily make our test-weakness analysis more conservative.



Generated tests may overfit implementation details of the oracle patch. We address this via behavior-preserving transformations that discard tests sensitive to superficial artifacts, removing 23% of candidate tests. Our RQ4 analysis finds only one ambiguous rejection across all affected instances, indicating that residual overfitting risk is low.



The manual classifications in RQ1 and RQ4 involve subjective judgment. Two authors independently labeled all cases (Cohen’s κ = 0.94 \kappa=0.94 and 0.92) and resolved disagreements by consensus.



External Validity. Our evaluation is conducted on SWE-bench Verified (500 Python instances from 12 repositories) so our results may not generalize to other languages, benchmarks, or proprietary codebases. However, our approach is not inherently tied to SWE-bench Verified: it applies to any benchmark providing an oracle patch and executable tests. The mutation operators and validation pipeline are instantiated for Python, but extending them to other languages is feasible given the availability of mature mutation testing tools. We evaluate patches from the top-10 leaderboard tools, covering both agent-based and LLM-based strategies, though this does not exhaust all repair approaches.



Construct Validity. STING uses the oracle patch as its primary correctness reference. If the oracle patch is not the only acceptable implementation, augmented tests may reject valid alternatives; our RQ4 analysis finds only one such case. We assess test quality using coverage and assertion characteristics, complemented by variant kill rate and downstream patch-assessment results. All LLM-based components use a single model (GPT-5-mini); results may vary under different models or settings.



## 6. Conclusion


This paper presented STING , a test augmentation framework that systematically diagnoses and repairs behavioral weaknesses in benchmark regression test suites. STING generates semantically modified variants of the oracle patch, uses surviving variants as diagnostic signals of under-constrained behavior, and synthesizes targeted tests that make the missing constraints explicit. Our evaluation on SWE-bench Verified shows that test weakness is widespread: 77% of instances admit at least one surviving variant. Guided by these variants, STING generates 1,014 validated tests across 211 instances, increases patch-region line and branch coverage by 10.8% and 9.5%, and adds richer behavioral checks than the original developer-written tests. When used to re-evaluate the top-10 repair agents, the augmented suites reduce resolved rates by 4.2%–9.0%, showing that many previously accepted patches exploit benchmark test gaps rather than fully satisfying the intended repair semantics. These results suggest that benchmark evaluation is not solely a solution-generation problem but also a test-strength problem. By turning implicit test gaps into explicit behavioral checks, STING provides a practical path toward more reliable benchmark-based assessment in automated software engineering.



## References

- ACoder-AI (2025) ACoder . Note: Accessed: Jan. 12, 2026 External Links: [Link](https://github.com/ACoder-AI/ACoder) Cited by: [§1](#S1.p1.1) , [Table 7](#S4.T7.19.13.13.2) .
- R. Aleithan, H. Xue, M. M. Mohajer, E. Nnorom, G. Uddin, and S. Wang (2024) Swe-bench+: enhanced coding benchmark for llms . arXiv preprint arXiv:2410.06992 . Cited by: [§1](#S1.p3.1) , [§1](#S1.p4.1) , [§2.1](#S2.SS1.p1.1) , [§2.2](#S2.SS2.p1.1) .
- J. Austin, A. Odena, M. Nye, M. Bosma, H. Michalewski, D. Dohan, E. Jiang, C. Cai, M. Terry, Q. Le, et al. (2021) Program synthesis with large language models . arXiv preprint arXiv:2108.07732 . Cited by: [§2.2](#S2.SS2.p1.1) .
- A. Bingham and R. Smallshire (2016) Cosmic Ray: mutation testing for python . Note: [https://github.com/sixty-north/cosmic-ray](https://github.com/sixty-north/cosmic-ray) Accessed: 2026-02-01 Cited by: [§2.2](#S2.SS2.p2.1) , [§3.1](#S3.SS1.p3.1) , [Table 1](#S3.T1.11.11.11.3) , [Table 1](#S3.T1.13.13.13.3) , [Table 1](#S3.T1.14.14.14.3) , [Table 1](#S3.T1.14.14.16.3) , [Table 1](#S3.T1.14.14.17.3) , [Table 1](#S3.T1.14.14.18.4) , [Table 1](#S3.T1.14.14.20.3) , [Table 1](#S3.T1.14.14.21.4) , [Table 1](#S3.T1.14.14.22.3) , [Table 1](#S3.T1.14.14.23.3) , [Table 1](#S3.T1.14.14.27.3) , [Table 1](#S3.T1.14.14.28.3) , [Table 1](#S3.T1.14.14.29.4) , [Table 1](#S3.T1.14.14.30.4) , [Table 1](#S3.T1.14.14.31.3) , [Table 1](#S3.T1.14.14.32.3) , [Table 1](#S3.T1.14.14.33.3) , [Table 1](#S3.T1.3.3.3.3) , [Table 1](#S3.T1.4.4.4.3) , [Table 1](#S3.T1.5.5.5.3) , [Table 1](#S3.T1.9.9.9.4) .
- G. Catolino, F. Palomba, A. Zaidman, and F. Ferrucci (2019) How the experience of development teams relates to assertion density of test classes . In 2019 IEEE International Conference on Software Maintenance and Evolution (ICSME) , pp. 223–234 . Cited by: [§4](#S4.SSx2.p3.1) , [§4](#S4.SSx2.p5.2) .
- M. Chen, J. Tworek, H. Jun, Q. Yuan, H. P. D. O. Pinto, J. Kaplan, H. Edwards, Y. Burda, N. Joseph, G. Brockman, et al. (2021) Evaluating large language models trained on code . arXiv preprint arXiv:2107.03374 . Cited by: [§2.2](#S2.SS2.p1.1) .
- Y. K. Chia, G. Chen, L. A. Tuan, S. Poria, and L. Bing (2023) Contrastive chain-of-thought prompting . arXiv preprint arXiv:2311.09277 . Cited by: [§3.3](#S3.SS3.p2.5) .
- R. Degiovanni and M. Papadakis (2022) ΜBert: mutation testing using pre-trained language models . In 2022 IEEE International Conference on Software Testing, Verification and Validation Workshops (ICSTW) , Vol. , pp. 160–169 . External Links: [Document](https://dx.doi.org/10.1109/ICSTW55395.2022.00039) Cited by: [§2.2](#S2.SS2.p2.1) .
- R. Dev (2025) Atlassian rovo dev . Note: Accessed: Jan. 12, 2026 External Links: [Link](https://www.atlassian.com/software/rovo-dev) Cited by: [§1](#S1.p1.1) , [Table 7](#S4.T7.16.10.10.3) .
- epam (2025) EPAM ai . Note: Accessed: Jan. 12, 2026 External Links: [Link](https://www.epam.com/services/artificial-intelligence) Cited by: [§1](#S1.p1.1) , [Table 7](#S4.T7.18.12.12.3) .
- G. Fraser and A. Arcuri (2011) Evosuite: automatic test suite generation for object-oriented software . In Proceedings of the 19th ACM SIGSOFT symposium and the 13th European conference on Foundations of software engineering , pp. 416–419 . Cited by: [§2.2](#S2.SS2.p3.1) .
- P. Gao, Z. Tian, X. Meng, X. Wang, R. Hu, Y. Xiao, Y. Liu, Z. Zhang, J. Chen, C. Gao, et al. (2025) Trae agent: an llm-based agent for software engineering with test-time scaling . arXiv preprint arXiv:2507.23370 . Cited by: [§1](#S1.p1.1) , [§2.1](#S2.SS1.p2.1) , [Table 7](#S4.T7.13.7.7.2) , [Table 7](#S4.T7.23.17.17.3) .
- S. Gao, C. Gao, C. Wang, J. Sun, D. Lo, and Y. Yu (2023) Two sides of the same coin: exploiting the impact of identifiers in neural code comprehension . In 2023 IEEE/ACM 45th International Conference on Software Engineering (ICSE) , pp. 1933–1945 . Cited by: [§3.4](#S3.SS4.p4.1) .
- L. R. Guerino, P. H. Kuroishi, A. C. R. Paiva, and A. M. R. Vincenzi (2024) Static and dynamic comparison of mutation testing tools for python . In Proceedings of the XXIII Brazilian Symposium on Software Quality , pp. 199–209 . Cited by: [§3.1](#S3.SS1.p3.1) .
- K. Hałas (2014) MutPy: mutation testing tool for python . Note: [https://github.com/mutpy/mutpy](https://github.com/mutpy/mutpy) Accessed: 2026-02-01 Cited by: [§2.2](#S2.SS2.p2.1) , [§3.1](#S3.SS1.p3.1) , [Table 1](#S3.T1.10.10.10.3) , [Table 1](#S3.T1.11.11.11.3) , [Table 1](#S3.T1.12.12.12.3) , [Table 1](#S3.T1.14.14.14.3) , [Table 1](#S3.T1.14.14.17.3) , [Table 1](#S3.T1.14.14.18.4) , [Table 1](#S3.T1.14.14.20.3) , [Table 1](#S3.T1.14.14.24.3) , [Table 1](#S3.T1.14.14.25.4) , [Table 1](#S3.T1.14.14.26.3) , [Table 1](#S3.T1.14.14.27.3) , [Table 1](#S3.T1.14.14.28.3) , [Table 1](#S3.T1.14.14.30.4) , [Table 1](#S3.T1.14.14.31.3) , [Table 1](#S3.T1.14.14.32.3) , [Table 1](#S3.T1.14.14.33.3) , [Table 1](#S3.T1.3.3.3.3) , [Table 1](#S3.T1.4.4.4.3) , [Table 1](#S3.T1.5.5.5.3) , [Table 1](#S3.T1.6.6.6.3) , [Table 1](#S3.T1.7.7.7.3) , [Table 1](#S3.T1.8.8.8.3) , [Table 1](#S3.T1.9.9.9.4) .
- M. Harman, J. Ritchey, I. Harper, S. Sengupta, K. Mao, A. Gulati, C. Foster, and H. Robert (2025) Mutation-guided llm-based test generation at meta . In Proceedings of the 33rd ACM International Conference on the Foundations of Software Engineering , pp. 180–191 . Cited by: [§2.2](#S2.SS2.p4.1) .
- harness (2025) Harness ai . Note: Accessed: Jan. 12, 2026 External Links: [Link](https://www.harness.io/) Cited by: [§1](#S1.p1.1) , [Table 7](#S4.T7.25.19.19.3) .
- M. Hort, L. Vidziunas, and L. Moonen (2025) Semantic-preserving transformations as mutation operators: a study on their effectiveness in defect detection . In 2025 IEEE International Conference on Software Testing, Verification and Validation Workshops (ICSTW) , pp. 337–346 . Cited by: [Table 2](#S3.T2) , [Table 2](#S3.T2.12.2) .
- A. Hovmöller (2018) Mutmut: mutation testing system for python . Note: [https://github.com/boxed/mutmut](https://github.com/boxed/mutmut) Accessed: 2026-02-01 Cited by: [§2.2](#S2.SS2.p2.1) , [§3.1](#S3.SS1.p3.1) , [Table 1](#S3.T1.1.1.1.4) , [Table 1](#S3.T1.11.11.11.3) , [Table 1](#S3.T1.14.14.17.3) , [Table 1](#S3.T1.14.14.18.4) , [Table 1](#S3.T1.14.14.19.3) , [Table 1](#S3.T1.14.14.33.3) , [Table 1](#S3.T1.2.2.2.3) , [Table 1](#S3.T1.3.3.3.3) , [Table 1](#S3.T1.4.4.4.3) , [Table 1](#S3.T1.5.5.5.3) .
- G. Jahangirova, D. Clark, M. Harman, and P. Tonella (2016) Test oracle assessment and improvement . In Proceedings of the 25th international symposium on software testing and analysis , pp. 247–258 . Cited by: [§2.2](#S2.SS2.p3.1) .
- Y. Jia and M. Harman (2010) An analysis and survey of the development of mutation testing . IEEE transactions on software engineering 37 ( 5 ), pp. 649–678 . Cited by: [§2.2](#S2.SS2.p2.1) .
- C. E. Jimenez, J. Yang, A. Wettig, S. Yao, K. Pei, O. Press, and K. Narasimhan (2023) Swe-bench: can language models resolve real-world github issues? . arXiv preprint arXiv:2310.06770 . Cited by: [§1](#S1.p1.1) , [§2.1](#S2.SS1.p1.1) .
- W. B. Langdon, M. Harman, and Y. Jia (2010) Efficient multi-objective higher order mutation testing with genetic programming . Journal of systems and Software 83 ( 12 ), pp. 2416–2430 . Cited by: [§2.2](#S2.SS2.p2.1) .
- C. Lemieux, J. P. Inala, S. K. Lahiri, and S. Sen (2023) Codamosa: escaping coverage plateaus in test generation with pre-trained large language models . In 2023 IEEE/ACM 45th International Conference on Software Engineering (ICSE) , pp. 919–931 . Cited by: [§2.2](#S2.SS2.p3.1) .
- J. Liu, C. S. Xia, Y. Wang, and L. Zhang (2023) Is your code generated by chatgpt really correct? rigorous evaluation of large language models for code generation . Advances in neural information processing systems 36 , pp. 21558–21572 . Cited by: [§2.2](#S2.SS2.p1.1) , [§2.2](#S2.SS2.p3.1) .
- S. Lukasczyk and G. Fraser (2022) Pynguin: automated unit test generation for python . In Proceedings of the ACM/IEEE 44th International Conference on Software Engineering: Companion Proceedings , pp. 168–172 . Cited by: [§2.2](#S2.SS2.p3.1) .
- A. S. Namin and J. H. Andrews (2009) The influence of size and coverage on test suite effectiveness . In Proceedings of the eighteenth international symposium on Software testing and analysis , pp. 57–68 . Cited by: [§4](#S4.SSx2.p2.5) .
- M. Ojdanic, E. Soremekun, R. Degiovanni, M. Papadakis, and Y. Le Traon (2023) Mutation testing in evolving systems: studying the relevance of mutants to code evolution . ACM Transactions on Software Engineering and Methodology 32 ( 1 ), pp. 1–39 . Cited by: [§2.2](#S2.SS2.p2.1) .
- K. Pan, S. Kim, and E. J. Whitehead Jr (2009) Toward an understanding of bug fix patterns . Empirical Software Engineering 14 ( 3 ), pp. 286–315 . Cited by: [§4](#S4.SSx1.p4.1) , [§4](#S4.SSx1.p7.1) , [Table 5](#S4.T5) .
- D. project (2019) Issue report: django__django-11276 . Note: Accessed: Jan. 18, 2026 External Links: [Link](https://www.swebench.com/index.html) Cited by: [§2.1](#S2.SS1.p2.1) .
- Z. Qi, F. Long, S. Achour, and M. Rinard (2015) An analysis of patch plausibility and correctness for generate-and-validate patch generation systems . In Proceedings of the 2015 international symposium on software testing and analysis , pp. 24–36 . Cited by: [§1](#S1.p2.1) , [§2.2](#S2.SS2.p1.1) .
- E. K. Smith, E. T. Barr, C. Le Goues, and Y. Brun (2015) Is the cure worse than the disease? overfitting in automated program repair . In Proceedings of the 2015 10th joint meeting on foundations of software engineering , pp. 532–543 . Cited by: [§1](#S1.p2.1) , [§2.2](#S2.SS2.p1.1) .
- Sonar (2025) Sonar foundation agent . Note: Accessed: Jan. 12, 2026 External Links: [Link](https://www.sonarsource.com/) Cited by: [§1](#S1.p1.1) , [Table 7](#S4.T7.12.6.6.2) .
- P. Straubinger, A. Degenhart, and G. Fraser (2024) An empirical evaluation of manually created equivalent mutants . In 2024 IEEE International Conference on Software Testing, Verification and Validation Workshops (ICSTW) , pp. 237–246 . Cited by: [§4](#S4.SSx1.p4.1) .
- S. H. Tan, H. Yoshida, M. R. Prasad, and A. Roychoudhury (2016) Anti-patterns in search-based program repair . In Proceedings of the 2016 24th ACM SIGSOFT International Symposium on Foundations of Software Engineering , pp. 727–738 . Cited by: [§2.2](#S2.SS2.p1.1) .
- S. Team (2025) SWE-bench verified leaderboard . Note: Accessed: Jan. 12, 2026 External Links: [Link](https://www.swebench.com/index.html) Cited by: [§4](#S4.SSx3.p2.7) .
- Z. Tian, H. Shu, D. Wang, X. Cao, Y. Kamei, and J. Chen (2024) Large language models for equivalent mutant detection: how far are we? . In Proceedings of the 33rd ACM SIGSOFT International Symposium on Software Testing and Analysis , pp. 1733–1745 . Cited by: [§3.1](#S3.SS1.SSS0.Px1.p1.1) .
- F. Tip, J. Bell, and M. Schäfer (2025) Llmorpheus: mutation testing using large language models . IEEE Transactions on Software Engineering . Cited by: [§2.2](#S2.SS2.p2.1) .
- I. S. Verified (August 13, 2024) Note: Accessed Jan. 1, 2026 External Links: [Link](https://openai.com/index/introducing-swe-bench-verified/) Cited by: [§1](#S1.p3.1) , [§4](#S4.p2.2) .
- Y. Wang, M. Pradel, and Z. Liu (2025) Are” solved issues” in swe-bench really solved correctly? an empirical study . arXiv preprint arXiv:2503.15223 . Cited by: [§1](#S1.p3.1) , [§1](#S1.p4.1) , [§2.1](#S2.SS1.p1.1) , [§2.2](#S2.SS2.p1.1) , [§2.2](#S2.SS2.p4.1) .
- Z. Wang, L. Zhang, C. Cao, N. Luo, X. Luo, and P. Liu (2023) How does naming affect llms on code analysis tasks? . arXiv preprint arXiv:2307.12488 . Cited by: [§3.4](#S3.SS4.p4.1) .
- Warp-dev (2025) Warp . Note: Accessed: Jan. 12, 2026 External Links: [Link](https://www.warp.dev/) Cited by: [§1](#S1.p1.1) , [Table 7](#S4.T7.21.15.15.3) .
- C. S. Xia, Z. Wang, Y. Yang, Y. Wei, and L. Zhang (2025) Live-swe-agent: can software engineering agents self-evolve on the fly? . arXiv preprint arXiv:2511.13646 . Cited by: [§1](#S1.p1.1) , [Table 7](#S4.T7.11.5.5.2) , [Table 7](#S4.T7.14.8.8.2) .
- T. Xie (2006) Augmenting automatically generated unit-test suites with regression oracle checking . In European conference on object-oriented programming , pp. 380–403 . Cited by: [§2.2](#S2.SS2.p3.1) .
- Q. Xin and S. P. Reiss (2017) Identifying test-suite-overfitted patches through test case generation . In Proceedings of the 26th ACM SIGSOFT International Symposium on Software Testing and Analysis , ISSTA 2017 , New York, NY, USA , pp. 226–236 . External Links: ISBN 9781450350761 , [Link](https://doi.org/10.1145/3092703.3092718) , [Document](https://dx.doi.org/10.1145/3092703.3092718) Cited by: [§2.2](#S2.SS2.p1.1) , [§2.2](#S2.SS2.p3.1) .
- J. Yang, A. Zhikhartsev, Y. Liu, and L. Tan (2017) Better test cases for better automated program repair . In Proceedings of the 2017 11th Joint Meeting on Foundations of Software Engineering , ESEC/FSE 2017 , New York, NY, USA , pp. 831–841 . External Links: ISBN 9781450351058 , [Link](https://doi.org/10.1145/3106237.3106274) , [Document](https://dx.doi.org/10.1145/3106237.3106274) Cited by: [§2.2](#S2.SS2.p1.1) , [§2.2](#S2.SS2.p3.1) .
- B. Yu, Y. Zhu, P. He, and D. Kang (2025) Utboost: rigorous evaluation of coding agents on swe-bench . In Proceedings of the 63rd Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers) , pp. 3762–3774 . Cited by: [§1](#S1.p3.1) , [§1](#S1.p4.1) , [§2.1](#S2.SS1.p1.1) , [§2.2](#S2.SS2.p1.1) , [§2.2](#S2.SS2.p4.1) .
- Z. Yuan, M. Liu, S. Ding, K. Wang, Y. Chen, X. Peng, and Y. Lou (2024) Evaluating and improving chatgpt for unit test generation . Proceedings of the ACM on Software Engineering 1 ( FSE ), pp. 1703–1726 . Cited by: [§2.2](#S2.SS2.p3.1) .
- Y. Zhang and A. Mesbah (2015) Assertions are strongly correlated with test suite effectiveness . In Proceedings of the 2015 10th Joint Meeting on Foundations of Software Engineering , pp. 214–224 . Cited by: [§4](#S4.SSx2.p3.1) , [§4](#S4.SSx2.p5.2) .


Experimental support, please [view the build logs](./2604.01518v1/__stdout.txt) for errors. Generated by [L A T E xml ![[LOGO]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAsAAAAOCAYAAAD5YeaVAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9wKExQZLWTEaOUAAAAddEVYdENvbW1lbnQAQ3JlYXRlZCB3aXRoIFRoZSBHSU1Q72QlbgAAAdpJREFUKM9tkL+L2nAARz9fPZNCKFapUn8kyI0e4iRHSR1Kb8ng0lJw6FYHFwv2LwhOpcWxTjeUunYqOmqd6hEoRDhtDWdA8ApRYsSUCDHNt5ul13vz4w0vWCgUnnEc975arX6ORqN3VqtVZbfbTQC4uEHANM3jSqXymFI6yWazP2KxWAXAL9zCUa1Wy2tXVxheKA9YNoR8Pt+aTqe4FVVVvz05O6MBhqUIBGk8Hn8HAOVy+T+XLJfLS4ZhTiRJgqIoVBRFIoric47jPnmeB1mW/9rr9ZpSSn3Lsmir1fJZlqWlUonKsvwWwD8ymc/nXwVBeLjf7xEKhdBut9Hr9WgmkyGEkJwsy5eHG5vN5g0AKIoCAEgkEkin0wQAfN9/cXPdheu6P33fBwB4ngcAcByHJpPJl+fn54mD3Gg0NrquXxeLRQAAwzAYj8cwTZPwPH9/sVg8PXweDAauqqr2cDjEer1GJBLBZDJBs9mE4zjwfZ85lAGg2+06hmGgXq+j3+/DsixYlgVN03a9Xu8jgCNCyIegIAgx13Vfd7vdu+FweG8YRkjXdWy329+dTgeSJD3ieZ7RNO0VAXAPwDEAO5VKndi2fWrb9jWl9Esul6PZbDY9Go1OZ7PZ9z/lyuD3OozU2wAAAABJRU5ErkJggg==)
](https://math.nist.gov/~BMiller/LaTeXML/) .


## Instructions for reporting errors

We are continuing to improve HTML versions of papers, and your feedback helps enhance accessibility and mobile support. To report errors in the HTML that will help us improve conversion and rendering, choose any of the methods listed below:

- Click the "Report Issue" ( ) button, located in the page header.

**Tip:** You can select the relevant text first, to include it in your report.

Our team has already identified [the following issues](https://github.com/arXiv/html_feedback/issues) . We appreciate your time reviewing and reporting rendering errors we may not have found yet. Your efforts will help us improve the HTML versions for all readers, because disability should not be a barrier to accessing research. Thank you for your continued support in championing open access for all.

Have a free development cycle? Help support accessibility at arXiv! Our collaborators at LaTeXML maintain a [list of packages that need conversion](https://github.com/brucemiller/LaTeXML/wiki/Porting-LaTeX-packages-for-LaTeXML) , and welcome [developer contributions](https://github.com/brucemiller/LaTeXML/issues) .



BETA
 [!Font Awesome Free v7.1.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2026 Fonticons, Inc.](javascript:toggleReadingMode();)