---
title: "Metrics for Classification"
comments: true
---

<h1>Table of Contents<span class="tocSkip"></span></h1>
<div class="toc"><ul class="toc-item"><li><span><a href="#binary-classification" data-toc-modified-id="Binary-Classification-1"><span class="toc-item-num">1&nbsp;&nbsp;</span>Binary Classification</a></span></li><li><span><a href="#multiclass-classification" data-toc-modified-id="Multiclass-Classification-2"><span class="toc-item-num">2&nbsp;&nbsp;</span>Multiclass Classification</a></span></li><li><span><a href="#3-multilabel-multiclass" data-toc-modified-id="3-Multilabel-Multiclass-3"><span class="toc-item-num">3&nbsp;&nbsp;</span>Multilabel Multiclass Classification</a></span><ul class="toc-item"><li><span><a href="#3.1-example-based-metrics" data-toc-modified-id="3.1-Example-based-Metrics-3.1"><span class="toc-item-num">3.1&nbsp;&nbsp;</span>Example based Metrics</a></span></li><li><span><a href="#3.2-label-based-metrics" data-toc-modified-id="3.2-Label-based-Metrics-3.2"><span class="toc-item-num">3.2&nbsp;&nbsp;</span>Label based Metrics</a></span></li></ul></li><li><span><a href="#references" data-toc-modified-id="References-4"><span class="toc-item-num">4&nbsp;&nbsp;</span>References</a></span></li></ul></div>


Notes

**Micro**. Calculate metrics globally by counting the total true positives, false negatives and false positives. This takes label imbalance into account.

**Macro**. Calculate metrics for each label, and find their unweighted mean. This does not take label imbalance into account. 

**Weighted**. Calculate metrics for each label, and find their average weighted by support (the number of true instances for each label). This alters ‘macro’ to account for label imbalance.


```python
import numpy as np
from sklearn import metrics as mt
import random
random.seed(133)
```

# Binary Classification


```python
ytrue = np.array([0,1,0,1,1,0]) # Ground Truth
yhat = np.array([0,1,1,1,0,1]) # Prediction

def confusion(ytrue,yhat):
    tp = 0 
    fp = 0 
    tn = 0 
    fn = 0 
    
    for i in range(len(ytrue)):
        if ytrue[i] == yhat[i] and yhat[i]==0: # tn
            tn+=1
        elif ytrue[i] == yhat[i] and yhat[i]==1: # tp
            tp+=1
        elif ytrue[i] != yhat[i] and yhat[i]==0: # fn
            fn+=1
        elif ytrue[i] != yhat[i] and yhat[i]==1: # fp
            fp+=1
        
    return [tn,fp,fn,tp]


def confusion_matrix(ytrue,yhat):
    """
    Ensure: |TN FP|
            |     | 
            |FN TP|
    """
    tn,fp,fn,tp = confusion(ytrue,yhat)
        
    return np.array([[tn,fp],[fn,tp]])


def accuracy(ytrue,yhat):
    """
    Require: ytrue, yhat. ndarray of shape (N,1). Each row is for one sample. Output can only be either 0 or 1.
    Ensure: the percentage of matches between y_true and y_hat
    """
    
    correct = 0
    for i in range(len(ytrue)):
        if ytrue[i]==yhat[i]:
            correct+=1
    return correct / float(len(ytrue))


def precision(ytrue,yhat):
    """
    Require: ytrue, yhat. ndarray of shape (N,1). Each row is for one sample.
    Ensure: Precision. The rate of false positives. Out of all the predicted positives, how many are actually positives.
    Application: when incorrectly labelling a spam as NOT SPAM is fine but labelling an important mail as SPAM is worse.
    """
    tn,fp,fn,tp = confusion(ytrue,yhat)
    return (tp / float(tp+fp))

def recall(ytrue,yhat):
    """
    Require: ytrue, yhat. ndarray of shape (N,1). Each row is for one sample.
    Ensure: Recall. The rate of false positives. Out of all the actual positives, how many are actually predicted positives.
    Application: how many is lablled as SPAM out of all actuall spams.
    """
    tn,fp,fn,tp = confusion(ytrue,yhat)
    return (tp / float(tp+fn))

def f1(ytrue,yhat):
    """
    Require: ytrue, yhat. ndarray of shape (N,1). Each row is for one sample.
    Ensure: f1-score. Harmonic mean of precision and recall.
    """
    r = recall(ytrue,yhat)
    p = precision(ytrue,yhat)
    return (2*((r*p)/(r+p)))

# --------------- test ------------------#
print(">>> confusion_matrix \n Custom: \n",confusion_matrix(ytrue,yhat), "\nsklearn: \n",mt.confusion_matrix(ytrue,yhat))
print(">>> Accuracy \n Custom: %f, sklearn: %f"%(accuracy(ytrue,yhat), mt.accuracy_score(ytrue,yhat)))
print(">>> Precision \n Custom: %f, sklearn: %f"%(precision(ytrue,yhat), mt.precision_score(ytrue,yhat)))
print(">>> Recall \n Custom: %f, sklearn: %f"%(recall(ytrue,yhat), mt.recall_score(ytrue,yhat)))
print(">>> f1 score \n Custom: %f, sklearn: %f"%(f1(ytrue,yhat), mt.f1_score(ytrue,yhat)))


```

    >>> confusion_matrix 
     Custom: 
     [[1 2]
     [1 2]] 
    sklearn: 
     [[1 2]
     [1 2]]
    >>> Accuracy 
     Custom: 0.500000, sklearn: 0.500000
    >>> Precision 
     Custom: 0.500000, sklearn: 0.500000
    >>> Recall 
     Custom: 0.666667, sklearn: 0.666667
    >>> f1 score 
     Custom: 0.571429, sklearn: 0.571429


# Multiclass Classification



```python
ytrue = [random.randint(0,2) for r in range(50)] # 3 classes: 0,1,2
yhat = [random.randint(0,2) for r in range(50)]

print(ytrue)
print(yhat)
def accuracy(ytrue,yhat):
    """
    Require: ytrue, yhat. ndarray of shape (N,1). Each row is for one sample. Output can only be 0 to N-1, where N is the number of classes.
    Ensure: the percentage of matches between y_true and y_hat
    """
    
    correct = 0
    for i in range(len(ytrue)):
        if ytrue[i]==yhat[i]:
            correct+=1
    return correct / float(len(ytrue))

def confusion_matrix(ytrue,yhat):
    """
                predicted
              0     1     2
           0 |              |
    truths 1 |              |
           2 |              |
    """
    
    classes = np.unique(np.concatenate((ytrue,yhat),axis=0))
    N = classes.shape[0]
    matrix = np.zeros((N,N))
    
    for i in range(len(ytrue)):
        matrix[ytrue[i],yhat[i]] += 1

    return matrix.astype(int)

def precision(ytrue,yhat,average='micro',return_class=False):
    matrix = confusion_matrix(ytrue,yhat)
    classes = np.unique(np.concatenate((ytrue,yhat),axis=0))
    N = classes.shape[0]
    SAMPLE = len(ytrue)
    tp = [] 
    fp = []
    for i in classes:
        tp.append(matrix[i,i])
        fp.append(sum([matrix[j,i] for j in classes])-matrix[i,i])
    
    if average == 'micro':
        sum_tp = sum(tp)
        sum_tp_fp = sum(tp+fp)
        pre = sum_tp / float(sum_tp_fp)
    elif average == 'macro':
        pre_class = [a/float(a+b) for a,b in zip(tp,fp)]
        pre = sum(pre_class) / float(N)
    elif average == 'weighted':
        pre_class = [a/float(a+b) for a,b in zip(tp,fp)]
        true_instances = []
        for i in classes:
            temp = 0
            for j in classes:
                temp+= matrix[i,j]
            true_instances.append(temp)
        
        pre = sum([p*s for p,s in zip(pre_class,true_instances)]) / float(SAMPLE)
        
    if return_class is True and average!='micro':
        return pre,pre_class
    else:
        return pre
    
    
    
def recall(ytrue,yhat,average='micro',return_class=False,return_support=False):

    matrix = confusion_matrix(ytrue,yhat)
    classes = np.unique(np.concatenate((ytrue,yhat),axis=0))
    N = classes.shape[0]
    SAMPLE = len(ytrue)
    
    tp = [] 
    fn = []
    
    for i in classes:
        tp.append(matrix[i,i])
        fn.append(sum([matrix[i,j] for j in classes])-matrix[i,i])
    
    if average == 'micro':
        """all tp / all (tp+fn)"""
        sum_tp = sum(tp)
        sum_tp_fn = sum(tp+fn)
        rec = sum_tp / float(sum_tp_fn)
        
    elif average == 'macro':
        """all pre / number of class. AKA simple average"""
        rec_class = [a/float(a+b) for a,b in zip(tp,fn)]
        rec = sum(rec_class) / float(N)
        
    elif average == 'weighted':
        """all (pre * support) / number of samples"""
        rec_class = [a/float(a+b) for a,b in zip(tp,fn)]
        true_instances = []
        for i in classes:
            temp = 0
            for j in classes:
                temp+= matrix[i,j]
            true_instances.append(temp)
        
        rec = sum([p*s for p,s in zip(rec_class,true_instances)]) / float(SAMPLE)
        
    if return_class is True and average!='micro':
        return rec,rec_class
    else:
        return rec

def f1(ytrue,yhat,average='micro'):
    """
    Require: ytrue, yhat. ndarray of shape (N,1). Each row is for one sample.
    Ensure: f1-score. Harmonic mean of precision and recall.
    """
    SAMPLE = len(ytrue)
    classes = np.unique(np.concatenate((ytrue,yhat),axis=0))
    N = classes.shape[0]
    if average=='micro':
        r = recall(ytrue,yhat,average='micro')
        p = precision(ytrue,yhat,average='micro')
        return (2*((r*p)/(r+p)))
    
    elif average=='macro':
        _,rec_class = recall(ytrue,yhat,average=average,return_class=True)
        _,pre_class = precision(ytrue,yhat,average,return_class=True)
        
        
        f1_class=[]
        for i in range(len(pre_class)):
            f1_class.append((2*((rec_class[i]*pre_class[i])/(rec_class[i]+pre_class[i]))))
        
        f1 = sum([f for f in f1_class]) / float(N)
        
        return f1
    
    elif average == 'weighted':
        _,rec_class = recall(ytrue,yhat,average=average,return_class=True)
        _,pre_class = precision(ytrue,yhat,average,return_class=True)
        
        
        f1_class=[]
        for i in range(len(pre_class)):
            f1_class.append((2*((rec_class[i]*pre_class[i])/(rec_class[i]+pre_class[i]))))
        
        
        support = np.zeros((len(pre_class),1))
        for i in ytrue:
            support[i]+=1
        
        
        
        f1 = sum([f*s for f,s in zip(f1_class,support)]) / float(SAMPLE)
        
        
    return f1
        

# --------------- test ------------------#

print(">>> confusion_matrix \n Custom: \n",confusion(ytrue,yhat), "\nsklearn: \n",mt.confusion_matrix(ytrue,yhat))
print(">>>Accuracy \n Custom: %f, sklearn: %f"%(accuracy(ytrue,yhat), mt.accuracy_score(ytrue,yhat)))
print(">>> Precision Micro \n Custom: %f, sklearn: %f"%(precision(ytrue,yhat,'micro'), mt.precision_score(ytrue,yhat,average='micro')))
print(">>> Precision Macro \n Custom: %f, sklearn: %f"%(precision(ytrue,yhat,'macro'), mt.precision_score(ytrue,yhat,average='macro')))
print(">>> Precision Weighted \n Custom: %f, sklearn: %f"%(precision(ytrue,yhat,'weighted'), mt.precision_score(ytrue,yhat,average='weighted')))

print(">>> Recall Micro \n Custom: %f, sklearn: %f"%(recall(ytrue,yhat,'micro'), mt.recall_score(ytrue,yhat,average='micro')))
print(">>> Recall Macro \n Custom: %f, sklearn: %f"%(recall(ytrue,yhat,'macro'), mt.recall_score(ytrue,yhat,average='macro')))
print(">>> Recall Weighted \n Custom: %f, sklearn: %f"%(recall(ytrue,yhat,'weighted'), mt.recall_score(ytrue,yhat,average='weighted')))

print(">>> f1 score Micro \n Custom: %f, sklearn: %f"%(f1(ytrue,yhat,'micro'), mt.f1_score(ytrue,yhat,average='micro')))
print(">>> f1 score Macro \n Custom: %f, sklearn: %f"%(f1(ytrue,yhat,'macro'), mt.f1_score(ytrue,yhat,average='macro')))
print(">>> f1 score weighted \n Custom: %f, sklearn: %f"%(f1(ytrue,yhat,'weighted'), mt.f1_score(ytrue,yhat,average='weighted')))

```

    [1, 1, 1, 1, 2, 1, 2, 2, 2, 2, 2, 0, 2, 0, 1, 2, 1, 1, 0, 0, 1, 2, 1, 0, 0, 1, 0, 0, 1, 1, 2, 2, 0, 1, 0, 2, 0, 2, 0, 2, 1, 0, 1, 1, 1, 0, 0, 2, 1, 1]
    [0, 0, 1, 0, 1, 1, 1, 2, 1, 1, 2, 2, 2, 2, 0, 2, 1, 1, 1, 2, 0, 1, 1, 0, 2, 1, 1, 1, 1, 1, 1, 2, 0, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1, 0, 1]
    >>> confusion_matrix 
     Custom: 
     [6, 11, 13, 9] 
    sklearn: 
     [[ 6  4  5]
     [10  9  1]
     [ 3  7  5]]
    >>>Accuracy 
     Custom: 0.400000, sklearn: 0.400000
    >>> Precision Micro 
     Custom: 0.400000, sklearn: 0.400000
    >>> Precision Macro 
     Custom: 0.406778, sklearn: 0.406778
    >>> Precision Weighted 
     Custom: 0.411100, sklearn: 0.411100
    >>> Recall Micro 
     Custom: 0.400000, sklearn: 0.400000
    >>> Recall Macro 
     Custom: 0.394444, sklearn: 0.394444
    >>> Recall Weighted 
     Custom: 0.400000, sklearn: 0.400000
    >>> f1 score Micro 
     Custom: 0.400000, sklearn: 0.400000
    >>> f1 score Macro 
     Custom: 0.395852, sklearn: 0.395852
    >>> f1 score weighted 
     Custom: 0.401267, sklearn: 0.401267


# 3 Multilabel Multiclass Classification

## 3.1 Example based Metrics
**Metrics**
* `exact match ratio` aka `subset accuracy` Optimal Value: 1
* `hamming_loss` Optimal Value: 0
* `Accuracy Exam` 
* `Precision Exam`
* `Recall Exam`
* `F1 exam`



```python
ytrue = np.array([[1, 1, 0, 1], [0, 0, 1, 1], [0, 0, 1, 0]])
yhat = np.array([[1, 0, 0, 1], [0, 0, 1, 1], [0, 0, 0, 0]])

def subset_accuracy(ytrue,yhat):
    N = ytrue.shape[1]
    SAMPLE = ytrue.shape[0]
    
    match = 0 
    for i in range(SAMPLE):
        if sum(ytrue[i]==yhat[i])==N:
            match+=1
    return match / float(SAMPLE)


def hamming_loss(ytrue,yhat):
    N = ytrue.shape[1]
    SAMPLE = ytrue.shape[0] 
    
    xor = sum(np.sum(ytrue!=yhat,axis=1))
    return xor/float(N*SAMPLE)

def accuracy_exam(ytrue,yhat):
    """
    Accuracy for each instance is defined as the proportion of the predicted CORRECT labels 
    to the total number (predicted and actual) of labels for that instance. 
    Overall accuracy is the average across all instances.
    A label is predicted if its value is 1.
    """
    N = ytrue.shape[1]
    SAMPLE = ytrue.shape[0]
    
    accuracy = 0
    for i in range(SAMPLE):
        intersection = 0
        union = 0
        for j in range(N):
            if ytrue[i,j] == yhat[i,j] and ytrue[i,j]==1:
                intersection+=1
            if ytrue[i,j]==1 or yhat[i,j]==1:
                union+=1
                
        if union!=0:
            accuracy += (intersection / float(union))
    return accuracy / float(SAMPLE)

def precision_exam(ytrue,yhat):
    """
    Precision is average over the proportion of predicted correct labels to the total number of actual labels.
    """
    N = ytrue.shape[1]
    SAMPLE = ytrue.shape[0]
    
    precision_sum = 0
    for i in range(SAMPLE):
        intersection = 0
        actual = sum(ytrue[i])
        for j in range(N):
            if ytrue[i,j] == yhat[i,j] and ytrue[i,j]==1:
                intersection+=1
                
        if actual!=0:
            precision_sum += (intersection / float(actual))
    return precision_sum / float(SAMPLE)

def recall_exam(ytrue,yhat):
    """
    Proportion of predicted correct labels to the total number of predicted labels, averaged over all instances.
    """
    N = ytrue.shape[1]
    SAMPLE = ytrue.shape[0]

    recall_sum = 0
    for i in range(SAMPLE):
        intersection = 0
        predicted_labels = sum(yhat[i])
        for j in range(N):
            if ytrue[i,j] == yhat[i,j] and ytrue[i,j]==1:
                intersection+=1

        if predicted_labels!=0:
            recall_sum += (intersection / float(predicted_labels))
    return recall_sum / float(SAMPLE)

def f1_exam(ytrue,yhat):
    N = ytrue.shape[1]
    SAMPLE = ytrue.shape[0]
    f1_sum = 0.0
    for i in range(SAMPLE):
        intersection = 0
        predicted = sum(yhat[i])
        actual = sum(ytrue[i])
        for j in range(N):
            if ytrue[i,j] == yhat[i,j] and ytrue[i,j]==1:
                intersection+=1
                
        f1_sum = f1_sum + ((2*intersection) / float(predicted+actual))
    
    return f1_sum / float(SAMPLE)

# sklearn returns "subset_accuracy" from accuracy_score() if ytrue,yhat are multilabel
print(">>> Subset Accuracy \n Custom: %f, sklearn: %f"%(subset_accuracy(ytrue,yhat), mt.accuracy_score(ytrue,yhat))) 
print(">>> Hamming Loss \n Custom: %f, sklearn: %f"%(hamming_loss(ytrue,yhat), mt.hamming_loss(ytrue,yhat))) 
print(">>> Accuracy Exam \n Custom: %f, sklearn: %s"%(accuracy_exam(ytrue,yhat)) 
print(">>> Precision Exam \n Custom: %f, sklearn: %s"%(precision_exam(ytrue,yhat))
print(">>> Recall Exam \n Custom: %f, sklearn: %s"%(recall_exam(ytrue,yhat))
print(">>> F1 Exam \n Custom: %f"%(f1_exam(ytrue,yhat))
```

    >>> Subset Accuracy 
     Custom: 0.333333, sklearn: 0.333333
    >>> Hamming Loss 
     Custom: 0.166667, sklearn: 0.166667
    >>> Accuracy Exam 
     Custom: 0.555556, sklearn: doesn't have accuracy_exam
    >>> Precision Exam 
     Custom: 0.555556, sklearn: doesn't have precision_exam
    >>> Recall Exam 
     Custom: 0.666667, sklearn: doesn't have recall_exam
    >>> F1 Exam 
     Custom: 0.600000, sklearn: doesn't have f1_exam


## 3.2 Label based Metrics

**Metrics**
* `Confusion Matrix` for each label
* `Precision Macro,Micro`
* `Recall Macro,Micro`
* `F1-score Macro,Micro`
* `F-beta Macro,Micro`


```python
ytrue = np.array([[1, 1, 0, 1], [0, 0, 1, 1], [0, 0, 1, 0]])
yhat = np.array([[1, 0, 0, 1], [0, 0, 1, 1], [0, 0, 0, 0]])
def confusion_matrix_labelwise(ytrue,yhat,verbose=False):
    """
    Returns labelwise tp,fp,fn,tp. 
    """
    L = ytrue.shape[1] # number of labels
    N = ytrue.shape[0] # number of samples
    confusion = np.zeros((L,4)) # list of lists, inner list will contain 0:tn, 1:fp, 2:fn, 3:tp
    
    for i in range(N):
        
        for j in range(L):
            
            if ytrue[i,j]==yhat[i,j] and ytrue[i,j]==1: # tp
                confusion[j,3]+=1
                
            elif ytrue[i,j]==yhat[i,j] and ytrue[i,j]==0: # tn
                confusion[j,0]+=1
                
            elif ytrue[i,j]!=yhat[i,j] and ytrue[i,j]==0: # fp
                confusion[j,1]+=1
            else:
                confusion[j,2] += 1
    if verbose is True:
        print('TN FP FN TP\n',confusion)
    return confusion   

def precision(ytrue,yhat,average='micro'):
    confusion = confusion_matrix_labelwise(ytrue,yhat) # col 0:tn, 1:fp, 2:fn, 3:tp
    L = ytrue.shape[1] # number of labels
    N = ytrue.shape[0] # number of samples
    
    if average=='micro': # micro sums everything, then calculates the global metric
        sums = np.sum(confusion,axis=0)
        tp = sums[3]
        tp_fp = tp + sums[1]
        
        if tp_fp!=0:
            precision = tp / float(tp_fp)
        else:
            precision = 0
    elif average=='macro': # macro calculates label wise precision, then averages
        pre = []
        for i in range(L):
            tp = confusion[i,3]
            tp_fp = tp + confusion[i,1]
            if tp_fp != 0:
                pre.append(tp/float(tp_fp))
            else:
                pre.append(0)
        precision = sum(pre)/float(L)
    return precision

def recall(ytrue,yhat,average='micro'):
    confusion = confusion_matrix_labelwise(ytrue,yhat) # col 0:tn, 1:fp, 2:fn, 3:tp
    L = ytrue.shape[1] # number of labels
    N = ytrue.shape[0] # number of samples
    
    if average=='micro': # micro sums everything, then calculates the global metric
        sums = np.sum(confusion,axis=0)
        tp = sums[3]
        tp_fn = tp + sums[2]
        
        if tp_fn!=0:
            recall = tp / float(tp_fn)
        else:
            recall = 0
    elif average=='macro': # macro calculates label wise precision, then averages
        rec = []
        for i in range(L):
            tp = confusion[i,3]
            tp_fn = tp + confusion[i,2]
            if tp_fn != 0:
                rec.append(tp/float(tp_fn))
            else:
                rec.append(0)
        recall =  sum(rec)/float(L)
    return recall

def f_beta(ytrue,yhat,beta=1,average='micro'):
    confusion = confusion_matrix_labelwise(ytrue,yhat) # rows are labels, cols are 0:tn, 1:fp, 2:fn, 3:tp
    L = ytrue.shape[1] # number of labels
    N = ytrue.shape[0] # number of samples
    f1 = 0
    if average=='macro':
        f1s = []
        for i in range(L):
            numerator = (1+(beta*beta))*confusion[i,3]
            denominator = (1+(beta*beta))*confusion[i,3] + (beta*beta)*confusion[i,2] + confusion[i,1]
            if denominator!=0:
                f1s.append(numerator / float(denominator))
        f1 = sum(f1s) / float(L)
    elif average=='micro':
        sums = np.sum(confusion,axis=0)
        tp = sums[3]
        fn = sums[2]
        fp = sums[1]
        numerator = (1+(beta*beta))*tp
        denominator = (1+(beta*beta))*tp + (beta*beta)*fn + fp
        if denominator!=0:
            f1 = numerator / float(denominator)
    return f1

print(">>> Precision Micro \n Custom:\n",confusion_matrix_labelwise(ytrue,yhat,verbose=False),'\n','sklearn: \n',mt.multilabel_confusion_matrix(ytrue,yhat))
print(">>> Precision Micro \n Custom: %f, sklearn: %f"%(precision(ytrue,yhat), mt.precision_score(ytrue,yhat,average='micro',zero_division=0)))
print(">>> Precision Macro \n Custom: %f, sklearn: %f"%(precision(ytrue,yhat,'macro'), mt.precision_score(ytrue,yhat,average='macro',zero_division=0)))
print(">>> Recall Micro\n Custom: %f, sklearn: %f"%(recall(ytrue,yhat),mt.recall_score(ytrue,yhat,average='micro',zero_division=0)))
print(">>> Recall Macro\n Custom: %f, sklearn: %f"%(recall(ytrue,yhat,'macro'), mt.recall_score(ytrue,yhat,average='macro',zero_division=0)))
print(">>> fbeta Macro\n Custom: %f, sklearn: %f"%(f_beta(ytrue,yhat,beta=1,average='macro'), mt.fbeta_score(ytrue,yhat,beta=1,average='macro',zero_division=0)))
print(">>> fbeta Micro\n Custom: %f, sklearn: %f"%(f_beta(ytrue,yhat,beta=1,average='micro'), mt.fbeta_score(ytrue,yhat,beta=1,average='micro',zero_division=0)))
```

    >>> Precision Micro 
     Custom:
     [[2. 0. 0. 1.]
     [2. 0. 1. 0.]
     [1. 0. 1. 1.]
     [1. 0. 0. 2.]] 
     sklearn: 
     [[[2 0]
      [0 1]]
    
     [[2 0]
      [1 0]]
    
     [[1 0]
      [1 1]]
    
     [[1 0]
      [0 2]]]
    >>> Precision Micro 
     Custom: 1.000000, sklearn: 1.000000
    >>> Precision Macro 
     Custom: 0.750000, sklearn: 0.750000
    >>> Recall Micro
     Custom: 0.666667, sklearn: 0.666667
    >>> Recall Macro
     Custom: 0.625000, sklearn: 0.625000
    beta:  1 <class 'int'>
    >>> fbeta Macro
     Custom: 0.666667, sklearn: 0.666667
    beta:  1 <class 'int'>
    >>> fbeta Micro
     Custom: 0.800000, sklearn: 0.800000


# References
1. https://www.youtube.com/watch?v=FAr2GmWNbT0
2. https://datascience.stackexchange.com/a/24051
3. Scikit-learn: Machine Learning in Python, Pedregosa et al., JMLR 12, pp. 2825-2830, 2011.
5. M. Zhang and Z. Zhou, "A Review on Multi-Label Learning Algorithms," in IEEE Transactions on Knowledge and Data Engineering, vol. 26, no. 8, pp. 1819-1837, Aug. 2014.
2. Sorower, Mohammad S. "A literature survey on algorithms for multi-label learning." Oregon State University, Corvallis 18 (2010): 1-25.
