# Question 1
# Consider the data set given below
# x <- c(0.18, -1.54, 0.42, 0.95)
# And weights given by
# w <- c(2, 1, 3, 1)

# Give the value of mu that minimizes the least squares equation sum (1 to n) = wi(xi - u) ^2

question1 <- function (){

  x <- c(0.18, -1.54, 0.42, 0.95)
  w <- c(2, 1, 3, 1)
  minFun <- function(u) {sum(w * (x - u)^2)}
  
  # The interval must cover all of the possible given answers. (1.077, 0.0025, 0.1471, 0.300)
  optimize(minFun, interval=c(0, 1.1), maximum=FALSE)["minimum"]
}

# $minimum
# [1] 0.1471429

# Question 2
## Consider the following data set
## x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
## y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)

## Fit the regression through the origin and get the slope treating y as 
## the outcome and x as the regressor. (Hint, do not center the data since 
## we want regression through the origin, not through the means of the data.)

question2 <- function(){
  
  x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)     # x as regressor
  y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)  # y as outcome
  
  coef(lm(y ~ x - 1)) # -1 since we want the regression through the origin
  #lm function https://stat.ethz.ch/R-manual/R-patched/library/stats/html/lm.html
}

# 0.8263  

# Question 3
# Do data(mtcars) from the datasets package and fit the regression model with 
# mpg as the outcome and weight as the predictor. Give the slope coefficient.


question3 <- function()
{
  weight <- mtcars$wt  # weight as regressor
  mpg    <- mtcars$mpg # mpg as outcome
  
  coef(lm(mpg ~ weight))["weight"]
  
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

question6 <- function()
{
  x <- c(8.58, 10.46, 9.01, 9.64, 8.86)  
  xNormalize <- (x - mean(x)) / sd(x)
  xNormalize[1]
}
# R [1] -0.9718658

# Question 7

# Consider the following data set (used above as well). 
# What is the intercept for fitting the model with x as the predictor 
# and y as the outcome?

# x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
# y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)

question7 <- function(){
  x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
  y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
  coef(lm(y ~ x))["(Intercept)"]
}

# (Intercept) 
# 1.567461 

# Question 8
# You know that both the predictor and response have mean 0. 
# What can be said about the intercept when you fit a linear regression?

# Bo = mean(Y) - B1 mean(X) => Bo = 0 - 0 = 0
# It must be identically 0.


# Question 9

# Consider the data given by

# x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)

# What value minimizes the sum of the squared 
# distances between these points and itself?

question9 <- function(){
  x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
  minFun <- function(u) {sum((x - u)^2)}
  
  optimize(minFun, interval=c(min(x), max(0.85)), maximum=FALSE)["minimum"]
  
  # or simply
  
  # the value of u that minimizes 
  # Sum (xi - u)^2 
  # This is physical center of mass of the histrogram.
  # u = mean (x) 
  
  mean (x)
}
#[1] 0.573

# Question 10

# Let the slope having fit Y as the outcome and X as the predictor 
# be denoted as B1. Let the slope from fitting X as the outcome and Y 
# as the predictor be denoted as y1. Suppose that you divide B1 by y1; 
# in other words consider B1/y1. What is this ratio always equal to?

#                   Sd(y)
# B1 = cor(y,x) x --------
#                   Sd(x)

#                   Sd(x)
# y1 = cor(x,y) x --------
#                   Sd(y)

#
# B1      cor(y,x)     Sd(y) * Sd(y)      sd(y)^2         Var(y)
#---- = ----------- x --------------- = ------------ =  ---------
# y1      cor(x,y)     Sd(x) * Sd(x)      sd(x)^2         Var(x)
#



