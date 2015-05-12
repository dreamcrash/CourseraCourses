# Question 1
##Consider the data set given below

## Give the value of u that minimizes the least squares equation sum(ni=1wi(xi−u)2)

q1 <- function()
{
  vector <- c()
  x <- c(0.18, -1.54, 0.42, 0.95)
  w <- c(2, 1, 3, 1)
  solutions <- c(0.300,0.1471,0.0025,1.077)
  
  for(u in solutions)
    vector <- c(vector, sum(w * (x - u)^2))
  
  solutions[which.min(vector)]
}

## [1] 0.1471

# Question 2
## Consider the following data set
## x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
## y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)

## Fit the regression through the origin and get the slope treating y as 
## the outcome and x as the regressor. (Hint, do not center the data since 
## we want regression through the origin, not through the means of the data.)



q2 <- function()
{
  x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)     # x as regressor
  y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)  # y as outcome
  
  lm(y ~ x - 1)
  #lm function https://stat.ethz.ch/R-manual/R-patched/library/stats/html/lm.html
}



# Question 3
# Do data(mtcars) from the datasets package and fit the regression model with 
# mpg as the outcome and weight as the predictor. Give the slope coefficient.

q3 <- function()
{
  weight <- mtcars$wt  # weight as regressor
  mpg    <- mtcars$mpg # mpg as outcome
  
  lm(mpg ~ weight)
  
  # or
  beta1<-cor(mpg,weight)* sd(mpg)/sd(weight)
  
  beta1
}

# Question 4
# Consider data with an outcome (Y) and a predictor (X). 
# The standard deviation of the predictor is one half that of the outcome. 
# The correlation between the two variables is .5. 
# What value would the slope coefficient for the regression model with Y 
# as the outcome and X as the predictor?


# Sd(x) = 0.5 Sd(y)
#
#                Sd(y)            2 Sd(x)
# B1 = C(Y,X) x ------- = 0.5 x ------------= 1
#                Sd(x)              Sd(x)


# Question 5
# Students were given two hard tests and scores were normalized to have empirical
# mean 0 and variance 1. The correlation between the scores on the two tests was 0.4. 
# What would be the expected score on Quiz 2 for a student who had a normalized 
# score of 1.5 on Quiz 1?

# C(Y,X) = 0.4
# SD(X) = SD(Y) = 1
# B0 = 0
# X = 1.5 (quiz 1)
# Y = ?   (quiz 2)

#                Sd(y)            1
# B1 = C(Y,X) x ------- = 0.4 x ----- = 0.4
#                Sd(x)            1

# Bo = Y - B1 X
# 0 = Y - 0.4 x 1.5
# Y = 0.6

# Question 6

# Consider the data given by the following

# x <- c(8.58, 10.46, 9.01, 9.64, 8.86)

# What is the value of the first measurement if x were normalized 
# (to have mean 0 and variance 1)?

# Normalizing data (xi - Mean(x)) / Sd(x)


q6 <- function()
{
  x <- c(8.58, 10.46, 9.01, 9.64, 8.86)  
  xNormalize <- (x - mean(x)) / sd(x)
  xNormalize[1]
}

# Question 7

# Consider the following data set (used above as well). 
# What is the intercept for fitting the model with x as the predictor 
# and y as the outcome?

# x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
# y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)

q7 <- function(){
  x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
  y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
  lm(y ~ x)
}

# Question 8
# You know that both the predictor and response have mean 0. 
# What can be said about the intercept when you fit a linear regression?

# It must be identically 0.


# Question 9

# Consider the data given by

# x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)

# What value minimizes the sum of the squared 
# distances between these points and itself?

q9 <- function(){
  vector <- c()
  x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
  solutions <- c(0.573,0.8,0.36,0.44)
  
  for(u in solutions)
    vector <- c(vector, sum((x - u)^2))
  
  solutions[which.min(vector)]
  
  # or simply
  
  # the value of u that minimizes 
  # Sum (xi - u)^2 
  # This is physical center of mass of the histrogram.
  # u = mean (x) 
  
  mean (x)
}

# Question 10

# Let the slope having fit Y as the outcome and X as the predictor 
# be denoted as β1. Let the slope from fitting X as the outcome and Y 
# as the predictor be denoted as γ1. Suppose that you divide β1 by γ1; 
# in other words consider β1/γ1. What is this ratio always equal to?

#                   Sd(y)
# β1 = cor(y,x) x --------
#                   Sd(x)

#                   Sd(x)
# γ1 = cor(x,y) x --------
#                   Sd(y)

#
# β1      cor(y,x)     Sd(y) * Sd(y)      sd(y)^2         Var(y)
#---- = ----------- x --------------- = ------------ =  ---------
# γ1      cor(x,y)     Sd(x) * Sd(x)      sd(x)^2         Var(x)
#
