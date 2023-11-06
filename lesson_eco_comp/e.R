# (e)

rf_model <- randomForest(Sales~., data = train_datas, mtry=floor(sqrt(ncol(train_datas) - 1)), inportance=TRUE)

rf_pred <- predict(rf_model, test_datas)

rf_mse <- mean((rf_pred - test_datas$Sales)^2)
rf_mse

importance(bag_model)