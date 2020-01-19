---
title: "Paper Review"
mathjax: true
comments: true
---

LSTM Recurrent Neural Networks for Short Text and Sentiment Classification

Nowak, Jakub, Ahmet Taspinar, and Rafał Scherer. *"LSTM recurrent neural networks for short text and sentiment classification."* International Conference on Artificial Intelligence and Soft Computing. Springer, Cham, 2017.

## Takeaway Message From the Paper
RNN models are superior in NLP than other models.
What is the motivation for this work (both people problem and technical problem), and its distillation into a research question?
In authors' word, 'Human communication is a very complex and complicated process. …. We use dictionaries, i.e. collections of words describing our surroundings, feelings, and thoughts. Very important is their order and context."  Statistical and Feed Forward Neural Nets don't take the order of the words in sentence into account. Thus a lot of the information is wasted.
## What is the proposed solution (hypothesis, idea, design)?
LSTM. When using this structure, we activate the same cell every time, modifying the state of its internal structure. The most important elements of LSTM cells are
– cell state – the state of the cell passed in sequence after to the next steps,
– forget gate – the gate that decides what information should be omitted,
– input gate – a gate that decides what should be forwarded to the next activation.
## What is the author’s evaluation of the solution? What logic, argument, evidence, artifacts (e.g., a proof-of-concept system), or experiments are presented in support of the idea?
Experiments run on Microsoft CNTK shows in small sentences GRU performed slightly better. And all other case, LSTM or BLSTM outperformed all other methods.

## What are the paper’s contributions (author’s and your opinion)? Ideas, methods, software, experimental results, experimental techniques...?
RNN is suitable for sequential problems.
## What is your analysis of the identified problem, idea and evaluation? Is this a good idea? What flaws do you perceive in the work? What are the most interesting or controversial ideas? For work that has practical implications, ask whether this will work, who would want it, what it will take to give it to them, and when might it become a reality?
This is a non-technical proof of the RNN's superiority in NLP. 
What are future directions for this research (author’s and yours, perhaps driven by shortcomings or other critiques)?
Memory requirements in the learning process is a problem. 

## What questions are you left with? What questions would you like to raise in an open discussion of the work (reviewinteresting and controversial points, above)? What do you find difficult to understand? List as many as you can
RNN, LSTM, Vanishing Gradient problem

**NOTE:** This are my personal point of view, uploading them here to keep up the writing habit for every paper that I read.