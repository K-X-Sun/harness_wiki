---
type: source
title: SWE-agent
date: 2026-04-15
dimension: harness
source_type: repo
tags:
- type-repo
- harness
- framework-swagent
- topic-security
---

# SWE-agent

Automated software engineering agent that fixes GitHub issues.

- GitHub: https://github.com/SWE-agent/SWE-agent
- Stars: 19,000 | Language: Python | License: MIT
- Paper: arXiv:2405.15793
- Dimension: Harness
- Project Type: Software engineering agent

## Overview

SWE-agent enables your language model of choice (e.g., GPT-4o or Claude Sonnet 4) to autonomously use tools to fix issues in real GitHub repositories, find cybersecurity vulnerabilities, or perform any custom task.

## Key Features

- **State of the art** on SWE-bench among open-source projects
- **Free-flowing & generalizable**: Leaves maximal agency to the LM
- **Configurable & fully documented**: Governed by a single `yaml` file
- **Made for research**: Simple & hackable by design

## Architecture

SWE-agent is built and maintained by researchers from Princeton University and Stanford University. It uses:
- Language model of choice via API calls
- YAML-based configuration
- Tool integration for file operations, test running, etc.

## Successors

**mini-swe-agent**: Simpler implementation matching SWE-agent performance with 100 lines of Python.

## EnIGMA Mode

Offensive cybersecurity (CTF) mode for solving capture the flag challenges.

## Citation

```bibtex
@inproceedings{yang2024sweagent,
  title={{SWE}-agent: Agent-Computer Interfaces Enable Automated Software Engineering},
  author={John Yang and Carlos E Jimenez and Alexander Wettig and Kilian Lieret and Shunyu Yao and Karthik R Narasimhan and Ofir Press},
  booktitle={The Thirty-eighth Annual Conference on Neural Information Processing Systems},
  year={2024},
  url={https://arxiv.org/abs/2405.15793}
}
```

## Contact

- John Yang: johnby@stanford.edu
- Carlos E. Jimenez: carlosej@cs.princeton.edu
- Kilian Lieret: kl5675@princeton.edu
