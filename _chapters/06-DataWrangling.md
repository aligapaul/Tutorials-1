---
title: '06-datawrangling'
permalink: '/chapters/06-DataWrangling'
previouschapter:
  url: /chapters/05-DataGathering
  title: '05-datagathering'
nextchapter:
  url: /chapters/07-DataCleaning
  title: '07-datacleaning'
redirect_from:
  - '/chapters/06-datawrangling'
---

# Data Wrangling

<div class="alert alert-success">
'Data Wrangling' generally refers to transforming raw data into a useable form for your analyses of interest, including loading, aggregating and formating. 
</div>

Note: Throughout this notebook, we will be using '!' to run the shell command 'cat' to print out the contents of example data files.

## Python I/O

<div class="alert alert-success">
Python has some basic tools for I/O (input / output). 
</div>

<div class="alert alert-info">
Official Python 
<a href="https://docs.python.org/3/library/io.html" class="alert-link">documentation</a> 
on I/O.
</div>



{:.input_area}
```python
# Check out an example data file
!cat files/dat.txt
```


{:.output_stream}
```
First line of data
Second line of data
```



{:.input_area}
```python
# First, explicitly open the file object for reading
f_obj = open('files/dat.txt', 'r')

# You can then loop through the file object, grabbing each line of data
for line in f_obj:
    # Note that I'm removing the new line marker at the end of each line (the '\n')
    print(line.strip('\n'))

# File objects then have to closed when you are finished with them
f_obj.close()
```


{:.output_stream}
```
First line of data
Second line of data

```



{:.input_area}
```python
# Since opening and closing files basically always goes together, there is a shortcut to do both of them
#  Use 'with' keyword to open files, and the file object will automatically be closed at the end of the code block
with open('files/dat.txt', 'r') as f_obj:
    for line in f_obj:
        print(line.strip('\n'))
```


{:.output_stream}
```
First line of data
Second line of data

```

Using Python's I/O is a pretty 'low level' way to read data files, and often takes a lot of work sorting out the details of reading files - for example, in the above example, dealing with the new line character explicitly. 

As long as you have reasonably well structured data files, using standardized file types, you can use higher-level functions that will take care of a lot of these details - loading data straight into pandas data objects, for example.

## Pandas I/O

<div class="alert alert-success">
Pandas has a range of functions that will automatically read in whole files of standard file types in pandas objects. 
</div>

<div class="alert alert-info">
Official Pandas
<a href="http://pandas.pydata.org/pandas-docs/stable/io.html" class="alert-link">documentation</a> 
on I/O. 
</div>



{:.input_area}
```python
import pandas as pd
```




{:.input_area}
```python
# Tab complete to check out all the read functions available
pd.read_
```


## File types

<div class="alert alert-success">
There are many different standardized (and un-standardized) file types in which data may be stored. Here, we will start by examing CSV and JSON files. 
</div>

### CSV Files

<div class="alert alert-success">
'Comma Separated Value' files store data, separated by comma's. Think of them like lists.
</div>

<div class="alert alert-info">
More information on CSV files from
<a href="https://en.wikipedia.org/wiki/Comma-separated_values" class="alert-link">wikipedia</a>. 
</div>



{:.input_area}
```python
# Let's have a look at a csv file (printed out in plain text)
!cat files/dat.csv
```


{:.output_stream}
```
1, 2, 3, 4
5, 6, 7, 8
9, 10, 11, 12
```

#### CSV Files with Python



{:.input_area}
```python
# Python has a module devoted to working with csv's
import csv
```




{:.input_area}
```python
# We can read through our file with the csv module
with open('files/dat.csv') as csvfile:
    csv_reader = csv.reader(csvfile, delimiter=',')
    for row in csv_reader:
        print(', '.join(row))
```


{:.output_stream}
```
1,  2,  3,  4
5,  6,  7,  8
9,  10,  11,  12

```

#### CSV Files with Pandas



{:.input_area}
```python
# Pandas also has functions to directly load csv data
pd.read_csv?
```




{:.input_area}
```python
# Let's read in our csv file
pd.read_csv(open('files/dat.csv'), header=None)
```





<div markdown="0">
<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>2</td>
      <td>3</td>
      <td>4</td>
    </tr>
    <tr>
      <th>1</th>
      <td>5</td>
      <td>6</td>
      <td>7</td>
      <td>8</td>
    </tr>
    <tr>
      <th>2</th>
      <td>9</td>
      <td>10</td>
      <td>11</td>
      <td>12</td>
    </tr>
  </tbody>
</table>
</div>
</div>



### JSON Files

<div class="alert alert-success">
JavaScript Object Notation files can store hierachical key/value pairings. Think of them like dictionaries.
</div>

<div class="alert alert-info">
More information on JSON files from
<a href="https://en.wikipedia.org/wiki/JSON" class="alert-link">wikipedia</a>.
</div>



{:.input_area}
```python
# Let's have a look at a json file (printed out in plain text)
!cat files/dat.json
```


{:.output_stream}
```
{
  "firstName": "John",
  "age": 53
}

```



{:.input_area}
```python
# Think of json's as similar to dictionaries
d = {'firstName': 'John', 'age': '53'}
print(d)
```


{:.output_stream}
```
{'firstName': 'John', 'age': '53'}

```

#### JSON Files with Python



{:.input_area}
```python
# Python also has a module for dealing with json
import json
```




{:.input_area}
```python
# Load a json file
with open('files/dat.json') as dat_file:    
    dat = json.load(dat_file)
```




{:.input_area}
```python
# Check what data type this gets loaded as
print(type(dat))
```


{:.output_stream}
```
<class 'dict'>

```

#### JSON Files with Pandas



{:.input_area}
```python
# Pandas also has support for reading in json files
pd.read_json?
```




{:.input_area}
```python
# You can read in json formatted strings with pandas
#  Note that here I am specifying to read it in as a pd.Series, as there is a single line of data
pd.read_json('{ "first": "Alan", "place": "Manchester"}', typ='series')
```





{:.output_data_text}
```
first          Alan
place    Manchester
dtype: object
```





{:.input_area}
```python
# Read in our json file with pandas
pd.read_json(open('files/dat.json'), typ='series')
```





{:.output_data_text}
```
age            53
firstName    John
dtype: object
```


