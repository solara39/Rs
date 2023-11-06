# (c)

cv_tree <- cv.tree(reg_tree, FUN = prune.tree)

plot(cv_tree$size, cv_tree$dev, type='b') 

optimized_size <- cv_tree$size[which.min(cv_tree$dev)]
pruned_tree <- prune.tree(reg_tree, best = optimized_size)

pruned_tree_pred <- predict(pruned_tree, test_datas)

pruned_tree_mse <- mean((pruned_tree_pred - test_datas$Sales)^2)
pruned_tree_mse