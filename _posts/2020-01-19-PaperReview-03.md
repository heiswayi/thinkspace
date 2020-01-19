---
title: "Paper Review [Keyphrase Extraction, DRNN, Twitter]"
comments: true
---
Keyphrase Extraction Using Deep Recurrent Neural Networks on Twitter

Zhang, Qi, et al. *"Keyphrase extraction using deep recurrent neural networks on twitter."* Proceedings of the 2016 conference on empirical methods in natural language processing. 2016.

### Takeaway Message From the Paper
Keyphrases are better at explaining the document that keywords. Keyword extraction is done to achieve keyphrase extraction.
### What is the proposed solution (hypothesis, idea, design)?
Input layer of the deep recurrent neural network is word embedding, first hidden layer extracts keyword, second hidden layer determines whether that keyword is single keyword, beginning of a keyphrase, middle of keyphrase, end of a keyphrase or not part of the keyphrase.

### What is the author’s evaluation of the solution? What logic, argument, evidence, artifacts (e.g., a proof-of-concept system), or experiments are presented in support of the idea?
Comparison was done with other methods. Proposed work resulted in better score.
### What are the paper’s contributions (author’s and your opinion)? Ideas, methods, software, experimental results, experimental techniques...?
Jointly extracting the keyword and keyphrase using Joint Layer Recurrent Neural Networks. 
### What are future directions for this research (author’s and yours, perhaps driven by shortcomings or other critiques)?
Since the model is a bit complex, I had expected the result would be much higher, around 90%. Has to find out why the score is lower than expected.


