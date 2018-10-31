---
interact_link: content/13-OrdinaryLeastSquares.ipynb
download_link: /Tutorials/assets/downloads/13-OrdinaryLeastSquares.ipynb.zip
title: '13-OrdinaryLeastSquares'
prev_page:
  url: /11-TestingDistributions
  title: '11-TestingDistributions'
next_page:
  url: /14-LinearModels
  title: '14-LinearModels'
comment: "***PROGRAMMATICALLY GENERATED, DO NOT EDIT. SEE ORIGINAL FILES IN /content***"
---

# Ordinary Least Squares

<div class="alert alert-success">
Ordinary least squares (OLS) means minimizing the error of the sum of squares between the predictions made by the model, and the observed data. 
</div>

<div class="alert alert-info">
Find more information on OLS on
<a href="https://en.wikipedia.org/wiki/Ordinary_least_squares" class="alert-link">wikipedia</a>
check out this cool 
<a href="http://setosa.io/ev/ordinary-least-squares-regression/" class="alert-link">interactive tool</a>
and/or check out this 
<a href="https://www.datarobot.com/blog/ordinary-least-squares-in-python/" class="alert-link">tutorial</a>
about doing OLS in Python.
</div>

#### Ordinary Least Squares

Ordinary least squares can be thought of as an error function - a formalization of how we will calculate the error of a model, given the data. 

Typically, we want to minimize this error term. So the OLS solution to, for example, a linear model, is the model which has the lowest value for the sum of squared errors, calculated as the square of the difference between the model prediction of a data point, and the data point itself.

Here, we'll create a minimal dataset, and explore fitting a simple linear model fit to it, using OLS.



{:.input_area}
```python
# Imports
%matplotlib inline

import random
import numpy as np
import matplotlib.pyplot as plt
```




{:.input_area}
```python
# Create some data
# x is an evenly space array of integers
x = np.arange(0, 6)

# y is some data with underlying relationship y = (theta) * x
#  For this example, the true relation of the data is y = 2x
true_rel = 2
y = true_rel * x

# Add some noise to the y dimension
noise = np.random.normal(0, 0.5, len(x))
y = y + noise
```




{:.input_area}
```python
# Plot the data
f = plt.figure()
plt.plot(x, y, '.');
```



![png](../images/build/13-OrdinaryLeastSquares_5_0.png)


Observing the data above, we can see that there is some relation between the x and y dimension, but we want a way to measure what that relation is. OLS is a procedure to do so: find the model (in this case, line) that minimizes the squared distances between each observed data point and the model prediction. 



{:.input_area}
```python
# Reshape data to play nice with numpy
x = np.reshape(x, [len(x), 1])
y = np.reshape(y, [len(y), 1])
```


Numpy provides us with a function to calculuate the OLS solution. In this case, we are fitting the model:

$$y = \theta x $$

Note that we are not fitting an intercept here (no 'b' value, if you think of 'y = ax + b'). In this simple model, we are therefore implicitly assuming an intercept value of zero. You can fit intercepts (and linear models with more parameters) with OLS, you just need to add them in. 



{:.input_area}
```python
# Fit the (Ordinary) Least Squares best fit line using numpy
#  This gives us a fit value (theta), and residuals (how much error we have in this fit)
theta, residuals, _, _ = np.linalg.lstsq(x, y)

# Pull out theta value from array
theta = theta[0][0]
```




{:.input_area}
```python
# Check what the OLS derived solution for theta is:
print(theta)
```


{:.output_stream}
```
1.98695402961

```



{:.input_area}
```python
# Check how good our OLS solution is
print('The true relationship between y & x is: \t', true_rel)
print('OLS calculated relationship between y & x is: \t', theta)
```


{:.output_stream}
```
The true relationship between y & x is: 	 2
OLS calculated relationship between y & x is: 	 1.98695402961

```



{:.input_area}
```python
# Check what the residuals are
residuals[0]
```





{:.output_data_text}
```
1.3701226131131277
```





{:.input_area}
```python
# Plot the raw data, with the true underlying relationship, and the OLS fit
fig, ax = plt.subplots(1)
ax.plot(x, y, 'x', markersize=10, label='Data')
ax.plot(x, 2*x, '--b', alpha=0.4, label='OLS Fit')
ax.plot(x, theta*x, label='True Fit')
ax.legend();
```



![png](../images/build/13-OrdinaryLeastSquares_13_0.png)




{:.input_area}
```python
# With our model, we can predict the value of a new 'x' datapoint
new_x = 2.5
pred_y = theta * new_x
print('The prediction for a new x of {} is {:1.3f}'.format(new_x, pred_y))
```


{:.output_stream}
```
The prediction for a new x of 2.5 is 4.967

```



{:.input_area}
```python
ax.plot(new_x, pred_y, 'or')
fig
```





![png](../images/build/13-OrdinaryLeastSquares_15_0.png)





{:.input_area}
```python
# We can also see what the model would predict for all the points we did observe
preds = theta * x
```




{:.input_area}
```python
# Residuals are the just the sum of squares between the model fit and the observed data points
# Re-calculate the residuals 'by hand'
error = np.sum(np.subtract(preds, y) ** 2)
```




{:.input_area}
```python
# Check that our residuals calculation matches the scipy implementation
print('Error from :', residuals[0])
print('Error from :', error)
```


{:.output_stream}
```
Error from : 1.37012261311
Error from : 1.37012261311

```

<div class="alert alert-success">
Note: In practice, you won't use numpy for OLS. Other modules, like statsmodels, have implementations of OLS more explicitly for linear modelling. </div>

<div class="alert alert-info">
See the 'LinearModels' notebook and/or 
<a href="http://www.statsmodels.org/dev/generated/statsmodels.regression.linear_model.OLS.html" class="alert-link">OLS in StatsModels</a>.
</div>
