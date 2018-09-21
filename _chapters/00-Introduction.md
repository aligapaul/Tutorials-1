---
interact_link: notebooks/00-Introduction.ipynb
title: '00-introduction'
permalink: '/chapters/00-Introduction'
previouschapter:
  url: 
  title: ''
nextchapter:
  url: /chapters/01-JupyterNotebooks
  title: '01-jupyternotebooks'
redirect_from:
  - '/chapters/00-introduction'
---

# Data Science in Practice

Welcome to the hands on materials for the Data Science in Practice class.

This notebook will guide through getting the tools you will need for working with these tutorials and assignments.

## What do you need for these tutorials?

### Software

- Working install of python3.6, with the anaconda distribution
- Jupyter Notebooks
- git/Github

### Prerequisites

This class, and this series of tutorials, presumes that you already have some basic knowledge of programming.

In particular it assumes some knowledge Python, covering the standard library. 

If you are somewhat unfamiliar with Python, you can follow the links in the Python notebook to catch up. 

### Computational Resources

The examples throughout these tutorials, and in the assignments are not computationally heavy. 

You should be able to run all these materials on any computer you have access to, assuming it will run the aforementioned tools. 

## Tools

The following are a series of tools that you will need for this class

<img src="img/jupyter.png" width="300px">

<div class="alert alert-success">
Jupyter notebooks are a way to intermix code, outputs and plain text. 
They run in a web browser, and connect to a kernel to be able to execute code. 
</div>

<div class="alert alert-info">
The official Jupyter website is available 
<a href=http://jupyter.org>here</a>.
</div>

<hr>

Note that you do not need to download Jupyter separately, as it comes packaged with anaconda, described below. 

<hr>

<img src="img/NBViewer.png" width="800px">

<div class="alert alert-success">
Notebooks can be rendered on webpages, and shared with others. NBViewer is a tool to host and render notebooks.
</div>

<div class="alert alert-info">
NBViewer is available 
<a href=https://nbviewer.jupyter.org/>here</a>.
</div>

Note that NBViewer is not a tool that you need to download, or necessarily use at all, it is simply a useful tool available online to view notebooks.

<hr>

<img src="img/anaconda.png" width="450px">

<div class="alert alert-success">
Anaconda is an open-source distribution of Python, designed for scientific computing, data science and machine learning. 
</div>

<div class="alert alert-info">
The anaconda website is 
<a href=https://www.anaconda.com>here</a>,
with the download page
<a href=https://www.anaconda.com>here</a>.
</div>

Anaconda itself is a distribution, that is, a collection of packages that are curated and maintained together, and serve as powerful. 

Anaconda also comes with conda, which is a package manager, allowing you to download, install, and manage other packages. 

The anaconda distribution includes all packages that are required for these tutorials.

Notes
-----
- If you are on Mac, you have a native installation of python. This native installation of Python may be older, will not include the extra packages that you will need for this class, and is best left untouched. 
    - Downloading anaconda will install a separate, independent install of Python, leaving your native install untouched. 
- Windows does not require Python natively and so it is not typically pre-installed. 



{:.input_area}
```python
# You can check which python you are using, and what version it is.
#  Once you have installed anaconda, you should see you are using Python in your anaconda folder
#  Make sure that the version you have is 3.6 (or at least 3.X)
#  Note: these are command-line functions that may not work on windows
!which python
!python --version
```


{:.output_stream}
```
/Users/tom/anaconda/envs/py36/bin/python
Python 3.6.3 :: Anaconda, Inc.

```

<img src="img/git.png" style="float:left" width="400px">
<img src="img/github.png" style="float:right" width="400px">

<div class="alert alert-success">
Git is a tool, a software package, for version control. Github is an online hosting service that can be used with git, and offers online tools to use git. 
</div>

<div class="alert alert-info">
Install 
<a href=https://git-scm.com/book/en/v2/Getting-Started-Installing-Git>git</a>,
if you don't already have it, and create an account on 
<a href=https://github.com/>Github</a>.
</div>

Git & Github are not the same thing, though, in practice, they are commonly used together, whereby git is used as a tool to version control code and manage multiple copies stored across your computer, as well as on remote repositories that are stored on Github.

Note that while Github is a private company, git is an open-source tool, and can be used independent of Github.



{:.input_area}
```python
# Check that you have git installed (which version doesn't really matter)
!git --version
```


{:.output_stream}
```
git version 2.14.3 (Apple Git-98)

```

<hr>
<img src="img/sourcetree.png" width="500px">

<div class="alert alert-success">
Source Tree is a free graphical user interface (GUI) for managing repositories with git & Github. 
</div>

<div class="alert alert-info">
Source Tree is available 
<a href=https://www.sourcetreeapp.com>here</a>.
You will need an account on 
<a href=https://www.atlassian.com>Atlassian</a>,
who make Source Tree, but this is free.
</div>

You don't need to use SourceTree (or any other GUI) if you know, or want to learn to use git from the command line.

## Environments

<div class="alert alert-success">
Environments are isolated, independent installations of a programming language and groups of packages, that don't interfere with each other. 
</div>

<div class="alert alert-info">
Anaconda has detailed instructions on using environments available 
<a href=https://conda.io/docs/using/envs.html>here</a>.
</div>

You do not need to use environments, however you may find it useful if you want or need to maintain multiple different versions of Python. 

If you want to use an environment, and already have conda, you can run this command from command line: <br>
$ conda create --name *envname* python=3.6 anaconda <br>
^ Replace '*envname*' with a name to call this environment.<br>
This will install a new environment, with Python 3.6 and the anaconda distribution.

You will then need to activate this environment (everytime) you want to use it. 

To activate your environment: <br>
$ source activate *envname*

To deactivate your environment: <br>
$ source deactivate *envname*
