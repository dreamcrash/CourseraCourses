# Question 1
# In a population of interest, a sample of 9 men yielded a sample average brain 
# volume of 1,100cc and a standard deviation of 30cc.
# What is a 95% Student's T confidence interval for the 
# mean brain volume in this new population? 

# n = 9
# mean = 1100
# sd = 30

question1 <- function(){
  mean <- 1100
  sd   <- 30
  n    <- 9
  error <- qt(0.975,df=n-1) * sd /sqrt(n)
  lower <- mean - error
  upper <- mean + error
  c(lower,upper)
}
# [1] 1076.94 1123.06


# Question 2
# A diet pill is given to 9 subjects over six weeks. 
# The average difference in weight (follow up - baseline) is -2 pounds. 
# What would the standard deviation of the difference in weight have 
# to be for the upper endpoint of the 95% T confidence interval to touch 0?

question2 <- function(){
  n <- 9
  
  # Y_ -> average difference
  # Y_ +- t0.975 * sd / sqrt(9)
  # -2 + t0.975 * sd/3 = 0
  t0.975 <- qt(0.975, 8)
  sd <- (2 / t0.975) * 3
  sd
}

# [1] 2.601903

# Question 3

# Since observations are paired we use a paired interval.



# Question 4
# In a study of emergency room waiting times, investigators consider a new 
# and the standard triage systems. To test the systems, administrators selected 
# 20 nights and randomly assigned the new triage system to be used on 10 nights 
# and the standard system on the remaining 10 nights. They calculated the nightly 
# median waiting time (MWT) to see a physician. The average MWT for the new system 
# was 3 hours with a variance of 0.60 while the average MWT for the old system was 
# 5 hours with a variance of 0.68. Consider the 95% confidence interval estimate for 
# the differences of the mean MWT associated with the new system. 
# Assume a constant variance. What is the interval? 
# Subtract in this order (New System - Old System).

# sp <- sqrt((10 * 0.6 + 10 * 0.68) / (10 + 10))
#3 - 5 + c(-1,1) * qt(0.95,18) * sp * (1/10 + 1 / 10)^0.5

question4 <- function(){
  n1 <- 10
  n2 <- 10
  mean1 <- 3
  mean2 <- 5
  sd1 <- 0.6
  sd2 <- 0.68
  sp <- sqrt((n1 * sd1 + n2 * sd2) / (n1 + n2))
  mean1 - mean2 + c(-1,1) * qt(0.975,n1+n2-2) * sp * (1/n1 + 1/n2)^0.5
}

# [1] -2.751649 -1.248351

# Question 5

# Suppose that you create a 95% T confidence interval. 
# You then create a 90% interval using the same data. 
# What can be said about the 90% interval with respect to the 95% interval?

# The interval will be narrower.

# Question 6
# To further test the hospital triage system, administrators 
# selected 200 nights and randomly assigned a new triage system to be used 
# on 100 nights and a standard system on the remaining 100 nights. 
# They calculated the nightly median waiting time (MWT) to see a physician. 
# The average MWT for the new system was 4 hours with a standard deviation 
# of 0.5 hours while the average MWT for the old system was 6 hours with a 
# standard deviation of 2 hours. Consider the hypothesis of a decrease in 
# the mean MWT associated with the new treatment. 
# What does the 95% independent group confidence interval with unequal 
# variances suggest vis a vis this hypothesis? 
# (Because there's so many observations per group, just use the Z quantile instead of the T.)


question6 <- function(){
  n1 <- 100
  n2 <- 100
  mean1 <- 4
  mean2 <- 6
  sd1 <- 0.5
  sd2 <- 2
  mean2 - mean1 + c(-1, 1) * qnorm(0.975) * sqrt(sd1^2 / n1 + sd2^2 / n2)
}

# [1] 1.595943 2.404057
# "Since this interval is above zero (old - new), we reject the null hypothesis 
# and conclude that the new system is does reduce MWTs."
# When subtracting (old - new) the interval is entirely above zero. 
#  The new system appears to be effective.

# Question 7
# Suppose that 18 obese subjects were randomized, 9 each, to a new diet pill and a placebo. 
# Subjects' body mass indices (BMIs) were measured at a baseline and again after 
# having received the treatment or placebo for four weeks. 
# The average difference from follow-up to the baseline (followup - baseline) 
# was -3 kg/m2 for the treated group and 1 kg/m2 for the placebo group. 
# The corresponding standard deviations of the differences was 1.5 kg/m2 for 
# the treatment group and 1.8 kg/m2 for the placebo group. Does the change in 
# BMI over the four week period appear to differ between the treated and placebo groups? 
# Assuming normality of the underlying data and a common population variance, 
# calculate the relevant *90%* t confidence interval. 
# Subtract in the order of (Treated - Placebo) with the smaller (more negative) number first.

question7 <- function(){
  n1 <- 9
  n2 <- 9
  mean1 <- -3
  mean2 <- 1
  sd1 <- 1.5
  sd2 <- 1.8
  sp <- sqrt(((n1-1) * sd1^2 + (n2-1) * sd2^2) / (n1 + n2 - 2))
  mean1 - mean2 + c(-1,1) * qt(0.95,n1+n2-2) * sp * (1/n1 + 1/n2)^0.5
}
# [1] -5.363579 -2.636421
