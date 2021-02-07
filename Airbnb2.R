## New York City Airbnb (2)
## Author: Your Name Here



## INIT ========================================================================
library(knitr)
library(tidyverse)
options(scipen=999)


## VARS ========================================================================
data_file <- "./new-york-city-airbnb-open-data.zip"


## DATA ========================================================================
Airbnb <- read_csv(data_file)

## The str() command is a convenient way to look at your data. This command
## scales to wide data sets better than the head() command does. In addition to
## showing you example data for each column, it tells you the number of column
## and rows in your data.
str(Airbnb)


## Price =======================================================================
## Density Plots Of Price
## What kinds of patterns do you see here?
ggplot(Airbnb, aes(price)) + geom_density()
ggplot(Airbnb, aes(price)) + geom_histogram()

ggplot(Airbnb %>% filter(price <= 1000), aes(price)) + geom_density()

ggplot(Airbnb %>% filter(price <= 250), aes(price)) + geom_density()

ggplot(Airbnb %>% filter(between(price,250,500)), aes(price)) + geom_density()

ggplot(Airbnb %>% filter(between(price,500,1000)), aes(price)) + geom_density()

ggplot(Airbnb %>% filter(between(price,1000,2000)), aes(price)) + geom_density()

## Remember this?
## What is driving those high value ones?
ggplot(Airbnb, aes(room_type, price)) + geom_boxplot()

## Is the neighborhood group useful to predict price?
ggplot(Airbnb, aes(x = room_type, y = price, color = neighbourhood_group)) +
    geom_point(position = "jitter", alpha = .5)

## NO

## What about number of reviews?
ggplot(Airbnb, aes(x = number_of_reviews, y = price, color = neighbourhood_group)) +
    geom_point( alpha = .5)

## NO

## Does it seem like we may  have more than one group here?
## If yes, how do we decide how many?


## KMeans ==============================================================================================
## Ebow Method for finding the optimal number of clusters
## Compute and plot withinss for k = 2 to k = 15.

## What can we do with residuals of the mean?
mean_price <- mean(Airbnb$price)
res <- (Airbnb$price - mean_price)^2
sum(res)

## So, what if we could do this for more than one group?

## Use the elbow, Like.
set.seed(123)
k_max <- 15
results <- tibble(k = numeric(0), tot.withinss = numeric(0))
for(i in 1:k_max){
    r <- kmeans(Airbnb$price,
                i,
                nstart = 50,
                iter.max = 15 )
    results <- bind_rows(results,tibble(k = i, tot.withinss = r$tot.withinss))
}

ggplot(results, aes(k, tot.withinss)) +
    geom_line() +
    geom_point() +
    xlab("Number of clusters K") +
    ylab("Total within-clusters sum of squares")

## Five seems like a good number. So, let's get five goups.
r <- kmeans(Airbnb$price,
            2,
            nstart = 50,
            iter.max = 15 )
Airbnb$cluster <- r$cluster

## The cluster number does not correlate with price!
## That part is "random".
Airbnb %>%
    group_by(cluster) %>%
    summarize(MeanPrice = mean(price),
              MinPrice  = min(price),
              MaxPrice  = max(price))

## But does this tell us anything more?
ggplot(Airbnb, aes(x = cluster, y = price, color = room_type)) +
    geom_point(position = "jitter", alpha = .5)

ggplot(Airbnb, aes(x = cluster, y = price, color = neighbourhood_group)) +
    geom_point(position = "jitter", alpha = .5)

## So, what about neighbourhood.
ggplot(Airbnb, aes(x = cluster, y = price, color = neighbourhood)) +
    geom_point(position = "jitter", alpha = .5)

## Oooh, that doesn't work.
## I mean, it does, but it doesn't.

Airbnb %>%
    group_by(neighbourhood_group, neighbourhood) %>%
    summarize(MeanPrice = mean(price),
              MinPrice  = min(price),
              MaxPrice  = max(price),
              Group1P   = round(100*sum(cluster == 1)/n(),1),
              Group2P   = round(100*sum(cluster == 2)/n(),1)) %>%
    kable()

## How is this like risk?
## How would we assess if a neighbourhood is a risk factor?

Airbnb <- Airbnb %>%
    mutate(expensive = cluster == 1)

Airbnb %>% select(neighbourhood_group) %>% distinct()

neighborhood_group_model <- glm(expensive~neighbourhood_group,
                                data = Airbnb,
                                family = "binomial")

exp(neighborhood_group_model$coefficients)
