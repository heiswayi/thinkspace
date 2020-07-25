---
title: "Bagging | Idea and Implementation"
comments: True
---
Bagging, random forest, and boosting are statistical approach to further enhance already available algorithms. They all seem to deal with multiple training of a models on the same dataset. Let's look at the idea behind these.

# Bagging

Consider a decision tree. When I split a dataset, and fit two distinct decision tree on those two halves, it will give different outputs. Meaning, our models will have high variance. Bagging or Bootstrap Aggragation comes from this problem. It is a general purpose approach for reducing the variance of models.

Theoretically, averaging samples reduces the variance. That's what mean are for, right? So, to solve the problem above, we can just train multiple models, get their predictions, average them, and voila! This is what bagging is. But how can we get multiple dataset though? We use [bootstrap](https://en.wikipedia.org/wiki/Bootstrapping_%28statistics%29) for that. Bootstrap will generate B different training datasets from one single dataset. We will train on $$b_{th}$$ dataset to get $$f_b(x)$$. When producing prediction, we will do average of all the $$f_b(x)$$. For a single sample $x$, the equation stands,

$$
\hat{f}_{bag}(x) = \frac{1}{B} \sum_{b=1}^{B} f_b(x)
$$

## Implementation in Python


```python
import numpy as np
from sklearn.datasets import make_regression
from sklearn.ensemble import BaggingRegressor
import importlib
```


```python
class Bagging:
    def __init__(self, B, modelName='sklearn.linear_model.LinearRegression'):
        """
        params
        ------
        B: int. 
            B separate datasets will be generated.
        
        modelName: str. 
            A sklearn Estimator for regression. Module name and model name must be separated by dot(.). Default: "sklearn.linear_model.LinearRegressor"
        
        returns
        -------
        
        """
        self.B = B
        self.modelName = modelName.split(".")
        
    def fit(self, X, y):
        """
        Fits B model to B datasets.
        
        params
        ------
        X, y: typical input ndarray.
        """
        nSamples, nFeats = X.shape
        np.random.seed(0)
        indices = np.random.randint(0, nSamples, size=(self.B, nSamples))
        self.module = importlib.import_module(self.modelName[0]+"."+self.modelName[1])
        self.modelContainer = []
        
        for i in range(self.B):
            estimator = eval('self.module.'+self.modelName[2]+"()")
            estimator.fit(X = X[ indices[i] ], y = y[ indices[i] ])
            self.modelContainer.append(estimator)
        
        return self
    
    def predict(self, X):
        """
        Averages outputs from B model to predict each observations.
        
        params
        ------
        X: typical input ndarray.
        """
        nSamples, nFeats = X.shape
        Y = np.zeros((nSamples, self.B)) # output for each model is a column vector. output for each sample is row vector
        for i in range(self.B):
            model = self.modelContainer[i]
            Y[:,i] = model.predict(X)
        
        y = Y.sum(axis=1) / self.B
        
        return y
```

Trying out the model


```python
X, y = make_regression(n_samples=100, n_features=4,
                       n_informative=2, n_targets=1,
                       random_state=0, shuffle=False)
X.shape, y.shape
```
```output
((100, 4), (100,))
```

sklearn's model

```python
from sklearn.linear_model import LinearRegression
regr = BaggingRegressor(base_estimator=LinearRegression(),
                        n_estimators=10, random_state=0).fit(X, y)
regr.predict([[0, 0, 0, 0]])
```




    array([1.54321e-15])



Our Model


```python
bag = Bagging(10)
bag.fit(X,y)
bag.predict(np.array([[0,0,0,0]]))
```




    array([6.99440506e-16])



Nice!
