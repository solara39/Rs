# (a)

library(ISLR)
library(tree)

data("Carseats")

n <- nrow(Carseats)

set.seed(42)
shuffled_index <- sample(1:n)

train <- shuffled_index[1:n/2]
test <- shuffled_index[(n/2 + 1):n]

train_datas <- Carseats[train, ]
test_datas <- Carseats[test, ]