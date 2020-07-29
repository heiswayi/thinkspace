---
title: "Idea and Implementation / Random Forest"
mathjax: True
comments: True
---
# Random Forest

RF is similar to bagging with one difference. While training each of $$B$$ datasets, bagging considers all the features $$p_i$$, RF does not. This is a way to decorrelate individual models. RF is mostly use with decision tree and the idea behind it seems clear and intuitive in that case. 

In normal situation, one tree is grown with all features. And in these features, some might be strong predictors. Therefore, while growing multiple trees, most of them will use the strong features in their top split. Hence, the predictions will be highly correlated and our goal to reduce variance will be slightly derailed. 

A key property in RF is the choice of $$m$$, the number of features to consider each split. If we use this feature subsets, then on average, $$(p-m)/p$$ splits will not even consider the strong predictors, and others will. This will decorrelate the trees, and the average of the predictions will be less variable. 

## Implementation


```python
class RF:
    """
    Implements RF from scratch with scikit learn's DecisionTreeRegressor.
    """
    def __init__(self, B, m):
        """
        params
        ------
        B: int.
            Number of trees in the forest.
        
        m: int.
            Number of features to consider in each tree.
        """
        self.B = B
        self.m = m
        
    def fit(self, X, y):
        nSamples = X.shape[0]
        np.random.seed(100)
        indices = np.random.randint(0, nSamples, size=(self.B, nSamples))
        
        self.modelContainer = []
        for i in range(self.B):
            model = DecisionTreeRegressor(max_features=self.m) # max_features is sklearn's 'm' variable
            model.fit(X, y)
            self.modelContainer.append(model)
        
    def predict(self, X):
        nSamples = X.shape[0]
        Y = np.zeros((nSamples, self.B))
        for i in range(self.B):
            model = self.modelContainer[i]
            Y[:,i] = model.predict(X)
        y = Y.sum(axis=1) / self.B
        return y        
```

## Trying out the models

sklearn's


```python
from sklearn.ensemble import RandomForestRegressor
sk = RandomForestRegressor(10, max_features=3, random_state=100)
sk.fit(X,y)
sk.predict([[0,0,0,0]])
```




    array([2.27887587])



ours


```python
rfr = RF(B=10, m=3)
rfr.fit(X,y)
rfr.predict(np.array([[0,0,0,0]]))
```




    array([3.20605521])



# References
1. Freund, Yoav, and Robert E. Schapire. "A desicion-theoretic generalization of on-line learning and an application to boosting." European conference on computational learning theory. Springer, Berlin, Heidelberg, 1995.
1. Hastie, Trevor, Robert Tibshirani, and Jerome Friedman. The elements of statistical learning: data mining, inference, and prediction. Springer Science & Business Media, 2009.
2. James, Gareth, et al. An introduction to statistical learning. Vol. 112. New York: springer, 2013.
