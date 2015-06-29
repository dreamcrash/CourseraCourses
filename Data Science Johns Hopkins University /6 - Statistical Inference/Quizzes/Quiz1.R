# Question 1
# Consider influenza epidemics for two parent heterosexual families. 
# Suppose that the probability is 17% that at least one of the parents 
# has contracted the disease. The probability that the father has contracted 
# influenza is 12% while the probability that both the mother and father 
# have contracted the disease is 6%. What is the probability that the mother 
# has contracted influenza?

# Answer
# F - Father has contracted influenza
# M - Mother has contracted influenza

# P (F U M) = 17 %
# P (F) = 12 %
# P (F /\ M) = 6 %

# P (M) ? 

# P(F U M) = P (F) + P (M) - P (F /\ M)
# 17 = 12 + P (M) - 6
# P(M) = 17 - 12 + 6 = 11 %


# Question 2
# A random variable, X is uniform, a box from 0 to 1 of height 1. 
# (So that its density is f(x)=1 for 0<=x<=1.) What is its 75th percentile? 

# Answer : 0.75 * 1 = 0.75


# Question 3
# You are playing a game with a friend where you flip a coin and 
# if it comes up heads you give her X dollars and if it comes up 
# tails she gives you Y dollars. The probability that the coin is 
# heads is p (some number between 0 and 1.) 
# What has to be true about X and Y to make so that 
# both of your expected total earnings is 0. The game would then be called "fair".

# Answer :
# heads = -X and P(heads) = p
# tails = +Y and P(tails) = p - 1
# w - earnings 

# w = -X * p + Y * (p - 1)

# w = 0 then 0 = -X * p + Y * (p - 1)
# X * p = Y * (p - 1)


#     p         Y
# -------- = -------
#  (p - 1)      x     


# Question 4
# A density that looks like a normal density (but may or may not be exactly normal) 
# is exactly symmetric about zero. 
# (Symmetric means if you flip it around zero it looks the same.) 
# What is its median? 

# The median must be 0.

# Question 5
# Consider the following PMF shown below in R

question5 <- function()
{
  x <- 1:4
  p <- x/sum(x)
  sum(x * p)
}

# Question 6
# A web site (www.medicine.ox.ac.uk/bandolier/band64/b64-7.html) for home pregnancy tests 
# cites the following: "When the subjects using the test were women who collected 
# and tested their own samples, the overall sensitivity was 75%. 
# Specificity was also low, in the range 52% to 75%." 
# Assume the lower value for the specificity. 
# Suppose a subject has a positive test and that 30% of women taking 
# pregnancy tests are actually pregnant. 
# What number is closest to the probability of pregnancy given the positive test?

# Answer : Using Bayes' rule
# Sensitivity = P ( + | D ) = 0.75 test is positive given the subject is pregnant 
# Specificity = P ( - | Dc) = 0.52 test is negative given the subject is not pregnant

# Prevalence of pregnancy P (D) = 0.30
# Positive predictive value P (D | +) ?
#
#                             P (+ | D) * P(D)
# P (D | +) = --------------------------------------------
#             P ( + | D) * P(D)  + P ( + | Dc) * P( Dc )
#             
#                             0.75  * 0.30
# P (D | +) = ------------------------------------------
#             0.75 * 0.30 + (1 - P(- | Dc) * (1 - P(D)))
#             
#                           0.225 
# P (D | +) = ------------------------------------------
#                   0.225 + (0.48 * 0.70)
#
#                       0.225 
# P (D | +) = -----------------------
#                   0.225 + 0.336
#
#                   0.225 
# P (D | +) = --------------- ~ 0.4011
#                   0.561

