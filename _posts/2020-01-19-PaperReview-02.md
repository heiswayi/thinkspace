---
title: "Paper Review [Keyword Extraction, SVM]"
comments: true
---
Keyword Extraction Using Support Vector Machine

Zhang, Kuo, et al. *"Keyword extraction using support vector machine."* international conference on web-age information management. Springer, Berlin, Heidelberg, 2006.

### Takeaway Message From the Paper
Keyword extraction problem presented as classification problem. 
### What is the motivation for this work (both people problem and technical problem), and its distillation into a research question?
Statistical Method such as Tfidf etc are less efficient in keyword extraction. Also, some methods uses defined words/phrases to use as keywords in new document. This restricts the possibility to find better words/phrases for keyword. Proposed method solves this.
### What is the proposed solution (hypothesis, idea, design)?
If any tags can be labeled as good or bad, then the input -> label can be trained using ML algorithms. Authors used training set's  keyword/phrases' feature vector as input. Label as output. And finally, from test document, used tri-gram method to select some number of word/phrase, turned them into feature vector, passed them to the trained model, got the label. If it's good, then used as a tag/keyword, else discarded. 
### What is the author’s evaluation of the solution? What logic, argument, evidence, artifacts (e.g., a proof-of-concept system), or experiments are presented in support of the idea?
Better result in the experiment, also showed that this resulted keywords helps to classify document compared to other method without keyword. 
### What are the paper’s contributions (author’s and your opinion)? Ideas, methods, software, experimental results, experimental techniques...?
The idea to present word/phrase selecting problem as classification problem. I, myself thought input should be the document. But this is more neat and faster on the memory. 
### What are future directions for this research (author’s and yours, perhaps driven by shortcomings or other critiques)?
word/phrase to feature vector can be done better now, with algos such as word2vec, glove.


