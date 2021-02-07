## Pima Indians
## Author: Your Name Here



## INIT ========================================================================
library(knitr)
library(tidyverse)


## VARS ========================================================================
data_file <- "./pima-indians-diabetes.csv"


## DATA ========================================================================
Diabetes <- read_csv(data_file)

## The str() command is a convenient way to look at your data. This command
## scales to wide data sets better than the head() command does. In addition to
## showing you example data for each column, it tells you the number of column
## and rows in your data.
str(Diabetes)
