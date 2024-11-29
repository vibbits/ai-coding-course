<!--
author: James Collier
email: james.collier@vib.be
language: en

font:     Noto Sans Egyptian Hieroglyphs, Noto Sans Ogham

-->

# Getting the Most Out of AI Coding Assistants

![James Collier](https://stprdappsazweu.blob.core.windows.net/iam-public/profile-pics-cropped/53-6924.jpeg "<a href='https://james.thecolliers.xyz'>James Collier</a>") ![Marine Guyot](https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=481,h=541,fit=crop,trim=0;380.0048959608323;0;380.0048959608323/YKbwLJxKNyCVNRWR/official_photo-mePkOLx1EWU6E6Lo.jpg "<a href='https://codingresearcher.com'>Marine Guyot</a>")

## Who are you?

Briefly introduce yourself:

* What is your name?
* What do you work on?
* Why did you join the course?

## Workshop goals

* What AI powered tools are available?

  * What can these tools do well?
  * What don't they do well?

* Tips and tricks, pros and cons, lots of discussion
* Ethical, security, and privacy issues
* Practical applications (try things out)

## What is "AI"?

* A chat interface? Is [ELIZA](https://www.theguardian.com/technology/2023/jul/25/joseph-weizenbaum-inventor-eliza-chatbot-turned-against-artificial-intelligence-ai) an AI?
* Statistical inference
* Machine learning
* Symbolic reasoning
* Large Language Models (LLMs)


## What is an LLM?

* A statistical model of language => multi-dimensional distribution
* Model inferred ("trained") from a "large" volume of data
* Training result is a high-dimensional statistical distribution
* Sampling from the distribution produces a "token"
* Training often optimizes for observing "human like" sequences of sampled tokens

## Software development tasks

* Building programs from scratch
* Adding features to existing programs
* Fixing bugs in existing programs
* Refactoring existing programs
* Collaborating with other programmers
* Testing
* Deployment
* Maintenance
* Code review
* Learning new tools/libraries/techniques/...
* Trying to understand code
* Design

## What tools do we already use for these tasks?

* Editors (with LSP)
* Static analysis (linters, type checkers)
* Dynamic analysis (valgrind, profilers)
* Tests
* Version control
* Build tools
* Debuggers
* Code generation
* Logging and monitoring
* Dependency management
* Project management
* Documentation
* Databases

## What can AI powered tools do?

### Code generation

                           --{{0}}--
**In-editor autocomplete**

!?[In editor auto-complete](images/autocomplete-opt.mp4)<!--
muted="true"
loop="true"
autoplay="true"
-->

#### Generate from comment description

!?[Generate code from comment](images/gen-from-comment-opt.mp4)<!--
muted="true"
loop="true"
autoplay="true"
-->

#### Generate in a chat

> Write a docstring for the `Token` class and all of it's methods

**This is with GPT-4o**

!?[Generate code in chat](images/gen-in-chat-opt.mp4)<!--
muted="true"
loop="true"
autoplay="true"
-->

#### Generate code from unit tests

> Generate a function called `make_tokens` based on the tests provided in `test_make_tokens`

!?[Generate code from tests](images/gen-from-tests-opt.mp4)<!--
muted="true"
loop="true"
autoplay="true"
-->

#### Generate unit tests from code

> Generate pytest style unit tests for the `make_tokens` function and the `Token` class

!?[Generate tests from code](images/gen-tests-opt.mp4)<!--
muted="true"
loop="true"
autoplay="true"
-->

#### Translation between languages (e.g. Python -> Perl)

> Convert the `tokenize` function into idiomatic Perl

!?[Converl Python to Perl](images/python-to-perl-opt.mp4)<!--
muted="true"
loop="true"
autoplay="true"
-->

#### Translation between technologies (e.g. SQL -> SQLAlchemy)

See [bad_sql_results.txt](bad_sql_results.txt)

### Pair programming

* Refactoring
* Explaining code

!?[Explain and refactor](images/pairprog-opt.mp4)<!--
muted="true"
loop="true"
autoplay="true"
-->

### Search engine

> What libraries are available to parse YAML in Python? What are their pros and cons?

!?[What YAML libraries are available in Python](images/yaml-opt.mp4)<!--
muted="true"
loop="true"
autoplay="true"
-->

### An example of bad results

> What libraries are available to decode YAML documents in the Elm language?

!?[Example of bad search engine results](images/bad-results-opt.mp4)<!--
muted="true"
loop="true"
autoplay="true"
-->

### Code review

> Review the code in `inference.py` and make concise suggestions about quality, security, readability, and performance.

!?[Code review](images/code-review-opt.mp4)<!--
muted="true"
loop="true"
autoplay="true"
-->

### Bug fixing

> There's a bug in the program where it doesn't print the last generated word. Can you suggest fixes?

!?[Code review](images/bugfix-opt.mp4)<!--
muted="true"
loop="true"
autoplay="true"
-->

## Ethics, security, and privacy

Brainstorm

## Demo: ChatGPT

1. Set custom context in ChatGPT:

> you are a machine learning developper in python. You use lightning-pytorch. You work in research field.

2. Describe the problem.

> I have eye tracking time-series data for patient with a certain age. I want to classify this time series based on age. Please suggest a list of good deep learning models.

3. Generate the python code to test this model

> Generate python code with the LSTM model

## Demo: `q`

* https://two-wrongs.com/q
* https://llm.datasette.io/

!?[q tool](images/q-opt.mp4)<!--
muted="true"
loop="true"
autoplay="true"
-->

## Explore tools

**Goal**: Make a real-world open-source contribution (or equivalent).

Now is a good time to install anything you would like to try out locally.
Also a good time to log into (or create accounts for) any services you might want to use:

* [OpenAI / ChatGPT](https://chatgpt.com)
* [Anthropic / Claude](https://claude.ai)
* [Replit](https://replit.com)
* [Codeium](https://codeium.com/)
* [Ollama](https://ollama.com/)
* [LLM](https://llm.datasette.io/)

## Use the tools for real

Try to understand the advantages and limitations of each tool.

**Some possibilities you could consider:**

* [Ollama](https://github.com/ollama/ollama/issues?q=is%3Aopen+is%3Aissue+label%3A%22good+first+issue%22+-linked%3Apr)
* [Polars dataframes](https://github.com/pola-rs/polars/issues?q=is%3Aopen+is%3Aissue+label%3A%22good+first+issue%22+-linked%3Apr)
* [Biopython](https://github.com/biopython/biopython/issues?q=is%3Aopen+is%3Aissue+label%3A%22good+first+issue%22+-linked%3Apr)
* [GGPlot2](https://github.com/tidyverse/ggplot2/issues/6178)
* [YAML](https://github.com/MaybeJustJames/yaml/issues?q=is%3Aissue+is%3Aopen+-linked%3Apr)
* [My small language model](#)

## Discussion

1. What worked well? Which use-case/tool combinations worked well?

2. Maybe useful / situational / it depends

3. Definitely not useful?

## Conclusion

**Do not give online models private or sensitive information**

**Do not blindly trust the output**

**Explore your options: things in this domain change very quickly**

**Are you planning to use any of the tools in this workshop?**