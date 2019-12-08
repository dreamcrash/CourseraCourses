# Question 1
# A pharmaceutical company is interested in testing a potential blood pressure lowering medication. 
# Their first examination considers only subjects that received the medication at baseline 
# then two weeks later. The data are as follows (SBP in mmHg) Subject  Baseline	Week 2
# 1	140	132
# 2	138	135
# 3	150	151
# 4	148	146
# 5	135	130
# Consider testing the hypothesis that there was a mean reduction in blood pressure? 
# Give the P-value for the associated two sided T test.

#  (Hint, consider that the observations are paired.)

question1 <- function()
{
  x <- c(140,138,150,148,135)
  y <- c(132,135,151,146,130)
  t.test(x,y,paired = TRUE)$p.value
  # [1] 0.08652278
}

# Question 2
# A sample of 9 men yielded a sample average brain volume of 1,100cc and a standard deviation of 30cc. 
# What is the complete set of values of u0 that a test of H0:u=u0 
# would fail to reject the null hypothesis in a two sided 5% Students t-test?

question2 <- function(){
  # This is the 95% student's T confidence interval.
  me <- 1100 
  sd <- 30
  n <- 9
  me + c(-1,1) * qt(0.975,8) * sd / sqrt(n)
 # [1] 1076.94 1123.06
}


# Question 3
# Researchers conducted a blind taste test of Coke versus Pepsi. 
# Each of four people was asked which of two blinded drinks given in random 
# order that they preferred. The data was such that 3 of the 4 people chose Coke. 
# Assuming that this sample is representative, report a P-value for a test of 
# the hypothesis that Coke is preferred to Pepsi using a one sided exact test.

# For this case we can use a binominal test
question3 <- function(){
  binom.test(3, 4, alt="greater")$p.value
  # R [1] 0.3125
  
  # Question Explanation
  # Let p be the proportion of people who prefer Coke. 
  # Then, we want to test H0:p=.5 versus Ha:p>.5. 
  # Let X be the number out of 4 that prefer Coke; assume X~Binomial(p,.5). 
  # Pvalue=P(X>=3)=choose(4,3)0.530.51+choose(4,4)0.540.50
}

# Question 4
# Infection rates at a hospital above 1 infection per 100 person days at risk are believed 
# to be too high and are used as a benchmark. A hospital that had previously been above the 
# benchmark recently had 10 infections over the last 1,787 person days at risk. 
# About what is the one sided P-value for the relevant test of whether the hospital is 
# *below* the standard?

# This case we can used a poison test

question4 <- function(){
  # poisson.test(error,T = days, rate radio, alternative) 
  poisson.test(10, 1787, 0.01, alt="less")$p.value
  
 # R [1] 0.03237153 
 
 # Question Explanation
 
 # H0:delta=0.01 versus Ha:delta<0.01. X=11, t=1,787 and assume X~H0Poisson(0.01xt)
}

question5 <- function(){
  #Question Explanation 
  
  H0:u (difference,treated) =u (difference,placebo)
  
  n1 <- n2 <- 9
  x1 <- -3  # treated
  x2 <- 1   # placebo
  s1 <- 1.5 # treated
  s2 <- 1.8 # placebo
  s <- sqrt(((n1 - 1) * s1^2 + (n2 - 1) * s2^2)/(n1 + n2 - 2))
  ts <- (x1 - x2)/(s * sqrt(1/n1 + 1/n2))
  2 * pt(ts, n1 + n2 - 2)
}


# Question 6
# Brain volumes for 9 men yielded a 90% confidence interval of 1,077 cc to 1,123 cc. 
# Would you reject in a two sided 5% hypothesis test of H0:u=1,078?

# Since 1,077 cc <= u <= 1,123 cc "No you wouldn't reject."

# Question 7
# Researchers would like to conduct a study of 100 healthy adults to detect a 
# four year mean brain volume loss of .01 mm3. Assume that the standard deviation 
# of four year volume loss in this population is .04 mm3. About what would be the power 
# of the study for a 5% one sided test versus a null hypothesis of no volume loss?

question7 <- function(){
  
  # power.t.test(100 healthy,mean brain volume loss of .01 mm3, 
  # volume loss in this population is .04 mm3 , the study for a 5%, type="one.sample", one sided test)$power
  power.t.test(100,0.01, 0.04 , 0.05, type="one.sample", alt="one.sided")$power
  # [1] 0.7989855
}

# Question 8
# Researchers would like to conduct a study of n healthy adults to detect a 
# four year mean brain volume loss of .01 mm3. Assume that the standard deviation 
# of four year volume loss in this population is .04 mm3. 
# About what would be the value of n needded for 90% power of type 
# one error rate of 5% one sided test versus a null hypothesis of no volume loss?

question8 <- function(){
  
   power.t.test(power=0.9,delta=0.01,sd=0.04 ,sig.level=0.05, type="one.sample", alt="one.sided")$n
   # [1] 138.3856
}

# Question 9
# As you increase the type one error rate, a, what happens to power?
# You will get larger power.

# Question Explanation

# As you require less evidence to reject, i.e. your a rate goes up, you will have larger power.






