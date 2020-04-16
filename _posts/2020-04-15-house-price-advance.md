---
title: "House Prices Prediction with Decision Tree"
comments: True
---
<h1>Table of Contents<span class="tocSkip"></span></h1>
<div class="toc"><ul class="toc-item"><li><span><a href="#loading-Data" data-toc-modified-id="Loading-Data-1"><span class="toc-item-num">1&nbsp;&nbsp;</span>Loading Data</a></span><ul class="toc-item"><li><span><a href="#declare-tasks-for-linear-regression" data-toc-modified-id="Declare-tasks-for-linear-regression-1.1"><span class="toc-item-num">1.1&nbsp;&nbsp;</span>Declare tasks for linear regression</a></span></li></ul></li><li><span><a href="#preprocessing" data-toc-modified-id="Preprocessing-2"><span class="toc-item-num">2&nbsp;&nbsp;</span>Preprocessing</a></span><ul class="toc-item"><li><span><a href="#null-value" data-toc-modified-id="Null-Value-2.1"><span class="toc-item-num">2.1&nbsp;&nbsp;</span>Null Value</a></span></li><li><span><a href="#categorical-values" data-toc-modified-id="Categorical-Values-2.2"><span class="toc-item-num">2.2&nbsp;&nbsp;</span>Categorical Values</a></span></li></ul></li><li><span><a href="#decision-tree" data-toc-modified-id="Decision-Tree-3"><span class="toc-item-num">3&nbsp;&nbsp;</span>Decision Tree</a></span><ul class="toc-item"><li><span><a href="#evaluation-measure" data-toc-modified-id="Evaluation-Measure-3.1"><span class="toc-item-num">3.1&nbsp;&nbsp;</span>Evaluation Measure</a></span></li></ul></li><li><span><a href="#submission-file" data-toc-modified-id="Submission-File-4"><span class="toc-item-num">4&nbsp;&nbsp;</span>Submission File</a></span></li></ul></div>


```python
import math
import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)
import matplotlib.pyplot as plt
from sklearn.impute import SimpleImputer
from sklearn.tree import DecisionTreeRegressor
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
import seaborn as sns


pd.set_option('display.max_columns',None)
```

# Loading Data
*source: https://www.kaggle.com/c/house-prices-advanced-regression-techniques*


```python
DATA = '/home/strange/shob/pywork/data/house-price-advanced-regression-KAGGLE/'
```


```python
nTrain = pd.read_csv(f"{DATA}train.csv")
nTest = pd.read_csv(f"{DATA}test.csv")
```


```python
print(nTrain.head().to_markdown())
```

    |    |   Id |   MSSubClass |   MSZoning |   LotFrontage |   LotArea |   Street |   Alley |   LotShape |   LandContour |   Utilities |   LotConfig |   LandSlope |   Neighborhood |   Condition1 |   Condition2 |   BldgType |   HouseStyle |   OverallQual |   OverallCond |   YearBuilt |   YearRemodAdd |   RoofStyle |   RoofMatl |   Exterior1st |   Exterior2nd |   MasVnrType |   MasVnrArea |   ExterQual |   ExterCond |   Foundation |   BsmtQual |   BsmtCond |   BsmtExposure |   BsmtFinType1 |   BsmtFinSF1 |   BsmtFinType2 |   BsmtFinSF2 |   BsmtUnfSF |   TotalBsmtSF |   Heating |   HeatingQC |   CentralAir |   Electrical |   1stFlrSF |   2ndFlrSF |   LowQualFinSF |   GrLivArea |   BsmtFullBath |   BsmtHalfBath |   FullBath |   HalfBath |   BedroomAbvGr |   KitchenAbvGr |   KitchenQual |   TotRmsAbvGrd |   Functional |   Fireplaces |   FireplaceQu |   GarageType |   GarageYrBlt |   GarageFinish |   GarageCars |   GarageArea |   GarageQual |   GarageCond |   PavedDrive |   WoodDeckSF |   OpenPorchSF |   EnclosedPorch |   3SsnPorch |   ScreenPorch |   PoolArea |   PoolQC |   Fence |   MiscFeature |   MiscVal |   MoSold |   YrSold |   SaleType |   SaleCondition |   SalePrice |
    |---:|-----:|-------------:|-----------:|--------------:|----------:|---------:|--------:|-----------:|--------------:|------------:|------------:|------------:|---------------:|-------------:|-------------:|-----------:|-------------:|--------------:|--------------:|------------:|---------------:|------------:|-----------:|--------------:|--------------:|-------------:|-------------:|------------:|------------:|-------------:|-----------:|-----------:|---------------:|---------------:|-------------:|---------------:|-------------:|------------:|--------------:|----------:|------------:|-------------:|-------------:|-----------:|-----------:|---------------:|------------:|---------------:|---------------:|-----------:|-----------:|---------------:|---------------:|--------------:|---------------:|-------------:|-------------:|--------------:|-------------:|--------------:|---------------:|-------------:|-------------:|-------------:|-------------:|-------------:|-------------:|--------------:|----------------:|------------:|--------------:|-----------:|---------:|--------:|--------------:|----------:|---------:|---------:|-----------:|----------------:|------------:|
    |  0 |    1 |           60 |          3 |            65 |      8450 |        1 |       0 |          3 |             3 |           0 |           4 |           0 |              5 |            2 |            2 |          0 |            5 |             7 |             5 |        2003 |           2003 |           1 |          1 |            12 |            13 |            1 |          196 |           2 |           4 |            2 |          2 |          3 |              3 |              2 |          706 |              5 |            0 |         150 |           856 |         1 |           0 |            1 |            4 |        856 |        854 |              0 |        1710 |              1 |              0 |          2 |          1 |              3 |              1 |             2 |              8 |            6 |            0 |             2 |            1 |          2003 |              1 |            2 |          548 |            4 |            4 |            2 |            0 |            61 |               0 |           0 |             0 |          0 |        2 |       2 |             2 |         0 |        2 |     2008 |          8 |               4 |      208500 |
    |  1 |    2 |           20 |          3 |            80 |      9600 |        1 |       0 |          3 |             3 |           0 |           2 |           0 |             24 |            1 |            2 |          0 |            2 |             6 |             8 |        1976 |           1976 |           1 |          1 |             8 |             8 |            2 |            0 |           3 |           4 |            1 |          2 |          3 |              1 |              0 |          978 |              5 |            0 |         284 |          1262 |         1 |           0 |            1 |            4 |       1262 |          0 |              0 |        1262 |              0 |              1 |          2 |          0 |              3 |              1 |             3 |              6 |            6 |            1 |             4 |            1 |          1976 |              1 |            2 |          460 |            4 |            4 |            2 |          298 |             0 |               0 |           0 |             0 |          0 |        2 |       2 |             2 |         0 |        5 |     2007 |          8 |               4 |      181500 |
    |  2 |    3 |           60 |          3 |            68 |     11250 |        1 |       0 |          0 |             3 |           0 |           4 |           0 |              5 |            2 |            2 |          0 |            5 |             7 |             5 |        2001 |           2002 |           1 |          1 |            12 |            13 |            1 |          162 |           2 |           4 |            2 |          2 |          3 |              2 |              2 |          486 |              5 |            0 |         434 |           920 |         1 |           0 |            1 |            4 |        920 |        866 |              0 |        1786 |              1 |              0 |          2 |          1 |              3 |              1 |             2 |              6 |            6 |            1 |             4 |            1 |          2001 |              1 |            2 |          608 |            4 |            4 |            2 |            0 |            42 |               0 |           0 |             0 |          0 |        2 |       2 |             2 |         0 |        9 |     2008 |          8 |               4 |      223500 |
    |  3 |    4 |           70 |          3 |            60 |      9550 |        1 |       0 |          0 |             3 |           0 |           0 |           0 |              6 |            2 |            2 |          0 |            5 |             7 |             5 |        1915 |           1970 |           1 |          1 |            13 |            15 |            2 |            0 |           3 |           4 |            0 |          3 |          1 |              3 |              0 |          216 |              5 |            0 |         540 |           756 |         1 |           2 |            1 |            4 |        961 |        756 |              0 |        1717 |              1 |              0 |          1 |          0 |              3 |              1 |             2 |              7 |            6 |            1 |             2 |            5 |          1998 |              2 |            3 |          642 |            4 |            4 |            2 |            0 |            35 |             272 |           0 |             0 |          0 |        2 |       2 |             2 |         0 |        2 |     2006 |          8 |               0 |      140000 |
    |  4 |    5 |           60 |          3 |            84 |     14260 |        1 |       0 |          0 |             3 |           0 |           2 |           0 |             15 |            2 |            2 |          0 |            5 |             8 |             5 |        2000 |           2000 |           1 |          1 |            12 |            13 |            1 |          350 |           2 |           4 |            2 |          2 |          3 |              0 |              2 |          655 |              5 |            0 |         490 |          1145 |         1 |           0 |            1 |            4 |       1145 |       1053 |              0 |        2198 |              1 |              0 |          2 |          1 |              4 |              1 |             2 |              9 |            6 |            1 |             4 |            1 |          2000 |              1 |            3 |          836 |            4 |            4 |            2 |          192 |            84 |               0 |           0 |             0 |          0 |        2 |       2 |             2 |         0 |       12 |     2008 |          8 |               4 |      250000 |


## Declare tasks for linear regression
1. Generate correlation matrix.
2. Select correlated features only

# Preprocessing

## Null Value
Impute null values. If nominal, replace with most common. If continuous, replace with mean.


```python
def imputer(df):
    for col in df.columns:
        if df[col].dtype=='O': # categorical
            imp_most = SimpleImputer(strategy='most_frequent')
            temp = df[col].values.reshape(-1,1)
            imp_most.fit(temp)
            X = df[col].values.reshape(-1,1)
            X = imp_most.transform(X)
            df[col] = X
        else:
            imp_mean = SimpleImputer(strategy='mean')
            temp = df[col].values.reshape(-1,1)
            imp_mean.fit(temp)
            X = df[col].values.reshape(-1,1)
            X = imp_mean.transform(X)
            df[col] = X

    return df
```


```python
nTrain = imputer(nTrain)
print(nTrain.head())
```

    |    |   Id |   MSSubClass |   MSZoning |   LotFrontage |   LotArea |   Street |   Alley |   LotShape |   LandContour |   Utilities |   LotConfig |   LandSlope |   Neighborhood |   Condition1 |   Condition2 |   BldgType |   HouseStyle |   OverallQual |   OverallCond |   YearBuilt |   YearRemodAdd |   RoofStyle |   RoofMatl |   Exterior1st |   Exterior2nd |   MasVnrType |   MasVnrArea |   ExterQual |   ExterCond |   Foundation |   BsmtQual |   BsmtCond |   BsmtExposure |   BsmtFinType1 |   BsmtFinSF1 |   BsmtFinType2 |   BsmtFinSF2 |   BsmtUnfSF |   TotalBsmtSF |   Heating |   HeatingQC |   CentralAir |   Electrical |   1stFlrSF |   2ndFlrSF |   LowQualFinSF |   GrLivArea |   BsmtFullBath |   BsmtHalfBath |   FullBath |   HalfBath |   BedroomAbvGr |   KitchenAbvGr |   KitchenQual |   TotRmsAbvGrd |   Functional |   Fireplaces |   FireplaceQu |   GarageType |   GarageYrBlt |   GarageFinish |   GarageCars |   GarageArea |   GarageQual |   GarageCond |   PavedDrive |   WoodDeckSF |   OpenPorchSF |   EnclosedPorch |   3SsnPorch |   ScreenPorch |   PoolArea |   PoolQC |   Fence |   MiscFeature |   MiscVal |   MoSold |   YrSold |   SaleType |   SaleCondition |   SalePrice |
    |---:|-----:|-------------:|-----------:|--------------:|----------:|---------:|--------:|-----------:|--------------:|------------:|------------:|------------:|---------------:|-------------:|-------------:|-----------:|-------------:|--------------:|--------------:|------------:|---------------:|------------:|-----------:|--------------:|--------------:|-------------:|-------------:|------------:|------------:|-------------:|-----------:|-----------:|---------------:|---------------:|-------------:|---------------:|-------------:|------------:|--------------:|----------:|------------:|-------------:|-------------:|-----------:|-----------:|---------------:|------------:|---------------:|---------------:|-----------:|-----------:|---------------:|---------------:|--------------:|---------------:|-------------:|-------------:|--------------:|-------------:|--------------:|---------------:|-------------:|-------------:|-------------:|-------------:|-------------:|-------------:|--------------:|----------------:|------------:|--------------:|-----------:|---------:|--------:|--------------:|----------:|---------:|---------:|-----------:|----------------:|------------:|
    |  0 |    1 |           60 |          3 |            65 |      8450 |        1 |       0 |          3 |             3 |           0 |           4 |           0 |              5 |            2 |            2 |          0 |            5 |             7 |             5 |        2003 |           2003 |           1 |          1 |            12 |            13 |            1 |          196 |           2 |           4 |            2 |          2 |          3 |              3 |              2 |          706 |              5 |            0 |         150 |           856 |         1 |           0 |            1 |            4 |        856 |        854 |              0 |        1710 |              1 |              0 |          2 |          1 |              3 |              1 |             2 |              8 |            6 |            0 |             2 |            1 |          2003 |              1 |            2 |          548 |            4 |            4 |            2 |            0 |            61 |               0 |           0 |             0 |          0 |        2 |       2 |             2 |         0 |        2 |     2008 |          8 |               4 |      208500 |
    |  1 |    2 |           20 |          3 |            80 |      9600 |        1 |       0 |          3 |             3 |           0 |           2 |           0 |             24 |            1 |            2 |          0 |            2 |             6 |             8 |        1976 |           1976 |           1 |          1 |             8 |             8 |            2 |            0 |           3 |           4 |            1 |          2 |          3 |              1 |              0 |          978 |              5 |            0 |         284 |          1262 |         1 |           0 |            1 |            4 |       1262 |          0 |              0 |        1262 |              0 |              1 |          2 |          0 |              3 |              1 |             3 |              6 |            6 |            1 |             4 |            1 |          1976 |              1 |            2 |          460 |            4 |            4 |            2 |          298 |             0 |               0 |           0 |             0 |          0 |        2 |       2 |             2 |         0 |        5 |     2007 |          8 |               4 |      181500 |
    |  2 |    3 |           60 |          3 |            68 |     11250 |        1 |       0 |          0 |             3 |           0 |           4 |           0 |              5 |            2 |            2 |          0 |            5 |             7 |             5 |        2001 |           2002 |           1 |          1 |            12 |            13 |            1 |          162 |           2 |           4 |            2 |          2 |          3 |              2 |              2 |          486 |              5 |            0 |         434 |           920 |         1 |           0 |            1 |            4 |        920 |        866 |              0 |        1786 |              1 |              0 |          2 |          1 |              3 |              1 |             2 |              6 |            6 |            1 |             4 |            1 |          2001 |              1 |            2 |          608 |            4 |            4 |            2 |            0 |            42 |               0 |           0 |             0 |          0 |        2 |       2 |             2 |         0 |        9 |     2008 |          8 |               4 |      223500 |
    |  3 |    4 |           70 |          3 |            60 |      9550 |        1 |       0 |          0 |             3 |           0 |           0 |           0 |              6 |            2 |            2 |          0 |            5 |             7 |             5 |        1915 |           1970 |           1 |          1 |            13 |            15 |            2 |            0 |           3 |           4 |            0 |          3 |          1 |              3 |              0 |          216 |              5 |            0 |         540 |           756 |         1 |           2 |            1 |            4 |        961 |        756 |              0 |        1717 |              1 |              0 |          1 |          0 |              3 |              1 |             2 |              7 |            6 |            1 |             2 |            5 |          1998 |              2 |            3 |          642 |            4 |            4 |            2 |            0 |            35 |             272 |           0 |             0 |          0 |        2 |       2 |             2 |         0 |        2 |     2006 |          8 |               0 |      140000 |
    |  4 |    5 |           60 |          3 |            84 |     14260 |        1 |       0 |          0 |             3 |           0 |           2 |           0 |             15 |            2 |            2 |          0 |            5 |             8 |             5 |        2000 |           2000 |           1 |          1 |            12 |            13 |            1 |          350 |           2 |           4 |            2 |          2 |          3 |              0 |              2 |          655 |              5 |            0 |         490 |          1145 |         1 |           0 |            1 |            4 |       1145 |       1053 |              0 |        2198 |              1 |              0 |          2 |          1 |              4 |              1 |             2 |              9 |            6 |            1 |             4 |            1 |          2000 |              1 |            3 |          836 |            4 |            4 |            2 |          192 |            84 |               0 |           0 |             0 |          0 |        2 |       2 |             2 |         0 |       12 |     2008 |          8 |               4 |      250000 |


## Categorical Values
Label encoding using sklearn


```python
le = LabelEncoder()
def labelEncode(df):
    """
    params: dataframe
    returns: dataframe. classes, label encoder classes in a dict with column names as keys
    """
    classes = {}
    for col in df.columns:
        if df[col].dtype == 'O':
            le.fit(df[col])
            df[col] = le.transform(df[col])
            classes[col] = le.classes_
    return df,classes
```


```python
nTrain,labelClasses = labelEncode(nTrain)
print(nTrain.head())
```

    |    |   Id |   MSSubClass |   MSZoning |   LotFrontage |   LotArea |   Street |   Alley |   LotShape |   LandContour |   Utilities |   LotConfig |   LandSlope |   Neighborhood |   Condition1 |   Condition2 |   BldgType |   HouseStyle |   OverallQual |   OverallCond |   YearBuilt |   YearRemodAdd |   RoofStyle |   RoofMatl |   Exterior1st |   Exterior2nd |   MasVnrType |   MasVnrArea |   ExterQual |   ExterCond |   Foundation |   BsmtQual |   BsmtCond |   BsmtExposure |   BsmtFinType1 |   BsmtFinSF1 |   BsmtFinType2 |   BsmtFinSF2 |   BsmtUnfSF |   TotalBsmtSF |   Heating |   HeatingQC |   CentralAir |   Electrical |   1stFlrSF |   2ndFlrSF |   LowQualFinSF |   GrLivArea |   BsmtFullBath |   BsmtHalfBath |   FullBath |   HalfBath |   BedroomAbvGr |   KitchenAbvGr |   KitchenQual |   TotRmsAbvGrd |   Functional |   Fireplaces |   FireplaceQu |   GarageType |   GarageYrBlt |   GarageFinish |   GarageCars |   GarageArea |   GarageQual |   GarageCond |   PavedDrive |   WoodDeckSF |   OpenPorchSF |   EnclosedPorch |   3SsnPorch |   ScreenPorch |   PoolArea |   PoolQC |   Fence |   MiscFeature |   MiscVal |   MoSold |   YrSold |   SaleType |   SaleCondition |   SalePrice |
    |---:|-----:|-------------:|-----------:|--------------:|----------:|---------:|--------:|-----------:|--------------:|------------:|------------:|------------:|---------------:|-------------:|-------------:|-----------:|-------------:|--------------:|--------------:|------------:|---------------:|------------:|-----------:|--------------:|--------------:|-------------:|-------------:|------------:|------------:|-------------:|-----------:|-----------:|---------------:|---------------:|-------------:|---------------:|-------------:|------------:|--------------:|----------:|------------:|-------------:|-------------:|-----------:|-----------:|---------------:|------------:|---------------:|---------------:|-----------:|-----------:|---------------:|---------------:|--------------:|---------------:|-------------:|-------------:|--------------:|-------------:|--------------:|---------------:|-------------:|-------------:|-------------:|-------------:|-------------:|-------------:|--------------:|----------------:|------------:|--------------:|-----------:|---------:|--------:|--------------:|----------:|---------:|---------:|-----------:|----------------:|------------:|
    |  0 |    1 |           60 |          3 |            65 |      8450 |        1 |       0 |          3 |             3 |           0 |           4 |           0 |              5 |            2 |            2 |          0 |            5 |             7 |             5 |        2003 |           2003 |           1 |          1 |            12 |            13 |            1 |          196 |           2 |           4 |            2 |          2 |          3 |              3 |              2 |          706 |              5 |            0 |         150 |           856 |         1 |           0 |            1 |            4 |        856 |        854 |              0 |        1710 |              1 |              0 |          2 |          1 |              3 |              1 |             2 |              8 |            6 |            0 |             2 |            1 |          2003 |              1 |            2 |          548 |            4 |            4 |            2 |            0 |            61 |               0 |           0 |             0 |          0 |        2 |       2 |             2 |         0 |        2 |     2008 |          8 |               4 |      208500 |
    |  1 |    2 |           20 |          3 |            80 |      9600 |        1 |       0 |          3 |             3 |           0 |           2 |           0 |             24 |            1 |            2 |          0 |            2 |             6 |             8 |        1976 |           1976 |           1 |          1 |             8 |             8 |            2 |            0 |           3 |           4 |            1 |          2 |          3 |              1 |              0 |          978 |              5 |            0 |         284 |          1262 |         1 |           0 |            1 |            4 |       1262 |          0 |              0 |        1262 |              0 |              1 |          2 |          0 |              3 |              1 |             3 |              6 |            6 |            1 |             4 |            1 |          1976 |              1 |            2 |          460 |            4 |            4 |            2 |          298 |             0 |               0 |           0 |             0 |          0 |        2 |       2 |             2 |         0 |        5 |     2007 |          8 |               4 |      181500 |
    |  2 |    3 |           60 |          3 |            68 |     11250 |        1 |       0 |          0 |             3 |           0 |           4 |           0 |              5 |            2 |            2 |          0 |            5 |             7 |             5 |        2001 |           2002 |           1 |          1 |            12 |            13 |            1 |          162 |           2 |           4 |            2 |          2 |          3 |              2 |              2 |          486 |              5 |            0 |         434 |           920 |         1 |           0 |            1 |            4 |        920 |        866 |              0 |        1786 |              1 |              0 |          2 |          1 |              3 |              1 |             2 |              6 |            6 |            1 |             4 |            1 |          2001 |              1 |            2 |          608 |            4 |            4 |            2 |            0 |            42 |               0 |           0 |             0 |          0 |        2 |       2 |             2 |         0 |        9 |     2008 |          8 |               4 |      223500 |
    |  3 |    4 |           70 |          3 |            60 |      9550 |        1 |       0 |          0 |             3 |           0 |           0 |           0 |              6 |            2 |            2 |          0 |            5 |             7 |             5 |        1915 |           1970 |           1 |          1 |            13 |            15 |            2 |            0 |           3 |           4 |            0 |          3 |          1 |              3 |              0 |          216 |              5 |            0 |         540 |           756 |         1 |           2 |            1 |            4 |        961 |        756 |              0 |        1717 |              1 |              0 |          1 |          0 |              3 |              1 |             2 |              7 |            6 |            1 |             2 |            5 |          1998 |              2 |            3 |          642 |            4 |            4 |            2 |            0 |            35 |             272 |           0 |             0 |          0 |        2 |       2 |             2 |         0 |        2 |     2006 |          8 |               0 |      140000 |
    |  4 |    5 |           60 |          3 |            84 |     14260 |        1 |       0 |          0 |             3 |           0 |           2 |           0 |             15 |            2 |            2 |          0 |            5 |             8 |             5 |        2000 |           2000 |           1 |          1 |            12 |            13 |            1 |          350 |           2 |           4 |            2 |          2 |          3 |              0 |              2 |          655 |              5 |            0 |         490 |          1145 |         1 |           0 |            1 |            4 |       1145 |       1053 |              0 |        2198 |              1 |              0 |          2 |          1 |              4 |              1 |             2 |              9 |            6 |            1 |             4 |            1 |          2000 |              1 |            3 |          836 |            4 |            4 |            2 |          192 |            84 |               0 |           0 |             0 |          0 |        2 |       2 |             2 |         0 |       12 |     2008 |          8 |               4 |      250000 |



```python
nTest = imputer(nTest)
nTest,_ = labelEncode(nTest)
```


```python
def rounded(corr,thresh):
    for i in range(corr.shape[0]):
        for j in range(corr.shape[1]):
            corr.iloc[i,j] = corr.iloc[i,j] if corr.iloc[i,j]>=thresh or corr.iloc[i,j]<=-thresh else np.round(corr.iloc[i,j])
    return corr
```


```python
corr = nTrain.corr()
# corr = rounded(corr,0.7)
fig, ax = plt.subplots(1,1,figsize=(20,15),dpi=100)
ax = sns.heatmap(corr,vmin = -1,vmax = 1,center=0)

```


![heatmap](../../assets/images/house-price-advance-heatmap.png)



```python
# select features

cols = ['YearRemodAdd','SaleCondition','PoolArea','LotShape','OverallQual','ExterQual','BsmtQual', \
       'TotalBsmtSF','HeatingQC','1stFlrSF','FullBath','GrLivArea','KitchenQual','GarageCars']
X = nTrain[cols]
y = nTrain['SalePrice']
testX = nTest[cols]
```


```python
print(X.shape,y.shape)
```

    (1460, 14) (1460,)



```python
trainX,valX,trainy,valy = train_test_split(X,y,test_size=0.4)
print(trainX.shape,trainy.shape,'\n',valX.shape,valy.shape)
```

    (876, 14) (876,) 
     (584, 14) (584,)


# Decision Tree


```python
model = DecisionTreeRegressor(criterion='mae',min_samples_split=5,min_samples_leaf=3,splitter='random',random_state=21)
model.fit(trainX,trainy)
print(model.score(valX,valy))
print(model.score(trainX,trainy))
```

    0.7333262120423661
    0.8768585202914994


## Evaluation Measure
*Log Root Mean Squared Error* is used in the competitions.


```python
def log_rmse(ytrue,ypred):
    sum = 0.0
    for i in range(len(ytrue)):
        sum += pow((math.log2(ypred[i])-math.log2(ytrue.iloc[i])),2)
    return math.sqrt(abs(sum/float(len(ytrue))))
```


```python
yhat = model.predict(valX)
print(log_rmse(valy,yhat))
```

    0.3138365972186103


# Submission File
Running the fitted model on Test Set to generate house prices and submit to Kaggle


```python
yhat = model.predict(testX)
```


```python
sub_file = pd.DataFrame({'Id':nTest.Id,'SalePrice':yhat})
sub_file.to_csv(f'{DATA}submission.csv',index=False)
```
