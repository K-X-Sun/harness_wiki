---
type: source
title: Voyager Project Website
date: 2026-04-15
dimension: harness
source_type: doc
tags:
- type-doc
- harness
- framework-voyager
- agent-lifelong-learning
---

# Voyager Project Website

An open-ended embodied agent with large language models for Minecraft.

- Website: https://voyager.minedojo.org/
- GitHub: https://github.com/MineDojo/Voyager
- Paper: arXiv:2305.16291
- Dimension: Harness

## Overview

Voyager is the first LLM-powered embodied lifelong learning agent in Minecraft that continuously explores the world, acquires diverse skills, and makes novel discoveries without human intervention.

## Key Components

1. **Automatic Curriculum**: Maximizes exploration by generating tasks based on current skill level and world state
2. **Skill Library**: Ever-growing library of executable code for storing and retrieving complex behaviors
3. **Iterative Prompting Mechanism**: Uses environment feedback, execution errors, and self-verification for program improvement

## Performance

- 3.3x more unique items discovered
- 2.3x longer distances traveled
- 15.3x faster unlocking of tech tree milestones
- Only framework to unlock diamond level in tech tree

## Architecture

Voyager interacts with GPT-4 via blackbox queries, bypassing the need for model parameter fine-tuning. The skills are temporally extended, interpretable, and compositional.

## Citation

```bibtex
@article{wang2023voyager,
  title={Voyager: An Open-Ended Embodied Agent with Large Language Models},
  author={Guanzhi Wang and Yuqi Xie and Yunfan Jiang and Ajay Mandlekar and Chaowei Xiao and Yuke Zhu and Linxi Fan and Anima Anandkumar},
  year={2023},
  journal={arXiv preprint arXiv:2305.16291}
}
```

## Team

- Guanzhi Wang (Caltech, NVIDIA) - *corresponding*
- Yuqi Xie (UT Austin)
- Yunfan Jiang (Stanford)
- Ajay Mandlekar (Stanford, NVIDIA) - *corresponding*
- Chaowei Xiao (ASU, Caltech)
- Yuke Zhu (UT Austin)
- Linxi "Jim" Fan (NVIDIA) - *corresponding*
- Anima Anandkumar (Caltech, NVIDIA) - *corresponding*

## Media Coverage

- [WIRED](https://www.wired.com/story/fast-forward-gpt-4-minecraft-chatgpt/)
- [Forbes](https://www.forbes.com/sites/johnkoetsier/2023/05/29/gpt-4-is-pretty-good-at-minecraft/)
- [TechCrunch](https://techcrunch.com/2023/06/02/this-ai-used-gpt-4-to-become-an-expert-minecraft-player/)
