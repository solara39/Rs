# (d)
library(randomForest)

bag_model <- randomForest(Sales~., data = train_datas, mtry=ncol(train_datas) - 1, inportance=TRUE)

bag_pred <- predict(bag_model, test_datas)

bag_mse <- mean((bag_pred - test_datas$Sales)^2)
bag_mse

importance(bag_model)