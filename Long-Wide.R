## INIT ========================================================================
library(tidyverse)
library(readxl)


## DATA ========================================================================
data_url <- "https://github.com/intro-to-data/Data/raw/master/NYS%20Pedal%20Problems.xlsx"
data_file <- "NYS Pedal Problems.xlsx"
download.file(data_url, data_file)
Long <- read_excel(data_file, sheet = "Long", .name_repair = "universal")
Wide <- read_excel(data_file, sheet = "Wide", .name_repair = "universal")


## Take a quick look at the data in Excel.

## LONG ========================================================================
## This works well.
head(Long)
ggplot(data = Long, aes(Year, Deaths.Per.Year)) + geom_line(color = "blue")


## WIDE ========================================================================
## So. Much. Fail.
## R operates on vectors (columns). Not rows. Rows are for observations.
head(Wide)

## Just think about it. How on earth would you write this in ggplot??
## Hint: You can't. Sorry.

Wide %>%
    pivot_longer(cols = -Year,
                 names_to = "Year",
                 values_to = "count",
                 names_repair = "universal") %>%
    mutate(Year = as.integer(gsub("..","",as.character(Year...2), fixed=TRUE))) %>%
    select(Year, count)

## That's a lot of work.
