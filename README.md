
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bigdataclass

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.com/edgararuiz/bigdataclass.svg?branch=master)](https://travis-ci.com/edgararuiz/bigdataclass)
[![Codecov test
coverage](https://codecov.io/gh/edgararuiz/bigdataclass/branch/master/graph/badge.svg)](https://codecov.io/gh/edgararuiz/bigdataclass?branch=master)
<!-- badges: end -->

The goal of `bigdataclass` is to provide an easy way to create the data
and materials needed for the Big Data with R class.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("edgararuiz/bigdataclass")
```

## Setup the class locally

1.  Load the package
    
    ``` r
    library(bigdataclass)
    ```

2.  Run `bdc_init_class_local()` to create the class in a folder called
    **big-data-class**
    
    ``` r
    bdc_create_class()
    ```
