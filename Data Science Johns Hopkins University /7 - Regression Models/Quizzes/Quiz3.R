

q1 <- function(){
  #Consider the mtcars data set. Fit a model with mpg as the outcome that includes number of cylinders 
  # as a factor variable and weight as confounder. Give the adjusted estimate for the expected change 
  # in mpg comparing 8 cylinders to 4.    
    
  data(mtcars) # load data
  # mpg as outcome, # of cylinders as factor variable, weight as confounder        
  summary(lm(mpg ~ as.factor(cyl) + wt, data=mtcars))
  
  
#Report
# Coefficients:
#    Estimate Std. Error t value Pr(>|t|)    
#  (Intercept)      33.9908     1.8878  18.006  < 2e-16 ***
#    as.factor(cyl)6  -4.2556     1.3861  -3.070 0.004718 ** 
#    as.factor(cyl)8  -6.0709     1.6523  -3.674 0.000999 ***
#    wt               -3.2056     0.7539  -4.252 0.000213 ***
#    ---
}

q2 <- function(){
  # Consider the mtcars data set. Fit a model with mpg as the outcome that includes 
  # number of cylinders as a factor variable and weight as a possible confounding variable. 
  # Compare the effect of 8 versus 4 cylinders on mpg for the adjusted and unadjusted by weight models. 
  # Here, adjusted means including the weight variable as a term in the regression model and unadjusted 
  # means the model without weight included. What can be said about the effect comparing 
  # 8 and 4 cylinders after looking at models with and without weight included?.
  
  data(mtcars) # load data
  fitCylandWt <- lm(mpg ~ as.factor(cyl) + wt, data=mtcars) # adjusted model
  fitCyl <- lm(mpg ~ as.factor(cyl), data=mtcars)           # unadjusted model
  
  # 1) adjusted model 
  # Coefficients:
  # (Intercept)  as.factor(cyl)6  as.factor(cyl)8               wt  
  # 33.991           -4.256           -6.071           -3.206  
  # vs
  # 
  # unadjusted model
  # Coefficients:
  # (Intercept)  as.factor(cyl)6  as.factor(cyl)8  
  # 26.664           -6.921          -11.564  
  
  # -6.071 vs -11.564
  
  # Holding weigh constant, cylinder appears to have less of an impact on mpg than if weight is disregarded
}

q3 <- function(){
  
  # Consider the mtcars data set. Fit a model with mpg as the outcome that considers 
  # number of cylinders as a factor variable and weight as confounder. 
  # Now fit a second model with mpg as the outcome model that considers the interaction 
  # between number of cylinders (as a factor variable) and weight. 
  # Give the P-value for the likelihood ratio test comparing the two models 
  # and suggest a model using 0.05 as a type I error rate significance benchmark.
  
  # Fit a model with mpg as the outcome that considers 
  # number of cylinders as a factor variable and weight as confounder:
  data(mtcars) # load data
  fitCylandWt <- lm(mpg ~ as.factor(cyl) + wt, data=mtcars)
  
  # Now fit a second model with mpg as the outcome model that considers the interaction 
  # between number of cylinders (as a factor variable) and weight:
  
  fitCylandWtInteraction <- lm(mpg ~ as.factor(cyl) * wt, data=mtcars)
  
  anova(fitCylandWt,fitCylandWtInteraction)$Pr[2]
  # [1] 0.123857 which is > than 0.05.
  # The P-value is larger than 0.05. So, according to our criterion, we would fail to reject, 
  # which suggests that the interaction terms may not be necessary.
}

q4 <- function(){
  
  # Consider the mtcars data set. Fit a model with mpg as the outcome that 
  # includes number of cylinders as a factor variable and weight inlcuded in the model as
  # lm(mpg ~ I(wt * 0.5) + factor(cyl), data=mtcars)
  # How is the wt coefficient interpretted?
  
  # By wt * 0.5 we are converting to short ton (in the USA is 2000 lbs)
  
  
  # Answer :
  # The estimated expected change in MPG per one ton in weight for a specific number of cylinders (4, 6, 8).
  
}


q5 <- function(){
  
  # Consider the following data set
  # x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
  # y <- c(0.549,-0.026,-0.127,-0.751, 1.344)
  
  # Give the hat diagonal for the most influential point
   hatvalues(lm(y ~ x))
   #         1         2         3         4         5 
   # 0.2286650 0.2438146 0.2525027 0.2804443 0.9945734 
}

q6 <- function(){
  # Consider the following data set
  # x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
  # y <- c(0.549,-0.026,-0.127,-0.751, 1.344)
  
  # Give the slope dfbeta for the point with the highest hat value.
  
  # dfbetas(lm(y ~ x))
  # (Intercept)             x
  # 1  1.06212391   -0.37811633
  # 2  0.06748037   -0.02861769
  # 3 -0.01735756    0.00791512
  # 4 -1.24958248    0.67253246
  # 5  0.20432010 -133.82261293
  
  # Answer : pos 5 -> -133.82261293
}

q7 <- function(){
  # The answer is in one of the lectures :
  # It is possible for the coefficient to reverse sign after adjustment. 
  # For example, it can be strongly significant and positive before adjustment 
  # and strongly significant and negative after adjustment.

  
}

