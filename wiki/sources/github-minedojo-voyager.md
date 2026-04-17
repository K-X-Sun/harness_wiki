---
type: source
title: Voyager (MineDojo)
date: 2026-04-15
dimension: harness
source_type: repo
tags:
- type-repo
- harness
- framework-voyager
- agent-lifelong-learning
---

# Voyager (MineDojo)

An open-ended embodied agent with large language models for Minecraft.

- GitHub: https://github.com/MineDojo/Voyager
- Paper: arXiv:2305.16291
- Stars: 15,000+ | Language: Python | License: MIT
- Dimension: Harness
- Project Type: Embodied lifelong learning agent

## Overview

Voyager is the first LLM-powered embodied lifelong learning agent in Minecraft that continuously explores the world, acquires diverse skills, and makes novel discoveries without human intervention.

## Key Components

1. **Automatic Curriculum**: Maximizes exploration by generating tasks based on current skill level and world state
2. **Skill Library**: Ever-growing library of executable code for storing and retrieving complex behaviors
3. **Iterative Prompting Mechanism**: Uses environment feedback, execution errors, and self-verification for program improvement

## Architecture

Voyager interacts with GPT-4 via blackbox queries, bypassing the need for model parameter fine-tuning. The skills are temporally extended, interpretable, and compositional.

## Performance

- 3.3x more unique items discovered
- 2.3x longer distances traveled
- 15.3x faster unlocking of tech tree milestones
- Only framework to unlock diamond level in tech tree

## Key Features

- **Self-Driven Exploration**: Continuously discovers new items and skills
- **Lifelong Learning**: Progressive acquisition, update, and accumulation of knowledge
- **Compositional Skills**: Compounds abilities rapidly and alleviates catastrophic forgetting
- **Zero-Shot Generalization**: Solves novel tasks in new worlds using learned skill library

## Citation

```bibtex
@article{wang2023voyager,
  title={Voyager: An Open-Ended Embodied Agent with Large Language Models},
  author={Guanzhi Wang and Yuqi Xie and Yunfan Jiang and Ajay Mandlekar and Chaowei Xiao and Yuke Zhu and Linxi Fan and Anima Anandkumar},
  year={2023},
  journal={arXiv preprint arXiv:2305.16291}
}
```
