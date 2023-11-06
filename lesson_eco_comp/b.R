# (b)

reg_tree <- tree(Sales~.,data=train_datas)

plot(reg_tree)
text(reg_tree, pretty=0)

tree_pred <- predict(reg_tree, test_datas)

tree_mse <- mean((tree_pred - test_datas$Sales)^2)
tree_mse