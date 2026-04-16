---
date: '2026-04-15'
source_type: repo
tags:
- type-repo
- topic-security
- topic-agent
- topic-swe
title: 'GitHub - SWE-agent/SWE-agent: SWE-agent takes a GitHub issue and tries to
  automatically fix it, using your LM of choice. It can also be employed for offensive
  cybersecurity or competitive coding challenges. [NeurIPS 2024] · GitHub'
---

# GitHub - SWE-agent/SWE-agent: SWE-agent takes a GitHub issue and tries to automatically fix it, using your LM of choice. It can also be employed for offensive cybersecurity or competitive coding challenges. [NeurIPS 2024] · GitHub

[Skip to content](#start-of-content)


## Navigation Menu
 Toggle navigation





 [](/)
[Sign in](/login?return_to=https%3A%2F%2Fgithub.com%2FSWE-agent%2FSWE-agent)
Appearance settings





 Search or jump to...



# Search code, repositories, users, issues, pull requests...


'"` </textarea></xmp>
Search



 Clear







[Search syntax tips](https://docs.github.com/search-github/github-code-search/understanding-github-code-search-syntax)





# Provide feedback




'"` </textarea></xmp>
We read every piece of feedback, and take your input very seriously.
 Include my email address so I can be contacted

Cancel Submit feedback


# Saved searches

## Use saved searches to filter your results more quickly






'"` </textarea></xmp>


Name

Query

To see all available qualifiers, see our [documentation](https://docs.github.com/search-github/github-code-search/understanding-github-code-search-syntax) .




Cancel Create saved search


[Sign in](/login?return_to=https%3A%2F%2Fgithub.com%2FSWE-agent%2FSWE-agent)
 [Sign up](/signup?ref_cta=Sign+up&ref_loc=header+logged+out&ref_page=%2F%3Cuser-name%3E%2F%3Crepo-name%3E&source=header-repo&source_repo=SWE-agent%2FSWE-agent)
Appearance settings

 Resetting focus


You signed in with another tab or window. Reload to refresh your session. You signed out in another tab or window. Reload to refresh your session. You switched accounts on another tab or window. Reload to refresh your session. Dismiss alert





{{ message }}



[SWE-agent](/SWE-agent) / **[SWE-agent](/SWE-agent/SWE-agent)** Public



- [Notifications](/login?return_to=%2FSWE-agent%2FSWE-agent)  You must be signed in to change notification settings
- [Fork 2.1k](/login?return_to=%2FSWE-agent%2FSWE-agent)
- [Star 19k](/login?return_to=%2FSWE-agent%2FSWE-agent)





[](/SWE-agent/SWE-agent)



# SWE-agent/SWE-agent








main




[Branches](/SWE-agent/SWE-agent/branches) [Tags](/SWE-agent/SWE-agent/tags)

[](/SWE-agent/SWE-agent/branches) [](/SWE-agent/SWE-agent/tags)




$! /$

Go to file

 Code
Open more actions menu




## Folders and files


| Name | Name | Last commit message | Last commit date |
|---|---|---|---|
| Latest commit History 2,158 Commits 2,158 Commits |
| .cursor/ rules | .cursor/ rules |  |  |
| .devcontainer | .devcontainer |  |  |
| .github | .github |  |  |
| assets | assets |  |  |
| config | config |  |  |
| docs | docs |  |  |
| sweagent | sweagent |  |  |
| tests | tests |  |  |
| tools | tools |  |  |
| trajectories | trajectories |  |  |
| .env.example | .env.example |  |  |
| .git-blame-ignore-revs | .git-blame-ignore-revs |  |  |
| .gitignore | .gitignore |  |  |
| .pre-commit-config.yaml | .pre-commit-config.yaml |  |  |
| CONTRIBUTING.md | CONTRIBUTING.md |  |  |
| LICENSE | LICENSE |  |  |
| README.md | README.md |  |  |
| SECURITY.md | SECURITY.md |  |  |
| codecov.yml | codecov.yml |  |  |
| mkdocs.yml | mkdocs.yml |  |  |
| mlc_config.json | mlc_config.json |  |  |
| pyproject.toml | pyproject.toml |  |  |
| View all files |



## Repository files navigation



[![swe-agent.com](/SWE-agent/SWE-agent/raw/main/assets/swe-agent-banner.png)
](https://swe-agent.com/latest/)

[![Docs](https://camo.githubusercontent.com/18bac9221c235dbe0388a2514fc6cf6facd4002e8a2f5bec9ad90a0c36e21c68/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f63732d677265656e3f7374796c653d666f722d7468652d6261646765266c6f676f3d6d6174657269616c666f726d6b646f6373266c6f676f436f6c6f723d7768697465)
](https://swe-agent.com/latest/) [![Slack](https://camo.githubusercontent.com/28edab52068e19592d957d96845ade6c7b996a9e20bceea4eca1946ff449ec3c/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f536c61636b2d3441313534423f7374796c653d666f722d7468652d6261646765266c6f676f3d736c61636b266c6f676f436f6c6f723d7768697465)
](https://join.slack.com/t/swe-bench/shared_invite/zt-36pj9bu5s-o3_yXPZbaH2wVnxnss1EkQ) [![arxiv 2405.15793](https://camo.githubusercontent.com/42052ee34d62dda4140e48f0a28c4695976c6f792750bd21ccc938ce63971471/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f61727869762d323430352e31353739332d7265643f7374796c653d666f722d7468652d6261646765266c6f676f3d6172786976266c6f676f436f6c6f723d7768697465266c6162656c436f6c6f723d626c61636b)
](https://arxiv.org/abs/2405.15793)

[![mini-swe-agent.com](/SWE-agent/SWE-agent/raw/main/assets/warning.png)
](https://github.com/SWE-agent/mini-swe-agent/)


Warning

Most of our current development effort is on [mini-swe-agent](https://github.com/SWE-agent/mini-swe-agent/) , which has superseded SWE-agent. It matches the performance performance of SWE-agent, while being much simpler. See the [FAQ](https://mini-swe-agent.com/latest/faq/) for more details about the differences. Our general recommendation is to use mini-SWE-agent instead of SWE-agent going forward.


SWE-agent enables your language model of choice (e.g. GPT-4o or Claude Sonnet 4) to autonomously use tools to [fix issues in real GitHub repositories](https://swe-agent.com/latest/usage/hello_world) , [find cybersecurity vulnerabilities](https://enigma-agent.com/) , or [perform any custom task](https://swe-agent.com/latest/usage/coding_challenges) .

- ✅ **State of the art** on SWE-bench among open-source projects
- ✅ **Free-flowing & generalizable** : Leaves maximal agency to the LM
- ✅ **Configurable & fully documented** : Governed by a single `yaml` file
- ✅ **Made for research** : Simple & hackable by design

SWE-agent is built and maintained by researchers from Princeton University and Stanford University.


## 📣 News
 [](#-news)

- July 24: [Mini-SWE-Agent](https://github.com/SWE-agent/mini-SWE-agent) achieves 65% on SWE-bench verified in 100 lines of python!
- May 2: [SWE-agent-LM-32b](https://github.com/SWE-bench/SWE-smith) achieves open-weights SOTA on SWE-bench
- Feb 28: [SWE-agent 1.0 + Claude 3.7 is SoTA on SWE-Bench full](https://x.com/KLieret/status/1895487966409298067)
- Feb 25: [SWE-agent 1.0 + Claude 3.7 is SoTA on SWE-bench verified](https://x.com/KLieret/status/1894408819670733158)
- Feb 13: [Releasing SWE-agent 1.0: SoTA on SWE-bench light & tons of new features](https://x.com/KLieret/status/1890048205448220849)
- Dec 7: [An interview with the SWE-agent & SWE-bench team](https://www.youtube.com/watch?v=fcr8WzeEXyk)


## 🚀 Get started!
 [](#-get-started)

👉 Try SWE-agent in your browser: [![Open in GitHub Codespaces](https://camo.githubusercontent.com/26e291765032ef46fe3f0d3bc3fd730c1e9ad43a4d06e95d01ffdb103b014e07/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f4f70656e5f696e5f4769744875625f436f64657370616365732d677261793f6c6f676f3d676974687562)
](https://codespaces.new/SWE-agent/SWE-agent) ( [more information](https://swe-agent.com/latest/installation/codespaces/) )

Read our [documentation](https://swe-agent.com) to learn more:

- [Installation](https://swe-agent.com/latest/installation/source/)
- [Hello world from the command line](https://swe-agent.com/latest/usage/hello_world/)
- [Benchmarking on SWE-bench](https://swe-agent.com/latest/usage/batch_mode/)
- [Frequently Asked Questions](https://swe-agent.com/latest/faq/)


## SWE-agent for offensive cybersecurity (EnIGMA)
 [](#swe-agent-for-offensive-cybersecurity-enigma-)

[![image](https://private-user-images.githubusercontent.com/13602468/393649968-84599168-11a7-4776-8a49-33dbf0758bb2.svg?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzYyNDMzNzcsIm5iZiI6MTc3NjI0MzA3NywicGF0aCI6Ii8xMzYwMjQ2OC8zOTM2NDk5NjgtODQ1OTkxNjgtMTFhNy00Nzc2LThhNDktMzNkYmYwNzU4YmIyLnN2Zz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjA0MTUlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwNDE1VDA4NTExN1omWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTVhMDIxN2Y1Njc3YjA1OTU4ZTZkYjU4ZTk4NDYzMDlmMmQwNDVhMzUzNWY4NzhjMzQ2NDBiODk4NzNjM2UyOWUmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JnJlc3BvbnNlLWNvbnRlbnQtdHlwZT1pbWFnZSUyRnN2ZyUyQnhtbCJ9.TlfY0ITnKvlMi-wyOfsxN9gk1gNGGOx67YWkJjLsaYU)
](https://private-user-images.githubusercontent.com/13602468/393649968-84599168-11a7-4776-8a49-33dbf0758bb2.svg?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzYyNDMzNzcsIm5iZiI6MTc3NjI0MzA3NywicGF0aCI6Ii8xMzYwMjQ2OC8zOTM2NDk5NjgtODQ1OTkxNjgtMTFhNy00Nzc2LThhNDktMzNkYmYwNzU4YmIyLnN2Zz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjA0MTUlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwNDE1VDA4NTExN1omWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTVhMDIxN2Y1Njc3YjA1OTU4ZTZkYjU4ZTk4NDYzMDlmMmQwNDVhMzUzNWY4NzhjMzQ2NDBiODk4NzNjM2UyOWUmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JnJlc3BvbnNlLWNvbnRlbnQtdHlwZT1pbWFnZSUyRnN2ZyUyQnhtbCJ9.TlfY0ITnKvlMi-wyOfsxN9gk1gNGGOx67YWkJjLsaYU)

[SWE-agent: EnIGMA](https://enigma-agent.com) is a mode for solving offensive cybersecurity (capture the flag) challenges. EnIGMA achieves state-of-the-art results on multiple cybersecurity benchmarks (see [leaderboard](https://enigma-agent.com/#results) ). Please use [SWE-agent 0.7](https://github.com/SWE-agent/SWE-agent/tree/v0.7) while we update EnIGMA for 1.0.

In addition, you might be interested in our other projects:

[![Mini-SWE-Agent](/SWE-agent/SWE-agent/raw/main/docs/assets/mini_logo_text_below.svg)
](https://github.com/SWE-agent/mini-SWE-agent) [![SWE-ReX](/SWE-agent/SWE-agent/raw/main/docs/assets/swerex_logo_text_below.svg)
](https://github.com/SWE-agent/SWE-ReX) [![SWE-bench](/SWE-agent/SWE-agent/raw/main/docs/assets/swebench_logo_text_below.svg)
](https://github.com/SWE-bench/SWE-bench) [![SWE-smith](/SWE-agent/SWE-agent/raw/main/docs/assets/swesmith_logo_text_below.svg)
](https://github.com/SWE-bench/SWE-smith) [![sb-cli](/SWE-agent/SWE-agent/raw/main/docs/assets/sbcli_logo_text_below.svg)
](https://github.com/SWE-bench/sb-cli)


## Contributions
 [](#contributions-)

If you'd like to contribute to the codebase, we welcome [issues](https://github.com/SWE-agent/SWE-agent/issues) and [pull requests](https://github.com/SWE-agent/SWE-agent/pulls) ! For larger code changes, we always encourage discussion in issues first.


## Citation & contact
 [](#citation--contact-)

SWE-agent is an academic project started at Princeton University by John Yang*, Carlos E. Jimenez*, Alexander Wettig, Kilian Lieret, Shunyu Yao, Karthik Narasimhan, and Ofir Press. Contact person: [John Yang](https://john-b-yang.github.io/) , [Carlos E. Jimenez](http://www.carlosejimenez.com/) , and [Kilian Lieret](https://www.lieret.net/) (Email: [johnby@stanford.edu](mailto:johnby@stanford.edu) , [carlosej@cs.princeton.edu](mailto:carlosej@cs.princeton.edu) , [kl5675@princeton.edu](mailto:kl5675@princeton.edu) ).

If you found this work helpful, please consider citing it using the following:
 SWE-agent citation

```
@inproceedings { yang2024sweagent , title = { {SWE}-agent: Agent-Computer Interfaces Enable Automated Software Engineering } , author = { John Yang and Carlos E Jimenez and Alexander Wettig and Kilian Lieret and Shunyu Yao and Karthik R Narasimhan and Ofir Press } , booktitle = { The Thirty-eighth Annual Conference on Neural Information Processing Systems } , year = { 2024 } , url = { https://arxiv.org/abs/2405.15793 } }
```


If you used the summarizer, interactive commands or the offensive cybersecurity capabilities in SWE-agent, please also consider citing:
 EnIGMA citation

```
@misc { abramovich2024enigmaenhancedinteractivegenerative , title = { EnIGMA: Enhanced Interactive Generative Model Agent for CTF Challenges } , author = { Talor Abramovich and Meet Udeshi and Minghao Shao and Kilian Lieret and Haoran Xi and Kimberly Milner and Sofija Jancheska and John Yang and Carlos E. Jimenez and Farshad Khorrami and Prashanth Krishnamurthy and Brendan Dolan-Gavitt and Muhammad Shafique and Karthik Narasimhan and Ramesh Karri and Ofir Press } , year = { 2024 } , eprint = { 2409.16165 } , archivePrefix = { arXiv } , primaryClass = { cs.AI } , url = { https://arxiv.org/abs/2409.16165 } , }
```



## 🪪 License
 [](#-license-)

MIT. Check `LICENSE` .


[![Pytest](https://github.com/SWE-agent/SWE-agent/actions/workflows/pytest.yaml/badge.svg)
](https://github.com/SWE-agent/SWE-agent/actions/workflows/pytest.yaml) [![build-docs](https://github.com/SWE-agent/SWE-agent/actions/workflows/build-docs.yaml/badge.svg)
](https://github.com/SWE-agent/SWE-agent/actions/workflows/build-docs.yaml) [![codecov](https://camo.githubusercontent.com/ee736c1ede1247b18dcdd4896f2c372771d716e532e53adf159aaa1e5d3de8fa/68747470733a2f2f636f6465636f762e696f2f67682f5357452d6167656e742f5357452d6167656e742f67726170682f62616467652e7376673f746f6b656e3d3138584156444b333635)
](https://codecov.io/gh/SWE-agent/SWE-agent) [![pre-commit.ci status](https://camo.githubusercontent.com/b225b387f880483f88e37285aaa8605f2c35b8036ac45e1872d9d32b478bcb4f/68747470733a2f2f726573756c74732e7072652d636f6d6d69742e63692f62616467652f6769746875622f5357452d6167656e742f5357452d6167656e742f6d61696e2e737667)
](https://results.pre-commit.ci/latest/github/SWE-agent/SWE-agent/main) [![Markdown links](https://github.com/SWE-agent/SWE-agent/actions/workflows/check-links-periodic.yaml/badge.svg)
](https://github.com/SWE-agent/SWE-agent/actions/workflows/check-links-periodic.yaml)





## About

SWE-agent takes a GitHub issue and tries to automatically fix it, using your LM of choice. It can also be employed for offensive cybersecurity or competitive coding challenges. [NeurIPS 2024]

[swe-agent.com](https://swe-agent.com)

### Topics


[agent](/topics/agent) [ai](/topics/ai) [cybersecurity](/topics/cybersecurity) [lms](/topics/lms) [developer-tools](/topics/developer-tools) [agent-based-model](/topics/agent-based-model) [llm](/topics/llm)


### Resources

[Readme](#readme-ov-file)

### License

[MIT license](#MIT-1-ov-file)

### Code of conduct

[Code of conduct](#coc-ov-file)

### Contributing

[Contributing](#contributing-ov-file)

### Security policy

[Security policy](#security-ov-file)


### Uh oh!


There was an error while loading. Please reload this page .


[Activity](/SWE-agent/SWE-agent/activity)

[Custom properties](/SWE-agent/SWE-agent/custom-properties)

### Stars

[**19k** stars](/SWE-agent/SWE-agent/stargazers)

### Watchers

[**109** watching](/SWE-agent/SWE-agent/watchers)

### Forks

[**2.1k** forks](/SWE-agent/SWE-agent/forks)

[Report repository](/contact/report-content?content_url=https%3A%2F%2Fgithub.com%2FSWE-agent%2FSWE-agent&report=SWE-agent+%28user%29)



## [Releases 10](/SWE-agent/SWE-agent/releases)
 [

v1.1.0: 10s of thousands of training trajectories Latest

May 22, 2025

](/SWE-agent/SWE-agent/releases/tag/v1.1.0)
[+ 9 releases](/SWE-agent/SWE-agent/releases)



## [Packages 0](/orgs/SWE-agent/packages?repo_name=SWE-agent)














### Uh oh!


There was an error while loading. Please reload this page .



### Uh oh!


There was an error while loading. Please reload this page .



## [Contributors](/SWE-agent/SWE-agent/graphs/contributors)

-
-
-


### Uh oh!


There was an error while loading. Please reload this page .



## Languages



- [Python 94.8%](/SWE-agent/SWE-agent/search?l=python)
- [JavaScript 1.6%](/SWE-agent/SWE-agent/search?l=javascript)
- [CSS 1.3%](/SWE-agent/SWE-agent/search?l=css)
- [Shell 0.8%](/SWE-agent/SWE-agent/search?l=shell)
- [C++ 0.5%](/SWE-agent/SWE-agent/search?l=c%2B%2B)
- [Perl 0.3%](/SWE-agent/SWE-agent/search?l=perl)
- Other 0.7%








## Footer


[](https://github.com) © 2026 GitHub, Inc.


You can’t perform that action at this time.