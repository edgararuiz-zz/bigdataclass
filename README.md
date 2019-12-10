
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bigdataclass

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
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
    bdc_init_class_local()
    ```

## Setup on a server with an external database

### Build time

#### Needed R packages

``` r
library(bigdataclass)
cat(paste0(bdc_libraries(), collapse = "\n"))
vroom
fs
purrr
dplyr
data.table
dtplyr
lobstr
ggplot2
tidyr
DBI
connections
RSQLite
dbplyr
dbplot
leaflet
tidymodels
modeldb
pins
RPostgres
sparklyr
wordcloud2
readr
```

#### Setup the database and create the exercise files

1.  Connect to the database *(replace with actual user name and
    password)*
    
    ``` r
    con <- dbConnect(RPostgres::Postgres(),
                     host = "localhost",
                     user = "admin_user",
                     port = 5432,
                     password = "password", 
                     dbname = "postgres",
                     bigint = "integer"
                     )
    ```

2.  Run the following script
    
    ``` r
    ## Load the library
    library(bigdataclass)
    ## Path to where the files are to be saved
    folder <- "usr/share/class"
    ## Creates the "retail" schema inside the database connection
    con <- bdc_init_db(con)
    ## Creates the tables and views inside the schema
    bdc_init_database(con = con, avg_daily_orders = 10000)
    ## Builds the files and saves them to the path in "folder" 
    bdc_init_files(con = con, folder = file.path(folder, "files"))
    ## Downloads the books from the Gutenbergh API and saves them to the "folder"
    bdc_init_books(file.path(folder, "books"))
    ```

### Run time

1.  Create the project using the following defaults *(replace with
    actual user name and password)*
    
    ``` r
    library(bigdataclass)
    folder <- "usr/share/class"
    bdc_create_project(
      folder = "/home/rstudio-user/big-data-class",
      db_connection = "con <- connection_open(RPostgres::Postgres(), host = 'localhost', user = 'user', password = 'pwd', port = 5432,  dbname = 'postgres', bigint = 'integer')",
      dbi_connection = "con <- dbConnect(RPostgres::Postgres(), host = 'localhost', user = 'user', password = 'pwd', port = 5432,  dbname = 'postgres', bigint = 'integer')",
      files_path = file.path(folder, "files"),
      books_path = file.path(folder, "books")
    )
    ```
