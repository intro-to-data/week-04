+Wee## Insurance Costs
## Data: https://www.kaggle.com/mirichoi0218/insurance
## Author: Your Name Here


## INIT ========================================================================
library(tidyverse)
options(scipen = 999)


## DATA =======================================================================
## Loads the data and provides an initial view.  This code checks for
## the presence of insurance.csv. If it fails to find the data file,
## it will give you an error and stop.
data_file <- "insurance.csv"
if (file.exists(data_file)){
    Insurance <- read_csv(file = data_file)
} else {
    stop("The data file is not in your current working directory.")
}
str(Insurance)


## Analysis ===================================================================

## Before continuing, here are some useful variables you should run
## the following code. You should also look at this code, because it
## will be useful later.
avg_charges <- mean(Insurance$charges)
sd_charges <- sd(Insurance$charges)
avg_log_charges <- mean(log(Insurance$charges))
sd_log_charges <- sd(log(Insurance$charges))



## Question 01: Distribution of charges
##
## - https://en.wikipedia.org/wiki/Multimodal_distribution
## - https://en.wikipedia.org/wiki/Log-normal_distribution
##
## How would you describe the distribution of charges? Is the data
## multi-modal? Do you believe it roughly follows the log-normal
## distribution? An eye-ball assessment is fine. I am not asking for a
## formal statistical test.

ggplot(Insurance, aes(charges)) +
    geom_density() +
    geom_vline(xintercept = avg_charges, color = "red")

## Fortunately, we can remove much of the skew from our data by taking
## the log of charges. It isn't perfect, and yes, it is still multi-modal,
## but it is much more normalized than before.

ggplot(Insurance, aes(age, log(charges))) +
    geom_point()

ggplot(Insurance, aes(age, charges)) +
    geom_point() +
    geom_smooth(method = "lm")

ggplot(Insurance, aes(age, charges, color = smoker)) +
    geom_point() +
    geom_smooth(method = "lm")



## Question 02: Measures of central tendency
##
## The red line on the above plots shows the calculated average. Which
## average (mean) is a better measure of central tendency?
## https://simple.wikipedia.org/wiki/Central_tendency

## Hint: You do not need any additional code for this question.


## Question 03: Create log_charges and calculate the average log_charge.
##
## Create a new column in the Insurance data called log_charges. This
## column should contain the more normalized distribution of charges.
## You will need to use the mutate() function to do this. You can see
## above for an example of how to apply log() to a vector. Remember to
## save the results of mutate back to Insurance to keep your new
## column.

## Your code here.


## Run the code below to calculate the average log_charge. If you
## successfully create the column above, this code should work for
## you. Remember, although useful for comparison purposes, the log of
## charges has no real meaning and the average does not approximate
## anything in the real world.
## Enter the results of this into Canvas.

Insurance %>% summarize(MeanLogCharges = mean(log_charges))


## Question 04: Average Charges
##
## It would be nice to compare costs of men to women. Group charges by
## sex, and calculate the average charge and standard deviation for
## males and females. To do this, you will need to use the dplyr
## commands group_by() and summarize(). The function for average is
## mean() and standard deviation is sd().

## Your code here.
## In Canvas, enter the average charge for males.


## Question 05: Average Log Charges
##
## This is just like question 3, but applied to a different column.

## Your code here.
## In cavas, enter the average log_charges for males.


## Question 06:
##
## - https://en.wikipedia.org/wiki/Coefficient_of_variation
##
## The average of log_charges is different than the average
## charge. Now, let's discuss the differences in standard
## deviation. One way to do so is to use the coefficient of variation.
##
## Calculate the coefficient of variation for charges and log_charges.
## Anytime you are comparing groups where the sd is a high proportion
## of the mean, you have the opportunity for misleading results.
## Note: This happens frequently.

## Your code here.
## (You can just type in the numbers. You don' have to create variables.)


## Question 07: Student's T-Test
##
## https://en.wikipedia.org/wiki/Student%27s_t-test
##
## The t-test is a classic test used for comparing the average of two
## groups. But, this data violates a key assumption of the t-test. The
## charges data is not even a little normalized.


?t.test ## Read the t.test function documentation.

## Run a t-test on the original data.
t.test(charges~sex, data = Insurance)

## Now run a t-test on the normalized data.
t.test(log_charges~sex, data = Insurance)

## Of course, the averages will differ. What do you notice about the
## p-value of the two t-tests? Are they similar? Are they different?
## If we assume statistical significance at the .05 level, do both
## tests suggest the same conclusion? Does this surprise you?


## Question 08: Charges as a function of age
##
## On average, we will all get more expensive as we age. (Yes, even
## you.) The graph below shows charges as a function of age, and adds
## in the linear model regression to prove the point. However, you
## should observe a weird banding effect in the distribution of
## charges. To my eyes, there are three "bands" of members. Banding
## such as this suggests there are one or more additional confounding
## variables which would help explain the banding/grouping.

ggplot(Insurance, aes(age, charges)) +
    geom_point() +
    geom_smooth(method = lm)

## Can you add color to the aesthetic command (aes) which helps
## explain at least some of the banding? In other words, which
## variable from our data can explain some or all of the banding we
## see from the above plot.
##
## Hint: This variable is probaly a categorical, and not a numeric
## variable like bmi. I'll explain how to add bmi into this later.

## Your code here
ggplot(Insurance, aes(age, charges, color = smoker)) +
    geom_point() +
    geom_smooth(method = lm)


## In Canvas, tell me what variable you added to the code to explain
## the banding.



## Question 09: Charges as a function of bmi and smoker status.
##
## Create a linear regression in ggplot, like we did in the previous
## question. The x-axis should be bmi, the y-axis should be charges,
## and color should be smoker status.

## Your code here.
ggplot(Insurance, aes(bmi, charges, color = smoker)) +
    geom_point() +
    geom_smooth(method = lm)

## In Canvas, please discuss what you see here.


## Question 10: Upload Insurance.R
##
## There's nothing to do here. Upload your .R file.
