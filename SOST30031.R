# ============================================================
# SOST30031 – R Portfolio: Weeks 1–3
# Author: Jacob Hollyoak
# ============================================================

# setwd("~/Rstudio 3rd year Folder")


# ============================================================
# WEEK 1: R BASICS
# ============================================================

# Calculator
2 + 2
2 + 5
3 - 2
18 / 6
4 * 7
(5 - 3)^2 / 4
9^(1/2) * 4

# Objects
x <- 5
y <- 6
x + y
z <- x * y
z
x < -5     # TRUE/FALSE question, not assignment
ls()

# Functions
sqrt(144)
log10(8)
log10(100)
log(100)
exp(1)
pi
sin(pi/2)
abs(-7)
factorial(3)
exp(x)
log(y, 2)

z <- x * y
trunc(x^2 + z / y)
log((100 * x - y^2) / z)
round(exp(x), 2)
p <- abs(floor(log((100 * x - y^2) / exp(z))))
p

# Vectors
x <- 1:10
x
x <- rep(1, 10)
x
x <- c(2, 6, 4, 2, 3, 7, 1, 5, 9, 8)
x
seq(1, 10, 0.2)

x <- rep(1, 10)
y <- 1:10
c(x, y)
x + y
x + 2 * y
x^2 / y
z <- (x + y) / 2
z
z <- c(z, rep(1, 3), c(100, 200, 300)) + 1
z
p <- 2.5
z * p

# Summary statistics
y <- c(4, 1, 0, 8, 1, x)
max(y)
range(y)
mean(y)
var(y)
sort(y)
cumsum(y)

# Indexing
z <- c(5, 8, 2)
z[10]      # NA – only 3 values
y <- c(9, 3, 7, 2, 9, 2, 1, 5, 4, 6)
y[y > 5]
y[y > 10]
y[y != 2]

# Matrices
ma1 <- matrix(c(1, 0, -20, 0, 1, -15, 1, -1, 0),
              nrow = 3, ncol = 3, byrow = TRUE)
ma1
dim(ma1)
ma1 <- matrix(c(4, 10, 130, 0, 8, -7, 9, 11, -2, 7, -5, 4),
              nrow = 3, ncol = 4)
ma1
ma1[2, 3]
ma1[, 4]


# ============================================================
# WEEK 2
# ============================================================
# No R practical this week.


# ============================================================
# WEEK 3: CAUSAL DAGs WITH DAGITTY
# ============================================================
# Question: total causal effect of Education on Earnings

# install.packages("dagitty")   # run once only
library(dagitty)

# 1. Confounding
dag1 <- dagitty('dag {
  Education [exposure]
  Earnings [outcome]
  Parental_SES -> Education
  Parental_SES -> Earnings
  Education -> Earnings
}')
plot(dag1)
adjustmentSets(dag1)
# Q1. Education -> Earnings
# Q2. Yes: Education <- Parental_SES -> Earnings
# Q3. Parental_SES
# Q4. Parental_SES
# Q5. Yes – { Parental_SES }

# 2. Mediator
dag2 <- dagitty('dag {
  Education [exposure]
  Earnings [outcome]
  Parental_SES -> Education
  Parental_SES -> Earnings
  Education -> Earnings
  Education -> Occupation
  Occupation -> Earnings
}')
plot(dag2)
adjustmentSets(dag2)
# Q6.  Occupation is a mediator
# Q7.  No – it is part of the total effect
# Q8.  { Parental_SES }
# Q9.  No
# Q10. The indirect effect (education -> jobs -> earnings)

# 3. Collider
dag3 <- dagitty('dag {
  Education [exposure]
  Earnings [outcome]
  Parental_SES -> Education
  Parental_SES -> Earnings
  Education -> Earnings
  Education -> Occupation
  Occupation -> Earnings
  Education -> Employment
  Health -> Employment
  Health -> Earnings
}')
plot(dag3)
adjustmentSets(dag3)
# Q11. Employment is a collider
# Q12. Closed
# Q13. Controlling for it opens the path and creates bias
# Q14. Only using employed people = controlling for a collider
# Q15. (a) Parental_SES – yes, confounder
#      (b) Occupation – no, mediator
#      (c) Employment – no, collider

# 4. Extension: Ability
dag4 <- dagitty('dag {
  Education [exposure]
  Earnings [outcome]
  Parental_SES -> Education
  Parental_SES -> Earnings
  Education -> Earnings
  Education -> Occupation
  Occupation -> Earnings
  Education -> Employment
  Health -> Employment
  Health -> Earnings
  Ability -> Education
  Ability -> Earnings
}')
plot(dag4)
adjustmentSets(dag4)
# Result: { Ability, Parental_SES }