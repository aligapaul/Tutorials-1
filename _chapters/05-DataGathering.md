---
interact_link: notebooks/05-DataGathering.ipynb
title: '05-datagathering'
permalink: '/chapters/05-DataGathering'
previouschapter:
  url: /chapters/04-DataSciencePython
  title: '04-datasciencepython'
nextchapter:
  url: /chapters/06-DataWrangling
  title: '06-datawrangling'
redirect_from:
  - '/chapters/05-datagathering'
---

# Data Gathering

<div class="alert alert-success">
Data Gathering is simply the process of collecting your data together.
</div>

This notebook covers strategies you can use to gather data for an analysis. 

If you want to move on to first working on data analyses (with provided data) you can move onto the next tutorials, and come back to this one later.

Data gathering can encompass anything from launching a data collection project, web scraping, pulling from a database, downloading data in bulk. 

It might even include simply calling someone to ask if you can use some of their data. 

## Where to get Data

### The Web

The web is absolutely full of data or ways to get data, either by hosting **data repositories** from which you can download data, by offering **APIs** through which you can request specific data from particular applications, or as data itself, such that you can use **web scraping** to extract data directly from websites. 

### Other than the Web

Not all data is indexed or accessible on the web, at least not publicly. 

Sometimes finding data means chasing down data wherever it might be. 

If there is some particular data you need, you can try to figure out who might have it, and get in touch to see if it might be available.

### Data Gathering Skills
Depending on your gathering method, you will likely have to do some combination of the following:
- Download data files from repositories
- Read data files into python
- Use APIs 
- Query databases
- Call someone and ask them to send you a harddrive

## Data Repositories

<div class="alert alert-success">
A Data Repository is basically just a place that data is stored. For our purposes, it is a place you can download data from. 
</div>

<div class="alert alert-info">
There is a curated list of good data source included in the 
<a href=https://github.com/COGS108/Projects>project materials</a>.
</div>

## Databases

<div class="alert alert-success">
A database is an organized collection of data. More formally, 'database' refers to a set of related data, and the way it is organized. 
</div>

### Structured Query Language - SQL

<div class="alert alert-success">
SQL (pronounced 'sequel') is a language used to 'communicate' with databases, making queries to request particular data from them.
</div>

<div class="alert alert-info">
There is a useful introduction and tutorial to SQL
<a href=http://www.sqlcourse.com/intro.html>here</a>
as well as some useful 'cheat sheets' 
<a href=http://www.cheat-sheets.org/sites/sql.su/>here</a>
and
<a href=http://www.sqltutorial.org/wp-content/uploads/2016/04/SQL-cheat-sheet.pdf>here</a>.
</div>

SQL is the standard, and most popular, way to interface with relational databases.

Note: None of the rest of the tutorials presume or require any knowledge of SQL. 

You can look into it if you want, or if it is relevant to accessing some data you want to analyze, but it is not required for this set of tutorials. 

## Application Program Interfaces (APIs)

<div class="alert alert-success">
APIs are basically a way for software to talk to software - it is an interface into an application / website / database designed for software.
</div>

<div class="alert alert-info">
For a simple explanation of APIs go
<a href=https://medium.freecodecamp.com/what-is-an-api-in-english-please-b880a3214a82>here</a>
or for a much broader, more technical, overview try
<a href=https://medium.com/@mattburgess/apis-a-basic-primer-f8250602597d>here</a>.
</div>

APIs offer a lot of functionality - you can send requests to the application to do all kinds of actions. In fact, any application interface that is designed to be used programatically is an API, including, for example, interfaces for using packages of code. 

One of the many things that APIs do, and offer, is a way to query and access data from particular applications / databases. The benefit of using APIs for data gathering purposes is that they typically return data in nicely structured formats, that are relatively easy to analyze.

### Launching URL Requests from Python



{:.input_area}
```python
# Imports
#  requests lets you make http requests from python
import requests
import pandas as pd
```


In practice, APIs are usually special URLs that return raw data (json or XML) as opposed to a web page to be rendered for human viewers (html). Find the documentation for a particular API to see how you send requests to access whatever data you want. For example, let's try the Github API. 



{:.input_area}
```python
# Request data from the Github API on a particular user
page = requests.get('https://api.github.com/users/tomdonoghue')
```




{:.input_area}
```python
# In this case, the content we get back is a json file
page.content
```





{:.output_data_text}
```
b'{"login":"TomDonoghue","id":7727566,"avatar_url":"https://avatars0.githubusercontent.com/u/7727566?v=4","gravatar_id":"","url":"https://api.github.com/users/TomDonoghue","html_url":"https://github.com/TomDonoghue","followers_url":"https://api.github.com/users/TomDonoghue/followers","following_url":"https://api.github.com/users/TomDonoghue/following{/other_user}","gists_url":"https://api.github.com/users/TomDonoghue/gists{/gist_id}","starred_url":"https://api.github.com/users/TomDonoghue/starred{/owner}{/repo}","subscriptions_url":"https://api.github.com/users/TomDonoghue/subscriptions","organizations_url":"https://api.github.com/users/TomDonoghue/orgs","repos_url":"https://api.github.com/users/TomDonoghue/repos","events_url":"https://api.github.com/users/TomDonoghue/events{/privacy}","received_events_url":"https://api.github.com/users/TomDonoghue/received_events","type":"User","site_admin":false,"name":"Tom","company":"UC San Diego","blog":"tomdonoghue.github.io","location":"San Diego","email":null,"hireable":null,"bio":"Cognitive Science Grad Student @ UCSD. \\r\\nOn Twitter @TomDonoghue","public_repos":13,"public_gists":0,"followers":13,"following":35,"created_at":"2014-05-28T20:20:48Z","updated_at":"2018-01-09T04:15:59Z"}'
```





{:.input_area}
```python
# We can read in the json data with pandas
pd.read_json(page.content, typ='series')
```





{:.output_data_text}
```
avatar_url             https://avatars0.githubusercontent.com/u/77275...
bio                    Cognitive Science Grad Student @ UCSD. \r\nOn ...
blog                                               tomdonoghue.github.io
company                                                     UC San Diego
created_at                                          2014-05-28T20:20:48Z
email                                                               None
events_url             https://api.github.com/users/TomDonoghue/event...
followers                                                             13
followers_url          https://api.github.com/users/TomDonoghue/follo...
following                                                             35
following_url          https://api.github.com/users/TomDonoghue/follo...
gists_url              https://api.github.com/users/TomDonoghue/gists...
gravatar_id                                                             
hireable                                                            None
html_url                                  https://github.com/TomDonoghue
id                                                               7727566
location                                                       San Diego
login                                                        TomDonoghue
name                                                                 Tom
organizations_url          https://api.github.com/users/TomDonoghue/orgs
public_gists                                                           0
public_repos                                                          13
received_events_url    https://api.github.com/users/TomDonoghue/recei...
repos_url                 https://api.github.com/users/TomDonoghue/repos
site_admin                                                         False
starred_url            https://api.github.com/users/TomDonoghue/starr...
subscriptions_url      https://api.github.com/users/TomDonoghue/subsc...
type                                                                User
updated_at                                          2018-01-09T04:15:59Z
url                             https://api.github.com/users/TomDonoghue
dtype: object
```



<div class="alert alert-info">
This
<a href=http://www.webopedia.com/TERM/A/API.html>list</a>
includes a collection of commonly used and available APIs. 
</div>

## Web Scraping

<div class="alert alert-success">
Web scraping is when you (programmatically) extract data from websites.
</div>

<div class="alert alert-info">
<a href=https://en.wikipedia.org/wiki/Web_scraping>Wikipedia</a>
has a useful page on web scraping.
</div>

Note that the following section uses the 'BeautifulSoup' module, which is not part of the standard anaconda distribution. 

If you do not have BeautifulSoup, and want to get it to run this section, you can uncomment the cell below, and run it, to install BeautifulSoup in your current Python environment. You only have to do this once.



{:.input_area}
```python
#import sys
#!conda install --yes --prefix {sys.prefix} beautifulsoup4
```




{:.input_area}
```python
# Import BeautifulSoup
from bs4 import BeautifulSoup
```




{:.input_area}
```python
# Set the URL for the page we wish to scrape
site_url = 'https://en.wikipedia.org/wiki/Data_science'

# Launch the URL request, to get the page
page = requests.get(site_url)
```




{:.input_area}
```python
# Print out the first 1000 characters of the scraped web page
page.content[0:1000]
```





{:.output_data_text}
```
b'<!DOCTYPE html>\n<html class="client-nojs" lang="en" dir="ltr">\n<head>\n<meta charset="UTF-8"/>\n<title>Data science - Wikipedia</title>\n<script>document.documentElement.className = document.documentElement.className.replace( /(^|\\s)client-nojs(\\s|$)/, "$1client-js$2" );</script>\n<script>(window.RLQ=window.RLQ||[]).push(function(){mw.config.set({"wgCanonicalNamespace":"","wgCanonicalSpecialPageName":false,"wgNamespaceNumber":0,"wgPageName":"Data_science","wgTitle":"Data science","wgCurRevisionId":822535327,"wgRevisionId":822535327,"wgArticleId":35458904,"wgIsArticle":true,"wgIsRedirect":false,"wgAction":"view","wgUserName":null,"wgUserGroups":["*"],"wgCategories":["Use dmy dates from December 2012","Information science","Computer occupations","Computational fields of study","Data analysis"],"wgBreakFrames":false,"wgPageContentLanguage":"en","wgPageContentModel":"wikitext","wgSeparatorTransformTable":["",""],"wgDigitTransformTable":["",""],"wgDefaultDateFormat":"dmy","wgMonthNames":["","Ja'
```



Note that the source of the scraped web-page is a messy pile of HTML. 

There is a lot of information in there, but with no clear organization. There is some structure in the page though, delineated by HTML tags, etc, we just need to use them to parse out the data. We can do that with BeautifulSoup, which takes in messy documents like this, and parses them based on a specified format. 



{:.input_area}
```python
# Parse the webpage with Beautiful Soup, using a html parser
soup = BeautifulSoup(page.content, 'html.parser')
```




{:.input_area}
```python
# With the parsed soup object, we can select particular segments of the web page

# Print out the page title
print('TITLE: \n')
print(soup.title)

# Print out the first p-tag
print('\nP-TAG:\n')
print(soup.find('p'))
```


{:.output_stream}
```
TITLE: 

<title>Data science - Wikipedia</title>

P-TAG:

<p><b>Data science</b>, also known as <b>data-driven science</b>, is an interdisciplinary field of scientific methods, processes, and systems to extract <a href="/wiki/Knowledge" title="Knowledge">knowledge</a> or insights from <a href="/wiki/Data" title="Data">data</a> in various forms, either structured or unstructured,<sup class="reference" id="cite_ref-:0_1-0"><a href="#cite_note-:0-1">[1]</a></sup><sup class="reference" id="cite_ref-2"><a href="#cite_note-2">[2]</a></sup> similar to <a href="/wiki/Data_mining" title="Data mining">data mining</a>.</p>

```

From the soup object, you can explore that the page is much more organized, and in such a way that you can extract particular components of interest. 

Note that it is still 'messy' in other ways, in that there might or might not be a systematic structure to how the page is laid out, and it still might take a lot of work to extract the particular information you want from it.

### APIs vs. Web Scraping

Web scraping is distinct from using an API, even though many APIs may be accessed over the internet. Web scraping is different in that you are (programmatically) navigating through the internet, and extracting data of interest. 

Note:
Be aware that scraping data from websites (without using APIs) can often be an involved project itself - scraping sites can take a considerable amount of tuning to get the data you want. 

Be aware that data presented on websites may not be well structured, or in an organzed format that lends itself to easy analysis.

If you try scraping websites, also make sure you are allowed to scrape the data, and follow the websites terms of service. 
