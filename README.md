
The vivo package - variable importance measure based on Ceteris Paribus profiles
==================================================================================================================

[![Build Status](https://travis-ci.com/kozaka93/vivo.svg?branch=master)](https://travis-ci.com/kozaka93/vivo)
[![codecov](https://codecov.io/gh/kozaka93/vivo/branch/master/graph/badge.svg)](https://codecov.io/gh/kozaka93/vivo)

This package is a tool for calculated variable importance. The measure is based on Ceteris Paribus plot and calculated in eight variants. We obtain eight variants measure through the possible options of three parameters such as `absolute_deviation`, `point` and `density`.

Installation
------------

``` r
install.packages("devtools")
library("devtools")
install_github("kozaka93/vivo")
```

Intuition
---------
Ceteris Paribus is a latin pharse meaning „other things held constant” or  „all else unchanged”. Ceteris Paribus Plots are designed to present model response around a single point in the feature space. Shows how the model response depends on changes in a single input variable, keeping all other variables uncharged. They are working for any Machine Learning model and allow for model comparisons to better understend how a black model is worinkg.


Let consider a example

#### 1 Dataset

We work on Apartments dataset from `DALEX` package.

```{r, message=FALSE, warning=FALSE}
library("DALEX")
data(apartments)
```

#### 2 Build a model

We define a random forest regression model.

```{r, message=FALSE, warning=FALSE}
library("randomForest")
#model
apartments_rf_model <- randomForest(m2.price ~ construction.year + surface + floor +
                                      no.rooms, data = apartments)
#explainer from DALEX
explainer_rf <- explain(apartments_rf_model,
                        data = apartmentsTest[,2:5], y = apartmentsTest$m2.price)
```

#### 3 Ceteris Paribus profiles

```{r, message=FALSE, warning=FALSE}
library("ingredients")

new_apartment <- data.frame(construction.year = 1998, surface = 88, floor = 2L, no.rooms = 3)
#calcutale ceteris paribus profiles
profiles <- ingredients::ceteris_paribus(explainer_rf, new_apartment)

#ceteris paribus plot
plot(profiles) + show_observations(profiles)
```
![](README_files/figure-markdown_github/unnamed-chunk-3-1.png)

### 4 Measure based on Ceteris Paribus profiles

The value of the colored area is our measure, which we can calculated in eight variants.

```{r, message=FALSE, warning=FALSE, error=FALSE, include=TRUE, echo = FALSE}
y_predict = predict(apartments_rf_model, new_apartment)
plot(profiles) + geom_ribbon(aes(ymin = y_predict, ymax = predict(apartments_rf_model, profiles)),
            alpha = 1,fill = '#47bac2') + geom_hline(yintercept = y_predict, colour = theme_drwhy_colors(1)) +show_observations(profiles)  
```
![](README_files/figure-markdown_github/unnamed-chunk-4-1.png)


```{r, message=FALSE, warning=FALSE}
library("vivo")

#calculate measure with all parameter are true
measure <- local_variable_importance(profiles, apartments, absolute_deviation = TRUE, point = TRUE, density = TRUE)

plot(measure)
```

![](README_files/figure-markdown_github/unnamed-chunk-5-1.png)
For the new observation the most important variable is surface, then floor, construction.year and no.rooms.
