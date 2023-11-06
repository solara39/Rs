# (f)

boost_model <- randomForest(Sales~., data = train_datas, distribution = "gaussian", n.trees = 5000, interaction.depth = 4)

boost_pred <- predict(boost_model, test_datas, n.trees = 5000)

boost_mse <- mean((boost_pred - test_datas$Sales)^2)
boost_mse