---
title: '09-datavisualization'
permalink: '/chapters/09-DataVisualization'
previouschapter:
  url: /chapters/08-DataPrivacy&Anonymization
  title: '08-dataprivacy&anonymization'
nextchapter:
  url: /chapters/10-Distributions
  title: '10-distributions'
redirect_from:
  - '/chapters/09-datavisualization'
---

# Data Visualization with Python

Data Visualization might mean a of different things. 

Here we are only going to deal with basic 2D plotting, using Matplotlib, which is a library for plotting with Python.

Matplotlib is very well supported with examples that you can use to figure out how it works. 

Here, we will run through a quick intro of using matplotlib, with examples adapted from the official materials.  

<div class="alert alert-success">
Data Visualization is a way to 'see' your data, for data exploration and data communication.
</div>

<div class="alert alert-info">
Check out matplotlibs official
<a href="https://matplotlib.org/" class="alert-link">website</a>
including their introductory 
<a href="http://matplotlib.org/users/beginner.html" class="alert-link">tutorial</a>,
and list of 
<a href="http://matplotlib.org/examples/" class="alert-link">examples</a>.
</div>

### Pyplot vs Pylab

Note that matplotlib is an and old, and quite massive, module, and actually has a couple different ways to use it. 

Short version: import 'matplotlib.pyplot', like we do here is perhaps most common, and will work!

Long version: follow the following link to learn a bit about the different ways in which matplotlib can be used (pyplot, pylab, etc.). 

Ultimately, it all calls the same underlying code, there is just different syntax for accessing everything. 

<div class="alert alert-info">
A description of the different ways to interact with matplotlib is availabe
<a href="http://stackoverflow.com/questions/16849483/which-is-the-recommended-way-to-plot-matplotlib-or-pylab" class="alert-link">here</a>.
</div>



{:.input_area}
```python
# Import matplotlib - the main python plotting package
import matplotlib.pyplot as plt

# Import numpy functions for generating test data to plot
import numpy as np
from numpy.random import rand

# This magic command plots figures directly in the notebook
%matplotlib inline
# This sets a higher resolution for figures
%config InlineBackend.figure_format = 'retina'
```


## Line graph



{:.input_area}
```python
# Let's create some fake data to plot
x = np.arange(0, 11)
y = x**2

# In matplotlib, we can make a figure and then plot to it
# Make a figure
f = plt.figure()
# To plot, simply pass the x and y data to the plot function
plt.plot(x, y)
```





{:.output_data_text}
```
[<matplotlib.lines.Line2D at 0x119df8710>]
```




![png](../images/chapters/09-DataVisualization_6_1.png)


Without any other information, matplotlib will add a number of plotting attributes by default.

For example, by default we get lines around the plot, tick marks as well as axis number labels. 

We can customize all of these things, and add more stuff to the plot as well.

## Scatter Plot

Lets try creating a Scatter plot
Let's image two groups of data, that we want to plot together on a scatter plot to compare. 



{:.input_area}
```python
# Create some Data
n = 50                   # n is the number of data points
x = rand(n)              # Randomly create x data points
y1 = rand(n)             # Randomly create 1st group of y data points
y2 = rand(n)             # Randomly create 2nd group of y data points
```


### Creating a Scatter Plot
The 'scatter' command works about the same as the plot command, but makes a scatter plot instead of a line. 

Here, we're adding another argument, 'c' which specifies the colour to make the points

There are lots of optional arguments we can add to 'plot' and 'scatter'



{:.input_area}
```python
# Plot the first set of data
plt.scatter(x, y1, c='blue')
# We now want to plot the second set of data on the same plot. 
# The 'hold' command tells Python to hold onto the current figure and add the next data to it. 
plt.hold
# Plot the second set of data
plt.scatter(x, y2, c='red')
```





{:.output_data_text}
```
<matplotlib.collections.PathCollection at 0x11aac7d68>
```




![png](../images/chapters/09-DataVisualization_11_1.png)


We now have a scatter plot!

However, it doesn't look very nice. Let's see if we can improve it. Let's experiment with adding lots of the customization functions to make a nicer graph.



{:.input_area}
```python
# Create a new figure
fig = plt.figure()
# Add an axes to our figure
ax = plt.axes()

# Plot the data again
ax.scatter(x, y1, c='blue', alpha=0.6, label='Group 1', s=50)
plt.hold
ax.scatter(x, y2, c='red', alpha=0.6, label='Group 2', s=50)
# Here we've added some more optional arguments. 
# alpha - sets the transparency of the data points
# label - makes a label for the data we've plotted, which can be used in the legend
# s - size. Changes the size of the dots we plot

# Add a title to our graph
plt.title('My Awesome Scatter Plot', fontsize=18, fontweight='bold')

# Add data labels
plt.xlabel('X Data Label', fontsize=16, fontweight='bold')
plt.ylabel('Y Data Label', fontsize=16, fontweight='bold')

# Set the ranges to plot of the x and y variables
plt.xlim([-0.1, 1.1])
plt.ylim([-0.1, 1.1])

# Set the tick labels
ax.set_xticks(np.array([0.0, 0.2, 0.4, 0.6, 0.8, 1.0]))
ax.set_yticks(np.array([0.0, 0.2, 0.4, 0.6, 0.8, 1.0]))

# Turn the top and right side lines off
ax.spines['right'].set_visible(False)
ax.spines['top'].set_visible(False)

# Set the tick marks to only be on the bottom and the left. 
ax.xaxis.set_ticks_position('bottom')
ax.yaxis.set_ticks_position('left')

# Set linewidth of remaining spines
ax.spines['left'].set_linewidth(2)
ax.spines['bottom'].set_linewidth(2)

# Add a legend. This will use the labels you defined when you set the data.
plt.legend(loc='upper left', scatterpoints=1, frameon=False)
# Legend doesn't require any arguments. 
# Here we optionally specify where to put the legend ('loc'), how many points to use 
#  in the legend ('scatterpoints'), and wether to have a box around the legend ('frameon')
```





{:.output_data_text}
```
<matplotlib.legend.Legend at 0x11a655cf8>
```




![png](../images/chapters/09-DataVisualization_13_1.png)


### Figures and Axes
Note above that sometimes we are calling these functions on 'ax' and sometimes we are calling with 'plt'

We also created a thing called fig. What's all this?

- 'plt' is just our nickname for the matplotlib module
    - Here, whenver we are using 'plt' we are implicitly calling a function from matplotlib on the current figure
- 'fig' is just an arbitrary variable name we have been using to assign to a figure object. 
    - We can use 'fig' (or whatever we call our figure) to update it after we have created it
- 'ax' is also just an arbitrary variable name for the current axis.
    - We can us 'ax (or whatever we call our axes) to update a particular axis after we have created it



{:.input_area}
```python
# 'fig' is a label for the figure we are working on.
# gcf() is a way to find the current figure. 
print(type(fig))             # Figure is an object in matplotlib
print(fig)                   # This is the figure handle 'fig' we made before
print(plt.gcf(), '\n')       # gcf grabs the current figure. In this case, current figure is same as 'fig'
```


{:.output_stream}
```
<class 'matplotlib.figure.Figure'>
Figure(432x288)
Figure(432x288) 


```


{:.output_data_text}
```
<matplotlib.figure.Figure at 0x117779588>
```




{:.input_area}
```python
# 'ax' is a name for the current axes. A figure can have many axes (figures can have subplots)
print(type(ax))              # Axes is a class of variable in matplotlib
print(ax)                    # This is the axes handle 'ax' that we made before
#print(plt.gca(), '\n')      # gca grabs the current axes. 

# In this case, current axis is 'ax'. Turned off as it plots an axis. 
# Note that here gca is drawing an empty axis
```


{:.output_stream}
```
<class 'matplotlib.axes._subplots.AxesSubplot'>
Axes(0.125,0.125;0.775x0.755)

```

Keeping track of figures and axes, and knowing what to call on what can be a bit confusing at first. 

Note that a lot of it gets managed behind the scenes - you don't have a to explicitly create new figures or axes. Matplotlib will make new figures and axes when it needs to, without explicitly being told to.

If you're wondering why we would bother using fig and ax then:
   - We often don't need to, but it can be very useful to have a label to grab our figure (and manipulate it) when we need to. 
   
For example, we can get our figure back just by calling it's name. 



{:.input_area}
```python
# Redraw figure with 'fig' variable name
fig
```





![png](../images/chapters/09-DataVisualization_18_0.png)



<div class="alert alert-info">
As well as the official documentation, another useful tutorial is available
<a href="https://www.labri.fr/perso/nrougier/teaching/matplotlib/" class="alert-link">here</a>.
</div>
