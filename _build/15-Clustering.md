---
interact_link: content/15-Clustering.ipynb
download_link: /Tutorials/assets/downloads/15-Clustering.ipynb.zip
title: '15-Clustering'
prev_page:
  url: /14-LinearModels
  title: '14-LinearModels'
next_page:
  url: /16-DimensionalityReduction
  title: '16-DimensionalityReduction'
comment: "***PROGRAMMATICALLY GENERATED, DO NOT EDIT. SEE ORIGINAL FILES IN /content***"
---

# Clustering

<div class="alert alert-success">
Clustering is the process of trying to find structure (clusters) in data.
</div>

<div class="alert alert-info">
<a href="https://en.wikipedia.org/wiki/Cluster_analysis" class="alert-link">Clustering</a>
article from wikipedia. 
</div>



{:.input_area}
```python
# Imports
%matplotlib inline

import numpy as np
import matplotlib.pyplot as plt
from sklearn import datasets
from sklearn.cluster import KMeans
from scipy.cluster.vq import whiten
```


Scikit-learn has a bunch of example datasets. Here, we'll use the iris dataset: which contains data about different species of plants. 



{:.input_area}
```python
# Load the iris data
iris = datasets.load_iris()
```




{:.input_area}
```python
# Check out the available features
print('\n'.join(iris.feature_names))
```


{:.output_stream}
```
sepal length (cm)
sepal width (cm)
petal length (cm)
petal width (cm)

```



{:.input_area}
```python
# Check out the species ('clusters')
print('\n'.join(iris.target_names))
```


{:.output_stream}
```
setosa
versicolor
virginica

```



{:.input_area}
```python
# The actual data is stored in iris.data
# Let's check how much data there is
[n_samples, n_features] = np.shape(iris.data) 
print("There are ", n_samples , " samples of data, each with " , n_features, " features.")
```


{:.output_stream}
```
There are  150  samples of data, each with  4  features.

```



{:.input_area}
```python
# Let's set up some indexes, so we know what data we're using
sl_ind = 0    # Sepal Length
sw_ind = 1    # Septal Width
pl_ind = 2    # Petal Length
pw_ind = 3    # Petal Width
```




{:.input_area}
```python
# Let's start looking at some data. 
# Let's start with a scatter plot of petal length vs. petal width
fig = plt.figure(1)
plt.scatter(iris.data[:, pl_ind], iris.data[:, pw_ind])

# Add title and labels
plt.title('Iris Data: Petal Length vs. Width', fontsize=16, fontweight='bold')
plt.xlabel('Petal Length', fontsize=14);
plt.ylabel('Petal Width', fontsize=14);
```



![png](../images/build/15-Clustering_9_0.png)




{:.input_area}
```python
# Plot the data colour coded by species
fig = plt.figure(1)
plt.scatter(iris.data[:, pl_ind][iris.target==0], iris.data[:, pw_ind][iris.target==0],
            c='green', label=iris.target_names[0])
plt.scatter(iris.data[:, pl_ind][iris.target==1], iris.data[:, pw_ind][iris.target==1],
            c='red', label=iris.target_names[1])
plt.scatter(iris.data[:, pl_ind][iris.target==2], iris.data[:, pw_ind][iris.target==2],
            c='blue', label=iris.target_names[2])

# Add title, labels and legend
plt.title('Iris Data: Petal Length vs. Width', fontsize=16, fontweight='bold')
plt.xlabel('Petal Length', fontsize=14);
plt.ylabel('Petal Width', fontsize=14);
plt.legend(scatterpoints=1, loc='upper left');

# Note that splitting up the plotting per group is basically a hack to make the legend work, 
# The following command plots the data perfectly well, colour coded by target:
#  plt.scatter(iris.data[:, petal_length_ind], iris.data[:, petal_width_ind], c=iris.target)
# However, it's a pain to get a labelled legend when plotted this way
```



![png](../images/build/15-Clustering_10_0.png)


## Task:
If we didn't already know the Species labels, we might notice that there seem to be distinct groups of datapoints. Clustering is the approach of trying to find these groups algorithmically. 

Here, we will do so with the KMeans algorithm. For information on KMeans and how it works, see the lecture. 



{:.input_area}
```python
# Pull out the data of interest - Petal Length & Petal Width
d1 = np.array(iris.data[:, pl_ind])
d2 = np.array(iris.data[:, pw_ind])
```


#### Whitening Data:
If your different dimensions use different units (or have wildy different variances), then these differences can greatly impact the clustering. 

This is because KMeans is isotropic: it treats different in each direction as equally important. So, if the units or variance are very different, this is equivalent to weighting certain features / dimensions as more or less important. 

To correct for this it is common, and sometimes necessary to 'whiten' data: to normalize each dimension by it's respective standard deviation.  



{:.input_area}
```python
# Check out the whiten function
whiten?
```




{:.input_area}
```python
# Whiten Data
d1w = whiten(d1)
d2w = whiten(d2)
```




{:.input_area}
```python
# Combine data into shape for skl
data = np.vstack([d1w, d2w]).T
```




{:.input_area}
```python
# Initialize KMeans object, set to fit 3 clusters
km = KMeans(n_clusters=3, random_state=13)
```




{:.input_area}
```python
# Fit the data with KMeans
km.fit(data)
```





{:.output_data_text}
```
KMeans(algorithm='auto', copy_x=True, init='k-means++', max_iter=300,
    n_clusters=3, n_init=10, n_jobs=1, precompute_distances='auto',
    random_state=13, tol=0.0001, verbose=0)
```





{:.input_area}
```python
# Let's check out the clusters that KMeans found
plt.scatter(d1, d2, c=km.labels_);
plt.xlabel('Year');
plt.ylabel('Age');

# Add title, labels and legend
plt.title('Iris Data: PL vs. PW Clustered', fontsize=16, fontweight='bold')
plt.xlabel('Petal Length', fontsize=14);
plt.ylabel('Petal Width', fontsize=14);
```



![png](../images/build/15-Clustering_19_0.png)


It looks like it's doing pretty well! Other than some discrepancies between the versicolor and virginica boundary, KMeans is able to reconstruct the species labels algorithmically, given only information on a couple features. 
