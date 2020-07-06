---
title: "Multinomial Naive Bayes from Scratch"
comments: True
mathjax: True
---
Multinomial naive bayes is the naive Bayes algorithm for multinomially distributed data. For a brief and intuitive explanation of Bayes theorem, read this kernel of mine: [Gaussian Naive Bayes Classifier from Scratch](https://www.kaggle.com/riyadhrazzaq/gaussian-naive-bayes-classifier). Everything is similar to Gaussian NB except the $$P(x_i \mid y)$$. The new equation is, 
$$
P(x_i \mid y) = \frac{N_{yi} + \alpha}{N_y + \alpha n} \label{eq1}\tag{1}
$$ 
Here, 
* $$\alpha$$ is the smoothing parameter, 
* $$N_{yi}$$ is the count of feature $$x_i$$ in class y.
* $$N_y$$ is the total count of all features in class y
* $$n$$ is the total number of features

# Multinomial Naive Bayes
You can look up in detail about multinomial distribution and you should. I will only put a short description of how a multinomial naive bayes classifier considers data. 
## Multinomial Data

| $$X_1$$  | $$X_2$$  | $$X_3$$  |
|---|---|---|
| 1 | 0 | 4 |
| 4 | 2 | 3 |

In the table above containing 2 sample of 3 features, we observe that feature $$X_1$$ has values 1 and 4, and so on. That is the common view of the data. And when other a general model accepts this data, it considers each number as value. For example, $$X_{1,2}=3$$. But in case of reading a multinomial data, $$X_{1,2}$$ says how many of feature $$X_{2}$$ is in sample 1. Meaning $$X_{1,2}$$ is not value of the feature, instead it is the count of the feature. Let's consider a text corpus. Each sentence is made up of different words $$w_i$$ and each of those $$w_i$$ belongs to the vocabulary, $$V$$. If $$V$$ contains 8 words, $$w_1,w_2,...,w_8$$ and if a sentence is: w1 w2 w2 w6 w3 w2 w8, the representation of that sentence will be- 

|$$w_1$$|$$w_2$$|$$w_3$$|$$w_4$$|$$w_5$$|$$w_6$$|$$w_7$$|$$w_8$$|
|---|---|---|---|---|---|---|---|
| 1|3 |1 | 0| 0|1 | 0|1 |

After inserting some other random sentences, the dataset is-

|$$w_1$$|$$w_2$$|$$w_3$$|$$w_4$$|$$w_5$$|$$w_6$$|$$w_7$$|$$w_8$$|
|---|---|---|---|---|---|---|---|
| 1|3 |1 | 0| 0|1 | 0|1 |
| 1|0 |0 | 0| 1|1 | 1|3 |
| 0|0 |0 | 0| 0|2 | 1|2 |

By the way, I haven't put them in a class. Randomly taking, $$y$$ = [1,0,1]. Now, comparing with the equation of above,

* $$N_{yi}$$ is the count of feature $$w_i$$ in each unique class of y. For example, for $$y=1$$, 
$$N_{y,1}=1, N_{y,6}=3$$
* $$N_y$$ is the total count of all features in each unique class of y. For example, for $$y=1$$, 
$$N_y=12$$
* $$n=8$$ is the total number of features
* $$\alpha$$ is known as smoothing parameter. It is needed for zero probability problem which is explained in resource [1]

To calculate likelyhoods for a test sentence, all we need is $$P(w_i \mid y)$$ which will be used to calculate $$P(X \mid y)$$ from training data. But $$P(w_i \mid y)$$ is the probability of feature $$w_i$$ appearing under class y once. If our test sentence has any feature $$w_i$$ n times, we will need to include $$P(w_i \mid y)$$ in $$P(X \mid y)$$ n times too. So, final equation for $$P(X_i \mid y)$$ will be-

$$
P(X_i \mid y) = P(w_1 \mid y)^{X_{i,1}} \times P(w_2 \mid y)^{X_{i,2}} \times ... \times P(w_n \mid y)^{X_{i,n}}
$$


Resources:
1. https://www.inf.ed.ac.uk/teaching/courses/inf2b/learnnotes/inf2b-learn07-notes-nup.pdf
2. https://scikit-learn.org/stable/modules/naive_bayes.html#multinomial-naive-bayes

### Some libraries and test data

```python
import numpy as np
import pandas as pd
from sklearn.naive_bayes import MultinomialNB
from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split 
```


```python
# test data
tmpX1 = np.array([int(i.strip()) for i in "2   0   0   0   1   2   3   1  0   0   1   0   2   1   0   0  0   1   0   1   0   2   1   0  1   0   0   2   0   1   0   1  2   0   0   0   1   0   1   3  0   0   1   2   0   0   2   1".split("  ")])
tmpX2 = np.array([int(i.strip()) for i in "0   1   1   0   0   0   1   0  1   2   0   1   0   0   1   1  0   1   1   0   0   2   0   0  0   0   0   0   0   0   0   0  0   0   1   0   1   0   1   0".split("  ")])
X = np.concatenate((tmpX1.reshape(-1,8), tmpX2.reshape(-1,8)), axis=0)
y = np.array([0,0,0,0,0,0,1,1,1,1,1])
X_test = np.array([[2,1,0,0,1,2,0,1],[0,1,1,0,1,0,1,0]])
y_test = np.array([0,1])
print("X and Y shapes\n", X.shape, y.shape)
```

    X and Y shapes
     (11, 8) (11,)


# Class MultiNB


```python
class MultiNB:
    def __init__(self,alpha=1):
        self.alpha = alpha
    
    def _prior(self): # CHECKED
        """
        Calculates prior for each unique class in y. P(y)
        """
        P = np.zeros((self.n_classes_))
        _, self.dist = np.unique(self.y,return_counts=True)
        for i in range(self.classes_.shape[0]):
            P[i] = self.dist[i] / self.n_samples
        return P
            
    def fit(self, X, y): # CHECKED, matches with sklearn
        """
        Calculates the following things- 
            class_priors_ is list of priors for each y.
            N_yi: 2D array. Contains for each class in y, the number of time each feature i appears under y.
            N_y: 1D array. Contains for each class in y, the number of all features appear under y.
            
        params
        ------
        X: 2D array. shape(n_samples, n_features)
            Multinomial data
        y: 1D array. shape(n_samples,). Labels must be encoded to integers.
        """
        self.y = y
        self.n_samples, self.n_features = X.shape
        self.classes_ = np.unique(y)
        self.n_classes_ = self.classes_.shape[0]
        self.class_priors_ = self._prior()
        
        # distinct values in each features
        self.uniques = []
        for i in range(self.n_features):
            tmp = np.unique(X[:,i])
            self.uniques.append( tmp )
            
        self.N_yi = np.zeros((self.n_classes_, self.n_features)) # feature count
        self.N_y = np.zeros((self.n_classes_)) # total count 
        for i in self.classes_: # x axis
            indices = np.argwhere(self.y==i).flatten()
            columnwise_sum = []
            for j in range(self.n_features): # y axis
                columnwise_sum.append(np.sum(X[indices,j]))
                
            self.N_yi[i] = columnwise_sum # 2d
            self.N_y[i] = np.sum(columnwise_sum) # 1d
            
    def _theta(self, x_i, i, h):
        """
        Calculates theta_yi. aka P(xi | y) using eqn(1) in the notebook.
        
        params
        ------
        x_i: int. 
            feature x_i
            
        i: int.
            feature index. 
            
        h: int or string.
            a class in y
        
        returns
        -------
        theta_yi: P(xi | y)
        """
        
        Nyi = self.N_yi[h,i]
        Ny  = self.N_y[h]
        
        numerator = Nyi + self.alpha
        denominator = Ny + (self.alpha * self.n_features)
        
        return  (numerator / denominator)**x_i
    
    def _likelyhood(self, x, h):
        """
        Calculates P(E|H) = P(E1|H) * P(E2|H) .. * P(En|H).
        
        params
        ------
        x: array. shape(n_features,)
            a row of data.
        h: int. 
            a class in y
        """
        tmp = []
        for i in range(x.shape[0]):
            tmp.append(self._theta(x[i], i,h))
        
        return np.prod(tmp)
    
    def predict(self, X):
        samples, features = X.shape
        self.predict_proba = np.zeros((samples,self.n_classes_))
        
        for i in range(X.shape[0]):
            joint_likelyhood = np.zeros((self.n_classes_))
            
            for h in range(self.n_classes_):
                joint_likelyhood[h]  = self.class_priors_[h] * self._likelyhood(X[i],h) # P(y) P(X|y) 
                
            denominator = np.sum(joint_likelyhood)
            
            for h in range(self.n_classes_):
                numerator = joint_likelyhood[h]
                self.predict_proba[i,h] = (numerator / denominator)
            
        indices = np.argmax(self.predict_proba,axis=1)
        return self.classes_[indices]
```


```python
def pipeline(X,y,X_test, y_test, alpha):
    """
    Sklearn Sanity Check
    """
    print("-"*20,'Sklearn',"-"*20)
    clf = MultinomialNB(alpha=alpha)
    clf.fit(X,y)
    sk_y = clf.predict(X_test)
    print("Feature Count \n",clf.feature_count_)
    print("Class Log Prior ",clf.class_log_prior_)
    print('Accuracy ',accuracy_score(y_test, sk_y),sk_y)
    print(clf.predict_proba(X_test))
    print("-"*20,'Custom',"-"*20)
    nb = MultiNB(alpha=alpha)
    nb.fit(X,y)
    yhat = nb.predict(X_test)
    me_score = accuracy_score(y_test, yhat)
    print("Feature Count\n",nb.N_yi)
    print("Class Log Prior ",np.log(nb.class_priors_))
    print('Accuracy ',me_score,yhat)
    print(nb.predict_proba) # my predict proba is only for last test set

```


```python
pipeline(X,y,X,y, alpha=1)
```

    -------------------- Sklearn --------------------
    Feature Count 
     [[5. 1. 2. 5. 4. 6. 7. 6.]
     [1. 4. 3. 1. 1. 2. 3. 1.]]
    Class Log Prior  [-0.6061358  -0.78845736]
    Accuracy  0.8181818181818182 [0 0 0 0 0 0 1 1 1 0 0]
    [[0.74940942 0.25059058]
     [0.52879735 0.47120265]
     [0.53711475 0.46288525]
     [0.69613326 0.30386674]
     [0.75239818 0.24760182]
     [0.62207341 0.37792659]
     [0.39213534 0.60786466]
     [0.45705923 0.54294077]
     [0.42055705 0.57944295]
     [0.54545455 0.45454545]
     [0.51099295 0.48900705]]
    -------------------- Custom --------------------
    Feature Count
     [[5. 1. 2. 5. 4. 6. 7. 6.]
     [1. 4. 3. 1. 1. 2. 3. 1.]]
    Class Log Prior  [-0.6061358  -0.78845736]
    Accuracy  0.8181818181818182 [0 0 0 0 0 0 1 1 1 0 0]
    [[0.74940942 0.25059058]
     [0.52879735 0.47120265]
     [0.53711475 0.46288525]
     [0.69613326 0.30386674]
     [0.75239818 0.24760182]
     [0.62207341 0.37792659]
     [0.39213534 0.60786466]
     [0.45705923 0.54294077]
     [0.42055705 0.57944295]
     [0.54545455 0.45454545]
     [0.51099295 0.48900705]]


# Spam Classification


```python
from nltk.corpus import stopwords
import string
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.preprocessing import LabelBinarizer
```


```python
df = pd.read_csv("../data/spam_uci.csv",encoding='iso8859_14')
df.drop(labels=df.columns[2:],axis=1,inplace=True)
df.columns=['target','text']
```

## Simple Preprocessing
to cleanup punctuations and stopwords


```python
def clean_util(text):
    punc_rmv = [char for char in text if char not in string.punctuation]
    punc_rmv = "".join(punc_rmv)
    stopword_rmv = [w.strip().lower() for w in punc_rmv.split() if w.strip().lower() not in stopwords.words('english')]
    
    return " ".join(stopword_rmv)
```


```python
df['text'] = df['text'].apply(clean_util)
```

# Vectorizing
Conforming the texts to the multinomial format we have discussed in the beginning. Also, classes in y must be converted to integers as I forgot to account for strings in my implementation and too lazy to update  •͡˘㇁•͡˘ 


```python
cv = CountVectorizer()
X = cv.fit_transform(df['text']).toarray()
lb = LabelBinarizer()
y = lb.fit_transform(df['target']).ravel()
print(X.shape,y.shape)
```

    (5572, 9381) (5572,)



```python
# Train Test Split
X_train, X_test, y_train, y_test = train_test_split(X,y)
print(X_train.shape, X_test.shape, y_train.shape, y_test.shape)
```

    (4179, 9381) (1393, 9381) (4179,) (1393,)


sklearn's `MultinomialNB`


```python
sk = MultinomialNB().fit(X_train,y_train)
sk.score(X_test,y_test)
```
```
0.9755922469490309
```
our `MultiNB` (⌐■_■)


```python
%%time
me = MultiNB()
me.fit(X_train, y_train)
yhat = me.predict(X_test)
print(accuracy_score(y_test,yhat))
```
```
0.9755922469490309
CPU times: user 1min 5s, sys: 0 ns, total: 1min 5s
Wall time: 1min 5s
```
It takes a lot of time but does not matter as it is a reference implementation only ヽ(｀Д´)ﾉ

**I wrote the scratch implementation for my learning, if you see any error or typo, please let me know.**
