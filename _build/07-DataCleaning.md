---
interact_link: content/07-DataCleaning.ipynb
download_link: /Tutorials/assets/downloads/07-DataCleaning.ipynb.zip
title: '07-DataCleaning'
prev_page:
  url: /06-DataWrangling
  title: '06-DataWrangling'
next_page:
  url: /08-DataPrivacy&Anonymization
  title: '08-DataPrivacy&Anonymization'
comment: "***PROGRAMMATICALLY GENERATED, DO NOT EDIT. SEE ORIGINAL FILES IN /content***"
---

# Data Cleaning

<div class="alert alert-success">
'Data Cleaning' is the process of finding and either removing or fixing 'bad data', where 'bad data' typically refers to corrupt and/or inaccurate data points. 
</div>



{:.input_area}
```python
# Imports
import numpy as np
import pandas as pd
```


## Missing Values

<div class="alert alert-success">
Missing Values are simply data points that are missing.
</div>

Missing values can be indicated in several ways. 

Values may be literally empty, or encoded as a special value, such as the Python 'None', or 'NaN', a numpy object (short for 'not a number'). 

Sometimes missing values are indicated by an arbitrarily chosen value, for example being indicated by some impossible value, such as '-999'. 

Missing values usually need dealing with before any analysis.

### Python - None Type



{:.input_area}
```python
# Python has the special value 'None', which can encode a missing, or null value
dat_none = None
```




{:.input_area}
```python
# None is actually it's own type
print(type(None))
```


{:.output_stream}
```
<class 'NoneType'>

```



{:.input_area}
```python
# Note that 'None' acts like a null type (as if the variable doesn't exist)
assert dat_none
```



{:.output_traceback_line}
```
---------------------------------------------------------------------------
```

{:.output_traceback_line}
```
AssertionError                            Traceback (most recent call last)
```

{:.output_traceback_line}
```
<ipython-input-4-95ad9e3fb11e> in <module>()
      1 # Note that 'None' acts like a null type (as if the variable doesn't exist)
----> 2 assert dat_none

```

{:.output_traceback_line}
```
AssertionError: 
```




{:.input_area}
```python
# Since None is a null type, basic operations will fail when None is in the data
dat_lst = [1, 2, 3, None]
sum(dat_lst) / len(dat_lst)
```



{:.output_traceback_line}
```
---------------------------------------------------------------------------
```

{:.output_traceback_line}
```
TypeError                                 Traceback (most recent call last)
```

{:.output_traceback_line}
```
<ipython-input-5-bc3aab645ea1> in <module>()
      1 # Since None is a null type, basic operations will fail when None is in the data
      2 dat_lst = [1, 2, 3, None]
----> 3 sum(dat_lst) / len(dat_lst)

```

{:.output_traceback_line}
```
TypeError: unsupported operand type(s) for +: 'int' and 'NoneType'
```


### Numpy - NaN



{:.input_area}
```python
# Numpy also has a special value for 'not a number' - NaN
dat_nan = np.nan
```




{:.input_area}
```python
# It's actually a special float value
type(dat_nan)
```





{:.output_data_text}
```
float
```





{:.input_area}
```python
# It doesn't evaluate as null (unlike None)
assert dat_nan
```




{:.input_area}
```python
# Numpy actually has multiple versions of NaN - but they are all actually the same.
np.nan is np.NaN is np.NAN
```





{:.output_data_text}
```
True
```





{:.input_area}
```python
# NaN values won't fail (unlike None) but they will return undefined (NaN) answers
dat_a = np.array([1, 2, 3, np.nan])
print(np.mean(dat_a))
```


{:.output_stream}
```
nan

```



{:.input_area}
```python
# You can tell numpy to do calculations, ignoring NaN values, but you have to explicitly tell it to do so
np.nanmean(np.array([1, 2, 3, np.nan]))
```





{:.output_data_text}
```
2.0
```



## The 'Art' of Data Cleaning

Dealing with missing data is a decision point: what do you do?
- Do you drop the observation?
    - What if this entails dropping a lot of observations?
- Do you keep it, but ignore it in any calculations?
    - What if you end up with different N's in different calculcations?
- Do you recode that data point?
    - What do you recode it to?

## Impossible Values

Data cleaning includes checking for and dealing with impossible values. Impossible values can occur due to encoding or data entry errors. 

Be wary that datasets may also encode missing data as a special value - for example using '-999' for missing age. 

These have to be dealt with, or they will skew your results.

## Data Cleaning in Pandas

Example problem: we have two separate files that collectively have id number, age, weight, and height for a group of people. 

Let's say that ultimately, we are interested in how age relates to height (is it really true that older people shrink!?)

Data Files:
- messy_dat.json, has id & height information
- messy_dat.csv, has id, age, & weight information



{:.input_area}
```python
# Load in the json file
df1 = pd.read_json('files/messy_dat.json')

# Since JSON files read in columns alphabetically, re-arrange columns
df1 = df1[['id', 'height']]
```




{:.input_area}
```python
# Check out the data. We have a NaN value!
df1
```





<div markdown="0">
<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>height</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>168.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>155.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>173.0</td>
    </tr>
  </tbody>
</table>
</div>
</div>





{:.input_area}
```python
# Let's use pandas to drop the NaN value(s)
#  Note the inplace argument: this performs the operation on the dataframe we call it on
#   without having having to return and re-save the dataframe to a new variable
df1.dropna(inplace=True)
```




{:.input_area}
```python
# Check out the data after dropping NaNs
df1
```





<div markdown="0">
<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>height</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>168.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>155.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>173.0</td>
    </tr>
  </tbody>
</table>
</div>
</div>





{:.input_area}
```python
# Read in the CSV data file
df2 = pd.read_csv('files/messy_dat.csv')
```




{:.input_area}
```python
# Check out the data
df2
```





<div markdown="0">
<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>age</th>
      <th>weight</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>20</td>
      <td>11.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>27</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>25</td>
      <td>14.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>-999</td>
      <td>12.0</td>
    </tr>
  </tbody>
</table>
</div>
</div>



Note that we have another NaN value! However, it is in the weight column, a feature we actually are not planning to use for our current analysis. If we drop NaN's from this dataframe, we are actually rejecting good data - since we will drop subject 1, who actually does have the age and height information we need. 



{:.input_area}
```python
# So, since we don't need it, lets drop the weight column instead
df2.drop('weight', axis=1, inplace=True)
```




{:.input_area}
```python
# Let's check if there are any NaN values in the age column (that we do need)
#  isnull() return booleans for each data point indicating whether it is NaN or not
#    We can sum across the boolean array to see how many NaN values we have
sum(df2['age'].isnull())
```





{:.output_data_text}
```
0
```



There aren't any NaN values in the data column that we need! Let's proceed!



{:.input_area}
```python
# Now lets merge our data together
#  Note that here we specify to use the 'id' column to combine the data
#    This means that data points will be combined based on them having the same id.
df = pd.merge(df1, df2, on='id')
```




{:.input_area}
```python
# Check out our merged dataframe
df
```





<div markdown="0">
<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>height</th>
      <th>age</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>168.0</td>
      <td>20</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>155.0</td>
      <td>27</td>
    </tr>
    <tr>
      <th>2</th>
      <td>4</td>
      <td>173.0</td>
      <td>-999</td>
    </tr>
  </tbody>
</table>
</div>
</div>





{:.input_area}
```python
# Check out basic descriptive statistics to see if things look reasonable
df.describe()
```





<div markdown="0">
<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>height</th>
      <th>age</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>3.000000</td>
      <td>3.000000</td>
      <td>3.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>2.333333</td>
      <td>165.333333</td>
      <td>-317.333333</td>
    </tr>
    <tr>
      <th>std</th>
      <td>1.527525</td>
      <td>9.291573</td>
      <td>590.351026</td>
    </tr>
    <tr>
      <th>min</th>
      <td>1.000000</td>
      <td>155.000000</td>
      <td>-999.000000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>1.500000</td>
      <td>161.500000</td>
      <td>-489.500000</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>2.000000</td>
      <td>168.000000</td>
      <td>20.000000</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>3.000000</td>
      <td>170.500000</td>
      <td>23.500000</td>
    </tr>
    <tr>
      <th>max</th>
      <td>4.000000</td>
      <td>173.000000</td>
      <td>27.000000</td>
    </tr>
  </tbody>
</table>
</div>
</div>



So, it looks like our average age is ~ -300.... 

That doesn't seem right. At some point in data collection, missing age values seem to have been encoded as -999. We need to deal with these data. 



{:.input_area}
```python
# Drop all rows with an impossible age
df = df[df['age'] > 0]
```




{:.input_area}
```python
# So what is the actual average age?
df['age'].mean()
```





{:.output_data_text}
```
23.5
```





{:.input_area}
```python
# Check out the cleaned data frame! It is now ready for doing real analysis with!
df
```





<div markdown="0">
<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>height</th>
      <th>age</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>168.0</td>
      <td>20</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>155.0</td>
      <td>27</td>
    </tr>
  </tbody>
</table>
</div>
</div>



### Data Cleaning Notes

This is really just the start of data cleaning - getting data into a fit shape for analysis can include any 
Tips:
- Read any documentation for the dataset you have
    - Things like missing values might be arbitrarily encoded, but should (hopefully) be documented somewhere
- Check that data types are as expected. If you are reading in mixed type data, make sure you end up with the correct encodings
- Visualize your data! Have a look that the distribution seems reasonable
- Check basic statistics. df.describe() can give you a sense if the something is being really skewed
- Keep in mind how your data were collected. 
    - If anything comes from humans entering information into forms, this might take a lot of cleaning
        - Fixing data entry errors (typos)
        - Dealing with inputs using different units / formats / conventions
    - Cleaning this kind of data is likely to take more manual work (since mistakes are likely idiosyncratic)
    
Note that in many real cases, visually scanning through data tables to look for missing or bad data is likely intractable, and/or very inefficient. Looking at your data will likely entail looking at distributions and descriptive statistics, as opposed to raw data. 

<div class="alert alert-info">
Quartz has a useful
<a href="https://github.com/Quartz/bad-data-guide" class="alert-link">Bad Data Guide</a>,
and the 
<a href="http://pandas.pydata.org/pandas-docs/stable/tutorials.html" class="alert-link">Pandas tutorials</a>
have lots of relevant materials, including a chapter (#7) on data cleaning.
</div>
