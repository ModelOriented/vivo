
The LocalVariableImportanceViaOscillations package - variable importance measure based on Ceteris Paribus profiles
==================================================================================================================

[![Build Status](https://travis-ci.com/kozaka93/LocalVariableImportanceViaOscillations.svg?branch=master)](https://travis-ci.com/kozaka93/LocalVariableImportanceViaOscillations)
[![codecov](https://codecov.io/gh/kozaka93/LocalVariableImportanceViaOscillations/branch/master/graph/badge.svg)](https://codecov.io/gh/kozaka93/LocalVariableImportanceViaOscillations) 

This package is a tool for calculated variable importance. The measure is based on Ceteris Paribus plot and calculated in eight variants.

Installation
------------

``` r
install.packages("devtools")
library(devtools)
install_github("kozaka93/LocalVariableImportanceViaOscillations")
```

Intuition
---------

Ceteris Paribus is a latin pharse meaning „other things held constant” or „all else unchanged”. Ceteris Paribus Plots are designed to present model response around a single point in the feature space. Shows how the model response depends on changes in a single input variable, keeping all other variables uncharged. They are working for any Machine Learning model and allow for model comparisons to better understend how a black model is worinkg.

Let consider a example

``` r
library(LocalVariableImportanceViaOscillations)
library(DALEX)
library(randomForest)
library(ingredients)
#data from DALEX package 
data(apartments)
#model 
apartments_rf_model <- randomForest(m2.price ~ construction.year + surface + floor +
                                      no.rooms, data = apartments)
explainer_rf <- explain(apartments_rf_model,
                        data = apartmentsTest[,2:5], y = apartmentsTest$m2.price)
#new observation
new_apartment <- data.frame(construction.year = 1998, surface = 88, floor = 2L, no.rooms = 3)
cp <- ingredients::ceteris_paribus(explainer_rf, new_apartment)

#ceteris paribus plot
plot(cp) + show_observations(cp)
```

![](README_files/figure-markdown_github/unnamed-chunk-3-1.png)

The value of the colored area is our measure, which we can calculated in eight variants. ![](README_files/figure-markdown_github/unnamed-chunk-4-1.png)

``` r
#calculate measure with all parameter are true
measure <- LocalVariableImportance(cp, apartments, absolute_deviation = TRUE, point = TRUE, density = TRUE)
```

    ## Results: 
    ## construction.year: 212.039089035232
    ##  surface: 299.755610860514
    ##  floor: 249.517683792673
    ##  no.rooms: 102.532756041815

``` r
plot(measure)
```

![](README_files/figure-markdown_github/unnamed-chunk-5-1.png)
