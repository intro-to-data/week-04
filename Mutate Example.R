## INIT ========================================================================
library(tidyverse)

## DATA ========================================================================
## This is a famous dataset of car, from the 70s.
## It is useful for all sorts of things.
data(mtcars)
str(mtcars)


## FIRST EXAMPLE ===============================================================

## Let's say I wanted to look at diplacement as a function of
## cylinders.  To do so, I will use a boxplot to look at the range of
## displacement (disp) by N cylinders (cyl). In other words, I am
## treating the cyl column as a factor, not a number/continuous
## variable.
##
## Note: Because cyl _is_ an integer, I have to convert it to a factor
## in order for this to work. This is awkward.
ggplot(mtcars, aes(factor(cyl), disp)) + geom_boxplot()

## So, what if I wanted to have cyl as a new column and not have to do that?
mtcars <-
    mtcars %>%
    mutate(cyl_factor = factor(cyl))

## Lines 23 and 24 create the new column. But, in order to save it, I
## have to save this new dataframe somwhere. I could call it
## mtcars_new, or anything else I want, but I don't actually want/need
## multiple mtcars datasets, so I will just reassign the new data to
## the old variable name.  Now, I can just use the new column.
ggplot(mtcars, aes(cyl_factor, disp)) + geom_boxplot()

## And the output is the same.


## SECOND EXAMPLE
## ==============================================================
## Maybe I want to compare the displacement of eight cylinder engines
## to engines with few than 8 cylinders. How many different cylinder types do I have?
mtcars %>% select(cyl) %>% distinct()

## OK, the biggest cylinder number in this data is 8, which is
## convenient. Let's call 8 cylinder engines big_engines. Because
## . . . . . well . . . . I want to. Again, see how I am transforming
## the data and then saving it again.

mtcars <-
    mtcars %>%
    mutate(big_engines = cyl == 8)

## And now, I'll look at the average displacement by my new big_engines column.
mtcars %>%
    group_by(big_engines) %>%
    summarize(AvgDisp = mean(disp),
              MaxDisp = max(disp),
              MinDisp = min(disp),
              SDDisp  = sd(disp))

## Clearly, the average displacement of eight cylinder engines is
## bigger than that of the 4 and 6 cylinder engines.




