
# Variable importance via oscillations <img src="man/figures/logo.png" align="right" width="150"/>

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/vivo)](https://cran.r-project.org/package=vivo)
<img src="http://cranlogs.r-pkg.org/badges/grand-total/vivo" /> [![Build
Status](https://api.travis-ci.org/ModelOriented/vivo.svg?branch=master)](https://travis-ci.org/ModelOriented/vivo)
[![Coverage
Status](https://img.shields.io/codecov/c/github/ModelOriented/vivo/master.svg)](https://codecov.io/github/ModelOriented/vivo?branch=master)
[![DrWhy-eXtrAI](https://img.shields.io/badge/DrWhy-eXtrAI-4378bf)](http://drwhy.ai/#eXtraAI)

## Overview

This `vivo` package helps to calculate 

**- instance level variable importance (local sensitivity).**

The measure is based on Ceteris Paribus profiles and can be calculated in eight variants. Select the variant
that suits your needs by setting parameters: `absolute_deviation`,
`point` and `density`.

**- model level variable importance (global sensitivity).**

The measure is based on Partial Dependence Profiles. 

## vivo package

The main function in `vivo` package are `global_variable_importance()` and `local_variable_importance()`.

<img src="man/figures/vivo.png" align="center" width="600"/>


`vivo` is a part of [DrWhy](https://github.com/ModelOriented/DrWhy)
collection of tools for Visual Exploration, Explanation and Debugging of
Predictive Models.

## Installation

From CRAN

``` r
install.packages("vivo")
```

From GitHub

``` r
install.packages("devtools")
devtools::install_github("ModelOriented/vivo")
```

## Intuition

#### Local variable importance 

Ceteris Paribus is a latin phrase meaning „other things held constant”
or „all else unchanged”. Ceteris Paribus Plots show how the model
response depends on changes in a single input variable, keeping all
other variables unchanged. They work for any Machine Learning model and
allow for model comparisons to better understand how a black model
works.

The measure is based on Ceteris Paribus profiles oscillations. In
particular, the larger influence of an explanatory variable on
prediction at a particular instance, the larger the deviation along the
corresponding Ceteris Paribus profile. For a variable that exercises
little or no influence on model prediction, the profile will be flat or
will barely change.

#### Global variable importance

Here we have a similar intuition as above, but we are looking at Partial Dependence Profiles, because they show how the prediction changes for the model, not only for observation.

## References

  - Ceteris Paribus profiles
    - `ceteris_paribus()` from [`ingredients`](https://modeloriented.github.io/ingredients/reference/ceteris_paribus.html)
    - [Introduction to Ceteris Paribus](https://pbiecek.github.io/ema/ceterisParibus.html)
  - Partial Dependence Profiles
    - `partial_dependence()` from [`ingredients`](https://modeloriented.github.io/ingredients/reference/partial_dependence.html)
    - [Introduction to Partial Dependence Profiles](https://pbiecek.github.io/ema/partialDependenceProfiles.html)


The package was created as a part of master’s diploma thesis at Warsaw
University of Technology at Faculty of Mathematics and Information
Science by [Anna Kozak](https://github.com/kozaka93/).
