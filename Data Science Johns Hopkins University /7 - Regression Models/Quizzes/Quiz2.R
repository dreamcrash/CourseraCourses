q1 <- function(){
  # Consider the following data with x as the predictor and y as as the outcome.
  x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)  # predictor
  y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)    # outcome
  #Give a P-value for the two sided hypothesis test of whether B1 
  # from a linear regression model is 0 or not.
  
  # slides 01_07.pdf
  fit<-lm(y~x)
  summary(fit)$coefficients
  #The answer is x -> Pr(>|t|) -> 0.05296439
}

q2 <- function()
{
  # Consider the previous problem, give the estimate of the residual standard deviation.
  x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)  # predictor
  y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)    # outcome
  
  fit<-lm(y~x)
  summary(fit)
  #The answer Residual standard error: 0.223 on 7 degrees of freedom
}

q3 <- function(){
  
  # In the mtcars data set, fit a linear regression model of weight (predictor) 
  # on mpg (outcome). Get a 95% confidence interval for the expected mpg at the 
  # average weight. What is the lower endpoint?
  
  wt <- mtcars$wt  # weight as regressor
  mpg<- mtcars$mpg # mpg as outcome
  
  fit <- lm(mpg ~ wt)
  newdata<-data.frame(wt=mean(wt))
  
  #prediction intervals slides 01_07.pdf page 13
  predict(fit,newdata, interval="confidence")
  #        fit      lwr      upr
  # 1 20.09062 18.99098 21.19027
  
  # Answer lwr -> 18.99
}

q4 <- function(){
  # Refer to the previous question. Read the help file for mtcars. 
  # What is the weight coefficient interpreted as?
  help(mtcars)
  # [, 1]  mpg	Miles/(US) gallon
  # [, 2]	cyl	Number of cylinders
  # [, 3]	disp	Displacement (cu.in.)
  # [, 4]	hp	Gross horsepower
  # [, 5]	drat	Rear axle ratio
  # [, 6]	wt	Weight (lb/1000)
  # [, 7]	qsec	1/4 mile time
  # [, 8]	vs	V/S
  # [, 9]	am	Transmission (0 = automatic, 1 = manual)
  # [,10]	gear	Number of forward gears
  # [,11]	carb	Number of carburetors
}

q5 <- function(){
  
  # Consider again the mtcars data set and a linear regression model with mpg 
  # as predicted by weight (1,000 lbs). A new car is coming weighing 3000 pounds. 
  # Construct a 95% prediction interval for its mpg. What is the upper endpoint?
  
  wt  <- mtcars$wt  # weight as regressor
  mpg <- mtcars$mpg # mpg as outcome
  
  fit <- lm(mpg ~ wt)
  newdata<-data.frame(wt=3) # 3 * 1.000 lbs
  predict(fit,newdata, interval="prediction")
  
  #        fit      lwr      upr
  # 1 21.25171 14.92987 27.57355
  
  # Answer -> upr -> 27.57355
}

q6 <- function(){
  
  # Consider again the mtcars data set and a linear regression model 
  # with mpg as predicted by weight (in 1,000 lbs). A "short" ton is defined as 
  # 2,000 lbs. Construct a 95% confidence interval for the expected change 
  # in mpg per 1 short ton increase in weight. Give the lower endpoint.
  
  
  # Getting a confidence interval slides 01_07.pdf page 8
  wt  <- mtcars$wt
  mpg <- mtcars$mpg
  
  fit <- lm(mpg ~ I(wt/2)) #  A "short" ton is defined as 2,000 lbs
  sumCoef<-summary(fit)$coefficients
  sumCoef[2,1]+c(-1,1)*qt(.975,df=fit$df)*sumCoef[2,2]
  # Estimate wt                           StdError wt
  # -12.97262  -8.40527
}

q7 <- function(){
  #If my X from a linear regression is measured in centimeters and 
  # I convert it to meters what would happen to the slope coefficient?
  
  #Example: X is height in m and Y is weight in kg. 
  #Then B1 is kg/m. Converting X to cm implies multiplying X by 100cm/m . 
  #To get B1 in the right units, we have to divide by 100cm/m to get 
  # it to have the right units.
  
  # slides 01_05.pdf page 6
  
  # The slope coefficient is multiplying by 100, that why we need to divide by
  # 100 in order to get B1 in the right units
  
}

q8 <- function(){
  
  # I have an outcome, Y, and a predictor, X and fit a linear regression model with 
  # Y=B0+B1X+e to obtain B^0 and B^1. What would be the consequence to the subsequent 
  # slope and intercept if I were to refit the model with a new regressor, 
  # X+c for some constant, c?
  
  #Intercept is by definition the y value you get when the predictor variable equals zero"
  
  #So:
  #Y = Bo, when x = 0,
  
  #if: x + c  = 0, then x = -c
  
  #Knowing that Y = Bo + B1x,
  
  #then with x + c =  0;
  
  #Y = Bo -cB1  
}

q9 <- function(){
  
  # Refer back to the mtcars data set with mpg as an outcome and weight (wt) 
  # as the predictor. About what is the ratio of the the sum of the squared errors, 
  # sum(ni=1(Yi-Y^i)2) when comparing a model with just an intercept (denominator) to 
  # the model with the intercept and slope (numerator)?
  
  wt  <- mtcars$wt  # weight as regressor
  mpg <- mtcars$mpg # mpg as outcome
  
  fit <- lm(mpg ~ wt)
  
  fitJustIntercept <- lm(mpg ~ 1)
  sum(fit$residuals ^ 2) /sum(fitJustIntercept$residuals ^ 2)
  # Answer = 0.2471672
}

q10 <- function(){
  # Do the residuals always have to sum to 0 in linear regression?
  wt  <- mtcars$wt  # weight as regressor
  mpg <- mtcars$mpg # mpg as outcome
  
  fitBoth <- lm(mpg ~ wt)
  fitJustIntercept <- lm(mpg ~ 1)
  fitSlope<-lm(mpg ~ wt - 1) 
  a <- c(sum(resid(fitBoth)),          #intercept + slope -> gives zero
        sum(resid(fitJustIntercept)),  #intercept -> gives zero
        sum(resid(fitSlope)) #Slope -> does not give zero
        )
  a # [1] -1.637579e-15 -5.995204e-15  9.811672e+01
  
  # If an intercept is included, then they will sum to 0 ? -> True
  # The residuals must always sum to zero. -> False, fitSlope != 0
  # The residuals never sum to zero. -> False, fitBoth and fitJustIntercept == 0
  # If an intercept is included, the residuals most likely won't sum to zero. -> False
}