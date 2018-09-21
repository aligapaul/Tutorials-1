---
interact_link: notebooks/02-DataAnalysis.ipynb
title: '02-dataanalysis'
permalink: '/chapters/02-DataAnalysis'
previouschapter:
  url: /chapters/01-JupyterNotebooks
  title: '01-jupyternotebooks'
nextchapter:
  url: /chapters/03-Python
  title: '03-python'
redirect_from:
  - '/chapters/02-dataanalysis'
---

# Data Analysis

This notebook goes through some minimal examples of the kinds of things we might want to do using data science approaches. 

In particular, it briefly introduces analyzing data for the purposes of:
- Predictions: to analyze available data in order to be able to make predictions about future data
- Classification: to group data in meaningful ways
- Knowledge Discovery: to seek to discover new knowledge about the data and the phenomena they represent

These examples will already start using packages in the python data-science toolkit, and some simple algorithms to demostrate example cases. 

The goal here is see, in code, the outline of the kinds of things data science is interested in doing. 

These tools and algorithms will be more fully described and properly introduced in future notebooks.



{:.input_area}
```python
%matplotlib inline

# Import matplotlib and numpy for some quick examples
import matplotlib.pyplot as plt
import numpy as np
```


# Prediction

<div class="alert alert-success">
Prediction is the use of current (training) data to make predictions about future observations.
</div>

### Example Problem

Let's say we wanted to predict dogs weight, from their length. 

Maybe, for example, it's easier to use a tape measure than to get a dog onto a scale, so if we could infer their weight from their length, we could save a lot of time. 



{:.input_area}
```python
# We start with some data
lengths = [75, 50, 90, 115]    # cm's
weights = [17.5, 10, 18, 20]   # kg's
```




{:.input_area}
```python
# Plot the data: Always visualize your data!
f, ax = plt.subplots()
ax.plot(lengths, weights , '.')
plt.xlabel('Length (cm)'); plt.xlim([30, 125]);
plt.ylabel('Weight (kg)'); plt.ylim([5, 25]);
```



![png](../images/./_chapters/02-DataAnalysis_7_0.png)




{:.input_area}
```python
# Polyfit (degree=1) will fit a linear fit to the data, of the form y = ax + b
#  Once we fit this simple model to the data, we can use it to predict from new data points
a, b = np.polyfit(lengths, weights, 1)
```




{:.input_area}
```python
# So now we can predict the weight of a new observation (a new dog)
new_length = 62
pred_weight = a * new_length + b 
print('Predicted weight for a new data point, weight  is', pred_weight)
```


{:.output_stream}
```
Predicted weight for a new data point, weight  is 13.3460674157

```



{:.input_area}
```python
# We can check how our prediction fits in with the data we observed
ax.plot(new_length, pred_weight, '.r')
f
```





![png](../images/./_chapters/02-DataAnalysis_10_0.png)





{:.input_area}
```python
# If we also happen to now the true weight of our test data, we can check how good our prediction is
actual_weight = 14.7
error = actual_weight - pred_weight

print('The (absolute) error of our prediction is', str(error), 'kg\'s.')
```


{:.output_stream}
```
The (absolute) error of our prediction is 1.35393258427 kg's.

```

How we go about making predictions gets more complicated, as we deal with large, messy data with more variables of various 'shapes'. 

Fundamentally, though, it comes down to the same process: what can we learn from a set of data, such that, given a new peice of data, we can make predictions about it (and using test data with known answers to evaluate how good our predictive models are). 
<hr>

# Classification

<div class="alert alert-success">
Classification (or clustering) is the process of trying to discover a systematic organization of data. 
</div>

### Problem
Our local zoologist is investigating a group of squirrels. 

She would like to know how many different species there are present in the population, but only has basic data to work with. 

We can try and cluster the data we have, and look for (what look like) meaningful groupings. 



{:.input_area}
```python
# We observe a bunch of squirrels with [height (cm), weight (grams)] pairs
dat = np.array([[10., 600.], [16., 1200], [6., 800], [12., 700.], [17., 1400.],
               [8., 500.], [20., 1500.], [21., 1300.], [11., 800.], [18., 1100.]])
```




{:.input_area}
```python
# Visualize our data!
f, ax = plt.subplots()
ax.plot(dat[:, 0], dat[:, 1], '.')
plt.xlabel('Height (cm)'); plt.xlim([0, 25]);
plt.ylabel('Weight (kg)'); plt.ylim([300, 1700]);
```



![png](../images/./_chapters/02-DataAnalysis_17_0.png)




{:.input_area}
```python
# Lets try a classification algorithm
#  If you're unfamiliar with KMeans, we'll come back to how it works later
from sklearn.cluster import KMeans
kmeans = KMeans(2).fit(dat)
```




{:.input_area}
```python
# This gives us a label each data point, as to which cluster it belongs to
kmeans.labels_
```





{:.output_data_text}
```
array([0, 1, 0, 0, 1, 0, 1, 1, 0, 1], dtype=int32)
```





{:.input_area}
```python
# We can use these to split our dataset up into putative groupings
cl_1 = dat[kmeans.labels_ == 0]
cl_2 = dat[kmeans.labels_ == 1]
```




{:.input_area}
```python
# And visualize the classification
f, ax = plt.subplots()
ax.plot(cl_1[:, 0], cl_1[:, 1], '.b')
ax.plot(cl_2[:, 0], cl_2[:, 1], '.r')
plt.xlabel('Height (cm)'); plt.xlim([0, 25]);
plt.ylabel('Weight (kg)'); plt.ylim([300, 1700]);
```



![png](../images/./_chapters/02-DataAnalysis_21_0.png)


Evaluating classification, especially in unsupervised cases such as this (when we don't know the answer) is very much non-trivial. It's hard to know if there really are two groups here - or perhaps more, or fewer. We'll come back to how these analyses actually work and how to evaluate what you get out of them. 

# Knowledge Discovery

<div class="alert alert-success">
Knowledge Discovery is the attempt to learn new things about the world from data. 
</div>

Knowledge discovery is not necessarily methodoligically distinct from prediction and classification, in that seeking new knowledge will likely include analysis focused on classification and prediction. 
